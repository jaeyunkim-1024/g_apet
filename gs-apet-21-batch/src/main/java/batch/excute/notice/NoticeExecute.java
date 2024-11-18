package batch.excute.notice;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.NoticeSendListDetailVO;
import biz.app.appweb.model.NoticeSendListVO;
import biz.app.appweb.model.PushDetailPO;
import biz.app.appweb.model.PushPO;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.service.PushService;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.common.model.EmailRecivePO;
import biz.common.model.NaverEmailSendPO;
import biz.common.model.NaverPushPO;
import biz.common.model.NaverPushTargetPO;
import biz.common.model.PushMessagePO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class NoticeExecute {

//	@Autowired private MessageSourceAccessor message;
	
	@Autowired private PushService pushService;
	
	@Autowired private BatchService batchService;
	
	@Autowired private BizService bizService;
	
	@Autowired private MemberBaseDao memberBaseDao;
	
	@Autowired private PushDao pushDao;
	
	@Autowired private Properties bizConfig;
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeExecute.java
	* - 작성일		: 2021. 02. 23.
	* - 작성자		: KKB
	* - 설명		: 예약 발송(EMAIL)
	* </pre>
	*/
	@SuppressWarnings("unchecked")
//	@Scheduled(fixedDelay=60000)
	public void rsrvEmailSend() {
	
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_RSRV_EMAIL_SEND);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		/***********************
		 * 메일전송
		 ***********************/
		PushSO pso = new PushSO();
		pso.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);
		pso.setSendReqYn(CommonConstants.COMM_YN_N);
		pso.setSndTypeCd(CommonConstants.SND_TYPE_40);
		Date now = new Date();
		pso.setEndDate(new Timestamp(now.getTime()));
		List<NoticeSendListVO> noticeSendNoList = pushService.listRsrvNotice(pso);
		int total = 0;
		if(CollectionUtils.isNotEmpty(noticeSendNoList)) {
			for(NoticeSendListVO nslvo: noticeSendNoList) { 
				total += nslvo.getDetailList().size();
			}
		}
		int fail = 0;
		if(CollectionUtils.isNotEmpty(noticeSendNoList)) {
			for(NoticeSendListVO nslvo: noticeSendNoList) {
				int thisTotal = 0;
				int thisFail = 0;
				NaverEmailSendPO nespo = new NaverEmailSendPO();
				nespo.setSenderAddress(nslvo.getSenderEmail());
				nespo.setTitle(nslvo.getSubject());
				nespo.setBody(nslvo.getContents());
//				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				nespo.setReservationDateTime(formatter.format(nslvo.getSendReqDtm()));
				List<EmailRecivePO> recipients = new ArrayList<EmailRecivePO>();
				for(NoticeSendListDetailVO detailvo : nslvo.getDetailList()) {
					thisTotal++;
					try {
						EmailRecivePO erpo = new EmailRecivePO();
						erpo.setAddress(detailvo.getReceiverEmail());
						if(StringUtil.isNotEmpty(detailvo.getMbrNo())) {
							MemberBaseSO mbso = new MemberBaseSO();
							mbso.setMbrNo(detailvo.getMbrNo());
							MemberBaseVO mbvo = memberBaseDao.getMemberBase(mbso);
							if(StringUtil.isNotBlank(mbvo.getMbrNm())) {
								erpo.setName(bizService.twoWayDecrypt(mbvo.getMbrNm(), detailvo.getMbrNo()));
							}
						}						
						Map<String, String> parameters = new HashMap<>();
						if(StringUtil.isNotBlank(detailvo.getSndInfo())) {
							parameters = new ObjectMapper().readValue(detailvo.getSndInfo(), HashMap.class);
							erpo.setParameters(parameters);
						}
						recipients.add(erpo);
					} catch (IOException e) {
						thisFail++;
						log.error("************************************");
						log.error("이메일 전송 Data Param 오류");
						log.error("이력 상세 번호 : " + detailvo.getHistDtlNo());
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						log.error("************************************");
					}
				}
				nespo.setRecipients(recipients);
				
				ObjectMapper obm = new ObjectMapper();
				String json = "";
				String requestId = "";
				PushPO ppo = new PushPO();
				try {
					json = obm.writeValueAsString(nespo);
					String JSONInput = json;
					JsonNode sentResultJsonNode = bizService.sendNaverEmail(JSONInput); // 이메일 API 전송
					requestId = sentResultJsonNode.findValue("requestId").toString().replace("\"", "");
					
					// 이력 데이터
					ppo.setNoticeSendNo(nslvo.getNoticeSendNo());
					ppo.setSendReqYn(CommonConstants.COMM_YN_Y);
					ppo.setOutsideReqId(requestId);
					if (StringUtil.isNotBlank(requestId)) { 
						ppo.setSndRstCd(CommonConstants.SND_RST_S);
						fail += thisFail;
					} else {
						ppo.setSndRstCd(CommonConstants.SND_RST_F);
						fail += thisTotal;
					}
				} catch (JsonProcessingException e) {
					fail += thisTotal;
					log.error("************************************");
					log.error("이메일 전송 Data 오류");
					log.error("이력 번호 : " + nslvo.getNoticeSendNo());
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					log.error("************************************");
				}
				// 알림 발송 리스트 업데이트
				pushDao.updateNoticeSendList(ppo);
			}
		}

		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+(total - fail)+" success, "+fail+" failed]";
		blpo.setBatchRstMsg(RstMsg);

		if(total != 0) {batchService.insertBatchLog(blpo);}
	}

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeExecute.java
	* - 작성일		: 2021. 02. 23.
	* - 작성자		: KKB
	* - 설명		: 예약 발송(PUSH)
	* </pre>
	*/
	@SuppressWarnings("unchecked")
