package biz.interfaces.nicepay.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderComplete;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.service.OrderService;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PaymentException;
import biz.app.receipt.dao.CashReceiptDao;
import biz.app.receipt.model.CashReceiptGoodsMapPO;
import biz.app.receipt.model.CashReceiptPO;
import biz.common.service.BizService;
import biz.interfaces.nicepay.client.NicePayClient;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.dao.NicePayNotiDao;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountNotiVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountOrderVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.NicePayApiSpec;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.interfaces.nicepay.service
 * - 파일명		: NicePayNotiServiceImpl.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: sorce
 * - 설명			: 나이스패이 noti (통보) service
 * </pre>
 */
@Slf4j
@Service
public class NicePayNotiServiceImpl implements NicePayNotiService {

	@Autowired private NicePayNotiDao nicepayNotiDao; 

	@Autowired private OrderService orderService;
	
	@Autowired BizService bizService;
	
	@Autowired
	CashReceiptDao cashReceiptDao;

	@Autowired
	OrderBaseDao orderBaseDao;
	
	@Autowired
	OrderDetailDao orderDetailDao;
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: completeVirtualAccount
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: sorce
	 * - 설명			: 무통장입름완료 -> 결제완료 처리
	 * </pre>
	 * @param vo
	 * @throws ParseException 
	 */
	@Override
	@Transactional
	public Boolean completeVirtualAccount(VirtualAccountNotiVO vo) throws ParseException {

		/**
		 * 1. 주문정보 수정
		 */
		// 1.1. 파라미터 처리
		VirtualAccountOrderVO orderVO = new VirtualAccountOrderVO();
		// 주문번호
		orderVO.setOrdNo(vo.getMOID());
		
		// 주문완료 상태
		orderVO.setOrdStatCd(CommonConstants.ORD_STAT_20);
		// 주문완료 일시
		if (StringUtils.isNotEmpty(vo.getAuthDate())) {
			SimpleDateFormat format = new SimpleDateFormat("yyMMddHHmmss");
			orderVO.setOrdCpltDtm(format.parse(vo.getAuthDate()));
		}
		// 주문상세 상태 
		orderVO.setOrdDtlStatCd(CommonConstants.ORD_DTL_STAT_120);

		/**
		 * 1.2. 데이터 수정
		 * 	- 주문 상태 코드 (order_base > ORD_STAT_CD)
		 * 	- 주문 상세 상태 코드 (order_detail > ORD_DTL_STAT_CD)
		 */
		int result = nicepayNotiDao.updateOrderInfoVirtualAccount(orderVO);
		
		/**
		 * 2. 결제정보 업데이트
		 * 	- pay_base 테이블 업데이트
		 */
		// 2.1. 파라미터 처리
		PayBaseVO payBaseVO = new PayBaseVO();
		payBaseVO.setOrdNo(vo.getMOID()); // 주문번호
		payBaseVO.setPayStatCd(CommonConstants.PAY_STAT_01); // 대기(00) -> 완료(01)로 변경
		if (StringUtils.isNotEmpty(vo.getAuthDate())) { // 결제완료 일시
			SimpleDateFormat format = new SimpleDateFormat("yyMMddHHmmss");
			Date date = format.parse(vo.getAuthDate());
			Timestamp timestamp = new Timestamp(date.getTime());
			payBaseVO.setPayCpltDtm(timestamp);
		}
		payBaseVO.setPayAmt(Long.parseLong(vo.getAmt())); // 결제 금액
		payBaseVO.setStrId(vo.getMID()); // 상점아이디
		payBaseVO.setDealNo(vo.getTID()); // 거래번호
		payBaseVO.setCfmRstCd(vo.getResultCode()); // 승인 결과 코드
		payBaseVO.setCfmRstMsg(vo.getResultMsg()); // 승인 결과 메세지
		// payBaseVO.setBankCd(vo.getVbankName()); // 입금은행 <- 입금은행은 넣지 않음
		// payBaseVO.setAcctNo(vo.getVbankNum()); // 계좌번호 <- 넣지 않음
		payBaseVO.setDpstrNm(vo.getVbankInputName()); // 입금자명
		// parameter json으로 변환
		Gson gson = new Gson();
		payBaseVO.setLnkRspsRst(gson.toJson(vo));
		
		if(StringUtils.isNotEmpty(vo.getRcptType()) && !StringUtils.equals(vo.getRcptType(), "0") && StringUtils.length(orderVO.getOrdNo()) < 18) {
			/**
			 * 2.2. 현금영수증 정보 insert
			 */
			// 2.2.1 주문 기본 조회
			OrderBaseSO obso = new OrderBaseSO();
			obso.setOrdNo(vo.getMOID());
			OrderBaseVO orderBase = orderBaseDao.getOrderBase(obso);
			
			OrderDetailSO odso = new OrderDetailSO();
			odso.setOrdNo(orderBase.getOrdNo());
			List<OrderDetailVO> orderDetailList = orderDetailDao.listOrderDetail(odso);
	
			/**
			 * RcptTid 값이 있는 경우 현금영수증이 있다고 판단 하는 것으로 
			 * RcptType (0:발행안함, 1:소득공제, 2:지출증빙)
			 * RcptAuthCode 승인번호
			 */
			Long cashRctNo = bizService.getSequence(CommonConstants.SEQUENCE_CASH_RCT_NO_SEQ);
	
			CashReceiptPO crpo = new CashReceiptPO();
			crpo.setCashRctNo(cashRctNo);
			crpo.setCrTpCd(CommonConstants.CR_TP_10);
			// 발행으로 처리
			crpo.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_20);
			crpo.setUseGbCd(vo.getRcptType()+"0"); // rcpt type + "0" -> useGBCd 코드와 동일해짐
			crpo.setStrId(payBaseVO.getStrId());
			crpo.setLnkDtm(payBaseVO.getPayCpltDtm()); // 입금일자로 반영
			crpo.setCfmRstCd(payBaseVO.getCfmRstCd()); // 
			crpo.setCfmRstMsg(payBaseVO.getCfmRstMsg()); //
			crpo.setLnkRstMsg(payBaseVO.getLnkRspsRst()); // 
			// 금액 계산
			// 현재 과세상품만 존재하므로 결제금액(상품금액+배송비)에 대해 부가세 계산하여 처리
			Long payAmt = payBaseVO.getPayAmt();
			Long staxAmt = Math.round(payAmt.doubleValue() / 1.1 * 0.1);
			Long splAmt = payAmt - staxAmt;
			Long srvcAmt = 0L;
	
			crpo.setPayAmt(payBaseVO.getPayAmt());
			crpo.setSplAmt(splAmt);
			crpo.setStaxAmt(staxAmt);
			crpo.setSrvcAmt(srvcAmt);
			
			if(StringUtils.equals(vo.getRcptType(), "1")) {
				crpo.setUseGbCd(CommonConstants.USE_GB_10);
			}else if(StringUtils.equals(vo.getRcptType(), "2")) {
				crpo.setUseGbCd(CommonConstants.USE_GB_20);
			}
	
			crpo.setIsuGbCd(CommonConstants.ISU_GB_10); // PG결제시 발행되는 현금영수증은 자동으로 고정

			// 값이 들어오지 않음 - 넣을 수 없음 
			crpo.setIsuMeansCd("");
			crpo.setIsuMeansNo("");
	
			// 현금영수증 TID - 사용되지 않지만 예의상 insert
			crpo.setLnkDealNo(vo.getRcptTID());

			// 현금영수증 저장
			cashReceiptDao.insertCashReceipt(crpo);
	
			// 2) 현금영수증 상품매핑테이블 저장
			CashReceiptGoodsMapPO crgmpo = null;
	
			for (OrderDetailVO orderDetail : orderDetailList) {
				crgmpo = new CashReceiptGoodsMapPO();
				crgmpo.setCashRctNo(cashRctNo);
				crgmpo.setOrdClmNo(orderDetail.getOrdNo());
				crgmpo.setOrdClmDtlSeq(orderDetail.getOrdDtlSeq());
				crgmpo.setAplQty(orderDetail.getOrdQty());
				cashReceiptDao.insertCashReceiptGoodsMap(crgmpo);
	
			}
		}
		
