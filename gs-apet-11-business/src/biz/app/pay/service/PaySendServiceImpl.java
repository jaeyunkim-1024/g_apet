package biz.app.pay.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.dao.ClaimDao;
import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimRefundPayDetailVO;
import biz.app.claim.model.ClaimRefundPayVO;
import biz.app.claim.model.ClaimSO;
import biz.app.goods.util.GoodsUtil;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
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
public class PaySendServiceImpl implements PaySendService {

	@Autowired private CacheService cacheService;

	@Autowired	private ClaimBaseDao claimBaseDao;

	@Autowired	private OrderBaseDao orderBaseDao;

	@Autowired	private ClaimDetailDao claimDetailDao;

	@Autowired	private ClaimDao claimDao;

	@Autowired	private PayBaseDao payBaseDao;

	@Autowired private Properties bizConfig;

	@Autowired private BizService bizService;
	
	@Autowired private StDao stDao;
	
	@Autowired private ChnlStdInfoDao chnlStdInfoDao;
	
	/*
	 * 환불완료 메일 및 SMS 전송
	 * @see biz.app.order.service.OrderService#sendOrderInfo(java.lang.String)
	 */
	@Override
	public void sendRefundComplete(String clmNo){

		boolean sendEmailExcute = true;
		boolean sendLmsExcute = true;
		ClaimBaseVO claimBase = null;
		OrderBaseVO orderBase = null;
		List<ClaimDetailVO> claimDetailList = null;

		ClaimRefundPayVO claimPay = null;
		
		StStdInfoVO stInfo = null;
		ChnlStdInfoVO chnlStdInfo = null;
		
		/************************************
		 * 클레임 내역 조회
		 ************************************/
		try {
			/*
			 * 클레임 기본 조회
			 */
			ClaimBaseSO cbso = new ClaimBaseSO();
			cbso.setClmNo(clmNo);
			claimBase = this.claimBaseDao.getClaimBase(cbso);
	
			if(claimBase == null ){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}
			
			/*
			 * 반품일 경우에만 처리
			 */
			if(!CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())){
				sendEmailExcute = false;
				sendLmsExcute = false;
			}else{
		
				/*
				 *   환불 정보 목록 조회
				 */
				ClaimSO cso = new ClaimSO();
				cso.setClmNo(claimBase.getClmNo());
				claimPay = this.claimDao.getClaimRefundPay(cso);
				
				/*
				 * 주문 기본 조회
				 */
				OrderBaseSO obso = new OrderBaseSO();
				obso.setOrdNo(claimBase.getOrdNo());
				orderBase = this.orderBaseDao.getOrderBase(obso);
		
				if(orderBase == null ){
					throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
				}
				
				/*
				 *  클레임 상세 목록 조회
				 */
				ClaimDetailSO cdso = new ClaimDetailSO();
				cdso.setClmNo(clmNo);
				claimDetailList = this.claimDetailDao.listClaimDetail(cdso);
		
				if(claimDetailList == null || claimDetailList.isEmpty()){
					throw new CustomException(ExceptionConstants.ERROR_CLAIM_NO_GOODS);
				}

				
				// 사이트 정보 조회
				stInfo =  this.stDao.getStStdInfo(claimBase.getStId());
				
				// 채널정보
				chnlStdInfo = this.chnlStdInfoDao.getChnlStdInfo(claimBase.getChnlId());
				
				// 실결제에 대한 환불금애이 존재하는 경우에만 LMS전송
				for(ClaimRefundPayDetailVO crpdvo: claimPay.getClaimRefundPayDetailListVO()){
					if(CommonConstants.PAY_MEANS_50.equals(crpdvo.getPayMeansCd()) && claimPay.getClaimRefundPayDetailListVO().size() == 1){
						sendLmsExcute = false;
					}
				}

			}

		}catch(Exception e){
			log.error("[클레임 환불 정보 조회 오류] 클레임번호 : "+ clmNo);
			sendEmailExcute = false;
			sendLmsExcute = false;

		}		
		