//	@Scheduled(fixedDelay=60000)
	public void rsrvPushSend() {
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_RSRV_PUSH_SEND);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		/***********************
		 * PUSH 전송
		 ***********************/
		PushSO pso = new PushSO();
		pso.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);
		pso.setSendReqYn(CommonConstants.COMM_YN_N);
		pso.setSndTypeCd(CommonConstants.SND_TYPE_10);
		Date now = new Date();
		pso.setEndDate(new Timestamp(now.getTime()));
		List<NoticeSendListVO> noticeSendNoList = pushService.listRsrvNotice(pso);
		int total = 0;
		if(CollectionUtils.isNotEmpty(noticeSendNoList)) {
			for(NoticeSendListVO nslvo: noticeSendNoList) { 
				total += nslvo.getDetailList().size();
			}
		}
		int fail = 0;
		if(CollectionUtils.isNotEmpty(noticeSendNoList)) {
			for(NoticeSendListVO nslvo: noticeSendNoList) {
				int thisTotal = 0;
				
				NaverPushPO nppo = new NaverPushPO();	// 네이버 발송 PO
				SendPushPO sppo = new SendPushPO ();
				sppo.setTitle(nslvo.getSubject());
//				sppo.setBody(nslvo.getContents());
				sppo.setBody(StringEscapeUtils.unescapeHtml4(nslvo.getContents()));
				
				if(StringUtil.isNotEmpty(nslvo.getDetailList()) && StringUtil.isNotEmpty(nslvo.getDetailList().get(0)) && StringUtil.isNotBlank(nslvo.getDetailList().get(0).getSndInfo())) {
					PushTargetPO ptpo = new PushTargetPO();
					try {
						ObjectMapper mapper = new ObjectMapper();
						JsonNode sndInfo = mapper.readTree(nslvo.getDetailList().get(0).getSndInfo());
						if(StringUtil.isNotEmpty(sndInfo.findValue("image"))){
							String thisImg = StringEscapeUtils.unescapeHtml4(sndInfo.findValue("image").toString());
							ptpo.setImage(thisImg.replaceAll("\"", ""));
						}
						if(StringUtil.isNotEmpty(sndInfo.findValue("landingUrl"))){
							String thisLandingUrl = StringEscapeUtils.unescapeHtml4(sndInfo.findValue("landingUrl").toString());
							ptpo.setLandingUrl(thisLandingUrl.replaceAll("\"", ""));
						}
						List<PushTargetPO> target = new ArrayList<>();
						target.add(ptpo);
						sppo.setTarget(target);
					} catch (IOException e) {
						log.error("************************************");
						log.error("PUSH 전송 Data Param 오류");
						log.error("이력 번호 : " + nslvo.getNoticeSendNo());
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						log.error("************************************");
					}
				}
				Map<String, PushMessagePO> message = bizService.convertToNaver(sppo); // 메세지 형식 네이버에 맞게 변환
				nppo.setMessage(message);
				
				NaverPushTargetPO nptpo = new NaverPushTargetPO();
				String reqDeviceType = null;
				if(CommonConstants.DEVICE_TYPE_10.equalsIgnoreCase(nslvo.getDeviceTypeCd())) {
					reqDeviceType = CommonConstants.PUSH_TYPE_ANDROID;
				}else if(CommonConstants.DEVICE_TYPE_20.equalsIgnoreCase(nslvo.getDeviceTypeCd())) {
					reqDeviceType = CommonConstants.PUSH_TYPE_IOS;
				}
				nptpo.setDeviceType(reqDeviceType);
				thisTotal = nslvo.getDetailList().size();
				ArrayList<String> sendTo = new ArrayList<String>();
				for(int i = 0 ; i < thisTotal ; i++) {
					// MEMBER_BASE의 INFO_RCV_YN확인
					MemberBaseSO mbso = new MemberBaseSO();
					mbso.setMbrNo(nslvo.getDetailList().get(i).getMbrNo());
					MemberBaseVO thisMbvo = memberBaseDao.getMemberBase(mbso);
					if(StringUtil.isBlank(thisMbvo.getInfoRcvYn()) || !thisMbvo.getInfoRcvYn().equals(CommonConstants.COMM_YN_N)) {
						sendTo.add(Long.toString(nslvo.getDetailList().get(i).getMbrNo()));
					}
				}
				nptpo.setTo(sendTo.toArray(new String[sendTo.size()]));
				nppo.setTarget(nptpo);
				
				// 수신거부로 수신자 없을경우 API 호출 안함
				JsonNode sentResultJsonNode = null;
				String requestId = null;
				String statusCode = null;
				if(sendTo.size() != 0) {
					sentResultJsonNode =bizService.sendNaverPush(nppo); // 발송 API호출
					requestId = sentResultJsonNode.findValue("requestId").toString().replace("\"", "");
					statusCode = sentResultJsonNode.findValue("statusCode").toString().replace("\"", "");
				}
				
				// 이력 데이터
				PushPO ppo = new PushPO();
				ppo.setNoticeSendNo(nslvo.getNoticeSendNo());
				ppo.setSendReqYn(CommonConstants.COMM_YN_Y);
				ppo.setOutsideReqId(requestId);
				if ( sendTo.size() == 0 || (StringUtil.isNotBlank(requestId) && CommonConstants.PUSH_RESULT_SUCCESS.equals(statusCode))) {  // 수신거부로 수신자 없을경우 성공처리
					ppo.setSndRstCd(CommonConstants.SND_RST_S);
					// 회원기본(MEMBER_BASE) 테이블의 알림수신여부(ALM_RCV_YN) 컬럼을 ‘Y’로 업데이트
					for (String thisMbrNo : sendTo) {
						MemberBasePO mbpo = new MemberBasePO();
						mbpo.setMbrNo(Long.parseLong(thisMbrNo));
						mbpo.setAlmRcvYn(CommonConstants.COMM_YN_Y);
						memberBaseDao.updateMemberBase(mbpo);
					}
				} else {
					ppo.setSndRstCd(CommonConstants.SND_RST_F);
					fail += thisTotal;
				}
				// 알림 발송 리스트 업데이트
				pushDao.updateNoticeSendList(ppo);
			}
		}

		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+(total - fail)+" success, "+fail+" failed]";
		blpo.setBatchRstMsg(RstMsg);

		if(total != 0) {batchService.insertBatchLog(blpo);}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeExecute.java
	* - 작성일		: 2021. 03. 03.
	* - 작성자		: KKB
	* - 설명		: 발송 이력 결과(EMAIL)
	* </pre>
	*/
	@SuppressWarnings("unchecked")
