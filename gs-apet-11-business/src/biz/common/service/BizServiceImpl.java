package biz.common.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;
import java.util.Map.Entry;
import java.util.function.Predicate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import com.google.gson.GsonBuilder;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.net.util.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import com.google.gson.Gson;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.PushDetailPO;
import biz.app.appweb.model.PushPO;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.contents.model.VodSO;
import biz.app.email.dao.EmailSendHistoryDao;
import biz.app.email.dao.EmailSendHistoryMapDao;
import biz.app.email.model.EmailSendHistoryMapPO;
import biz.app.email.model.EmailSendHistoryPO;
import biz.app.emma.service.EmmaService;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.dao.MemberDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberUnsubscribeVO;
import biz.app.sms.service.SmsHistService;
import biz.app.ssgmessage.dao.SsgDao;
import biz.app.st.dao.StDao;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import biz.common.dao.BizDao;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileSO;
import biz.common.model.AttachFileVO;
import biz.common.model.EmailRecivePO;
import biz.common.model.EmailSend;
import biz.common.model.EmailSendMap;
import biz.common.model.EmailSendPO;
import biz.common.model.LmsSendPO;
import biz.common.model.NaverEmailSendPO;
import biz.common.model.NaverPushPO;
import biz.common.model.NaverPushTargetPO;
import biz.common.model.PushMessagePO;
import biz.common.model.PushTargetPO;
import biz.common.model.PushTokenPO;
import biz.common.model.PushTokenSO;
import biz.common.model.PushTokenVO;
import biz.common.model.SearchEngineEventPO;
import biz.common.model.SendPushPO;
import biz.common.model.SmsSendPO;
import biz.common.model.SsgKkoBtnPO;
import biz.common.model.SsgMessageSendPO;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.cis.client.ApiClient;
import framework.cis.model.request.gateway.GatewayRequest;
import framework.cis.model.response.ApiResponse;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.CisApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;
import net.minidev.json.JSONObject;
import net.sf.json.JSONArray;

@Slf4j
//@Service
@Transactional
public class BizServiceImpl implements BizService {

	@Autowired private BizDao bizDao;

	@Autowired private SmsHistService smsHistService;

	@Autowired private Properties bizConfig;

	@Autowired private Properties webConfig;

	@Autowired private CacheService cacheService;
	
	@Autowired private EmailSendHistoryDao emailSendHistoryDao;
	
	@Autowired private EmailSendHistoryMapDao emailSendHistoryMapDao;
	
	@Autowired private MessageSourceAccessor message;

	@Autowired private EmmaService emmaService;
	
	@Autowired private StDao stDao;
	
	@Autowired private PushService pushService;
	
	@Autowired private PushDao pushDao;
	
	@Autowired private MemberDao memberDao;

	@Autowired private SsgDao ssgDao;
	
	@Autowired private StService stService;
	
	@Autowired private MemberBaseDao memberBaseDao;
	
	@Autowired private PetraUtil PetraUtil;
	
	@Autowired private ApiClient apiClient;
	
//	private String ssgBody;
	
	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	public Long getSequence (String sequence ) {
		Long seqNo = null;
		seqNo = bizDao.getSequence(sequence );
		if(log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("{} SeqNo : {}", sequence, seqNo );
			log.debug("==================================================");
		}
		return seqNo;
	}

	/*
	 * SMS 전송
	 * 0 : 전송, -1:예약시간 없음, -2:예약시간형식오류, -3:수신자정보가 없음, -4:수신번호수와 수신자명수가 다름, -5:메세지 없음
	 * @see biz.app.sms.service.SmsService#sendSms(biz.app.sms.model.SmsSendDTO)
	 */
	@Override
	public int sendSms(SmsSendPO po) {
		int result = 0;

//
//		String url = bizConfig.getProperty("mdalin.sms.url");
//		String remoteId = bizConfig.getProperty("mdalin.remote.id");
//		String remotePass = bizConfig.getProperty("mdalin.remote.password");
//		String remoteReturnurl = bizConfig.getProperty("mdalin.remote.return.url");
//		String remoteCallBack = bizConfig.getProperty("mdalin.remote.send.no");
//
//		String	reserveTime = "";
//		String	reserveType = "";
//		String	receivePhone = "";
//		String  receiveName = "";
//		String[] receivePhones = null;
//		String[] receiveNames = null;
//		String  receiveMsg = "";
//		String  sendPhone = "";

		try {
			log.debug("start sendSms");
//			// 예약 관련 체크로직
//			if(CommonConstants.COMM_YN_Y.equals(po.getReserveYn())){
//				reserveType = "1";
//	
//				if(po.getReserveTime() == null || "".equals(po.getReserveTime())){
//					result = -1;
//				} else {
//					if(po.getReserveTime().length() == 12){
//						String dateFormat = "(\\d{4})(\\d{2})(\\d{2})(\\d{2})(\\d{2})";
//						reserveTime = po.getReserveTime().replaceAll(dateFormat, "$1-$2-$3 $4:$5");
//					}else{
//						result = -2;
//					}
//				}
//			}else{
//				reserveType = "0";
//			}
//	
//			// 수신자정보관련 체크 로직
//			if("".equals(po.getReceivePhone())){
//				result = -3;
//			}else{
//				receivePhone = po.getReceivePhone().replaceAll(" ", "").replaceAll("-", "");
//				receivePhones = receivePhone.split(",");
//	
//				if(po.getReceiveName() != null && !"".equals(po.getReceiveName())){
//					receiveName = po.getReceiveName().replaceAll(" ", "");
//					receiveNames = receiveName.split(",");
//	
//					if(receivePhones.length != receiveNames.length){
//						result = -4;
//					}
//				}
//	
//			}
//	
//			if(po.getMsg() == null || "".equals(po.getMsg())){
//				result = -5;
//			}else{
//				receiveMsg = po.getMsg();
//			}
//	
//			receiveMsg = StringUtil.cutText(receiveMsg, 90, false);
//	
//			if(po.getSendPhone() == null || "".equals(po.getSendPhone())){
//				sendPhone = remoteCallBack;
//			}else{
//				sendPhone = po.getSendPhone();
//			}
//	
//			if(result == 0){
//				MdalinSendDTO msdto = new MdalinSendDTO();
//	
//				msdto.setRemoteReserve(reserveType);
//				msdto.setRemoteReservetime(reserveTime);
//				msdto.setRemotePhone(receivePhone);
//				msdto.setRemoteName(receiveName);
//				msdto.setRemoteNum(String.valueOf(receivePhones.length));
//				msdto.setRemoteSubject("");
//				msdto.setRemoteMsg(receiveMsg);
//				msdto.setRemoteContents("");
//	
//				String smsHistId = String.valueOf(System.nanoTime());
//				msdto.setRemoteEtc1(smsHistId);
//				msdto.setRemoteEtc2("");
//				msdto.setRemoteCallback(sendPhone);
//	
//				MdalinClient client = new MdalinClient(url, remoteId, remotePass, remoteReturnurl);
//				// 임시로 막았음 2017.1.20
//				//int sendStatus = client.sms(msdto);
//				int sendStatus = 9999;
//	
//				// 이력 등록
//				SmsHistPO shpo = new SmsHistPO();
//				shpo.setSmsHistId(smsHistId);
//				shpo.setSmsGbCd(CommonConstants.SMS_GB_10);
//				shpo.setSndNo(msdto.getRemoteCallback());
//				shpo.setTtl(msdto.getRemoteSubject());
//				shpo.setContent(receiveMsg);
//				shpo.setRsvYn(po.getReserveYn());
//				shpo.setRsvDtm(msdto.getRemoteReservetime());
//				shpo.setUsrDfn1(msdto.getRemoteEtc1());
//				shpo.setUsrDfn2(msdto.getRemoteEtc2());
//				shpo.setSndRstStat(String.valueOf(sendStatus));
//				shpo.setSysRegrNo(po.getSysRegrNo());
//				smsHistService.insertSmsHist(shpo, receivePhones, receiveNames);
//			}
	
//			log.debug(">>>>>>>>>>SMS SEND RESULT = " + result);
			
		}catch(Exception e){
			// 보안성 진단. 오류메시지를 통한 정보노출
			//log.error(e.toString());
			log.error("#### sendSms exception", e.getClass());
		}
		return result;
	}