		/*****************************************
		 * 이메일 전송
		 * - 반품일 경우에만 전송
		 ******************************************/
		if(sendEmailExcute
				&& CommonConstants.CHNL_GB_10.equals(chnlStdInfo.getChnlGbCd())){

			// 제휴몰 주문인 경우 제외
			try {
				EmailSend email = new EmailSend();
				List<EmailSendMap> mapList = new ArrayList<>();
				EmailSendMap esMap = null;
				
				email.setEmailTpCd(CommonConstants.EMAIL_TP_330);
				email.setStId(orderBase.getStId());
				email.setReceiverNm(orderBase.getOrdNm());
				email.setReceiverEmail(orderBase.getOrdrEmail());
				email.setMbrNo(orderBase.getMbrNo());
				email.setMap01(orderBase.getOrdNo());	//주문번호
				email.setMap02(DateUtil.getTimestampToString(orderBase.getOrdAcptDtm(), "yyyy.MM.dd HH:mm")); //주문일자
				email.setMap03(this.cacheService.getCodeName(CommonConstants.CLM_TP, claimBase.getClmTpCd()));	

				Long refundAmt = 0L;
				String refundSvmn = "0";
				String refundPayMeans = "적립금";
				String ooaNm = "";
				String bankNm = "";
				String acctNo = "";
				
				for(ClaimRefundPayDetailVO crpdvo: claimPay.getClaimRefundPayDetailListVO()){
					if(CommonConstants.PAY_MEANS_50.equals(crpdvo.getPayMeansCd())){
						refundSvmn = crpdvo.getPayAmt().toString();
					}else{
						refundAmt += crpdvo.getPayAmt();
						refundPayMeans = this.cacheService.getCodeName(CommonConstants.PAY_MEANS, crpdvo.getPayMeansCd());
						if(CommonConstants.PAY_MEANS_30.equals(crpdvo.getPayMeansCd()) || CommonConstants.PAY_MEANS_40.equals(crpdvo.getPayMeansCd())){
							ooaNm = crpdvo.getOoaNm();
							acctNo = crpdvo.getAcctNo();
							bankNm = this.cacheService.getCodeName(CommonConstants.BANK, crpdvo.getBankCd());
						}									
					}
				}

				email.setMap04(String.valueOf(refundAmt.longValue()));
				email.setMap05(refundSvmn);
				email.setMap06(refundPayMeans);
				email.setMap07(ooaNm); // 예금주
				email.setMap08(bankNm); // 은행명
				email.setMap09(acctNo); // 계좌번호
				
				if(claimDetailList != null && !claimDetailList.isEmpty()){
					for(ClaimDetailVO claimDetail : claimDetailList){
						esMap =  new EmailSendMap();
						
						esMap.setMap01(GoodsUtil.getGoodsImageSrc(bizConfig.getProperty("image.domain"), claimDetail.getImgPath(), claimDetail.getGoodsId(), claimDetail.getImgSeq(), ImageGoodsSize.SIZE_70.getSize()));	
						esMap.setMap02("[" + claimDetail.getBndNmKo() + "] " + claimDetail.getGoodsNm());
						esMap.setMap03(String.valueOf(claimDetail.getSaleAmt().longValue() - claimDetail.getPrmtDcAmt().longValue()));
						esMap.setMap04(String.valueOf(claimDetail.getClmQty().intValue()));
						esMap.setMap05(claimDetail.getItemNm());
						
						mapList.add(esMap);
					}
				}
				
				this.bizService.sendEmail(email, mapList);
				
			}catch(Exception e){
				log.error("[환불안내 메일 전송 오류] 클레임번호 : "+ clmNo);
			}
		}
		
		
		/************************************
		 * LMS 전송
		 * - 실결제 금액에 대한 환불이 존재하는 경우
		 * - 반품에 대한 환불인 경우
		 ************************************/
			
		if(sendLmsExcute
				&& CommonConstants.CHNL_GB_10.equals(chnlStdInfo.getChnlGbCd())){

			// 제휴몰 주문인 경우 제외
			try {
				LmsSendPO lspo = new LmsSendPO();
				
				lspo.setSendPhone(stInfo.getCsTelNo());
				lspo.setReceiveName(orderBase.getOrdNm());
				lspo.setReceivePhone(orderBase.getOrdrMobile());

				/*
				 * 제목 및 내용 설정
				 */
				CodeDetailVO smsTpVO = cacheService.getCodeCache(CommonConstants.SMS_TP, CommonConstants.SMS_TP_330);

				String subject = smsTpVO.getUsrDfn2Val();
				String msg = smsTpVO.getUsrDfn3Val();

				//제목 Argument 치환
				subject = StringUtil.replaceAll(subject,CommonConstants.SMS_TITLE_ARG_MALL_NAME, stInfo.getStNm());

				String goodsNm = claimDetailList.get(0).getGoodsNm();
				int etcGoodsCnt = claimDetailList.size() - 1;
				
				if(goodsNm.length() > 20){
					goodsNm = goodsNm.substring(0,  20) + "...";
				}
				
				if(etcGoodsCnt > 0){
					goodsNm += " 외 " + etcGoodsCnt + "개";
				}
				
				//내용 Argument 치환
				msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());
				msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_GOODS_NM, goodsNm);
				
				Long refundPayAmt = 0L;
				
				for(ClaimRefundPayDetailVO crpdvo: claimPay.getClaimRefundPayDetailListVO()){
					if(!CommonConstants.PAY_MEANS_50.equals(crpdvo.getPayMeansCd())){
						refundPayAmt += crpdvo.getPayAmt();
					}
				}
				
				String refundAmt = StringUtil.formatNum(String.valueOf(refundPayAmt.longValue()));
				
				msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_REFUND_AMT, refundAmt);
				
				lspo.setSubject(subject);
				lspo.setMsg(msg);
				
				this.bizService.sendLms(lspo);
					
			}catch(Exception e){
				log.error("[환불안내 LMS 전송 오류] 클레임번호 : "+ clmNo);
	
			}
		}
	}
	

}