//	@Scheduled(fixedDelay=360000)
	public void sentEmailResult() {
	
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_SENT_EMAIL_RST);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int total = 0;
		int success = 0;
		/*************************
		 * 이력 데이터 조회
		 *************************/
		PushSO pso = new PushSO();
		pso.setSndTypeCd(CommonConstants.SND_TYPE_40);
		pso.setSendReqYn(CommonConstants.COMM_YN_Y);
		pso.setSndRstCdNullYn(CommonConstants.COMM_YN_Y);
		// 발송후 이력 없는 데이터 조회 조회
		List<NoticeSendListDetailVO> listSentNoticeDetail = pushDao.listSentNoticeDetail(pso);
		if(CollectionUtils.isNotEmpty(listSentNoticeDetail)) {
			total = listSentNoticeDetail.size();
			Map<String, Long> outsideReqIds = new HashMap<>();		
			for(NoticeSendListDetailVO nsldvo : listSentNoticeDetail) {
				outsideReqIds.put(nsldvo.getOutsideReqId(), nsldvo.getNoticeSendNo());
			}
			// OutsideReqId 별 API 조회
			for(String key : outsideReqIds.keySet()){
				// naver API getMailList
				JsonNode thisMailList = getNaverMailList(key);
				for (JsonNode objNode : thisMailList.get("content")) {
					String mailId = (objNode.get("mailId") != null)?objNode.get("mailId").asText():null;
					PushDetailPO pdpo = new PushDetailPO();
					pdpo.setSubject((objNode.get("title") != null)? objNode.get("title").asText() : null);
					pdpo.setOutsideReqDtlId(mailId);
					pdpo.setReceiverEmail((objNode.get("representativeRecipient") != null)? objNode.get("representativeRecipient").asText() : null);
					pdpo.setSendReqDtm((objNode.get("sendDate") != null && objNode.get("sendDate").get("utc") != null)? new Timestamp(objNode.get("sendDate").get("utc").asLong()): null);
					pdpo.setSndRstCd((objNode.get("emailStatus").get("code") != null)? objNode.get("emailStatus").get("code").asText() : null);
					// naver API getMail
					JsonNode thisMail = getNaverMail(mailId);
					pdpo.setContents((thisMail.get("body") != null)? thisMail.get("body").asText() : null);
					pdpo.setNoticeSendNo(outsideReqIds.get(key));					
					log.debug("getSubject :"+pdpo.getSubject());
					log.debug("getOutsideReqDtlId :"+pdpo.getOutsideReqDtlId());
					log.debug("getReceiverEmail :"+pdpo.getReceiverEmail());
					log.debug("getSendReqDtm :"+pdpo.getSendReqDtm());
					log.debug("getSndRstCd :"+pdpo.getSndRstCd());
					log.debug("getContents :"+pdpo.getContents());
					log.debug("getNoticeSendNo :"+pdpo.getNoticeSendNo());
					// 이력 결과 업데이트
					if(pdpo.getOutsideReqDtlId() != null && pdpo.getSndRstCd() != null) {
						PushDetailPO pd = new PushDetailPO();
						pd.setSubject(pdpo.getSubject());
						pd.setOutsideReqDtlId(pdpo.getOutsideReqDtlId());
						pd.setReceiverEmail(pdpo.getReceiverEmail());
						pd.setSendReqDtm(pdpo.getSendReqDtm());
						pd.setSndRstCd(pdpo.getSndRstCd());
						pd.setContents(pdpo.getContents());
						pd.setNoticeSendNo(pdpo.getNoticeSendNo());
						success += pushDao.updateNoticeSendDetailList(pd); 
					}
				}
	        }
		}
		
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+(success)+" success, "+(total-success)+" failed]";
		blpo.setBatchRstMsg(RstMsg);

		if(total != 0) {batchService.insertBatchLog(blpo);}
	}
	
	
	
	public JsonNode getNaverMailList(String requestId) {// 네이버 이메일 이력조회(리스트)
		try {
			String url = bizConfig.getProperty("naver.cloud.outmail.url")+"/requests/"+ requestId + "/mails";
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			String signature = bizService.makeSignature("/api/v1/mails/requests/"+ requestId + "/mails", "GET", String.valueOf(timestamp),
					bizConfig.getProperty("naver.cloud.outmail.access"),
					bizConfig.getProperty("naver.cloud.outmail.secret"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			HttpEntity<String> entity = new HttpEntity<String>(headers);
			log.info("=================== getNaverMailList request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());
			log.info("========================================================");

			String result = bizService.convertToCisApi(url, HttpMethod.GET, entity);
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readTree(result);
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_METHOD_NOT_ALLOWED:
				throw new CustomException(ExceptionConstants.ERROR_API_METHOD_NOT_ALLOWED);
			case HttpStatus.SC_INTERNAL_SERVER_ERROR:
				throw new CustomException(ExceptionConstants.ERROR_API_INTERNAL_SERVER_ERROR);
			default:
				throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
			}
		} catch (CustomException ce) {
			throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
	}
	
	public JsonNode getNaverMail(String mailId) {// 네이버 이메일 이력조회(단건: 내용)
		try {
			String url = bizConfig.getProperty("naver.cloud.outmail.url")+"/"+ mailId;
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			String signature = bizService.makeSignature("/api/v1/mails/"+ mailId, "GET", String.valueOf(timestamp),
					bizConfig.getProperty("naver.cloud.outmail.access"),
					bizConfig.getProperty("naver.cloud.outmail.secret"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			HttpEntity<String> entity = new HttpEntity<String>(headers);
			log.info("=================== getNaverMailList request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());
			log.info("========================================================");

			String result = bizService.convertToCisApi(url, HttpMethod.GET, entity);
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readTree(result);
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_METHOD_NOT_ALLOWED:
				throw new CustomException(ExceptionConstants.ERROR_API_METHOD_NOT_ALLOWED);
			case HttpStatus.SC_INTERNAL_SERVER_ERROR:
				throw new CustomException(ExceptionConstants.ERROR_API_INTERNAL_SERVER_ERROR);
			default:
				throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
			}
		} catch (CustomException ce) {
			throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
	}
}