	/*
	 * LMS 전송
	 * 0 : 전송, -1:예약시간 없음, -2:예약시간형식오류, -3:수신자정보가 없음, -4:수신번호수와 수신자명수가 다름, -5:메세지 없음
	 * @see biz.app.sms.service.SmsService#sendLms(biz.app.sms.model.LmsSendPO)
	 */
	@Override
	public int sendLms(LmsSendPO po) {
		int result = 0;


//		String url = bizConfig.getProperty("mdalin.lms.url");
//		String remoteId = bizConfig.getProperty("mdalin.remote.id");
//		String remotePass = bizConfig.getProperty("mdalin.remote.password");
//		String remoteReturnurl = bizConfig.getProperty("mdalin.remote.return.url");
//		String remoteCallBack = bizConfig.getProperty("mdalin.remote.send.no");
//
//		String	reserveTime = "";
//		String	reserveType = "";
//		String	receivePhone = "";
//		String  receiveName = "";
//		String[] receivePhones = null;
//		String[] receiveNames = null;
//		String	receiveSubject =  "";
//		String  receiveMsg = "";
//		String  sendPhone = "";

		try {
			log.debug("start sendLms");
//			// 예약 관련 체크로직
//			if(CommonConstants.COMM_YN_Y.equals(po.getReserveYn())){
//				reserveType = "1";
//	
//				if(po.getReserveTime() == null || "".equals(po.getReserveTime())){
//					result = -1;
//				} else {
//					if(po.getReserveTime().length() == 12){
//						String dateFormat = "(\\d{4})(\\d{2})(\\d{2})(\\d{2})(\\d{2})";
//						reserveTime = po.getReserveTime().replaceAll(dateFormat, "$1-$2-$3 $4:$5");
//					}else{
//						result = -2;
//					}
//				}
//			}else{
//				reserveType = "0";
//			}
//	
//			// 수신자정보관련 체크 로직
//			if("".equals(po.getReceivePhone())){
//				result = -3;
//			}else{
//				receivePhone = po.getReceivePhone().replaceAll(" ", "").replaceAll("-", "");
//				receivePhones = receivePhone.split(",");
//	
//				if(po.getReceiveName() != null && !"".equals(po.getReceiveName())){
//					receiveName = po.getReceiveName().replaceAll(" ", "");
//					receiveNames = receiveName.split(",");
//	
//					if(receivePhones.length != receiveNames.length){
//						result = -4;
//					}
//				}
//	
//			}
//	
//			if(po.getSubject() == null || "".equals(po.getSubject())){
//				receiveSubject = po.getMsg().substring(0, 20);
//			}else{
//				receiveSubject = po.getSubject();
//			}
//	
//			if(receiveSubject.length() > 20){
//				receiveSubject = receiveSubject.substring(0, 20);
//			}
//	
//			if(po.getMsg() == null || "".equals(po.getMsg())){
//				result = -5;
//			}else{
//				receiveMsg = po.getMsg();
//			}
//	
//			receiveMsg = StringUtil.cutText(receiveMsg, 2000, false);
//	
//			if(po.getSendPhone() == null || "".equals(po.getSendPhone())){
//				sendPhone = remoteCallBack;
//			}else{
//				sendPhone = po.getSendPhone();
//			}
//	
//			if(result == 0){
//				MdalinSendDTO mldto = new MdalinSendDTO();
//	
//				mldto.setRemoteReserve(reserveType);
//				mldto.setRemoteReservetime(reserveTime);
//				mldto.setRemotePhone(receivePhone);
//				mldto.setRemoteName(receiveName);
//				mldto.setRemoteNum(String.valueOf(receivePhones.length));
//				mldto.setRemoteSubject(receiveSubject);
//				mldto.setRemoteMsg(receiveMsg);
//				mldto.setRemoteContents("");
//	
//				String smsHistId = String.valueOf(System.nanoTime());
//				mldto.setRemoteEtc1(smsHistId);
//				mldto.setRemoteEtc2("");
//	
//				mldto.setRemoteCallback(sendPhone);
//	
//				MdalinClient client = new MdalinClient(url, remoteId, remotePass, remoteReturnurl);
//				// 임시로 막음 2017.05.11 snw
//				//int sendStatus = client.sms(mldto);
//	
//				int sendStatus = 200;
//				
//				// 이력 등록
//				SmsHistPO shpo = new SmsHistPO();
//				shpo.setSmsHistId(smsHistId);
//				shpo.setSmsGbCd(CommonConstants.SMS_GB_20);
//				shpo.setSndNo(mldto.getRemoteCallback());
//				shpo.setTtl(mldto.getRemoteSubject());
//				shpo.setContent(receiveMsg);
//				shpo.setRsvYn(po.getReserveYn());
//				shpo.setRsvDtm(mldto.getRemoteReservetime());
//				shpo.setUsrDfn1(mldto.getRemoteEtc1());
//				shpo.setUsrDfn2(mldto.getRemoteEtc2());
//				shpo.setSndRstStat(String.valueOf(sendStatus));
//				shpo.setSysRegrNo(po.getSysRegrNo());
//				smsHistService.insertSmsHist(shpo, receivePhones, receiveNames);
//			}
//	
//			log.debug(">>>>>>>>>>LMS SEND RESULT = " + result);
		}catch(Exception e){
			// 보안성 진단. 오류메시지를 통한 정보노출
			//log.error(e.toString());
			log.error("#### sendLms exception", e.getClass());
		}

		return result;
	}

	
	/*
	 * 이메일 전송
	 * @see biz.common.service.BizService#sendEmail(biz.common.model.EmailSend, java.util.List)
	 */
	@Override
	@Deprecated
	public void sendEmail(EmailSend email, List<EmailSendMap> mapList) {
		int result = 0;
		EmailSendHistoryPO eshpo = null;
		EmailSendHistoryMapPO eshmpo = null;
		
		/******************************
		 * 메일 유형 정보 조회
		 ******************************/
		CodeDetailVO emailTpVO = cacheService.getCodeCache(CommonConstants.EMAIL_TP, email.getEmailTpCd());
		
		if(emailTpVO == null){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		/*
		 * Mapping 테이블 존재유무에 따른 데이터 검증
		 */
		if(CommonConstants.COMM_YN_Y.equals(emailTpVO.getUsrDfn2Val()) && (mapList == null || mapList.isEmpty())){
			throw new CustomException(ExceptionConstants.ERROR_EMAIL_SEND_HISTORY_MAP_NO_EXISTS);
		}
		
		/*****************************
		 * 기본데이터 설정 및 등록
		 *****************************/
		eshpo = new EmailSendHistoryPO();
		eshpo.setEmailTpCd(email.getEmailTpCd());
		eshpo.setMbrNo(email.getMbrNo());
		eshpo.setReceiverNm(email.getReceiverNm());
		eshpo.setReceiverEmail(email.getReceiverEmail());
		
		/*
		 * 보내는 사람 설정
		 */
		StStdInfoVO stInfo = stDao.getStStdInfo(email.getStId());
		eshpo.setSenderNm(stInfo.getStNm());	
		eshpo.setSenderEmail(stInfo.getDlgtEmail());
		
		/*
		 * 제목 : 공통코드 사용자정의 3번 필드에서 조회
		 *  - 임시 이메일인 경우 제목 별도
		 */
		String subJect = "";
		
		if(CommonConstants.EMAIL_TP_110.equals(email.getEmailTpCd())){
			subJect = email.getSubject();
		}else{
			eshpo.setStId(email.getStId());
			subJect = emailTpVO.getUsrDfn3Val();
			subJect = subJect.replace(CommonConstants.EMAIL_TITLE_ARG_MALL_NAME, stInfo.getStNm());
		}
		eshpo.setSubject(subJect);
		eshpo.setContents(email.getContents());
		
		eshpo.setMap01(email.getMap01());
		eshpo.setMap02(email.getMap02());
		eshpo.setMap03(email.getMap03());
		eshpo.setMap04(email.getMap04());
		eshpo.setMap05(email.getMap05());
		eshpo.setMap06(email.getMap06());
		eshpo.setMap07(email.getMap07());
		eshpo.setMap08(email.getMap08());
		eshpo.setMap09(email.getMap09());
		eshpo.setMap10(email.getMap10());
		eshpo.setMap11(email.getMap11());
		eshpo.setMap12(email.getMap12());
		eshpo.setMap13(email.getMap13());
		eshpo.setMap14(email.getMap14());
		eshpo.setMap15(email.getMap15());
		eshpo.setMap16(email.getMap16());
		eshpo.setMap17(email.getMap17());
		eshpo.setMap18(email.getMap18());
		eshpo.setMap19(email.getMap19());
		eshpo.setMap20(email.getMap20());
		eshpo.setMap21(email.getMap21());
		eshpo.setMap22(email.getMap22());
		eshpo.setMap23(email.getMap23());
		eshpo.setMap24(email.getMap24());
		eshpo.setMap25(email.getMap25());
		eshpo.setMap26(email.getMap26());
		eshpo.setMap27(email.getMap27());
		eshpo.setMap28(email.getMap28());
		eshpo.setMap29(email.getMap29());
		eshpo.setMap30(email.getMap30());
		eshpo.setMap31(email.getMap31());
		eshpo.setMap32(email.getMap32());
		eshpo.setMap33(email.getMap33());
		eshpo.setMap34(email.getMap34());
		eshpo.setMap35(email.getMap35());
		eshpo.setMap36(email.getMap36());
		//EmailSendHistory table 삭제로 주석처리.
//		result = this.emailSendHistoryDao.insertEmailSendHistory(eshpo);
		result = 1;
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}		
		/*****************************
		 * Map 데이터 생성 및 등록
		 *****************************/
		if(mapList != null && !mapList.isEmpty()){
			for(EmailSendMap map : mapList){
				eshmpo = new EmailSendHistoryMapPO();
				eshmpo.setHistNo(eshpo.getHistNo());
				eshmpo.setMap01(map.getMap01());
				eshmpo.setMap02(map.getMap02());
				eshmpo.setMap03(map.getMap03());
				eshmpo.setMap04(map.getMap04());
				eshmpo.setMap05(map.getMap05());
				eshmpo.setMap06(map.getMap06());
				eshmpo.setMap07(map.getMap07());
				eshmpo.setMap08(map.getMap08());
				eshmpo.setMap09(map.getMap09());
				eshmpo.setMap10(map.getMap10());
				//EmailSendHistory table 삭제로 HIST_NO 없음.
//				result = this.emailSendHistoryMapDao.insertEmailSendHistoryMap(eshmpo);
				result = 1;
				if(result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
			}
		}
		
	}

	@Override
	@Transactional(readOnly = true)
	public List<AttachFileVO> listAttachFile(AttachFileSO so) {
		return bizDao.listAttachFile(so);
	}

	@Override
	public void insertAttachFile(AttachFilePO po) {
		int result = bizDao.insertAttachFile(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteAttachFile(AttachFilePO po) {
		po.setSysDelrNo(AdminSessionUtil.getSession().getUsrNo());
		int result = bizDao.deleteAttachFile(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public String oneWayEncrypt(String strTarget) {
		String userId = getPetraUserId();
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.oneWayEncrypt(strTarget, userId, clientIp);
	}

	private String getPetraUserId() {
		String userId = null;
		if(StringUtils.equals(CommonConstants.PROJECT_GB_ADMIN, webConfig.getProperty("project.gb"))) {
			Session session = AdminSessionUtil.getSession();
			if (session == null) {
				userId = "NonLoginUser";
			} else {
				userId = String.valueOf(session.getUsrNo());
			}
		} else if (StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))){
			userId = String.valueOf(CommonConstants.COMMON_BATCH_USR_NO);
		}else {
			userId = String.valueOf(FrontSessionUtil.getSession().getMbrNo());
		}
		return userId;
	}

	@Override
	@Transactional(readOnly = true)
	public String oneWayEncrypt(String strTarget, Object userId) {
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.oneWayEncrypt(strTarget, String.valueOf(userId), clientIp);
	}

	@Override
	@Transactional(readOnly = true)
	public String twoWayEncrypt(String strTarget) {
		String userId = getPetraUserId();
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayEncrypt(strTarget, userId, clientIp);
	}

	@Override
	@Transactional(readOnly = true)
	public String twoWayEncrypt(String strTarget, Object userId) {
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayEncrypt(strTarget, String.valueOf(userId), clientIp);
	}

	@Override
	@Transactional(readOnly = true)
	public String twoWayDecrypt(String strTarget) {
		String userId = getPetraUserId();
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayDecrypt(strTarget, userId, clientIp);
	}

	@Override
	@Transactional(readOnly = true)
	public String twoWayDecrypt(String strTarget, Object userId) {
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayDecrypt(strTarget, String.valueOf(userId), clientIp);
	}

	@Override
	public String genContentsId(VodSO so) {
		String id = "";
		CodeDetailVO cdVo = cacheService.getCodeCache(CommonConstants.VD_GB, so.getVdGbCd());
		id += cdVo.getUsrDfn1Val();

		id += DateUtil.getNowDate();
		String seq = StringUtils.leftPad(String.valueOf(bizDao.getSequence(CommonConstants.SEQUENCE_APET_CONTENTS_SEQ)), 5, "0");
		seq = seq.substring(seq.length() - 5);
		id += seq;

		return id;
	}

	@Override
	public String sendEmail(EmailSendPO email) {
		// 네이버 이메일 PO
		NaverEmailSendPO nespo = new NaverEmailSendPO();
		PushVO pvo = new PushVO();
		nespo.setSenderAddress(email.getSenderAddress());
		if (StringUtil.isNotEmpty(email.getTmplNo())) { // 템플릿 사용
			PushSO pso = new PushSO();
			pso.setTmplNo(email.getTmplNo());
			pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
			
			if(StringUtil.isNotEmpty(email.getPushGb())) {
				nespo.setTitle(email.getTitle());
				nespo.setBody(email.getBody());
				email.setTitle(email.getTitle());
				email.setBody(email.getBody());
			}else {
				nespo.setTitle(pvo.getSubject());
				nespo.setBody(pvo.getContents());
				email.setTitle(pvo.getSubject());//추가 leejh 210205
				email.setBody(pvo.getContents());
			}
			
		} else if (StringUtil.isNotBlank(email.getTitle()) && StringUtil.isNotBlank(email.getBody())) { // title & body
			nespo.setTitle(email.getTitle());
			nespo.setBody(email.getBody());
		} else {
			throw new CustomException(ExceptionConstants.ERROR_EMAIL_SEND_FAIL);
		}
		nespo.setRecipients(email.getRecipients());
		nespo.setReservationDateTime(email.getReservationDateTime());

		ObjectMapper obm = new ObjectMapper();
		String JSONInput;
		try {
			String json = obm.writeValueAsString(nespo);
			JSONInput = json;
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_EMAIL_SEND_FAIL);
		}

		PushPO ppo = new PushPO();
		ppo.setTmplNo(email.getTmplNo());
		ppo.setSubject(email.getTitle());
		ppo.setContents(email.getBody());
		ppo.setSenderEmail(email.getSenderAddress());
		ppo.setInfoTpCd(email.getInfoTpCd());
		ppo.setSndTypeCd(CommonConstants.SND_TYPE_40);
		if (StringUtil.isBlank(email.getReservationDateTime())) { // 즉시 발송만 API 전송
			ppo.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);
			ppo.setSendReqYn(CommonConstants.COMM_YN_Y);
			Date now = new Date();
			ppo.setSendReqDtm(new Timestamp(now.getTime()));
			JsonNode sentResultJsonNode = sendNaverEmail(JSONInput); // 이메일 API 전송
			String requestId = sentResultJsonNode.findValue("requestId").toString().replace("\"", "");
			ppo.setOutsideReqId(requestId);
			String count = sentResultJsonNode.findValue("count").toString();
			if (StringUtil.isNotBlank(requestId) && StringUtil.isNotBlank(count) && Long.valueOf(count) > 0) { // 1개 이상
				ppo.setSndRstCd(CommonConstants.SND_RST_S);
			} else {
				ppo.setSndRstCd(CommonConstants.SND_RST_F);
			}
		} else {
			ppo.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);
			ppo.setSendReqYn(CommonConstants.COMM_YN_N);
			ppo.setSendReqDtm(email.getSendReqDtm());
		}

		// 알림 발송 리스트 등록
		ppo.setSysRegrNo(email.getSysRegrNo());
		ppo.setSysUpdrNo(email.getSysRegrNo());
		pushDao.insertNoticeSendList(ppo);

		// 알림 발송 상세 리스트 등록
		for (EmailRecivePO erpo : email.getRecipients()) {
			PushDetailPO pdpo = new PushDetailPO();
			pdpo.setNoticeSendNo(ppo.getNoticeSendNo());
			if (!erpo.getParameters().isEmpty()) {
				Gson gson = new Gson();
				pdpo.setSndInfo(gson.toJson(erpo.getParameters()));
			}
			pdpo.setMbrNo(erpo.getMbrNo());
			pdpo.setReceiverEmail(erpo.getAddress());
			pdpo.setSysRegrNo(email.getSysRegrNo());
			pdpo.setSysUpdrNo(email.getSysRegrNo());
			pushDao.insertNoticeSendDetailList(pdpo);
		}
		return String.valueOf(ppo.getNoticeSendNo());
	}