		/**
		 * 2.3. 데이터 수정
		 * 	- order_base 테이블 수정
		 */
		nicepayNotiDao.updatePayInfoVirtualAccount(payBaseVO);
		
		/**
		 * TODO 2.4. 포인트 지급 필요
		 * - 이 부분은 차후 개발
		 */
		
		
		/**
		 * 2.6. 알림톡 전송
		 * - clmNo로 들어올 경우 알림톡 메시지를 보내지 않음
		 * - orderVO.getOrdNo() 글자수가  18자 미만일 때만 실행
		 * - 과오납시는 알림톡 메시지를 보낼 필요가 없다고 함 (유준희 부장님께 문의 2021-04-27)
		 */
		if(result > 0 && StringUtils.length(orderVO.getOrdNo()) < 18) {
			try {
				orderService.sendMessage(orderVO.getOrdNo(), "", "", null);
			}catch(Exception e) {
				log.error("### NicePayNotiServiceImpl.java > sendMessage() ERROR 발생");
				// 보안성 진단. 오류메시지를 통한 정보노출
				//log.error(e.getMessage());
			}
		}
		
		return true;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: selectList
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: sorce
	 * - 설명			: 테스트용
	 * </pre>
	 * @param vo
	 * @return
	 */
	public List<PayBaseVO> selectList(PayBaseVO vo) {
		return nicepayNotiDao.selectList(vo);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: updateCryptoTest
	 * - 작성일		: 2021. 03. 21.
	 * - 작성자		: sorce
	 * - 설명			: 암호화 테스트
	 * </pre>
	 * @param vo
	 * @return
	 */
	public int updateCryptoTest(PayBaseVO vo) {
		return nicepayNotiDao.updateCryptoTest(vo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: encrypForTable
	 * - 작성일		: 2021. 04. 13.
	 * - 작성자		: sorce
	 * - 설명			: encrypt
	 * </pre>
	 * @param map
	 * @return
	 */
	public int encrypForTable(Map<String, String> map) {
		Integer result = 0;
		/**
		 * 1. table data select
		 */
		List<Map<String, Object>> list = nicepayNotiDao.selectTargetList(map);
		
		/**
		 * 2. update
		 */
		for(Map<String, Object> data:list) {
			if(data != null) {
				String value = (String)data.get(MapUtils.getString(map, "fieldName"));
				
				map.put("preCrypto", value);
				map.put("postCrypto", bizService.twoWayEncrypt(value));
				result += nicepayNotiDao.updateTargetField(map);

			}
		}
		
		return result;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: decrypForTable
	 * - 작성일		: 2021. 04. 13.
	 * - 작성자		: sorce
	 * - 설명			: decrypt
	 * </pre>
	 * @param map
	 * @return
	 */
	public int decrypForTable(Map<String, String> map) {
		Integer result = 0;
		/**
		 * 1. table data select
		 */
		List<Map<String, Object>> list = nicepayNotiDao.selectTargetList(map);
		
		/**
		 * 2. update
		 */
		for(Map<String, Object> data:list) {
			if(data != null) {
				String value = (String)data.get(MapUtils.getString(map, "fieldName"));
				
				map.put("preCrypto", value);
				map.put("postCrypto", bizService.twoWayDecrypt(value));
				result += nicepayNotiDao.updateTargetField(map);

			}
		}
		
		return result;
	}
}