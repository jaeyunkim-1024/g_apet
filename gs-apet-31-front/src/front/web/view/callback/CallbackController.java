package front.web.view.callback;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import biz.app.login.model.SnsMemberInfoPO;
import framework.common.util.*;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import biz.app.login.model.SnsMemberInfoSO;
import biz.app.login.service.FrontLoginService;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberLoginHistVO;
import biz.app.member.service.MemberService;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.callback
* - 파일명		: CallbackController.java
* - 작성일		: 2020. 12. 17.
* - 작성자		: ValueFactory
* - 설명		: Callback을 위한 controller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping(value = {"callback"})
public class CallbackController {
	
	@Autowired	private NaverLoginUtil naverLoginUtil;
	
	@Autowired 	private KakaoLoginUtil kakaoLoginUtil;
	
	@Autowired 	private GoogleLoginUtil googleLoginUtil;

	@Autowired 	private AppleLoginUtil appleLoginUtil;
	
	@Autowired private MemberService memberService;
	
	@Autowired	private BizService bizService;

	@Autowired	private FrontLoginService frontLoginService;

	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CallbackController.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: KKB
	* - 설명		: 네이버 로그인 callback ( 코드로 토큰획득 > 사용자 정보 호출)
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"naverLogin/"})
	public String snsNaverCallback(HttpServletRequest request, Session session, ModelMap map, ViewBase view, String state, String code, RedirectAttributes redirectAttr) {
//		String storedState = naverLoginUtil.getSession(request.getSession());
		String storedState = naverLoginUtil.getSESSION_STATE();
		Map<String, String> userMap = null;
		String returnURL = "login/indexLogin";
		if(storedState != null && storedState.equals(state)) {			
			/* 접근 토큰 획득 */
			OAuth2AccessToken oauthToken = this.naverLoginUtil.getAccessToken(request.getSession(), code, state, "");
			if (oauthToken != null) {
				userMap = this.naverLoginUtil.getUserProfile(oauthToken);

				//연동하기 클릭 하였을 때
				String checkCode = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString();
				if(StringUtil.isNotEmpty(checkCode)){
					snsConnectManageDetail(FrontConstants.SNS_LNK_CD_10,userMap);
					return "redirect:/mypage/info/indexManageDetail";
				}

				if (userMap != null) {
					map.put("resultJson", userMap.get("resultJson"));
					
					String resultcode = userMap.get("resultcode");
					if(resultcode != null && resultcode.equals("00")) {
						
						Map<String, Object> result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_10);
						String exCode= result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
						if(exCode != null) {
							redirectAttr.addAttribute("snsExCode",exCode);
							//redirectAttr.addAttribute("mbrNo",result.get("mbrNo"));
						}
						return result.get("returnUrl").toString();
					}
				}
			}
		}
		return returnURL;
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CallbackController.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: KKB
	* - 설명		: 카카오 로그인 callback ( 코드로 토큰획득 > 사용자 정보 호출)
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"kakaoLogin/"})
	public String snsKaKaoCallback(HttpServletRequest request, Session session, ModelMap map, ViewBase view, String state, String code, RedirectAttributes redirectAttr) {
		String storedState = kakaoLoginUtil.getSession(request.getSession());
		Map<String, String> userMap = null;
		String returnVal = "login/indexLogin";
		if(storedState != null && storedState.equals(state)) {			
			/* 접근 토큰 획득 */
			OAuth2AccessToken oauthToken = this.kakaoLoginUtil.getAccessToken(request.getSession(), code, state, "");
			if (oauthToken != null) {
				userMap = this.kakaoLoginUtil.getUserProfile(oauthToken);
				if (userMap != null) {
					//연동하기 클릭 하였을 때
					String checkCode = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString();
					if(StringUtil.isNotEmpty(checkCode)){
						snsConnectManageDetail(FrontConstants.SNS_LNK_CD_20,userMap);
						return "redirect:/mypage/info/indexManageDetail";
					}

					map.put("resultJson", userMap.get("resultJson"));
					
					Map<String, Object> result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_20);
					String exCode= result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
					if(exCode != null) {
						redirectAttr.addAttribute("snsExCode", exCode);
						//redirectAttr.addAttribute("mbrNo",result.get("mbrNo"));
					}
					return result.get("returnUrl").toString();
				}
			}
		}
		return returnVal;
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CallbackController.java
	* - 작성일		: 2020. 12. 22.
	* - 작성자		: KKB
	* - 설명		: 구글 로그인 callback ( 코드로 토큰획득 > 사용자 정보 호출)
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"googleLogin/"})
	public String snsGoogleCallback(HttpServletRequest request, Session session, ModelMap map, ViewBase view, String state, String code, RedirectAttributes redirectAttr) {
		String storedState = googleLoginUtil.getSession(request.getSession());
		Map<String, String> userMap = null;
		String returnVal = "login/indexLogin";
		if(storedState != null && storedState.equals(state)) {			
			/* 접근 토큰 획득 */
			OAuth2AccessToken oauthToken = this.googleLoginUtil.getAccessToken(request.getSession(), code, state, "");
			if (oauthToken != null) {
				userMap = this.googleLoginUtil.getUserProfile(oauthToken);

				//연동하기 클릭 하였을 때
				String checkCode = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString();
				if(StringUtil.isNotEmpty(checkCode)){
					snsConnectManageDetail(FrontConstants.SNS_LNK_CD_30,userMap);
					return "redirect:/mypage/info/indexManageDetail";
				}

				if (userMap != null) {
					map.put("resultJson", userMap.get("resultJson"));
					
					Map<String, Object> result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_30);
					String exCode= result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
					if(exCode != null) {
						redirectAttr.addAttribute("snsExCode", exCode);
						//redirectAttr.addAttribute("mbrNo",result.get("mbrNo"));
					}
					return result.get("returnUrl").toString();
				}
			}
		}
		return returnVal;
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CallbackController.java
	* - 작성일		: 2020. 12. 22.
	* - 작성자		: KKB
	* - 설명		: 애플 로그인 callback
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"appleLogin/"})
	public String snsAppleCallback(HttpServletRequest request
			, String id_token
			, @RequestParam(value="user",required=false)String user
			, RedirectAttributes redirectAttr)
	{
		try{
			OAuth2AccessToken token = Optional.ofNullable(appleLoginUtil.getAccessToken(request.getSession(),id_token,null,null)).orElseThrow(()->new NullPointerException());
			Map<String, String> userMap = appleLoginUtil.getUserProfile(token);
			//올바른 회원 정보 아닐 시
			if(userMap.isEmpty()) {
				log.error("NullPointerException");
				throw new NullPointerException();
			}

			//연동하기 클릭 하였을 때
			String checkCode = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString();
			if(StringUtil.isNotEmpty(checkCode)){
				snsConnectManageDetail(FrontConstants.SNS_LNK_CD_40,userMap);
				return "redirect:/mypage/info/indexManageDetail";
			}
			
			//로그인 일 때
			Map<String, Object> result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_40);
			
			String exCode= Optional.ofNullable(result.get("exCode")).orElseGet(()->"").toString();
			if(exCode != null) {
				redirectAttr.addAttribute("snsExCode",exCode);
				//redirectAttr.addAttribute("mbrNo",result.get("mbrNo"));
			}
			return result.get("returnUrl").toString();
		}catch(Exception npe){
			//return TilesView.login(new String[]{ "indexLogin"});
			return "redirect:/indexLogin";
		}
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CallbackController.java
	* - 작성일		: 2021. 03. 15.
	* - 작성자		: KKB
	* - 설명		: 앱 SNS 로그인
	 * </pre>
	 *
	 * @return view
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = {"snsAppLogin/"})
	public String snsAppLogin(Session session,  ModelMap map, ViewBase view, String snsLnkCd, RedirectAttributes redirectAttr,
			String uuid, String email, String name, String mobile, String ciCtfVal, String gender, String birthday, String birthyear, String deviceToken, String deviceType ) {
		Map<String, String> userMap = new HashMap<>();
		log.debug("snsAppLogin! : "+uuid+"/"+email+"/"+deviceToken+"/"+deviceType); 
		userMap.put("uuid", uuid);
		userMap.put("email", email);
		userMap.put("name", name);
		userMap.put("mobile", mobile);
		userMap.put("ciCtfVal", ciCtfVal);
		userMap.put("gender", gender);
		userMap.put("birthday", birthday);
		userMap.put("birthyear", birthyear);
		userMap.put("deviceToken", deviceToken);
		userMap.put("deviceTpCd", deviceType); 
		Map<String, Object> result = null;
		if(CommonConstants.SNS_LNK_CD_10.equals(snsLnkCd)) {
			result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_10);
		}else if (CommonConstants.SNS_LNK_CD_20.equals(snsLnkCd)) {
			result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_20);
		}else if (CommonConstants.SNS_LNK_CD_30.equals(snsLnkCd)) {
			result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_30);
		}else if (CommonConstants.SNS_LNK_CD_40.equals(snsLnkCd)) {
			result = this.SnsLoginProcess(userMap, CommonConstants.SNS_LNK_CD_40);
		}

		//연동하기 클릭 하였을 때
		String checkCode = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString();
		if(StringUtil.isNotEmpty(checkCode)){
			snsConnectManageDetail(snsLnkCd,userMap);
			return "redirect:/mypage/info/indexManageDetail";
		}

		String exCode= result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
		if(exCode != null) {
			redirectAttr.addAttribute("snsExCode",exCode);
			//redirectAttr.addAttribute("mbrNo",result.get("mbrNo"));
		}
		return result.get("returnUrl").toString();
	}
	
	
	
	
	
	@SuppressWarnings("unchecked")
	private Map<String,Object> SnsLoginProcess (Map<String, String>  userMap , String snsLnkCd) {
		Map<String, Object> result = new HashMap<>();

		// 기존 sns회원 여부 체크
		SnsMemberInfoSO snsSo = new SnsMemberInfoSO();
		snsSo.setSnsUuid(userMap.get("uuid"));
		snsSo.setSnsLnkCd(snsLnkCd); 
		MemberBaseVO snsMember = memberService.getExistingSnsMemberCheck(snsSo);
		
		//sns정보일치하는 기존 sns회원이 있다면
		if(snsMember != null && snsMember.getMbrNo() != null) {
			
			String returnUrl = "";
			if(SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL)!=null) {
				returnUrl = SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL).toString();
				SessionUtil.removeAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL); 
			}
			
			//하루펫츠비 최초로그인인 경우
			if(!StringUtil.isEmpty(snsMember.getJoinPathCd()) && !snsMember.getJoinPathCd().equals(FrontConstants.JOIN_PATH_30)) {
				MemberLoginHistVO loginHist = this.memberService.selectLoginHistory(snsMember.getMbrNo());
				if( StringUtil.isEmpty(loginHist)) {
					
					result.put("exCode", "PBHR");
					SessionUtil.setAttribute(FrontConstants.SESSION_LOGIN_MBR_NO,snsMember.getMbrNo()); //없어도 될 듯
					SessionUtil.setAttribute(FrontConstants.SESSION_UPDATE_HRPB, snsMember);
					
					result.put("returnUrl", "redirect:/indexLogin");
					
					return result;
				}
			}
			
			//로그인처리하고 return 하기.
			String validCheck = frontLoginService.checkLoginInfo(snsMember);

			//sns 계정 연결 상태 아닌 경우 - 현재는 이런 경우 없다.
			if(!validCheck.equals(CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS) && !validCheck.equals("notag")) {
				//유효성체크 실패한경우
				result.put("exCode", validCheck);
				//result.put("mbrNo", snsMember.getMbrNo());
				SessionUtil.setAttribute(FrontConstants.SESSION_LOGIN_MBR_NO,snsMember.getMbrNo());
				if(returnUrl != null) {
					result.put("returnUrl", "redirect:/indexLogin?returnUrl="+returnUrl);
				}else {
					result.put("returnUrl", "redirect:/indexLogin");
				}
			}else {
				//성공한경우
				snsMember.setLoginPathCd(snsLnkCd); 
				
				Map<String,String> map = (Map<String, String>) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_TOKEN);
				log.debug("snsLoginTokenGet : {}",map); 
				if(map!= null || userMap.get("deviceToken") != null) {
					String deviceToken = map == null ? userMap.get("deviceToken") : map.get("deviceToken");
					String deviceTpCd = map == null ? userMap.get("deviceTpCd") : map.get("deviceTpCd");
					snsMember.setDeviceToken(deviceToken);
					snsMember.setDeviceTpCd(deviceTpCd);
					SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_TOKEN);
				}
				frontLoginService.saveLoginSession(snsMember,null);
				
				
				if(returnUrl == null) {
					returnUrl = "/shop/home/";
				//	result.put("returnUrl", "redirect:"+returnUrl);
				}/*else {
					result.put("returnUrl", "redirect:/tv/home/");
				}*/
				
				if( validCheck.equals("notag") ) {
					//result.put("returnUrl", "redirect:/join/indexTag");
					returnUrl = "/join/indexTag";
				}
				
				result.put("returnUrl", "redirect:/appLoginProcess?returnUrl="+returnUrl+"&loginPathCd="+snsMember.getLoginPathCd());
			}
			
			return result;
		}
		else 
		{//sns회원 정보 없는경우 sns회원가입이라 간주.
			
			//sns정보와 맞는 기존일반회원 체크
			snsSo.setEmail(userMap.get("email"));
			snsSo.setMbrNm(userMap.get("name"));
			
			if(userMap.get("mobile") !=null) {snsSo.setMobile(userMap.get("mobile").replace("-", ""));}	//모바일 추가해야함. 
			
			snsSo.setCiCtfVal(userMap.get("ciCtfVal"));   //ci  받는부분은 추가해야  
			
			//체크조회 위한 암호화
			if(snsSo.getMobile() != null && !snsSo.getMobile().equals("")) 	{snsSo.setMobile(bizService.twoWayEncrypt(snsSo.getMobile()));}
			if(snsSo.getMbrNm() !=null && !snsSo.getMbrNm().equals("")) 	{snsSo.setMbrNm(bizService.twoWayEncrypt(snsSo.getMbrNm()));}
			//String beforeEncEmail = snsSo.getEmail();
			if(snsSo.getEmail() != null && !snsSo.getEmail().equals("")) {
				snsSo.setEmail(bizService.twoWayEncrypt(snsSo.getEmail()));
			}
			
			MemberBaseVO exsMember =  memberService.getExistingMemberCheck(snsSo);
			
			//sns정보일치하는 기존 일반회원이 있다면 계정연동
			if(exsMember != null && exsMember.getMbrNo() != null) {
				//계정연동 로그인 화면으로 이동.
				snsSo.setMbrNo(exsMember.getMbrNo());
				snsSo.setLoginId(bizService.twoWayDecrypt(exsMember.getLoginId())); 
				SessionUtil.setAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO, snsSo);
				
				result.put("returnUrl" ,TilesView.redirect(new String[] { "join","connectSns" }));
				
				return result;
			}
			else	 
			{	//sns 정보 일치하는 기존 일반회원 없다면 최초회원가입
				String genderCd = null;
				
				if(userMap.get("gender")!=null) {
					if(userMap.get("gender").equals("F") || userMap.get("gender").equals("female")) {genderCd = "20";}
					else if(userMap.get("gender").equals("M") || userMap.get("gender").equals("male")) {genderCd = "10";}
					snsSo.setGender(genderCd);
				}
				
				if(userMap.get("birthday") !=null && !userMap.get("birthday").isEmpty() && userMap.get("birthyear")!=null && !userMap.get("birthyear").isEmpty()) {
					snsSo.setBirth(userMap.get("birthyear")+userMap.get("birthday").replace("-", ""));  
				}
				//snsSo.setMobile(userMap.get("mobile"));
				
				/*if(beforeEncEmail != null && !beforeEncEmail.equals("")) {
					//애플 이메일 비공개인 경우
					if(beforeEncEmail.indexOf("@privaterelay.appleid.com") > -1) {
						snsSo.setEmailApple(snsSo.getEmail());
					}
				}*/
				log.debug("sns move join : {}",snsSo);
				SessionUtil.setAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO, snsSo); 
				
				//약관 동의 화면 이동.
				result.put("returnUrl", TilesView.redirect(new String[] { "join","indexTerms" }));
				return result;
			}
			
			
		}
		
		
	}

	private void snsConnectManageDetail(String snsLnkCd,Map<String,String> userMap){
		Long mbrNo = Long.parseLong(SessionUtil.getAttribute(FrontWebConstants.SESSION_SNS_CONNECT_MEMBER).toString());

		try{
			String snsUuid = userMap.get("uuid");
			String email = bizService.twoWayEncrypt(userMap.get("email"));
			//체크
			SnsMemberInfoPO p = new SnsMemberInfoPO();
			p.setSnsUuid(snsUuid);
			p.setMbrNo(mbrNo);
			p.setEmail(email);
			//토큰 추가 필요?
			p.setSnsLnkCd(snsLnkCd);
			p.setSnsStatCd(FrontConstants.SNS_STAT_10);
			p.setSnsJoinYn(FrontConstants.COMM_YN_N);
			p.setSysRegrNo(mbrNo);
			memberService.upSertSnsMemberInfo(p);
			SessionUtil.setAttribute(FrontWebConstants.SESSION_SNS_LNK_CD_KEY,snsLnkCd);
		}catch(Exception e){
			log.error("### SNS CONNECT IS FAILED {}",e.getClass());
		}
	}
}
