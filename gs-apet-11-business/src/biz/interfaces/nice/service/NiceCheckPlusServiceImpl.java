package biz.interfaces.nice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.common.service
* - 파일명		: NiceCheckPlusServiceImpl.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Nice ChekPlus 관련 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("niceCheckPlusService")
public class NiceCheckPlusServiceImpl implements NiceService {

//	@Autowired Properties bizConfig;
//
//	@Autowired private MessageSourceAccessor message;
//
//	/*
//	 * 인증 체크
//	 * @see biz.itf.nice.service.NiceService#check(java.lang.String, java.lang.String, boolean)
//	 */
//	@Override
//	public NiceCheckVO check(String siteDomain, String sessionId, boolean mobile) {
//		NiceCheckVO result = new NiceCheckVO();
//
//		result.setParamR1(sessionId);	// 사용자 파라미터에 세션값 저장(체크용)
//
//	    CPClient niceCheck = new CPClient();
//
//	    String sSiteCode = bizConfig.getProperty("nice.checkplus.site.code");				// NICE로부터 부여받은 사이트 코드
//	    String sSitePassword = bizConfig.getProperty("nice.checkplus.site.pw");		// NICE로부터 부여받은 사이트 패스워드
//
//	    String sRequestNumber;        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
//	                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
//	    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
//	  	//session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
//
//	   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
//
//	   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
//		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
//
//		if(mobile){
//			customize = "Mobile";
//		}
//
//	    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
//	    String sReturnUrl = siteDomain + "/join/popupCheckPlusSuccess";      // 성공시 이동될 URL
//	    String sErrorUrl = siteDomain + "/join/popupCheckPlusFail";          // 실패시 이동될 URL
//
//	    // 입력될 plain 데이타를 만든다.
//	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
//	                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
//	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
//	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
//	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
//	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
//	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
//
//		String sRtnMsgNo = "";			// 결과 메세지 코드
//		boolean sRtnCode = false;
//
//	    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
//
//	    if( iReturn == 0 ) {
//	    	result.setEncData(niceCheck.getCipherData());
//	    	sRtnMsgNo = "0";
//	    	sRtnCode = true;
//	    } else if( iReturn == -1) {
//	    	sRtnMsgNo = "1";
//	    } else if( iReturn == -2) {
//	    	sRtnMsgNo = "2";
//	    } else if( iReturn == -3) {
//	    	sRtnMsgNo = "3";
//	    } else if( iReturn == -9) {
//	    	sRtnMsgNo = "9";
//	    } else {
//	    	sRtnMsgNo = "etc";
//	    }
//
//	    result.setRtnCode(sRtnCode);
//	    result.setRtnMsg(message.getMessage("business.nice.checkplus.check.msg."+sRtnMsgNo));
//
//		return result;
//	}
//
//	/*
//	 * 개인정보 추출
//	 * @see front.web.view.common.service.NiceService#getCertifyData(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
//	 */
//	@Override
//	public NiceCertifyDataVO getCertifyData(String encData, String paramR1, String paramR2, String paramR3, String sessionId) {
//		NiceCertifyDataVO result = new NiceCertifyDataVO();
//
//	    CPClient niceCheck = new  CPClient();
//
//	    String sEncodeData = requestReplace(encData, "encodeData");
//
//	    String sSiteCode = bizConfig.getProperty("nice.checkplus.site.code");				// NICE로부터 부여받은 사이트 코드
//	    String sSitePassword = bizConfig.getProperty("nice.checkplus.site.pw");		// NICE로부터 부여받은 사이트 패스워드
//
//		String sRtnMsgNo = "";			// 결과 메세지 코드
//		boolean sRtnCode = false;
//
//	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);
//
//	    if( iReturn == 0 ){
//
//	        if(!paramR1.equals(sessionId)){
//	        	sRtnMsgNo = "session";
//	        } else {
//	        	sRtnCode = true;
//	        	sRtnMsgNo = "0";
//
//		        // 데이타를 추출합니다.
//	        	/* 데모 작업을 위해 로직 하드코딩
//		        HashMap mapresult = niceCheck.fnParse(niceCheck.getPlainData());
//
//		        result.setAuthType("20");	// 인증수단 : 휴대폰인증
//		        result.setName(StringUtil.nvl((String)mapresult.get("NAME")));
//		        result.setDupInfo(StringUtil.nvl((String)mapresult.get("DI")));
//		        result.setGenderCode(StringUtil.nvl((String)mapresult.get("GENDER")));
//		        result.setBirthDate(StringUtil.nvl((String)mapresult.get("BIRTHDATE")));
//		        result.setNationalInfo(StringUtil.nvl((String)mapresult.get("NATIONALINFO")));
//		        result.setReqNo(StringUtil.nvl((String)mapresult.get("REQ_SEQ")));
//		        result.setErrorCode(StringUtil.nvl((String)mapresult.get("ERR_CODE")));
//		        result.setColInfo(StringUtil.nvl((String)mapresult.get("CI")));
//		        */
//	        	
//	        	result.setAuthType("20");	// 인증수단 : 휴대폰인증
//		        result.setName("데모테스터");
//		        result.setDupInfo(RandomStringUtils.randomAlphanumeric(10));
//		        result.setGenderCode("1");
//		        result.setBirthDate(LocalDate.now().minus(Period.ofDays((new Random().nextInt(365 * 70)))).toString().replace("-", ""));
//		        result.setNationalInfo("0");
//		        result.setReqNo("1");
//		        result.setErrorCode("0");
//		        result.setColInfo(RandomStringUtils.randomAlphanumeric(10));
//		        
//		        /*
//		        sResponseNumber = (String)mapresult.get("RES_SEQ");
//		        sAuthType 			= (String)mapresult.get("AUTH_TYPE");
//		        sConnInfo 			= (String)mapresult.get("CI");
//		        */
//			    // 휴대폰 번호 : MOBILE_NO => (String)mapresult.get("MOBILE_NO");
//				// 이통사 정보 : MOBILE_CO => (String)mapresult.get("MOBILE_CO");
//				// checkplus_success 페이지에서 결과값 null 일 경우, 관련 문의는 관리담당자에게 하시기 바랍니다.
//
//	        }
//
//	    } else if( iReturn == -1) {
//	    	sRtnMsgNo = "1";
//	    } else if( iReturn == -4) {
//	    	sRtnMsgNo = "4";
//	    } else if( iReturn == -5) {
//	    	sRtnMsgNo = "5";
//	    } else if( iReturn == -6) {
//	    	sRtnMsgNo = "6";
//	    } else if( iReturn == -9) {
//	    	sRtnMsgNo = "9";
//	    } else if( iReturn == -12) {
//	    	sRtnMsgNo = "12";
//	    } else {
//	    	sRtnMsgNo = "etc";
//	    }
//
//	    result.setRtnCode(sRtnCode);
//	    result.setRtnMsg(message.getMessage("business.nice.checkplus.result.msg."+sRtnMsgNo));
//
//	    log.debug(">>>>>>>>>>>>>>>>>CheckPlus 인증데이터="+result.toString());
//	    return result;
//	}
//
//
//	public static String requestReplace (String paramValue, String gubun) {
//        String result = "";
//
//        if (paramValue != null) {
//
//        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
//
//        	paramValue = paramValue.replaceAll("\\*", "");
//        	paramValue = paramValue.replaceAll("\\?", "");
//        	paramValue = paramValue.replaceAll("\\[", "");
//        	paramValue = paramValue.replaceAll("\\{", "");
//        	paramValue = paramValue.replaceAll("\\(", "");
//        	paramValue = paramValue.replaceAll("\\)", "");
//        	paramValue = paramValue.replaceAll("\\^", "");
//        	paramValue = paramValue.replaceAll("\\$", "");
//        	paramValue = paramValue.replaceAll("'", "");
//        	paramValue = paramValue.replaceAll("@", "");
//        	paramValue = paramValue.replaceAll("%", "");
//        	paramValue = paramValue.replaceAll(";", "");
//        	paramValue = paramValue.replaceAll(":", "");
//        	paramValue = paramValue.replaceAll("-", "");
//        	paramValue = paramValue.replaceAll("#", "");
//        	paramValue = paramValue.replaceAll("--", "");
//        	paramValue = paramValue.replaceAll("-", "");
//        	paramValue = paramValue.replaceAll(",", "");
//
//        	if("encodeData".equals(gubun)){
//        		paramValue = paramValue.replaceAll("\\+", "");
//        		paramValue = paramValue.replaceAll("/", "");
//            paramValue = paramValue.replaceAll("=", "");
//        	}
//
//        	result = paramValue;
//
//        }
//        return result;
//	}
}