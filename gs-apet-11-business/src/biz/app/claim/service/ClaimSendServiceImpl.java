package biz.app.claim.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimRefundPayDetailVO;
import biz.app.claim.model.ClaimRefundPayVO;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.interfaces.TicketIncidentReqVO;
import biz.app.claim.model.interfaces.TicketIncidentResVO;
import biz.app.goods.util.GoodsUtil;
import biz.app.order.dao.OrderDlvraDao;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
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
import biz.interfaces.humuson.constants.HumusonConstants;
import framework.admin.util.AdminSessionUtil;
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
* - 설명			: 클레임 전송 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class ClaimSendServiceImpl implements ClaimSendService {

	@Autowired private CacheService cacheService;

	@Autowired	private ClaimBaseDao claimBaseDao;

	@Autowired	private ClaimDetailDao claimDetailDao;

	@Autowired	private OrderDlvraDao orderDlvraDao;

	@Autowired	private PayBaseDao payBaseDao;

	@Autowired private Properties bizConfig;

	@Autowired private BizService bizService;
		
	@Autowired private StDao stDao;
	
	@Autowired private ChnlStdInfoDao chnlStdInfoDao;
	
	@Autowired private ClaimService claimService;
	
	
	
	/* 
	 * 클레임 접수 메일 및 SMS 전송
	 * @see biz.app.claim.service.ClaimSendService#sendClaimAccept(java.lang.String)
	 */
	@Override
	public void sendClaimAccept(String clmNo){

		boolean sendExecute = true;
		ClaimBaseVO claimBase = null;
		List<ClaimDetailVO> claimDetailList = null;
		ClaimRefundPayVO  claimRefundPay = null;

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
			 *  클레임 상세 목록 조회
			 */
			ClaimDetailSO cdso = new ClaimDetailSO();
			cdso.setClmNo(claimBase.getClmNo());
			claimDetailList = this.claimDetailDao.listClaimDetail(cdso);
	
			if(claimDetailList == null || claimDetailList.isEmpty()){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NO_GOODS);
			}
	
			/*
			 * 결제 환불 정보
			 */
			ClaimSO cso = new ClaimSO();
			cso.setClmNo(claimBase.getClmNo());
			claimRefundPay = claimService.getClaimRefundPay(cso);
			
			// 사이트 정보 조회
			stInfo =  this.stDao.getStStdInfo(claimBase.getStId());
			
			// 채널정보
			chnlStdInfo = this.chnlStdInfoDao.getChnlStdInfo(claimBase.getChnlId());

		}catch(Exception e){
			log.error("[클레임 전송 정보 조회 오류] 클레임호 : "+ clmNo);
			sendExecute = false;
		}		
		
		if(sendExecute
				&& CommonConstants.CHNL_GB_10.equals(chnlStdInfo.getChnlGbCd())){
			// 제휴몰 주문인 경우 제외
			log.debug(">>>>>>>>>>>>>>>주문 전송 시작");
			/*****************************************
			 * 이메일 전송
			 ******************************************/
			try {
				EmailSend email = new EmailSend();
				List<EmailSendMap> mapList = new ArrayList<>();
				EmailSendMap esMap = null;
				
				if(CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())){
					email.setEmailTpCd(CommonConstants.EMAIL_TP_300);
					email.setMap20(HumusonConstants.EMAIL_CLAIM_TP_01);
				} else if(CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())){
					email.setEmailTpCd(CommonConstants.EMAIL_TP_310);
					email.setMap20(HumusonConstants.EMAIL_CLAIM_TP_02);
				} else if(CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd())){
					email.setEmailTpCd(CommonConstants.EMAIL_TP_320);
					email.setMap20(HumusonConstants.EMAIL_CLAIM_TP_03);
				}
				
				email.setStId(claimBase.getStId());
				email.setReceiverNm(claimBase.getOrdNm());
				email.setReceiverEmail(claimBase.getOrdrEmail());
				email.setMbrNo(claimBase.getMbrNo());

				email.setMap01(claimBase.getOrdNo());	//주문번호
				email.setMap02(DateUtil.getTimestampToString(claimBase.getAcptDtm(), "yyyy.MM.dd HH:mm")); //접수일자
	
				/*
				 * 클레임 유형별 설정
				 */
				if(CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd()) || CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())){
					/*
					 * 주문상품결제정보 설정
					 */
					if(Optional.ofNullable(claimRefundPay.getOrgDlvrcAmt()).orElse(0L).longValue() > 0){
						email.setMap13("(+)"); // 배송비 부호
					}else{
						email.setMap13(""); // 배송비 부호
					}
					email.setMap14(String.valueOf(Optional.ofNullable(claimRefundPay.getOrgDlvrcAmt()).orElse(0L).longValue())); // 배송비 금액

					if(claimRefundPay.getCpDcAmt().longValue() > 0){
						email.setMap17("(-)"); // 쿠폰할인 부호
					}else{
						email.setMap17(""); // 쿠폰할인 부호
					}
					email.setMap18(String.valueOf(Optional.ofNullable(claimRefundPay.getCpDcAmt()).orElse(0L).longValue())); // 쿠폰할인 금액
					
					email.setMap19(String.valueOf(claimRefundPay.getGoodsAmt() + claimRefundPay.getOrgDlvrcAmt() - claimRefundPay.getCpDcAmt())); // 결제금액
					
					
					/*
					 * 환불정보 설정
					 */
					email.setMap21(String.valueOf(claimRefundPay.getGoodsAmt() + claimRefundPay.getOrgDlvrcAmt() - claimRefundPay.getCpDcAmt()));//결제금액
					email.setMap22(String.valueOf(claimRefundPay.getGoodsAmt()));
					email.setMap23(String.valueOf(claimRefundPay.getOrgDlvrcAmt()));
					email.setMap24(String.valueOf(claimRefundPay.getNewRtnOrgDlvrcAmt() + claimRefundPay.getClmDlvrcAmt()));
					email.setMap25(String.valueOf(claimRefundPay.getNewRtnOrgDlvrcAmt() + claimRefundPay.getClmDlvrcAmt()));
					
					/*
					 * 환불결제 정보
					 */
					String refundTp = "01";	//01: 기타 , 02:가상계좌/무통장
					String refundPayMeans = "";
					Long 	refnudAmt = 0L;
					String refundSvmn = "0";
					String	refundBankCd = "";
					String refundAcctNo = "";
					String refundOoaNm = "";
					for(ClaimRefundPayDetailVO crpdvo :  claimRefundPay.getClaimRefundPayDetailListVO()){
						if(CommonConstants.PAY_MEANS_30.equals(crpdvo.getPayMeansCd()) || CommonConstants.PAY_MEANS_40.equals(crpdvo.getPayMeansCd())){
							refundTp = "02";
							refundBankCd = crpdvo.getBankCd();
							refundAcctNo = crpdvo.getAcctNo();
							refundOoaNm = crpdvo.getOoaNm();
									
						}
						if(CommonConstants.PAY_MEANS_50.equals(crpdvo.getPayMeansCd())){
							refundSvmn = crpdvo.getPayAmt().toString();
						}
						if(CommonConstants.PAY_MEANS_10.equals(crpdvo.getPayMeansCd()) || CommonConstants.PAY_MEANS_20.equals(crpdvo.getPayMeansCd())){
							refundPayMeans = this.cacheService.getCodeName(CommonConstants.PAY_MEANS, crpdvo.getPayMeansCd());
							refnudAmt += crpdvo.getPayAmt();
						}
					}
					
					email.setMap30(refundTp);
					
					if("01".equals(refundTp)){
						email.setMap26(String.valueOf(claimRefundPay.getTotAmt()));
						email.setMap27(refundPayMeans);
						email.setMap28(refnudAmt.toString());
						email.setMap29(refundSvmn);
					}else{
						email.setMap31(String.valueOf(claimRefundPay.getTotAmt()));
						email.setMap32(refundSvmn);
						email.setMap33("계좌입금");
						email.setMap34(refundOoaNm);
						email.setMap35(this.cacheService.getCodeName(CommonConstants.BANK, refundBankCd));
						email.setMap36(refundAcctNo);
					}

				}else{
					Long addDlvrAmt = 0L;
					
					if(claimRefundPay != null){
						addDlvrAmt = claimRefundPay.getNewRtnOrgDlvrcAmt() + claimRefundPay.getClmDlvrcAmt();
					}
					if(addDlvrAmt.longValue() > 0){
						email.setMap07(String.valueOf(addDlvrAmt.longValue())); // 교환배송비(금액)
						email.setMap08("선결제"); // 교환배송비(선결제/면제)
					}else{
						email.setMap07(""); // 교환배송비(금액)
						email.setMap08(""); // 교환배송비(선결제/면제)
					}
					
				}

				/*
				 * 클레임 상품 정보 설정
				 */
				String clmRsnCd = "";
				Long rtrnaNo = 0L;
				if(claimDetailList != null && !claimDetailList.isEmpty()){
					for(ClaimDetailVO claimDetail : claimDetailList){
						if(!CommonConstants.CLM_DTL_TP_40.equals(claimDetail.getClmDtlTpCd())){
						
							esMap =  new EmailSendMap();
							
							esMap.setMap01(GoodsUtil.getGoodsImageSrc(bizConfig.getProperty("image.domain"), claimDetail.getImgPath(), claimDetail.getGoodsId(), claimDetail.getImgSeq(), ImageGoodsSize.SIZE_70.getSize()));	
							esMap.setMap02("[" + claimDetail.getBndNmKo() + "] " + claimDetail.getGoodsNm());
							esMap.setMap03(String.valueOf(Optional.ofNullable(claimDetail.getSaleAmt()).orElse(0L).longValue() - Optional.ofNullable(claimDetail.getPrmtDcAmt()).orElse(0L).longValue()));
							esMap.setMap04(claimDetail.getItemNm() + " [ " + claimDetail.getClmQty().intValue() + "개 ]");
							
							clmRsnCd = claimDetail.getClmRsnCd();
							rtrnaNo = claimDetail.getRtrnaNo();
							mapList.add(esMap);
						}
					}
				}
				
				/*
				 * 클레임 사유 설정
				 */
				String clmRsnNm = this.cacheService.getCodeName(CommonConstants.CLM_RSN, clmRsnCd);
				email.setMap03(clmRsnNm); // 사유

				/*
				 * 회수배송지 정보 설정
				 */
				if(CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd()) || CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd())){
					OrderDlvraSO odaso = new OrderDlvraSO();
					odaso.setOrdDlvraNo(rtrnaNo);
					OrderDlvraVO orderDlvra = this.orderDlvraDao.getOrderDlvra(odaso);
					
					email.setMap09(orderDlvra.getAdrsNm()); // 회수배송지 > 받는사람
					email.setMap10(StringUtil.phoneNumber(orderDlvra.getMobile())); // 회수배송지 연락처
					email.setMap11(orderDlvra.getRoadAddr() + " " + orderDlvra.getRoadDtlAddr()); // 회수배송지 주소
					email.setMap12(orderDlvra.getDlvrMemo()); // 회수배송지 메모
				}
				
				//this.bizService.sendEmail(email, mapList);  임시코딩
				
			}catch(Exception e){
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				log.error("[클레임 접수 메일 전송 오류] 클레임번호 : "+ clmNo);
			}
			
			/************************************
			 * LMS 전송
			 * - 주문취소는 완료시점
			 * - 반품/교환은 접수시점
			 ************************************/
			try {
				LmsSendPO lspo = new LmsSendPO();
				
				lspo.setSendPhone(stInfo.getCsTelNo());
				lspo.setReceiveName(claimBase.getOrdNm());
				lspo.setReceivePhone(claimBase.getOrdrMobile());

				String smsTp = null;
				
				/*
				 *  클레임 유형별 코드정보 조회
				 */
				if(CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())){
					smsTp = CommonConstants.SMS_TP_300;
				}else if(CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())){
					smsTp = CommonConstants.SMS_TP_310;
				}else if(CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd())){
					smsTp = CommonConstants.SMS_TP_320;
				}
				
				CodeDetailVO smsTpVO = cacheService.getCodeCache(CommonConstants.SMS_TP, smsTp);

				/*
				 * 제목 및 내용 설정
				 */
				String subject = smsTpVO.getUsrDfn2Val();
				String msg = smsTpVO.getUsrDfn3Val();

				//제목 Argument 치환
				subject = StringUtil.replaceAll(subject,CommonConstants.SMS_TITLE_ARG_MALL_NAME, stInfo.getStNm());

				//내용 Argument 치환
				msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());
								
				String goodsNm = "";
				int etcClmCnt = 0;
				if(claimDetailList != null && !claimDetailList.isEmpty()) {
					goodsNm = claimDetailList.get(0).getGoodsNm();
					
					etcClmCnt = claimDetailList.size() - 1;
				}
				
				
				if(goodsNm.length() > 20){
					goodsNm = goodsNm.substring(0,  20) + "...";
				}
				
				if(! CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd()) && etcClmCnt > 0){
					goodsNm += " 외 " + etcClmCnt + "개";
				}

				msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_GOODS_NM, goodsNm);
				
				if(CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())){

					String cnclAmt = StringUtil.formatNum(String.valueOf(claimRefundPay.getTotAmt().longValue()));
					
					msg = StringUtil.replaceAll(msg, CommonConstants.SMS_MSG_ARG_CNCL_AMT, cnclAmt);
				} else {

					String clmRsnCd = claimDetailList.get(0).getClmRsnCd();
					String clmRsnNm = this.cacheService.getCodeName(CommonConstants.CLM_RSN, clmRsnCd);
					
					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_CLM_RSN_CONTENT, clmRsnNm);
				}
				
				lspo.setSubject(subject);
				lspo.setMsg(msg);
				
				this.bizService.sendLms(lspo);
					
			}catch(Exception e){
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				log.error("[클레임 접수 LMS 전송 오류] 클레임번호 : "+ clmNo);
	
			}
		}
	}

	@Override
	public void sendAddTicketIncident(ClaimRegist clmRegist) {
		
		if(StringUtils.isEmpty(clmRegist.getTwcTckt()) || StringUtils.isEmpty(clmRegist.getClmRsnCd())) {
			log.error("티켓 사건 추가 API PARAMETER 오류 : {}", clmRegist.toString());
		}else {
			CodeDetailVO rsnCd = cacheService.getCodeCache(CommonConstants.CLM_RSN, clmRegist.getClmRsnCd());
			
			if(rsnCd == null || StringUtils.isEmpty(rsnCd.getUsrDfn4Val())){
				log.error("클레임 사유 코드 - 티켓 이벤트 코드 정의되지 않음.");
			}else {
				TicketIncidentReqVO reqVO = null;
				String apiKey = bizConfig.getProperty("ticket.incident.api.key");
			
				try {
				
					reqVO = new TicketIncidentReqVO();
					reqVO.setApiKey(apiKey);
					reqVO.setTicketDispId(clmRegist.getTwcTckt());
					reqVO.setEventCode(rsnCd.getUsrDfn4Val());
					reqVO.setAgentLoginId(AdminSessionUtil.getSession().getLoginId());
					StringBuilder builder = new StringBuilder();
					if (CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())) {
						builder.append("주문취소가 되었습니다.");
					}else if(CommonConstants.CLM_TP_20.equals(clmRegist.getClmTpCd())) {
						builder.append("반품접수가 되었습니다.");
					}else if(CommonConstants.CLM_TP_20.equals(clmRegist.getClmTpCd())) {
						builder.append("교환접수가 되었습니다.");
					}
					
					builder.append("(").append(rsnCd.getDtlNm()).append(")");
					
					reqVO.setContent(builder.toString());
					
					String serverUrl = bizConfig.getProperty("ticket.incident.url");
					
					HttpHeaders headers = new HttpHeaders();
	
					// Content-Type 설정
					headers.setContentType(MediaType.APPLICATION_JSON);
					HttpEntity<TicketIncidentReqVO> entity = new HttpEntity<>(reqVO, headers);
					
					
					log.info("Request Header :{}", entity.getHeaders());
					log.info("Request body :{}", entity.getBody());
					
					HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
						factory.setConnectTimeout(5*1000); // 연결시간초과, ms
						factory.setReadTimeout(30*1000); // 읽기시간초과, ms
	
					RestTemplate restTemplate = new RestTemplate(factory);
					ResponseEntity<String> responseEntity = restTemplate.exchange(serverUrl, HttpMethod.POST, entity, String.class);
	
					log.info("Response Body {}", responseEntity.getBody());
					 
					String body = responseEntity.getBody();
					
					Gson gson = new Gson();
					TicketIncidentResVO res = gson.fromJson(body, TicketIncidentResVO.class);
					
					// 0 성공
					if(!"0".equals(res.getCode())) {
						log.error("티켓 사건 추가 API 응답 오류 : {}", res.toString());
					}
					log.info("RES VO :{}", res.toString());
				} catch (HttpStatusCodeException e) {
					log.error("{}", e.getStatusCode());
					log.error("티켓 사건 추가 API Connection 오류 : {}", reqVO != null ? reqVO.toString() : "");
	
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					log.error("티켓 사건 추가 API 오류 : {}", reqVO != null ? reqVO.toString() : "");
				}
			}
		}
	}
}