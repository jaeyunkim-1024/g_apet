package biz.app.order.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.util.GoodsUtil;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.dao.OrderDlvraDao;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderPayVO;
import biz.app.pay.dao.PayBaseDao;
import biz.app.st.dao.StDao;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.dao.ChnlStdInfoDao;
import biz.app.system.model.ChnlStdInfoVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.EmailSend;
import biz.common.model.EmailSendMap;
import biz.common.model.LmsSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.ImageGoodsSize;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderSendServiceImpl.java
* - 작성일		: 2017. 6. 30.
* - 작성자		: Administrator
* - 설명			: 주문 전송 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class OrderSendServiceImpl implements OrderSendService {

	@Autowired private CacheService cacheService;

	@Autowired	private OrderDao orderDao;

	@Autowired	private OrderBaseDao orderBaseDao;

	@Autowired	private OrderDetailDao orderDetailDao;

	@Autowired	private OrderDlvraDao orderDlvraDao;

	@Autowired	private PayBaseDao payBaseDao;

	@Autowired private Properties bizConfig;

	@Autowired private BizService bizService;

	@Autowired private StDao stDao;

	@Autowired private ChnlStdInfoDao chnlStdInfoDao;

	/*
	 * 주문 메일 및 SMS 전송
	 * @see biz.app.order.service.OrderService#sendOrderInfo(java.lang.String)
	 */
	@Override
	public void sendOrderInfo(String ordNo){

		boolean sendExcute = true;
		OrderBaseVO orderBase = null;
		List<OrderDetailVO> orderDetailList = null;
		OrderPayVO payInfo = null;
		StStdInfoVO stInfo = null;
		ChnlStdInfoVO chnlStdInfo = null;

		/************************************
		 * 주문 내역 조회
		 ************************************/
		try {
			/*
			 * 주문 기본 조회
			 */
			OrderBaseSO obso = new OrderBaseSO();
			obso.setOrdNo(ordNo);
			orderBase = this.orderBaseDao.getOrderBase(obso);

			if(orderBase == null ){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}


			/*
			 *  주문 상세 목록 조회
			 */
			OrderDetailSO odso = new OrderDetailSO();
			odso.setOrdNo(orderBase.getOrdNo());
			orderDetailList = this.orderDetailDao.listOrderDetail(odso);

			if(orderDetailList == null || orderDetailList.isEmpty()){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}

			/*
			 *  결제 정보 목록 조회
			 */
			payInfo = this.orderDao.getOrderPayInfo(ordNo);

			// 사이트 정보 조회
			stInfo =  this.stDao.getStStdInfo(orderBase.getStId());

			// 채널정보
			chnlStdInfo = this.chnlStdInfoDao.getChnlStdInfo(orderBase.getChnlId());
		}catch(Exception e){
			log.error("[주문 전송 정보 조회 오류] 주문번호 : "+ ordNo);
			sendExcute = false;

		}

		if(sendExcute
				&& CommonConstants.CHNL_GB_10.equals(chnlStdInfo.getChnlGbCd())){
			// 제휴몰 주문인 경우 제외

			/*****************************************
			 * 이메일 전송
			 ******************************************/
			try {
				EmailSend email = new EmailSend();
				List<EmailSendMap> mapList = new ArrayList<>();
				EmailSendMap esMap = null;


				if(CommonConstants.ORD_STAT_10.equals(orderBase.getOrdStatCd())){
					email.setEmailTpCd(CommonConstants.EMAIL_TP_200);
				}else{
					email.setEmailTpCd(CommonConstants.EMAIL_TP_220);
				}

				email.setStId(orderBase.getStId());
				email.setReceiverNm(orderBase.getOrdNm());
				email.setReceiverEmail(orderBase.getOrdrEmail());
				email.setMbrNo(orderBase.getMbrNo());
				email.setMap01(orderBase.getOrdNo());	//주문번호
				email.setMap02(DateUtil.getTimestampToString(orderBase.getOrdAcptDtm(), "yyyy.MM.dd HH:mm")); //주문일자

				/*
				 * 결제 수단별 설정 정보
				 */
				String payCd = "";
				String payStat = "";
				String payBank = "";

				if(CommonConstants.PAY_MEANS_30.equals(payInfo.getPayMeansCd()) || CommonConstants.PAY_MEANS_40.equals(payInfo.getPayMeansCd()) ||
				CommonConstants.PAY_MEANS_10.equals(payInfo.getPayMeansCd()) || CommonConstants.PAY_MEANS_50.equals(payInfo.getPayMeansCd()) ||
				CommonConstants.PAY_MEANS_20.equals(payInfo.getPayMeansCd())){

					if(CommonConstants.PAY_MEANS_30.equals(payInfo.getPayMeansCd())){
						payCd = "01"; // 가상계좌
					}
					if(CommonConstants.PAY_STAT_01.equals(payInfo.getPayStatCd())){
						payStat = "01";  // 입금확인
					}else{
						payStat = "02";	// 입금전
					}
					payBank = this.cacheService.getCodeName(CommonConstants.BANK, payInfo.getBankCd()) + " " + payInfo.getAcctNo() + " " + payInfo.getOoaNm();
				}

				email.setMap03(payInfo.getPayAmt().toString()); // 최종결제금액
				email.setMap05(this.cacheService.getCodeName(CommonConstants.PAY_MEANS, payInfo.getPayMeansCd())); // 결제수단
				email.setMap06(payCd); // 결제코드
				email.setMap07(payStat); // (가상계좌)입금확인코드
				email.setMap08(payBank); // 가상계좌입금은행정보

				/*
				 * 배송 정보 설정
				 */
				OrderDlvraSO odaso = new OrderDlvraSO();
				odaso.setOrdNo(orderBase.getOrdNo());
				OrderDlvraVO orderDlvra = this.orderDlvraDao.getOrderDlvra(odaso);

				email.setMap09(orderDlvra.getAdrsNm()); // 배송받는사람
				email.setMap10(StringUtil.phoneNumber(orderDlvra.getMobile())); // 배송 연락처
				email.setMap11(orderDlvra.getRoadAddr() + " " + orderDlvra.getRoadDtlAddr()); // 배송 주소
				email.setMap12(orderDlvra.getDlvrMemo()); // 배송 메모

				/*
				 * 주문 결제 정보
				 */
				if(payInfo.getDlvrAmt().longValue() > 0){
					email.setMap13("(+)"); 	//배송비 부호
				}else{
					email.setMap13(""); 	//배송비 부호
				}
				email.setMap14(payInfo.getDlvrAmt().toString());	//배송비 가격

				if(payInfo.getSvmnAmt().longValue() > 0){
					email.setMap15("(-)"); 	//적립금 부호
				}else{
					email.setMap15(""); 	//적립금 부호
				}
				email.setMap16(payInfo.getSvmnAmt().toString());	//적립금 가격

				if(payInfo.getCpDcAmt().longValue() > 0){
					email.setMap17("(-)"); 	//배송비 부호
				}else{
					email.setMap17(""); 	//배송비 부호
				}
				email.setMap18(payInfo.getCpDcAmt().toString());	//쿠폰할인 가격
				email.setMap19(payInfo.getPayAmt().toString());	//결제금액


				// 예상적립금
				Long svmnAmt = 0L;

				if(orderDetailList != null && !orderDetailList.isEmpty()){
					for(OrderDetailVO orderDetail : orderDetailList){
						esMap =  new EmailSendMap();

						esMap.setMap01(GoodsUtil.getGoodsImageSrc(bizConfig.getProperty("image.domain"), orderDetail.getImgPath(), orderDetail.getGoodsId(), orderDetail.getImgSeq(), ImageGoodsSize.SIZE_70.getSize()));
						esMap.setMap02("[" + orderDetail.getBndNmKo() + "] " + orderDetail.getGoodsNm());
						esMap.setMap03(String.valueOf(orderDetail.getSaleAmt().longValue() - orderDetail.getPrmtDcAmt().longValue()));
						esMap.setMap04(String.valueOf(orderDetail.getOrdQty().intValue()));
						esMap.setMap05(orderDetail.getItemNm());

						svmnAmt += orderDetail.getOrdQty() * orderDetail.getOrdSvmn();

						mapList.add(esMap);
					}
				}

				email.setMap04(String.valueOf(svmnAmt.longValue()));

				this.bizService.sendEmail(email, mapList);

			}catch(Exception e){
				log.error("[주문 메일 전송 오류] 주문번호 : "+ ordNo);
			}

			/*****************************************
			 * LMS전송
			 * - 입금계좌 안내 (가상계좌, 무통장)
			 * - 주문접수단계에서만 발송
			 ******************************************/
			try {
				if(CommonConstants.ORD_STAT_10.equals(orderBase.getOrdStatCd())
						&& payInfo != null
				&& (CommonConstants.PAY_MEANS_30.equals(payInfo.getPayMeansCd()) || CommonConstants.PAY_MEANS_40.equals(payInfo.getPayMeansCd()))){
					LmsSendPO lspo = new LmsSendPO();

					lspo.setSendPhone(stInfo.getCsTelNo());
					lspo.setReceiveName(orderBase.getOrdNm());
					lspo.setReceivePhone(orderBase.getOrdrMobile());

					/*
					 * 제목 및 내용 설정
					 */
					CodeDetailVO smsTpVO = cacheService.getCodeCache(CommonConstants.SMS_TP, CommonConstants.SMS_TP_210);

					String subject = smsTpVO.getUsrDfn2Val();
					String msg = smsTpVO.getUsrDfn3Val();

					//제목 Argument 치환
					subject = StringUtil.replaceAll(subject,CommonConstants.SMS_TITLE_ARG_MALL_NAME, stInfo.getStNm());

					// 내용 변수 생성
					String dueDay = DateUtil.convertDateToString(payInfo.getDpstSchdDt(), "H");
					String bankNm = this.cacheService.getCodeName(CommonConstants.BANK, payInfo.getBankCd());
					String acctNo = payInfo.getAcctNo();
					String ooaNm = payInfo.getOoaNm();
					String dueAmt = payInfo.getPayAmt().toString();


					String goodsNm = orderDetailList.get(0).getGoodsNm();
					int etcOrdCnt = orderDetailList.size() - 1;

					if(goodsNm.length() > 20){
						goodsNm = goodsNm.substring(0,  20) + "...";
					}

					if(etcOrdCnt > 0){
						goodsNm += " 외 " + etcOrdCnt + "개";
					}


					//내용 Argument 치환
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_DUE_DAY, dueDay);
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_BANK_NM, bankNm);
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_ACCT_NO, acctNo);
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_OOA_NM, ooaNm);
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_DUE_AMT, dueAmt);
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_GOODS_NM, goodsNm);

					lspo.setSubject(subject);
					lspo.setMsg(msg);

					this.bizService.sendLms(lspo);
				}

			}catch(Exception e){
				log.error("[주문 메일 전송 오류] 주문번호 : "+ ordNo);
			}

			/************************************
			 * LMS 전송
			 * - 주문완료
			 * - 최종 완료 시점에만 전송한다.
			 ************************************/
			try {
				if(CommonConstants.ORD_STAT_20.equals(orderBase.getOrdStatCd())){
					LmsSendPO lspo = new LmsSendPO();

					lspo.setSendPhone(stInfo.getCsTelNo());
					lspo.setReceiveName(orderBase.getOrdNm());
					lspo.setReceivePhone(orderBase.getOrdrMobile());

					/*
					 * 제목 및 내용 설정
					 */
					CodeDetailVO smsTpVO = cacheService.getCodeCache(CommonConstants.SMS_TP, CommonConstants.SMS_TP_220);

					String subject = smsTpVO.getUsrDfn2Val();
					String msg = smsTpVO.getUsrDfn3Val();

					//제목 Argument 치환
					subject = StringUtil.replaceAll(subject,CommonConstants.SMS_TITLE_ARG_MALL_NAME, stInfo.getStNm());

					String goodsNm = orderDetailList.get(0).getGoodsNm();
					int etcOrdCnt = orderDetailList.size() - 1;

					if(goodsNm.length() > 20){
						goodsNm = goodsNm.substring(0,  20) + "...";
					}

					if(etcOrdCnt > 0){
						goodsNm += " 외 " + etcOrdCnt + "개";
					}

					//내용 Argument 치환
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_ORD_NO, orderBase.getOrdNo());
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_GOODS_NM, goodsNm);

					lspo.setSubject(subject);
					lspo.setMsg(msg);

					this.bizService.sendLms(lspo);

				}
			}catch(Exception e){
				log.error("[주문 LMS 전송 오류] 주문번호 : "+ e);

			}
		}
	}


}

