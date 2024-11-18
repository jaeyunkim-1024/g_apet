package biz.interfaces.nice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.common.service
* - 파일명		: NiceIpinServiceImpl.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Nice Ipin 인증관련 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("niceIpinService")
public class NiceIpinServiceImpl implements NiceService {

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
//		String sSiteCode = bizConfig.getProperty("nice.ipin.site.code");
//		String sSitePw = bizConfig.getProperty("nice.ipin.site.pw");
//		String sReturnUrl = siteDomain + "/join/popupIpinResult";
//		String sCPRequest;
//
//		IPIN2Client pClient = new IPIN2Client();
//
//		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
//		sCPRequest = pClient.getRequestNO(sSiteCode);
//
//		// CP 요청번호를 세션에 저장합니다.
//		// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
//		// 필수사항은 아니며, 보안을 위한 권고사항입니다.
////		session.setAttribute("CPREQUEST" , sCPRequest);
//
//
//		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
//		int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnUrl);
//
//		String sRtnMsgNo = "";			// 결과 메세지 코드
//		boolean sRtnCode = false;
//
//		// Method 결과값에 따른 처리사항
//		if (iRtn == 0) {
//
//			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
//			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
//			result.setEncData(pClient.getCipherData());
//
//			sRtnMsgNo = "0";
//			sRtnCode = true;
//
//		} else if (iRtn == -1 || iRtn == -2) {
//			sRtnMsgNo = "1_2";
//		} else if (iRtn == -9) {
//			sRtnMsgNo = "9";
//		} else {
//			sRtnMsgNo = "etc";
//		}
//
//		result.setRtnCode(sRtnCode);
//		result.setRtnMsg(message.getMessage("business.nice.ipin.check.msg."+sRtnMsgNo));
//
//		return result;
//	}
//
//
//	/*
//	 * 개인정보 추출
//	 * @see front.web.view.common.service.NiceService#getCertifyData(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
//	 */
//	@Override
//	public NiceCertifyDataVO getCertifyData(String encData, String paramR1, String paramR2, String paramR3, String sessionId) {
//		NiceCertifyDataVO result = new NiceCertifyDataVO();
//
//		String sSiteCode = bizConfig.getProperty("nice.ipin.site.code");
//		String sSitePw = bizConfig.getProperty("nice.ipin.site.pw");
//		String sResponseData = requestReplace(encData, "encodeData");
//
//	    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
//	    //String sCPRequest = (String)session.getAttribute("CPREQUEST");
//
//
//	    // 객체 생성
//	    IPIN2Client pClient = new IPIN2Client();
//
//		/*
//		┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
//			Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
//
//			fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
//			'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)
//
//			따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
//		└────────────────────────────────────────────────────────────────────
//		*/
//		int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
//		//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);
//
//		String sRtnMsgNo = "";			// 결과 메세지 코드
//		boolean sRtnCode = false;
//
//
//		// Method 결과값에 따른 처리사항
//		if (iRtn == 1)
//		{
//
//			if(!paramR1.equals(sessionId)){
//	        	sRtnMsgNo = "session";
//	        }else{
//				sRtnMsgNo = "1";
//				sRtnCode = true;
//				/*
//					다음과 같이 사용자 정보를 추출할 수 있습니다.
//					사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.
//
//					사용자 정보를 다른 페이지에서 이용하실 경우에는
//					보안을 위하여 암호화 데이타(sResponseData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)
//
//					만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
//					form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.
//				*/
//				/*
//	    		String sVNumber				= pClient.getVNumber();			// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
//	    		String sAgeCode				= pClient.getAgeCode();			// 연령대 코드 (개발 가이드 참조)
//	    		String sAuthInfo			= pClient.getAuthInfo();		// 본인확인 수단 (개발 가이드 참조)
//	    		String sCoInfo1				= pClient.getCoInfo1();			// 연계정보 확인값 (CI - 88 byte 고유값)
//	    		String sCIUpdate			= pClient.getCIUpdate();		// CI 갱신정보
//				*/
//	    		result.setAuthType("10");	// 인증수단 : IPIN
//	    		result.setName(StringUtil.nvl(pClient.getName())); // 이름
//	    		result.setDupInfo(StringUtil.nvl(pClient.getDupInfo())); // 중복가입 확인값 (DI - 64 byte 고유값)
//	    		result.setGenderCode(StringUtil.nvl(pClient.getGenderCode())); // 성별 코드 (개발 가이드 참조)
//	    		result.setBirthDate(StringUtil.nvl(pClient.getBirthDate())); // 생년월일 (YYYYMMDD)
//	    		result.setNationalInfo(StringUtil.nvl(pClient.getNationalInfo())); // 내/외국인 정보 (개발 가이드 참조)
//	    		result.setReqNo(StringUtil.nvl(pClient.getCPRequestNO())); // CP 요청번호
//	    		result.setColInfo(StringUtil.nvl(pClient.getCoInfo1()));
//	        }
//
//		} else if (iRtn == -1 || iRtn == -4) {
//			sRtnMsgNo =	"1_4";
//		} else if (iRtn == -6) {
//			sRtnMsgNo =	"6";
//		} else if (iRtn == -9) {
//			sRtnMsgNo = "9";
//		} else if (iRtn == -12) {
//			sRtnMsgNo = "12";
//		} else if (iRtn == -13) {
//			sRtnMsgNo = "13";
//		} else {
//			sRtnMsgNo = "etc";
//		}
//
//		result.setRtnCode(sRtnCode);
//		result.setRtnMsg(message.getMessage("business.nice.ipin.result.msg."+sRtnMsgNo));
//		log.debug(">>>>>>>>>>>>>>>>>ipin 인증데이터="+result.toString());
//
//		return result;
//	}
//
//
//	/**
//	* <pre>
//	* - 프로젝트명	: 31.front.web
//	* - 파일명		: NiceIpinServiceImpl.java
//	* - 작성일		: 2016. 3. 2.
//	* - 작성자		: snw
//	* - 설명		: Nice 특수문자 재처리
//	* </pre>
//	* @param paramValue
//	* @param gubun
//	* @return
//	* @throws Exception
//	*/
//	private String requestReplace(String paramValue, String gubun){
//        String result = "";
//
//        if (paramValue != null) {
//
//        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
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
//        	if(!"encodeData".equals(gubun)){
//        		paramValue = paramValue.replaceAll("\\+", "");
//        		paramValue = paramValue.replaceAll("/", "");
//            paramValue = paramValue.replaceAll("=", "");
//        	}
//
//        	result = paramValue;
//
//        }
//        return result;
//  }


}