	@Override
	public JsonNode sendNaverEmail(String JSONInput) {// 네이버 이메일 발송
		try {
			String url = bizConfig.getProperty("naver.cloud.outmail.url");
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			String signature = makeSignature("/api/v1/mails", "POST", String.valueOf(timestamp),
					bizConfig.getProperty("naver.cloud.outmail.access"),
					bizConfig.getProperty("naver.cloud.outmail.secret"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			HttpEntity<String> entity = new HttpEntity<String>(JSONInput, headers);
			log.info("=================== emailApi request ===================");
			log.info("Request Header :{}", entity.getHeaders());
			log.info("Request body :{}", entity.getBody());
			log.info("========================================================");

			ObjectMapper mapper = new ObjectMapper();
			String result = convertToCisApi(url, HttpMethod.POST, entity);
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
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
	}

	// 네이버 메일 Signature 생성
	@Override
	public String makeSignature(String url, String method, String timestamp, String accessKey, String secretKey) {
		String space = " "; // 공백
		String newLine = "\n"; // 줄바꿈

		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
				.append(newLine).append(accessKey).toString();
		String encodeBase64String = "";
		try {
			SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);

			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
			encodeBase64String = Base64.encodeBase64String(rawHmac);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return encodeBase64String;
	}

	@Override
	public String insertDeviceToken(PushTokenPO po) {
		try {
			String url = bizConfig.getProperty("naver.cloud.push.url") + "/services/"
					+ bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/users";
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.push.access"));
			String signature = makeSignature(
					"/push/v2/services/" + bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/users",
					"POST", String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.push.access"),
					bizConfig.getProperty("naver.cloud.push.secret.customer"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			ObjectMapper obm = new ObjectMapper();
			String JSONInput;
			try {
				String json = obm.writeValueAsString(po);
				JSONInput = json;
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			HttpEntity<String> entity = new HttpEntity<String>(JSONInput, headers);
			log.info("=================== InsertDeviceToken request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());
			log.info("Request body :{}", entity.getBody());
			log.info("=================================================================");

			convertToCisApi(url, HttpMethod.POST, entity);
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_NOT_FOUND:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
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

	@Override
	public PushTokenVO getDeviceToken(PushTokenSO so) {
		PushTokenVO result = null;
		try {
			if (StringUtil.isBlank(so.getUserId())) {
				return result;
			}
			String url = bizConfig.getProperty("naver.cloud.push.url") + "/services/"
					+ bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/users/" + so.getUserId();
			HttpHeaders headers = new HttpHeaders();
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.push.access"));
			String signature = makeSignature(
					"/push/v2/services/" + bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/users/"
							+ so.getUserId(),
					"GET", String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.push.access"),
					bizConfig.getProperty("naver.cloud.push.secret.customer"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			HttpEntity<String> entity = new HttpEntity<String>(headers);
			log.info("=================== GetDeviceToken request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());
			log.info("=================================================================");
			String responseResult = convertToCisApi(url, HttpMethod.GET, entity);
			ObjectMapper mapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,
					false);
			if (StringUtil.isNotEmpty(responseResult)) {
				try {
					result = mapper.readValue(responseResult, PushTokenVO.class);
				} catch (IOException e) {
					// 보안성 진단. 오류메시지를 통한 정보노출
					//e.printStackTrace();
					log.error("#### IOException when getDeviceToken", e.getClass());
				}
			}
			return result;
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_NOT_FOUND:
//				throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
				return new PushTokenVO();
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

	@Override
	public String deleteDeviceToken(PushTokenPO po) {
		try {
			if (StringUtil.isBlank(po.getUserId())) {
				return "";
			}
			String url = bizConfig.getProperty("naver.cloud.push.url") + "/services/"
					+ bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/users/" + po.getUserId();
			HttpHeaders headers = new HttpHeaders();
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.push.access"));
			String signature = makeSignature(
					"/push/v2/services/" + bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/users/"
							+ po.getUserId(),
					"DELETE", String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.push.access"),
					bizConfig.getProperty("naver.cloud.push.secret.customer"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			HttpEntity<String> entity = new HttpEntity<String>(headers);
			log.info("=================== DeleteDeviceToken request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());
			log.info("=================================================================");

			convertToCisApi(url, HttpMethod.DELETE, entity);
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_NOT_FOUND:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
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

	@Override
	public String sendPush(SendPushPO po) {
		// 즉시발송 >> 배치로 변경
		po.setReservationDateTime(DateUtil.getNowDateTime());
		
		if(StringUtil.isEmpty(po.getTmplNo())) { // 템플릿 미사용
			int splitCnt = 100;
			List<String> result = new ArrayList<String>();
			List<List<PushTargetPO>> splitedTargetList = Lists.partition(po.getTarget(), splitCnt);
			for(List<PushTargetPO> thisSplitedTarget : splitedTargetList) {
				PushPO ppo = new PushPO();	// 이력 저장 PO
				ppo.setSndTypeCd(CommonConstants.SND_TYPE_10);			
				ppo.setSubject(po.getTitle());	
				ppo.setContents(po.getBody());
				String reqDeviceType = CommonConstants.DEVICE_TYPE_30;
				if(CommonConstants.PUSH_TYPE_ANDROID.equalsIgnoreCase(po.getDeviceType())) {
					reqDeviceType = CommonConstants.DEVICE_TYPE_10;
				}else if(CommonConstants.PUSH_TYPE_IOS.equalsIgnoreCase(po.getDeviceType())) {
					reqDeviceType = CommonConstants.DEVICE_TYPE_20;
				}
				ppo.setDeviceTypeCd(reqDeviceType);
				ppo.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);
				ppo.setSendReqYn(CommonConstants.COMM_YN_N);
				ppo.setSendReqDtm(po.getSendReqDtm());
				
				// 알림 발송 리스트 등록
				ppo.setSysRegrNo(po.getSysRegrNo());
				ppo.setSysUpdrNo(po.getSysRegrNo());
				ppo.setInfoTpCd(po.getInfoTpCd());
				pushDao.insertNoticeSendList(ppo);
				
				// 알림 발송 상세 리스트 등록
				PushTargetPO firstList = thisSplitedTarget.get(0);
				String image = firstList.getImage();
				String landingUrl = Optional.ofNullable(firstList.getLandingUrl()).orElseGet(()->"");
				for (PushTargetPO ptpo : thisSplitedTarget) {
					PushDetailPO pdpo = new PushDetailPO();
					pdpo.setNoticeSendNo(ppo.getNoticeSendNo());
					pdpo.setMbrNo(Long.parseLong(ptpo.getTo()));
					Gson gson = new Gson();
					Map<String, String> sndInfo = new HashMap<String, String>();
					sndInfo.put("image", image);
					//2021.09.24 - APETQA-7164 , landing Url 없을 시 파라미터 SET X , kjy01
					if(StringUtil.isNotEmpty(landingUrl)){
						sndInfo.put("landingUrl", firstList.getLandingUrl());
					}

					pdpo.setSndInfo(gson.toJson(sndInfo));
					if(StringUtil.isNotBlank(po.getLiveYn())) {
						pdpo.setLiveYn(po.getLiveYn());
					}
					// 회원 토큰값 확인 및 ANDROID /IOS 구분
					MemberBaseSO mbso = new MemberBaseSO();
					mbso.setMbrNo(Long.parseLong(ptpo.getTo()));
					MemberBaseVO mbvo = memberBaseDao.getMemberBase(mbso);
					if( mbvo != null ) {
						pdpo.setDeviceTkn((StringUtil.isNotEmpty(mbvo))?mbvo.getDeviceToken():null);
						pdpo.setDeviceTypeCd((StringUtil.isNotEmpty(mbvo))?mbvo.getDeviceTpCd():null);
						pdpo.setSysRegrNo(po.getSysRegrNo());
						pdpo.setSysUpdrNo(po.getSysRegrNo());
						if(StringUtil.isNotBlank(mbvo.getInfoRcvYn()) && mbvo.getInfoRcvYn().equals(CommonConstants.COMM_YN_N)) {
							pdpo.setOutsideReqDtlId(CommonConstants.COMM_YN_N);
						}
						pushDao.insertNoticeSendDetailList(pdpo); 
					}else {
						log.error("==================================================================================================");
						log.error("BizService.sendPush NO MEMBER ERROR ::: NoticeSendNo :"+ppo.getNoticeSendNo()+", MbrNo :"+ptpo.getTo());
						log.error("==================================================================================================");
					}
				}
				result.add(String.valueOf(ppo.getNoticeSendNo()));
			}
			Gson gson = new Gson();
			return gson.toJson(result);
		}else { // 탬플릿과 param을 이용 다른 내용 전달 할 경우(건별로 전송 및 저장)
			String result[] = new String[po.getTarget().size()]; 
			
			PushSO pso = new PushSO();
			pso.setTmplNo(po.getTmplNo());
			PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
			
			String tilte = "";
			String body = "";

			//알림 메시지 발송 수동여부
			if(StringUtil.isNotEmpty(po.getPushGb())) {
				tilte = po.getTitle();
				body = po.getBody();
			}else {
				tilte =  pvo.getSubject();
				body = pvo.getContents();
			}
			
			for(int i=0 ; i < po.getTarget().size() ; i++) { // 수신자별 param 바인딩				
				// default Message 바인딩
				String replacedTitle = tilte;
				String replacedBody = body;
				Map<String, String> thisParameters = po.getTarget().get(i).getParameters();
				if(thisParameters != null ) {
					for( String key : thisParameters.keySet() ){
						if(key.indexOf("${") == 0) {
							replacedTitle = StringUtil.replaceAll(replacedTitle, key, thisParameters.get(key));
							replacedBody = StringUtil.replaceAll(replacedBody, key, thisParameters.get(key));
						} else {
							replacedTitle = StringUtil.replaceAll(replacedTitle, "${" + key + "}", thisParameters.get(key));
							replacedBody = StringUtil.replaceAll(replacedBody, "${" + key + "}", thisParameters.get(key));
						}
				    }
				}else {
					new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				String thisMbrNo = po.getTarget().get(i).getTo();
				PushPO ppo = new PushPO(); // 이력 저장 PO
				ppo.setSndTypeCd(CommonConstants.SND_TYPE_10);
				ppo.setSubject(replacedTitle);	
				ppo.setContents(replacedBody);
				ppo.setTmplNo(po.getTmplNo());
				String reqDeviceType = CommonConstants.DEVICE_TYPE_30;
				if(CommonConstants.PUSH_TYPE_ANDROID.equalsIgnoreCase(po.getDeviceType())) {
					reqDeviceType = CommonConstants.DEVICE_TYPE_10;
				}else if(CommonConstants.PUSH_TYPE_IOS.equalsIgnoreCase(po.getDeviceType())) {
					reqDeviceType = CommonConstants.DEVICE_TYPE_20;
				}
				ppo.setDeviceTypeCd(reqDeviceType);
				ppo.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);
				ppo.setSendReqYn(CommonConstants.COMM_YN_N);
				ppo.setSendReqDtm(po.getSendReqDtm());
				
				// 알림 발송 리스트 등록
				ppo.setSysRegrNo(po.getSysRegrNo());
				ppo.setSysUpdrNo(po.getSysRegrNo());
				ppo.setInfoTpCd(po.getInfoTpCd());
				pushDao.insertNoticeSendList(ppo);
				// 알림 발송 상세 리스트 등록
				PushDetailPO pdpo = new PushDetailPO();
				pdpo.setNoticeSendNo(ppo.getNoticeSendNo());
				pdpo.setMbrNo(Long.parseLong(thisMbrNo));
				//Gson gson = new Gson();
				Gson gson = new GsonBuilder().disableHtmlEscaping().create();
				Map<String, String> sndInfo = new HashMap<String, String>();
				sndInfo.put("image", (StringUtil.isNotEmpty(po.getTarget().get(i).getImage()))? po.getTarget().get(i).getImage() :pvo.getImgPath());
				sndInfo.put("landingUrl",(StringUtil.isNotEmpty(po.getTarget().get(i).getLandingUrl()))? po.getTarget().get(i).getLandingUrl() :pvo.getMovPath());

				pdpo.setSndInfo(gson.toJson(sndInfo));
				// 회원 토큰값 확인 및 ANDROID /IOS 구분
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(Long.parseLong(thisMbrNo));
				MemberBaseVO mbvo = memberBaseDao.getMemberBase(mbso);
				if( mbvo != null ) {
					pdpo.setDeviceTkn((StringUtil.isNotEmpty(mbvo))?mbvo.getDeviceToken():null);
					pdpo.setDeviceTypeCd((StringUtil.isNotEmpty(mbvo))?mbvo.getDeviceTpCd():null);
					pdpo.setSysRegrNo(po.getSysRegrNo());
					pdpo.setSysUpdrNo(po.getSysRegrNo());
					if(StringUtil.isNotBlank(mbvo.getInfoRcvYn()) && mbvo.getInfoRcvYn().equals(CommonConstants.COMM_YN_N)) {
						pdpo.setOutsideReqDtlId(CommonConstants.COMM_YN_N);
					}
					pushDao.insertNoticeSendDetailList(pdpo); 
					result[i] = String.valueOf(ppo.getNoticeSendNo());
				}else {
					log.error("==================================================================================================");
					log.error("BizService.sendPush NO MEMBER ERROR ::: NoticeSendNo :"+ppo.getNoticeSendNo()+", MbrNo :"+thisMbrNo);
					log.error("==================================================================================================");
				}
			}
			Gson gson = new Gson();
			return gson.toJson(result);
		}
	}
	
	@Override
	public Map<String, PushMessagePO> convertToNaver(SendPushPO po){
		// 네이버 push에 message 형식에 맞게 셋팅
		Map<String, PushMessagePO> message = new HashMap<String, PushMessagePO>();
		//default
		PushMessagePO defaultMessage = new PushMessagePO();
		defaultMessage.setContent("");
		Map<String, String> defaultCustom = new HashMap<>();
		defaultMessage.setCustom(defaultCustom);
		Map<String, String> defaultOption = new HashMap<>();
		defaultMessage.setOption(defaultOption);
		message.put(CommonConstants.PUSH_TYPE_DEFAULT, defaultMessage);
		//gcm
		PushMessagePO gcmMessage = new PushMessagePO();
		gcmMessage.setContent("string");
		Map<String, String> gcmCustom = new HashMap<>();
		gcmCustom.put("title", po.getTitle());
		gcmCustom.put("body", po.getBody());
		gcmCustom.put("image", po.getTarget().get(0).getImage());
		gcmCustom.put("landingUrl", po.getTarget().get(0).getLandingUrl());
		gcmMessage.setCustom(gcmCustom);
		Map<String, String> gcmOption = new HashMap<>();
		gcmMessage.setOption(gcmOption);
		message.put(CommonConstants.PUSH_TYPE_ANDROID, gcmMessage);
		//apns
		PushMessagePO apnsMessage = new PushMessagePO();
		apnsMessage.setContent(po.getBody());
		Map<String, String> apnsCustom = new HashMap<>();
		apnsCustom.put("landingUrl", po.getTarget().get(0).getLandingUrl());
		apnsMessage.setCustom(apnsCustom);
		Map<String, String> apnsOption = new HashMap<>();
		apnsOption.put("aps.sound", "Y");
		apnsOption.put("aps.alert.title", po.getTitle());
		apnsMessage.setOption(apnsOption);
		message.put(CommonConstants.PUSH_TYPE_IOS, apnsMessage);
		return message;
	}
	
	@Override
	public JsonNode sendNaverPush(NaverPushPO po) {
		try {
			String url = bizConfig.getProperty("naver.cloud.push.url") + "/services/"
					+ bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/messages";
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.push.access"));
			String signature = makeSignature(
					"/push/v2/services/" + bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/messages",
					"POST", String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.push.access"),
					bizConfig.getProperty("naver.cloud.push.secret.customer"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());

			ObjectMapper obm = new ObjectMapper();
			String JSONInput;
			try {
				JSONInput = obm.writeValueAsString(po);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			log.info("=================== PO ===================");
			log.info("NaverPushPO :{}", po);
			log.info("json :{}", JSONInput);
			log.info("==========================================");
			HttpEntity<String> entity = new HttpEntity<String>(JSONInput, headers);
			log.info("=================== SendPush request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());
			log.info("Request body :{}", entity.getBody());
			log.info("========================================================");

			String result = convertToCisApi(url, HttpMethod.POST, entity);
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readTree(result);
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_NOT_FOUND:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
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

	@Override
	public String sendClickEventToSearchEngineServer(SearchEngineEventPO sepo) { 
		if(StringUtil.isNotEmpty(sepo) && StringUtil.isNotBlank(sepo.getLogGb())) {
			try {
				String serverUrl = "";
		        UriComponents builder = null ;
				if(StringUtil.isNotBlank(sepo.getLogGb()) && sepo.getLogGb().equalsIgnoreCase("SEARCH")) {
					serverUrl = bizConfig.getProperty("search.log.url.search");
					builder = UriComponentsBuilder.fromHttpUrl(serverUrl)
			                .queryParam("MBR_NO", sepo.getMbr_no())
			                .queryParam("SECTION",  sepo.getSection())
			                .queryParam("INDEX",  sepo.getIndex())
			                .queryParam("CONTENT_ID", sepo.getContent_id())
			                .queryParam("KEYWORD", sepo.getKeyword())
			                .queryParam("TIMESTAMP", sepo.getTimestamp())
			                .build(false);    //자동으로 encode해주는 것을 막기 위해 false
				}else if(StringUtil.isNotBlank(sepo.getLogGb()) && sepo.getLogGb().equalsIgnoreCase("ACTION")) {
					serverUrl = bizConfig.getProperty("search.log.url.action");
					builder = UriComponentsBuilder.fromHttpUrl(serverUrl)
			                .queryParam("MBR_NO", sepo.getMbr_no())
			                .queryParam("SECTION",  sepo.getSection())
			                .queryParam("CONTENT_ID", sepo.getContent_id())
			                .queryParam("ACTION", sepo.getAction())
			                .queryParam("URL", sepo.getUrl())
			                .queryParam("TARGET_URL", sepo.getTargetUrl())
			                .queryParam("LITD", twoWayEncrypt(sepo.getLitd()))
			                .queryParam("LTTD", twoWayEncrypt(sepo.getLttd()))
			                .queryParam("PRCL_ADDR", twoWayEncrypt(sepo.getPrclAddr()))
			                .queryParam("ROAD_ADDR", twoWayEncrypt(sepo.getRoadAddr()))
			                .queryParam("POST_NO_NEW", twoWayEncrypt(sepo.getPostNoNew()))
			                .queryParam("TIMESTAMP", sepo.getTimestamp())
			                .queryParam("AGENT", sepo.getAgent())
			                .build(false);    //자동으로 encode해주는 것을 막기 위해 false
				}
				RestTemplate restTemplate = new RestTemplate();
			    HttpHeaders headers = new HttpHeaders();
		        headers.setContentType(new MediaType("application","json",Charset.forName("UTF-8")));    //Response Header to UTF-8  
		        ResponseEntity<String> responseEntity = restTemplate.exchange(builder.toUriString(), HttpMethod.GET, new HttpEntity<String>(headers), String.class);
			    
			    ObjectMapper mapper = new ObjectMapper();
			    JsonNode jsonNode;
				jsonNode = mapper.readTree(responseEntity.getBody());
				return jsonNode.toString();
			} catch (Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("{}", e);
				//e.printStackTrace();
				log.error("#### exception sendClickEventToSearchEngineServer", e.getClass());
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		return "";
	}

	@Override
	public int sendMessage(SsgMessageSendPO po) {
//		if (StringUtil.isNotEmpty(po.getTmplNo())) {
//			PushSO pso = new PushSO();
//			pso.setTmplNo(po.getTmplNo());
//			PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
//			po.setFsubject(pvo.getSubject());
//			po.setFmessage(pvo.getContents());
//		}
//		ssgBody = po.getFmessage();
//		for (SsgMessageRecivePO recipient : po.getRecipients()) {
//			if (recipient.getParameters() != null) {
//				recipient.getParameters().forEach((k, v)-> {
//					String message;
//					if(k.indexOf("${") == 0) {
//						message = StringUtil.replaceAll(ssgBody, k, v);
//					} else {
//						message = StringUtil.replaceAll(ssgBody, "${" + k + "}", v);
//					}
//				});
//			}
//		}
		
		// 각 업무 단에서 데이터 바인딩하여 object 넘긴다.
		int result = 0;
		if (StringUtil.isEmpty(po.getFcallback())) {
			StStdInfoSO so = new StStdInfoSO();
			so.setUseYn(CommonConstants.COMM_YN_Y);
			List<StStdInfoVO> list = stService.listStStdInfo(so);
			po.setFcallback(list.get(0).getCsTelNo());
		}
		if (StringUtil.isNotEmpty(po.getFdestine())) {
			po.setFcallback(StringUtil.removeFormat(StringUtils.defaultIfEmpty(po.getFcallback(), StringUtils.EMPTY)));
			po.setFdestine(StringUtil.removeFormat(po.getFdestine()));
			if (StringUtil.isEmpty(po.getSysUseYn())) {
				po.setFuserid(CommonConstants.FUSER_DEFAULT);
			} else if (StringUtil.equals(CommonConstants.COMM_YN_N, po.getSysUseYn())) {
				if (po.getMbrNo() == null) {
					po.setFuserid(CommonConstants.FUSER_DEFAULT);
				} else {
					po.setFuserid(String.valueOf(po.getMbrNo()));
				}
			}
			// 운영환경이 아닌 곳에서 allowList 적용. BO 로그인 인증문자 -> 알림톡 변경으로 인해 stg 해제
			if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER) || StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_STG)) {
				po.setFsendstat(CommonConstants.MSG_STATUS_READY);
			} else {
				CodeDetailVO allowList = cacheService.getCodeCache(CommonConstants.MSG_ALLOW_LIST, CommonConstants.MSG_ALLOW_LIST_10);
				if (allowList.getUsrDfn1Val().indexOf(po.getFdestine()) != -1) {
					po.setFsendstat(CommonConstants.MSG_STATUS_READY);
				} else {
					po.setFsendstat(CommonConstants.MSG_STATUS_COMPLETE);
				}
			}
			
			// KKO
			if (StringUtil.equals(CommonConstants.SND_TYPE_30, po.getSndTypeCd())) {
				po.setFyellowid(bizConfig.getProperty("kakao.sender.key"));
				po.setFmsgtype(CommonConstants.MSG_TP_KKO);
				po.setFkkoresendmsg(po.getFmessage());
				if (StringUtil.getByteLength(po.getFmessage()) > 90) {
					po.setFkkoresendtype(CommonConstants.RESEND_MSG_TP_LMS);
				} else {
					po.setFkkoresendtype(CommonConstants.RESEND_MSG_TP_SMS);
				}
				if(po.getButtionList() != null) {
					JSONArray  jsArr = new JSONArray();
					JSONObject jsObj = new JSONObject();
					for (SsgKkoBtnPO button : po.getButtionList()) {
						//ButtonJson 생성
						jsObj.put("name", button.getBtnName());
						if (StringUtil.isEmpty(button.getBtnType())) {
							jsObj.put("type", CommonConstants.KKO_BTN_TP_WL);
							jsObj.put("url_pc", button.getPcLinkUrl());
							jsObj.put("url_mobile", button.getMobileLinkUrl());
						} else {
							jsObj.put("type", button.getBtnType());
							if (StringUtil.equals(CommonConstants.KKO_BTN_TP_AL, button.getBtnType())) {
								jsObj.put("scheme_ios", button.getSchemaIos());
								jsObj.put("scheme_android", button.getSchemaAndroid());
							} else {
								jsObj.put("url_pc", button.getPcLinkUrl());
								jsObj.put("url_mobile", button.getMobileLinkUrl());
							}
						}
						jsArr.add(jsObj);
						jsObj.clear();
					}
					jsObj.put("button", jsArr);
					String jsObjStr = jsObj.toString();
					jsObjStr = StringUtils.removeEnd(jsObjStr, "}");
					jsObjStr = StringUtils.removeStart(jsObjStr, "{");
					
					po.setFkkobutton(jsObjStr);
				}
				
				// subject
				if (StringUtil.isEmpty(po.getFkkosubject())) {
					
					String kSubject = po.getFmessage().split("\\n")[0];
					po.setFkkosubject(StringUtil.cutText(kSubject, 80, true));
				}
				po.setFsubject(po.getFkkosubject());

				result = ssgDao.insertKko(po);
			}
			
			// MMS/LMS/SMS
			if (StringUtil.equals(CommonConstants.SND_TYPE_20, po.getSndTypeCd())) {
				if (StringUtil.isNotEmpty(po.getFfilepath())) {
					String[] filePathArr = Arrays.stream(po.getFfilepath().split(";")).map(String::trim).filter(Predicate.isEqual("").negate()).toArray(String[]::new);
					po.setFfilecnt((long) filePathArr.length);
					po.setFfilepath(String.join(";", filePathArr));
					po.setFmsgtype(CommonConstants.MSG_TP_MMS);
					// subject
					if (StringUtil.isEmpty(po.getFsubject())) {
						String mmsSubject = po.getFmessage().split("\\n")[0];
						po.setFsubject(StringUtil.cutText(mmsSubject, 80, true));
					}
					result = ssgDao.insertMms(po);
				} else {
					if (StringUtil.getByteLength(po.getFmessage()) > 90) {
						po.setFmsgtype(CommonConstants.MSG_TP_LMS);
						po.setFfilecnt(0L);
						// subject
						if (StringUtil.isEmpty(po.getFsubject())) {
							String lmsSubject = po.getFmessage().split("\\n")[0];
							po.setFsubject(StringUtil.cutText(lmsSubject, 80, true));
						}
						result = ssgDao.insertMms(po);
					} else {
						po.setFmsgtype(CommonConstants.MSG_TP_SMS);
						result = ssgDao.insertSms(po);
					}
				}
			}
			
			if (result == 0) {
				po.setFdestine(MaskingUtil.getTelNo(po.getFdestine()));
				po.setFmessage(null);
				po.setFsubject(null);
				log.error("SSG send message error : {}", po);
			} else {
				// 이력 저장
				PushPO ppo = new PushPO();
				PushDetailPO pdpo = new PushDetailPO();
				if (StringUtil.isEmpty(po.getSysUseYn())) {
					ppo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
					pdpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
					ppo.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
					pdpo.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
				} else if (StringUtil.equals(CommonConstants.COMM_YN_N, po.getSysUseYn())) {
					ppo.setSysRegrNo(po.getUsrNo());
					pdpo.setSysRegrNo(po.getUsrNo());
					ppo.setSysUpdrNo(po.getUsrNo());
					pdpo.setSysUpdrNo(po.getUsrNo());
				}
				// 제목
				if (StringUtil.isNotEmpty(po.getFsubject())) {
					ppo.setSubject(po.getFsubject());
				} else {
					ppo.setSubject(StringUtil.cutText(po.getFmessage(), 80, true));
				}
				
				// 내용
				ppo.setContents(po.getFmessage());
				// 발신자 번호
				ppo.setSndrNo(po.getFcallback());
				// 발송 방식 코드
				ppo.setNoticeTypeCd(po.getNoticeTypeCd());
				// 요청 여부
				ppo.setSendReqYn(CommonConstants.COMM_YN_Y);
				// 요청 결과 코드
				ppo.setSndRstCd(CommonConstants.SND_RST_S);
				// 전송 방식 코드
				ppo.setSndTypeCd(CommonConstants.SND_TYPE_20);
				// msgtype | pk
				String msgType = "SMS";
				if (po.getFmsgtype() > CommonConstants.MSG_TP_SMS && po.getFmsgtype() < CommonConstants.MSG_TP_KKO ) {
					msgType = "MMS";
				} else if (po.getFmsgtype() >= CommonConstants.MSG_TP_KKO) {
					ppo.setSndTypeCd(CommonConstants.SND_TYPE_30);
					msgType = "KKO";
				}
				ppo.setOutsideReqId(msgType + "|" + String.valueOf(po.getFseq()));
				
				// 요청일시
				// 예약
				if(StringUtil.isNotEmpty(po.getFsenddate())) {
					ppo.setSendReqDtm(po.getFsenddate());
				}else {
					Date now = new Date();
					ppo.setSendReqDtm(new Timestamp(now.getTime()));
				}
				// 정보성 구분
				ppo.setInfoTpCd(po.getInfoTpCd());
				
				pushDao.insertNoticeSendList(ppo);
				
				// 알림 발송 상세 리스트 등록
				
				// 이력 통지 번호
				pdpo.setNoticeSendNo(ppo.getNoticeSendNo());
				// 회원 또는 사용자 번호
				
				pdpo.setMbrNo(po.getMbrNo());
				// 제목
				pdpo.setSubject(ppo.getSubject());
				// 내용
				pdpo.setContents(ppo.getContents());
				// 수신자 번호
				pdpo.setRcvrNo(po.getFdestine());
				pushDao.insertNoticeSendDetailList(pdpo);
				
			}
		}
		
		return result;
	}

	@Override
	public MemberUnsubscribeVO getUnsubscribes() {
		return getUnsubscribes(CommonConstants.COMM_YN_N);
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public MemberUnsubscribeVO getUnsubscribes(String syncYn) {
		MemberUnsubscribeVO member = new MemberUnsubscribeVO();
		try {
			String method = "GET";
			String apiURL = StringUtils.replace(bizConfig.getProperty("naver.cloud.unsubscribes.url"), "{serviceId}", bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer"));
			GatewayRequest request = new GatewayRequest();
			request.setRequestUrl(apiURL);
			request.setRequestMethod(method);
			request.setContentType("application/x-www-form-urlencoded");
			request.setCharacterSet("UTF-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			JSONArray jsArr = new JSONArray();
			JSONObject jsObj = new JSONObject();
			jsObj.put("value", String.valueOf(timestamp).trim());
			jsObj.put("key", "x-ncp-apigw-timestamp");
			jsArr.add(jsObj);
			jsObj.clear();
			jsObj.put("value", bizConfig.getProperty("naver.cloud.unsubscribes.access"));
			jsObj.put("key", "x-ncp-iam-access-key");
			jsArr.add(jsObj);
			jsObj.clear();
			jsObj.put("value", makeSignature("/sms/v2/services/" + bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer") + "/unsubscribes",
					method, String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.unsubscribes.access"),bizConfig.getProperty("naver.cloud.unsubscribes.secret.customer")).trim());
			jsObj.put("key", "x-ncp-apigw-signature-v2");
			jsArr.add(jsObj);
			jsObj.clear();
			jsObj.put("value", "application/json");
			jsObj.put("key", "Content-Type");
			jsArr.add(jsObj);
			jsObj.clear();
			request.setHeader(jsArr);
			ApiResponse ar = apiClient.getResponse(CisApiSpec.IF_R_GATEWAY_INFO, request);
			JsonUtil jsonUt = new JsonUtil();
			List<MemberUnsubscribeVO> list = jsonUt.toArray(MemberUnsubscribeVO.class, ar.getResponseJson().get("resTxt").getTextValue());

			if (list != null) {
				List<String> mobileNos = new ArrayList<>();
//				List<String> mobileNoList = new ArrayList<>();
				list.stream().forEach(v->{
					String clientTelNo = StringUtil.removeFormat(StringUtils.defaultIfEmpty(v.getClientTelNo(), StringUtils.EMPTY));
					mobileNos.add(twoWayEncrypt(clientTelNo));
//					mobileNoList.add(clientTelNo);
				});
				member.setTotalCnt(mobileNos.size());
				// 동기화
				int result = 0;
				if (StringUtil.equals(CommonConstants.COMM_YN_Y, syncYn)) {
					MemberBasePO memberBasePo = new MemberBasePO();
					memberBasePo.setMkngRcvYn(CommonConstants.COMM_YN_N);
					memberBasePo.setMobileArr(mobileNos.stream().toArray(String[]::new));
					memberBasePo.setChgActrCd(CommonConstants.CHG_ACTR_080);
					result = memberDao.callProcedureMarketingChange(memberBasePo);
				}
				MemberBaseSO so = new MemberBaseSO();
				so.setMobileNos(mobileNos.toArray(new String[mobileNos.size()]));
				List<MemberBaseVO> memberList = memberDao.getUnsubscribeMemberList(so);
				memberList.stream().forEach(v->{
					v.setMbrNm(MaskingUtil.getName(StringUtil.isNotEmpty(twoWayDecrypt(v.getMbrNm())) == true ? twoWayDecrypt(v.getMbrNm()) : v.getMbrNm()));
					v.setLoginId(MaskingUtil.getId(StringUtil.isNotEmpty(twoWayDecrypt(v.getLoginId())) == true ? twoWayDecrypt(v.getLoginId()) : v.getLoginId()));
					v.setMobile(MaskingUtil.getTelNo(StringUtil.formatPhone(StringUtil.isNotEmpty(twoWayDecrypt(v.getMobile())) == true ? twoWayDecrypt(v.getMobile()) : v.getMobile())));
				});
				member.setUnsubscribesList(memberList);
				member.setUpdateCnt(result);
			}
		} catch (Exception e) {
			member.setFailCnt(1);
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
		return member;
	}

	@Override
	public List<MemberUnsubscribeVO> registUnsubscribes(String[] mobileArr) {
		String method = "POST";
		return registUnsubscribes(mobileArr, method);
	}

	@Override
	public MemberUnsubscribeVO registUnsubscribes(String mobile) {
		String[] mobileArr = new String[] {mobile};
		List<MemberUnsubscribeVO> list = registUnsubscribes(mobileArr);
		return list.get(0);
	}

	@Override
	public List<MemberUnsubscribeVO> deleteUnsubscribes(String[] mobileArr) {
		String method = "DELETE";
		return registUnsubscribes(mobileArr, method);
	}

	@Override
	public MemberUnsubscribeVO deleteUnsubscribes(String mobile) {
		String[] mobileArr = new String[] {mobile};
		List<MemberUnsubscribeVO> list = deleteUnsubscribes(mobileArr);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return new MemberUnsubscribeVO();
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<MemberUnsubscribeVO> registUnsubscribes(String[] mobileArr, String method) {
		JsonUtil jsonUt = new JsonUtil();
		List<MemberUnsubscribeVO> list = new ArrayList<>();
		
		// 운영환경에서만 적용
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			try {
				JSONArray jsArr = new JSONArray();
				JSONObject jsObj = new JSONObject();
				
				//한번 요청에 1000건까지 요청 가능
				int devide = mobileArr.length / 1000;
				if (mobileArr.length % 1000 != 0) {
					devide = (int) Math.floor(mobileArr.length / 1000) + 1;
				}
				
				int num = 0;
				
				//한번 요청에 1000건까지 요청 가능
				for (int i = 0; i < devide; i++) {
					String[] mobileArray = Arrays.stream(Arrays.copyOfRange(mobileArr, num, num+1000)).filter(str-> str != null).toArray(String[]::new);
					JSONArray jsArray = new JSONArray();
					for (String mobile : mobileArray) {
						mobile = StringUtil.removeFormat(StringUtils.defaultIfEmpty(mobile, StringUtils.EMPTY));
						jsObj.put("clientTelNo", mobile);
						jsArray.add(jsObj);
						jsObj.clear();
					}
					GatewayRequest request = new GatewayRequest();
					request.setRequestData(jsArray.toString());
					String apiURL = StringUtils.replace(bizConfig.getProperty("naver.cloud.unsubscribes.url"), "{serviceId}", bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer"));
					
					Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
					String signature = makeSignature("/sms/v2/services/" + bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer") + "/unsubscribes",
							method, String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.unsubscribes.access"),bizConfig.getProperty("naver.cloud.unsubscribes.secret.customer")).trim();
					String access = bizConfig.getProperty("naver.cloud.unsubscribes.access");
					request.setRequestUrl(apiURL);
					request.setRequestMethod(method);
					request.setContentType("application/json");
					request.setCharacterSet("UTF-8");
					jsArr.clear();
					jsObj.put("value", String.valueOf(timestamp).trim());
					jsObj.put("key", "x-ncp-apigw-timestamp");
					jsArr.add(jsObj);
					jsObj.clear();
					jsObj.put("value", access);
					jsObj.put("key", "x-ncp-iam-access-key");
					jsArr.add(jsObj);
					jsObj.clear();
					jsObj.put("value", signature);
					jsObj.put("key", "x-ncp-apigw-signature-v2");
					jsArr.add(jsObj);
					jsObj.clear();
					jsObj.put("value", "application/json");
					jsObj.put("key", "Content-Type");
					jsArr.add(jsObj);
					jsObj.clear();
					request.setHeader(jsArr);
					num += 1000;
					
					ApiResponse ar = apiClient.getResponse(CisApiSpec.IF_R_GATEWAY_INFO, request);
					List<MemberUnsubscribeVO> list2 = new ArrayList<>();
					if (StringUtil.isNotEmpty(ar.getResponseJson().get("resTxt").getTextValue())) {
						list2 = jsonUt.toArray(MemberUnsubscribeVO.class, ar.getResponseJson().get("resTxt").getTextValue());
						list.addAll(list2);
					}
					jsArr.clear();
					jsArray.clear();
				}
				list.stream().forEach(v->{
					v.setMobile(twoWayEncrypt(v.getClientTelNo()));
					v.setClientTelNo(MaskingUtil.getTelNo(StringUtil.formatPhone(v.getClientTelNo())));
				});
				return list;
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
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
			}
			
		} else {
			return list;
		}
	}
	
	@Override
	public MemberUnsubscribeVO getUnsubscribesDirect() {
		return getUnsubscribesDirect(CommonConstants.COMM_YN_N);
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public MemberUnsubscribeVO getUnsubscribesDirect(String syncYn) {
		MemberUnsubscribeVO member = new MemberUnsubscribeVO();
		try {
			String apiURL = StringUtils.replace(bizConfig.getProperty("naver.cloud.unsubscribes.url"), "{serviceId}", bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer"));
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			URL url = new URL(apiURL);
			String method = "GET";
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
//			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", String.valueOf(timestamp).trim());
			con.setRequestProperty("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.unsubscribes.access"));
			con.setRequestProperty("x-ncp-apigw-signature-v2",makeSignature("/sms/v2/services/" + bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer") + "/unsubscribes",
					method, String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.unsubscribes.access"),bizConfig.getProperty("naver.cloud.unsubscribes.secret.customer")).trim());
			con.setDoOutput(true);
			con.setRequestMethod(method);

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 오류 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			JsonUtil jsonUt = new JsonUtil();
			List<MemberUnsubscribeVO> list = jsonUt.toArray(MemberUnsubscribeVO.class, response.toString());

			if (list != null) {
				List<String> mobileNos = new ArrayList<>();
//				List<String> mobileNoList = new ArrayList<>();
				list.stream().forEach(v->{
					String clientTelNo = StringUtil.removeFormat(StringUtils.defaultIfEmpty(v.getClientTelNo(), StringUtils.EMPTY));
					mobileNos.add(twoWayEncrypt(clientTelNo));
//					mobileNoList.add(clientTelNo);
				});
				member.setTotalCnt(mobileNos.size());
				// 동기화
				int result = 0;
				if (StringUtil.equals(CommonConstants.COMM_YN_Y, syncYn)) {
					MemberBasePO memberBasePo = new MemberBasePO();
					memberBasePo.setMkngRcvYn(CommonConstants.COMM_YN_N);
					memberBasePo.setMobileArr(mobileNos.stream().toArray(String[]::new));
					memberBasePo.setChgActrCd(CommonConstants.CHG_ACTR_080);
					result = memberDao.callProcedureMarketingChange(memberBasePo);
				}
				MemberBaseSO so = new MemberBaseSO();
				so.setMobileNos(mobileNos.toArray(new String[mobileNos.size()]));
				List<MemberBaseVO> memberList = memberDao.getUnsubscribeMemberList(so);
				memberList.stream().forEach(v->{
					v.setMbrNm(MaskingUtil.getName(StringUtil.isNotEmpty(twoWayDecrypt(v.getMbrNm())) == true ? twoWayDecrypt(v.getMbrNm()) : v.getMbrNm()));
					v.setLoginId(MaskingUtil.getId(StringUtil.isNotEmpty(twoWayDecrypt(v.getLoginId())) == true ? twoWayDecrypt(v.getLoginId()) : v.getLoginId()));
					v.setMobile(MaskingUtil.getTelNo(StringUtil.formatPhone(StringUtil.isNotEmpty(twoWayDecrypt(v.getMobile())) == true ? twoWayDecrypt(v.getMobile()) : v.getMobile())));
				});
				member.setUnsubscribesList(memberList);
				member.setUpdateCnt(result);
			}
		} catch (Exception e) {
			member.setFailCnt(1);
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
		return member;
	}

	@Override
	public List<MemberUnsubscribeVO> registUnsubscribesDirect(String[] mobileArr) {
		String method = "POST";
		return registUnsubscribesDirect(mobileArr, method);
	}

	@Override
	public MemberUnsubscribeVO registUnsubscribesDirect(String mobile) {
		String[] mobileArr = new String[] {mobile};
		List<MemberUnsubscribeVO> list = registUnsubscribesDirect(mobileArr);
		return list.get(0);
	}

	@Override
	public List<MemberUnsubscribeVO> deleteUnsubscribesDirect(String[] mobileArr) {
		String method = "DELETE";
		return registUnsubscribesDirect(mobileArr, method);
	}

	@Override
	public MemberUnsubscribeVO deleteUnsubscribesDirect(String mobile) {
		String[] mobileArr = new String[] {mobile};
		List<MemberUnsubscribeVO> list = deleteUnsubscribesDirect(mobileArr);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return new MemberUnsubscribeVO();
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<MemberUnsubscribeVO> registUnsubscribesDirect(String[] mobileArr, String method) {
		JsonUtil jsonUt = new JsonUtil();
		List<MemberUnsubscribeVO> list = new ArrayList<>();
		try {
			String apiURL = StringUtils.replace(bizConfig.getProperty("naver.cloud.unsubscribes.url"), "{serviceId}", bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer"));
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			String signature = makeSignature("/sms/v2/services/" + bizConfig.getProperty("naver.cloud.unsubscribes.serviceid.customer") + "/unsubscribes",
					method, String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.unsubscribes.access"),bizConfig.getProperty("naver.cloud.unsubscribes.secret.customer")).trim();
			headers.set("x-ncp-apigw-signature-v2", signature.trim());
			JSONArray  jsArr = new JSONArray();
			JSONObject jsObj = new JSONObject();
			
			//한번 요청에 1000건까지 요청 가능
			int devide = mobileArr.length / 1000;
			if (mobileArr.length % 1000 != 0) {
				devide = (int) Math.floor(mobileArr.length / 1000) + 1;
			}
			
			HttpEntity<String> entity;
			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
			factory.setConnectTimeout(10 * 1000); // 읽기시간초과, ms
			factory.setReadTimeout(10 * 1000); // 연결시간초과, ms
			RestTemplate restTemplate = new RestTemplate(factory);
			ResponseEntity<String> responseEntity = null;
			int num = 0;
			
			//한번 요청에 1000건까지 요청 가능
			for (int i = 0; i < devide; i++) {
				String[] mobileArray = Arrays.stream(Arrays.copyOfRange(mobileArr, num, num+1000)).filter(str-> str != null).toArray(String[]::new);
				for (String mobile : mobileArray) {
					mobile = StringUtil.removeFormat(StringUtils.defaultIfEmpty(mobile, StringUtils.EMPTY));
					jsObj.put("clientTelNo", mobile);
					jsArr.add(jsObj);
					jsObj.clear();
				}
				
				entity = new HttpEntity<String>(jsArr.toString(), headers);
				jsArr.clear();
				log.info("=================== Unsubscribes Api request ===================");
				log.info("Request Header :{}", entity.getHeaders());
				log.info("Request body :{}", entity.getBody());
				log.info("========================================================");
				if (StringUtils.equals("POST", method)) {
					responseEntity = restTemplate.exchange(apiURL, HttpMethod.POST, entity, String.class);
				}
				if (StringUtils.equals("DELETE", method)) {
					responseEntity = restTemplate.exchange(apiURL, HttpMethod.DELETE, entity, String.class);
				}
				log.info("=================== Unsubscribes Api response ===================");
				log.info("Response Body {} : " + responseEntity.getBody());
				log.info("========================================================");
				num += 1000;
				
				if (StringUtil.isNotEmpty(responseEntity.getBody())) {
					List<MemberUnsubscribeVO> list2 = new ArrayList<>();
					list2 = jsonUt.toArray(MemberUnsubscribeVO.class, responseEntity.getBody());
					list.addAll(list2);
				}
			}
			list.stream().forEach(v->{
				v.setMobile(twoWayEncrypt(v.getClientTelNo()));
				v.setClientTelNo(MaskingUtil.getTelNo(StringUtil.formatPhone(v.getClientTelNo())));
			});
			return list;
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
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
	}
	
	@Override
	public JsonNode getNaverPushResult(String requestId) {
		try {
			String url = bizConfig.getProperty("naver.cloud.push.url") + "/services/"
					+ bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/messages/" + requestId;
			HttpHeaders headers = new HttpHeaders();
			//headers.set("Content-Type", "application/json; charset=utf-8");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			headers.set("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			headers.set("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.push.access"));
			//서명생성
			String signature = makeSignature(
					"/push/v2/services/" + bizConfig.getProperty("naver.cloud.push.serviceid.customer") + "/messages/" + requestId,
					"GET", String.valueOf(timestamp), bizConfig.getProperty("naver.cloud.push.access"),
					bizConfig.getProperty("naver.cloud.push.secret.customer"));
			headers.set("x-ncp-apigw-signature-v2", signature.trim());
						
			HttpEntity<String> entity = new HttpEntity<String>(headers);
			log.info("=================== getNaverPushResult request ===================");
			log.info("Request url : " + url);
			log.info("Request Header :{}", entity.getHeaders());			
			log.info("==================================================================");

//			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
//			factory.setConnectTimeout(10 * 1000); // 읽기시간초과, ms
//			factory.setReadTimeout(10 * 1000); // 연결시간초과, ms
//			RestTemplate restTemplate = new RestTemplate(factory);
//			ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
//			log.info("=================== SendPush response ===================");
//			log.info("Response statusCode : " + responseEntity.getBody());
//			log.info("=========================================================");
//			ObjectMapper mapper = new ObjectMapper();
//			return mapper.readTree(responseEntity.getBody());
			String result = convertToCisApi(url, HttpMethod.GET, entity);
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readTree(result);
		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_NOT_FOUND:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
			case HttpStatus.SC_INTERNAL_SERVER_ERROR:
				throw new CustomException(ExceptionConstants.ERROR_API_INTERNAL_SERVER_ERROR);
			default:
				throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
			}
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}
	}
	
	@Override
	public String convertToCisApi(String url, HttpMethod method, HttpEntity<String> entity) {
		GatewayRequest request = new GatewayRequest();
		request.setRequestUrl(url);
		request.setRequestMethod(method.toString());
		request.setRequestData(entity.getBody());
		request.setContentType("application/json");
		request.setCharacterSet("UTF-8");
		HttpHeaders headers = entity.getHeaders();
		JSONArray  jsArr = new JSONArray();
		for (Entry<String, List<String>> entry : headers.entrySet()) {
			JSONObject jsObj = new JSONObject();
			jsObj.put("key", entry.getKey());
			if(entry.getValue().size() > 1) {
				jsObj.put("value", entry.getValue());
			}else {
				jsObj.put("value", entry.getValue().get(0));
			}
			jsArr.add(jsObj);
		}
		request.setHeader(jsArr);
		ApiResponse ar = apiClient.getResponse(CisApiSpec.IF_R_GATEWAY_INFO, request);
		//오류 처리
		String resCd = ar.getResponseJson().get("resCd").getTextValue();
		if(!"0000".equals(resCd)) {
			log.error(">>>>>>>>>>>>> CIS GATEWAY ERROR");
			log.error(">>>>>>>>>>>>> resCd=" + resCd);
			log.error(">>>>>>>>>>>>> resMsg=" + ar.getResponseJson().get("resMsg").getTextValue());
			throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
		}
		return ar.getResponseJson().get("resTxt").getTextValue();
	}
}