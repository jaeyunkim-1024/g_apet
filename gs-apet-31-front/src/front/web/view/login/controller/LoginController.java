package front.web.view.login.controller;

import java.security.PrivateKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.appweb.service.PushService;
import biz.app.appweb.service.TermsService;
import biz.app.login.model.SnsMemberInfoSO;
import biz.app.login.service.FrontLoginService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCertifiedLogPO;
import biz.app.member.service.MemberDormantService;
import biz.app.member.service.MemberService;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.common.model.EmailRecivePO;
import biz.common.model.EmailSendPO;
import biz.common.model.PushTokenPO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.AppleLoginUtil;
import framework.common.util.GoogleLoginUtil;
import framework.common.util.KakaoLoginUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.NaverLoginUtil;
import framework.common.util.RSAUtil;
import framework.common.util.RequestUtil;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import framework.common.util.security.PBKDF2PasswordEncoder;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;



/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.login.controller
* - 파일명		: LoginController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 로그인 Controller
* </pre>
*/
@Slf4j
@Controller
public class LoginController {
	
	private static final String[] NAVIGATION_LOGIN = {"로그인"};
	private static final String[] NAVIGATION_NOT_USING = {"휴면계정 해제 안내"};

	@Autowired private FrontLoginService frontLoginService;

	@Autowired private MessageSourceAccessor message;
	
	@Autowired private MemberService memberService;

	@Autowired private BizService bizService;

	@Autowired private CacheService cacheService;

	@Autowired	private NaverLoginUtil naverLoginUtil;
	
	@Autowired 	private KakaoLoginUtil kakaoLoginUtil;
	
	@Autowired 	private GoogleLoginUtil googleLoginUtil;

	@Autowired 	private AppleLoginUtil appleLoginUtil;
	
	@Autowired 	private PushService pushService;
	
	@Autowired 	private Properties bizConfig;

	@Autowired private TermsService termsService;

	@Autowired private TagService tagService;
	
	/*@Autowired
	private Properties bizConfig;*/
	
	// PBKDF2
	@Autowired private PBKDF2PasswordEncoder passwordEncoder;
	
	@Autowired private MemberDormantService memberDormantService;
		
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 3. 19.
	* - 작성자		: 이지희
	* - 설명		: 로그인 페이지 화면
	* </pre>
	* @param session
	* @param map
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexLogin")
	public String indexLogin(Session session, ModelMap map, ViewBase view,  String returnUrl, String snsExCode, HttpServletRequest request, HttpServletResponse response){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		
		response.setDateHeader("Expires",0); 
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		response.setHeader("Pragma", "no-cache");
		
		SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		
		String[] cookieNames = {
				FrontConstants.COOKIE_POPUP_NAME, bizConfig.getProperty("envmt.gb")+FrontConstants.COOKIE_RECENT_GOODS, FrontConstants.COOKIE_REMEMBER_LOGIN_ID,
				FrontWebConstants.SESSION_ORDER_PARAM_TYPE, FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS, FrontConstants.SESSION_ORDER_PARAM_CART_YN,
				FrontConstants.COOKIE_POP_LAYER_EVENT_PC, FrontConstants.COOKIE_POP_LAYER_EVENT_MO, FrontConstants.COOKIE_POP_LAYER_EVENT_APP
		};
		FrontSessionUtil.removeSessionExcept(cookieNames);
		
		view.setNavigation(NAVIGATION_LOGIN);
		
		//리턴 url이 있는 경우
		if(returnUrl != null){
			
			Map<String, String[]> paramMap = request.getParameterMap();
			Set<String> keySet = paramMap.keySet();
			for(String key : keySet) {
				if(!StringUtil.equals(key, "snsExCode") && !StringUtil.equals(key, "returnUrl")) {
					returnUrl += "&"+key+"="+paramMap.get(key)[0];
				}
			}
			
			SessionUtil.setAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL, returnUrl);
		}else if(SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL)!=null) {
			//리턴 url없는 세션에 있는 경우 - sns 로그인 시 결과값 갖고 다시 돌아올 때.
			map.put("snsReturnUrl", SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL).toString());
			SessionUtil.removeAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL);
		}
		
		map.put("returnUrl", returnUrl);
		map.put("session", session);
		map.put("view", view);
		if(snsExCode != null) {
			map.put("snsExCode", snsExCode);
			//펫츠비 sns로 최초로그인
			if(StringUtil.equals(snsExCode,"PBHR")) {
				map.put("snsExMsg", "PBHR");
				map.put("returnUrl", "/shop/home");
			}else if(!StringUtil.equals(snsExCode,"noInfoPBHR")) {
				map.put("snsExMsg", message.getMessage("business.exception." + snsExCode));
			}
		}
	
		if(session.getKeepYn() != null && !session.getKeepYn().equals("")) {
			map.put("remember", bizService.twoWayDecrypt(session.getKeepYn()));
		}
		
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		map.put("RSAModulus", publKeyMap.get("RSAModulus"));
		map.put("RSAExponent", publKeyMap.get("RSAExponent"));
		
		return TilesView.login(new String[]{ "indexLogin"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 로그인 처리
	* </pre>
	* @param login_id
	* @param password
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap login(MemberBaseVO checkVo){
		
		ModelMap map = new ModelMap();
		
		PrivateKey privateKey = (PrivateKey)SessionUtil.getAttribute("_RSA_WEB_KEY_");
		if(privateKey == null) {
			map.addAttribute(FrontConstants.CONTROLLER_RESULT_CODE, "keyError");
			return map;
		}
		
		String uid = RSAUtil.decryptRas(privateKey, checkVo.getLoginId());
		String pwd = RSAUtil.decryptRas(privateKey, checkVo.getPswd());
		checkVo.setLoginId(uid);
		checkVo.setPswd(pwd); 
		
		checkVo.setLoginPathCd(CommonConstants.LOGIN_PATH_ABOUTPET);
		Map<String, Object> result = this.frontLoginService.checkLogin(checkVo);
		
		String resultCode = result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
		String resultMsg = null;
		
		if(StringUtil.isNotBlank(resultCode)) {
			resultMsg = message.getMessage("business.exception." + resultCode);

		}else if(result.get("PBHR") != null) {
			//하루 펫츠비 기존 회원인데 최초 로그인인 경우
			resultCode = "PBHR";
		}
		else 
		{ //성공인 경우
			resultCode = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			//가입정보 추가
			map.addAttribute(FrontConstants.JOIN_PATH , result.get(FrontConstants.JOIN_PATH));
			//태그정보 없다면 태그 선택 페이지로
			if(result.get("tags") != null && result.get("tags").equals("no_tag")) {
				map.addAttribute("tags",result.get("tags"));
			}
			//펫로그 회원정보
			map.addAttribute("petLog", result.get("petLog"));
			
			//SessionUtil.removeAttribute("_RSA_WEB_KEY_");
		}
		log.debug(">>>>>>>>>로그인결과="+resultCode);
		
		
		map.addAttribute("mbrNo",result.get("mbrNo"));
		map.addAttribute(FrontConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.addAttribute(FrontConstants.CONTROLLER_RESULT_MSG, resultMsg);

		map.addAttribute("gsptStateCd",result.get("gsptStateCd"));
		map.addAttribute("gsptUseYn",result.get("gsptUseYn"));

		return map;
	}	


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 로그아웃 처리
	* </pre> 
	* @param request
	* @param response
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="logout")
	public String logout(HttpServletRequest request, Session session, HttpServletResponse response, String returnUrl,  ModelMap map, ViewBase view){
		
		Long orgMbrNo = session.getMbrNo();
		String[] cookieNames = {
				FrontConstants.COOKIE_POPUP_NAME, bizConfig.getProperty("envmt.gb")+FrontConstants.COOKIE_RECENT_GOODS, FrontConstants.COOKIE_REMEMBER_LOGIN_ID,
				FrontConstants.COOKIE_POP_LAYER_EVENT_PC, FrontConstants.COOKIE_POP_LAYER_EVENT_MO, FrontConstants.COOKIE_POP_LAYER_EVENT_APP
		};
		FrontSessionUtil.removeSessionExcept(cookieNames);
		
		String returnVal = TilesView.layout("login",new String[]{"indexLogout"});
		/*
		if(returnUrl != null && !returnUrl.equals("")) {
			returnVal = "redirect:"+returnUrl;
		}*/
		map.put("returnUrl", returnUrl);
		map.put("view", view);
		map.put("orgMbrNo", orgMbrNo);
		
		return returnVal;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 04. 16.
	 * - 작성자		: 이지희	
	 * - 설명		: app로그아웃 시 토큰정보 삭제
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="deleteMemberTokenInfo")
	@ResponseBody
	public String deleteMemberTokenInfo( Session session ,@RequestParam(value="orgMbrNo",required=false) String orgMbrNo){
		
		if(orgMbrNo == null) {
			return "";
		}
		
		//String orgMbrNo = SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_MBR_NO).toString();
		PushTokenPO tokenPo = new PushTokenPO();
		tokenPo.setUserId(orgMbrNo);
		bizService.deleteDeviceToken(tokenPo);
		
		MemberBasePO po = new MemberBasePO();
		po.setMbrNo(Long.parseLong(orgMbrNo));
		po.setDeviceToken("nullToken"); //해당 값이면 token null로
		memberService.updateMemberBase(po); 
		
		return "S";
	}

	


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 02. 05.
	* - 작성자		: 이지희	
	* - 설명		: 아이디 찾기 화면
	* </pre>
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login/indexFindId")
	public String indexFindId(Session session, ModelMap map, ViewBase view){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		map.put("session", session);
		map.put("view", view);
		return TilesView.login(new String[]{ "indexFindId"});
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 05.
	 * - 작성자		: 이지희	
	 * - 설명		: 아이디 찾기 결과 화면
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="login/indexFindIdResult")
	public String indexFindIdResult(Session session, ModelMap map, ViewBase view, String authJson ,MemberBaseSO so){
		
		map.put("session", session);
		map.put("view", view);
		
		//본인인증
		if(authJson != null && !authJson.equals(""))  {
			MemberBaseVO returnMem= this.frontLoginService.getMemberIdPswdMobile(authJson,null);
			if(returnMem == null) {
				map.put("member", "notMatch");
				map.put("session", session);
				map.put("view", view);
				return TilesView.login(new String[]{ "indexFindId"});
			}
			map.put("member", returnMem);
		}else {
			//이메일 인증
			//so.setMbrNm(bizService.twoWayEncrypt(so.getMbrNm()));
			so.setEmail(bizService.twoWayEncrypt(so.getEmail()));
			MemberBaseVO mem= this.frontLoginService.getMemberLoginIdEmail(so);
			
			MemberBaseVO returnMem = new MemberBaseVO();
			returnMem.setLoginId(MaskingUtil.getId(mem.getLoginId()));
			returnMem.setMbrNm(mem.getMbrNm() == null ? "" : mem.getMbrNm()); 
			map.put("member", returnMem);
		}
		
		return TilesView.login(new String[]{ "indexFindIdResult"});
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: snw
	* - 설명		: 아이디 찾기 (이메일)
	* </pre>
	* @param mbrNm
	* @param email
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login/findMemberIdPswdEmail")
	@ResponseBody
	public ModelMap findMemberIdPswdEmail(MemberBaseSO so, @RequestParam(value="pswdFindUseYn", required=false) String pswdFindUseYn){
		ModelMap modelmap = new ModelMap();
		
		so.setPswd("pswd"); 
		//so.setMbrNm(bizService.twoWayEncrypt(so.getMbrNm()));
		so.setEmail(bizService.twoWayEncrypt(so.getEmail()));
		if(so.getLoginId() != null) {so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));}  //비번 찾기인 경우
		MemberBaseVO vo = memberService.getMemberBase(so);
		
		if(vo == null || vo.getMbrNo() == null ) {
			modelmap.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_NOT_USE);
			return modelmap;
		}
		EmailSendPO emailPO = new EmailSendPO();
//		if(pswdFindUseYn.equals("Y")) {
			//비밀번호 찾기 템플릿
//			emailPO.setTmplNo((long)156); 
//		}else{
			//아이디 찾기 템플릿
			emailPO.setTmplNo((long)50); 
//		}
		emailPO.setSenderAddress("hello@aboutpet.co.kr"); 

		//수신자 정보
		List<EmailRecivePO> recipients = new ArrayList<EmailRecivePO>();
		
		EmailRecivePO revPO = new EmailRecivePO();
		revPO.setAddress(bizService.twoWayDecrypt(vo.getEmail()));
		revPO.setName(vo.getMbrNm() == null ? null :bizService.twoWayDecrypt(vo.getMbrNm())); 

		Map<String,String> map =new HashMap<String, String>();
		String ctf_no =  StringUtil.randomNumeric(6);
		if(StringUtil.isNotEmpty(vo.getNickNm())) {
			map.put("nick_nm", vo.getNickNm()+"님");
		}else {
			map.put("nick_nm", "");
		}
		map.put("ctf_email_no", ctf_no);
		if(so.getLoginId() != null) {map.put("ctf_type","비밀번호 찾기");}
		else 						{map.put("ctf_type", "아이디 찾기");}
		revPO.setParameters(map);
		recipients.add(revPO);
		
		emailPO.setRecipients(recipients);
		
		bizService.sendEmail(emailPO);
		
		modelmap.put("ctfNo", ctf_no);
		return modelmap;
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 02. 08.
	* - 작성자		: 이지희	
	* - 설명		: 비밀번호 찾기 화면
	* </pre>
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login/indexFindPswd")
	public String indexFindPswd(Session session, ModelMap map, ViewBase view){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		map.put("session", session);
		map.put("view", view);
		return TilesView.login(new String[]{ "indexFindPswd"});
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: 이지희	
	 * - 설명		: 비밀번호 찾기 본인인증인 경우 처리
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="login/indexFindPswdCtfResult")
	@ResponseBody
	public ModelMap indexFindPswdCtfResult( String authJson ,String loginId){
		
		ModelMap map = new ModelMap();
		//본인인증
		if(authJson != null && !authJson.equals("")) {
			loginId = loginId.replaceAll(" ", ""); 
			MemberBaseVO returnMem= this.frontLoginService.getMemberIdPswdMobile(authJson,loginId);
			//정보에 해당하는 회원 없으면 
			if(returnMem == null) {
				map.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_NOT_USE);
				return map;
			}else {
				
				map.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS);
				//다음페이지에서 체크하기 위한 세션 set
				SessionUtil.setAttribute(FrontConstants.SESSION_UPDATE_PSWD, returnMem);
			}
		}
		
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: 이지희	
	 * - 설명		: 비밀번호 찾기 이메일 인증인 경우 처리
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="login/indexFindPswdEmailResult")
	public String indexFindPswdEmailResult(Session session, ModelMap map, ViewBase view, MemberBaseSO so){
		
		
		/*so.setMbrNm(bizService.twoWayEncrypt(so.getMbrNm().replaceAll(" ","")));*/
		so.setEmail(bizService.twoWayEncrypt(so.getEmail().replaceAll(" ","")));
		so.setLoginId(bizService.twoWayEncrypt(so.getLoginId().replaceAll(" ","")));  
		MemberBaseVO mem= this.frontLoginService.getMemberLoginIdEmail(so);
		
		MemberBaseVO returnMem = new MemberBaseVO();
		returnMem.setLoginId(mem.getLoginId()); 
		//returnMem.setMobile(bizService.twoWayDecrypt(mem.getMobile()));
		//returnMem.setBirth(bizService.twoWayDecrypt(mem.getBirth()));
		returnMem.setMbrNo(mem.getMbrNo());
		//SessionUtil.setAttribute("findPswdMbrNo", mem.getMbrNo()); 
		//다음페이지에서 체크하기 위한 세션 set
		SessionUtil.setAttribute(FrontConstants.SESSION_UPDATE_PSWD, returnMem);
		
		map.put("session", session);
		map.put("view", view);
	
		return TilesView.redirect(new String[]{"login","indexFindPswdResult"});
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: 이지희	
	 * - 설명		: 비밀번호 찾기 완료 화면
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="login/indexFindPswdResult")
	public String indexFindPswdResult(Session session, ModelMap map, ViewBase view){
		
		map.put("session", session);
		map.put("view", view);
		
		//그전 페이지에서 인증후 저장한 세션값 갖고오기
		Object sessionVal = SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_PSWD);
		if(sessionVal == null) {
			//세션 없으면 로그인 페이지로 
			return  TilesView.redirect(new String[]{"indexLogin"});
		}
		
		SessionUtil.removeAttribute(FrontConstants.SESSION_UPDATE_PSWD);
		
		MemberBaseVO sessionVO = (MemberBaseVO)sessionVal;
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(sessionVO.getMbrNo());
		so.setPswd("pswd");
		MemberBaseVO mem= this.memberService.getMemberBase(so);
		
		MemberBaseVO returnMem = new MemberBaseVO();
		returnMem.setLoginId(bizService.twoWayDecrypt(mem.getLoginId())); 
		returnMem.setMobile(bizService.twoWayDecrypt(mem.getMobile()));
		returnMem.setBirth(bizService.twoWayDecrypt(mem.getBirth()));
		SessionUtil.setAttribute("findPswdMbrNo", mem.getMbrNo()); 
		
		map.put("member",returnMem );
		
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		map.put("RSAModulus", publKeyMap.get("RSAModulus"));
		map.put("RSAExponent", publKeyMap.get("RSAExponent"));
	
		return TilesView.login(new String[]{ "indexFindPswdResult"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInfoController.java
	* - 작성일		: 2021. 02. 08
	* - 작성자		: 이지희
	* - 설명		: 회원 비밀번호 변경
	* </pre>
	* @param session
	* @param mbrNo
	* @param newPswd
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login/updateMemberPassword", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap updateMemberPassword(Session session, String newPswd) {
		ModelMap map = new ModelMap();
		
		PrivateKey privateKey = (PrivateKey)SessionUtil.getAttribute("_RSA_WEB_KEY_");
		if(privateKey == null) {
			return null;
		}
		newPswd = RSAUtil.decryptRas(privateKey, newPswd);
		
		//이전 비밀번호 갖고오기
		Long mbrNo = null; 
		if(SessionUtil.getAttribute("findPswdMbrNo") != null) {
			mbrNo = Long.parseLong(SessionUtil.getAttribute("findPswdMbrNo").toString());
		}else {
			MemberBaseVO vo = (MemberBaseVO)SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB);
			mbrNo = vo.getMbrNo();
		}
		List<String> pwList = this.memberService.listBeforePswd(mbrNo.toString());
		
		//이전 비밀번호와 일치하는지 체크
		boolean isMatch = false;
		for(String beforePw : pwList) {
			if (passwordEncoder.check( beforePw, newPswd)) {
				isMatch = true;
				break;
			}
		}
		//일치하는 이전 비번 있다면 
		if(isMatch) {
			map.put(FrontConstants.CONTROLLER_RESULT_CODE, "duplicated");
			return map;
		}else {
			this.memberService.updateMemberPassword(mbrNo, newPswd); 
			
			map.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS);
			return map;
		}
		
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: KKB
	* - 설명		: SNS 로그인 페이지 처리 화면
	 * </pre>
	 * 
	 * @param  request
	 * @param  chnlId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "snsLogin", method= {RequestMethod.POST, RequestMethod.GET} )
	@ResponseBody
	public Map snsLogin(HttpServletRequest request, String snsLnkCd, String deviceTpCd, String deviceToken
			, @RequestParam(value="checkCode",required=false)String checkCode ) {
		Map<String,String> map = new HashMap<String,String>();
		String goUrl = "";
		if(StringUtil.equals(snsLnkCd, FrontConstants.SNS_LNK_CD_10)) {
			goUrl = naverLoginUtil.getAuthorizationUrl(request.getSession());
		}else if(StringUtil.equals(snsLnkCd, FrontConstants.SNS_LNK_CD_20)) {
			goUrl = kakaoLoginUtil.getAuthorizationUrl(request.getSession());
		}else if(StringUtil.equals(snsLnkCd, FrontConstants.SNS_LNK_CD_30)) {
			goUrl = googleLoginUtil.getAuthorizationUrl(request.getSession());
		}else if(StringUtil.equals(snsLnkCd, FrontConstants.SNS_LNK_CD_40)){
			goUrl = appleLoginUtil.getLoginAuthorizationUrl(request.getSession());
		}
		
		if(deviceToken != null && !deviceToken.equals("")) {
			Map<String,String> deviceMap = new HashMap<String, String>();
			deviceMap.put("deviceTpCd", deviceTpCd);
			deviceMap.put("deviceToken", deviceToken);
			SessionUtil.setAttribute(FrontConstants.SESSION_SNS_TOKEN, deviceMap );
		}

		//내 정보 관리에서 연동하기 클릭 시
		if(StringUtil.isNotEmpty(checkCode)){
			SessionUtil.setAttribute(FrontWebConstants.SESSION_CHECK_CODE,checkCode);
			SessionUtil.setAttribute(FrontWebConstants.SESSION_SNS_CONNECT_MEMBER,FrontSessionUtil.getSession().getMbrNo());
		}else{
			String[] sessionKey = new String[]{FrontWebConstants.SESSION_CHECK_CODE,FrontWebConstants.SESSION_SNS_LNK_CD_KEY,FrontWebConstants.SESSION_SNS_CONNECT_MEMBER};
			for(String key : sessionKey){
				try{
					SessionUtil.removeAttribute(key);
				}catch(NullPointerException npe){
					log.error("######### Failed Session Key Sns Connect");
				}
			}
		}

		map.put("goUrl", goUrl);
		return map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 2. 4.
	* - 작성자		: 이지희
	* - 설명		: 회원 휴면/정지 변경
	* </pre>
	* @param session
	* @return
	*/
	@RequestMapping(value="login/memberUpdateState", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap memberUpdateState(MemberBasePO po, String authJson, HttpServletRequest request){
		ModelMap map = new ModelMap();
		String returnCode = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		String originStat = po.getMbrStatCd();
		if(po.getMbrNo() == null || po.getMbrNo() < 1) {
			po.setMbrNo(Long.parseLong(SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_MBR_NO).toString()));
		}
		
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(po.getMbrNo());
		
		
		//번호 중복이거나 정지인 경우 회원정보 비교  -- 지금은 이거 사용 안함.
		if((originStat.equals(FrontConstants.MBR_STAT_40) || originStat.equals(FrontConstants.MBR_STAT_70))  
				&& authJson != null && !"".equals(authJson) ) {
		
			//본인인증 값 설정
			String authJsonRpl = authJson.replaceAll("&quot;", "\"");
			
			JSONObject auth = new JSONObject(authJsonRpl);
			String mbrNm = bizService.twoWayEncrypt( auth.getString("RSLT_NAME"));
			String mobile = bizService.twoWayEncrypt(auth.getString("TEL_NO"));
			String gender = auth.getString("RSLT_SEX_CD");
			if(gender.equals("F")) {gender = "20";}
			else if(gender.equals("M")) {gender = "10";}
			String birth = bizService.twoWayEncrypt(auth.getString("RSLT_BIRTHDAY"));
			
			
			//기존회원과 같은 ci값 있는지 비교
			MemberBaseSO compareSo = new MemberBaseSO();
			compareSo.setCiCtfVal(auth.getString("CI")); 
			compareSo.setPswd("pswd"); 
			MemberBaseVO compareVo = memberService.getMemberBase(compareSo);
			if(compareVo != null && compareVo.getMbrNo() != null && compareVo.getMbrNo() > 0 && !compareVo.getMbrNo().equals(po.getMbrNo())) {
				map.put(FrontConstants.CONTROLLER_RESULT_CODE, "existMemberInfo");
				map.put("existLoginId", MaskingUtil.getId(bizService.twoWayDecrypt(compareVo.getLoginId())));
				return map;
			}
			
			
			//회원 정보 조회
			so.setPswd("pswd");
			MemberBaseVO member = memberService.getMemberBase(so);
			
			//비교해서 다르면 Fail
			if( !member.getMobile().equals(mobile)){
					//|| !member.getBirth().equals(birth) || !member.getGdGbCd().equals(gender)) { 
				
				map.put(FrontConstants.CONTROLLER_RESULT_CODE,FrontConstants.CONTROLLER_RESULT_CODE_NOT_USE);
				return map;
			}
			
			po.setCiCtfVal(auth.getString("CI"));
			po.setDiCtfVal(auth.getString("DI"));
			po.setMobileCd(auth.getString("TEL_COM_CD"));
			po.setCtfYn("Y"); 
			po.setBirth(birth);
			po.setGdGbCd(gender);
			String natinalCd  = auth.getString("RSLT_NTV_FRNR_CD");
			if(natinalCd.equals("L")) {natinalCd = "10";}
			else if(natinalCd.equals("F")) {natinalCd = "20";}
			po.setNtnGbCd(natinalCd); 
			
			//중복상태였던 경우 기존에 중복이었던  회원 중복상태로 update
			if(originStat.equals(FrontConstants.MBR_STAT_40) ) {
				memberService.checkMbrNoFromMobile(member.getMobile(), member.getMbrNo());
			}
		}
		
		
		
		//휴면인 경우
		if(originStat.equals(FrontConstants.MBR_STAT_30)) {
			po.setDormantRlsYn(FrontConstants.COMM_YN_Y);	//해제 일 때, 분기처리
			/*po = memberDormantService.selectDormantMemberBase(so); 일단 주석
			if(po.getMbrNo() == null || po.getMbrNo() < 1)  {
				map.put(FrontConstants.CONTROLLER_RESULT_CODE,FrontConstants.CONTROLLER_RESULT_CODE_FAIL);
				return map;
			}*/
		}
		
		
		po.setMbrStatCd(FrontConstants.MBR_STAT_10); 
		po.setSysUpdrNo(po.getMbrNo()); 
		//멤버상태 정상으로 update
		memberService.updateMemberBase(po);
		
		//다 처리 됐다면 휴면 db에서 정보 삭제 & 로그인처리
		if(originStat.equals(FrontConstants.MBR_STAT_30)) {
			memberDormantService.deleteDormantMemberBase(so);
			 
			 MemberBaseSO  loginSO = new MemberBaseSO();
			 loginSO.setMbrNo(po.getMbrNo());
			 loginSO.setPswd("pswd");
			 
			 MemberBaseVO loginVo= memberService.getMemberBase(loginSO);
			 loginVo.setLoginPathCd(FrontConstants.LOGIN_PATH_ABOUTPET);
			 
			 //sns연동 시 여기로 넘어온 경우 연동 시켜주기
			 SnsMemberInfoSO sns = (SnsMemberInfoSO) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_CONNECT_DORMANT);	
			 if(sns != null && !StringUtil.isEmpty(sns.getSnsLnkCd())) {
				 loginVo.setLoginPathCd(sns.getSnsLnkCd());
				 memberService.insertSnsMemberInfo(sns);
				 SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_CONNECT_DORMANT); 
			 }
			 
			 if(po.getDeviceToken() != null && !po.getDeviceToken().equals("")) {
				loginVo.setDeviceToken(po.getDeviceToken());
				loginVo.setDeviceTpCd(po.getDeviceTpCd()); 
			 }
			 frontLoginService.saveLoginSession(loginVo,null);
		}
		
		map.put(FrontConstants.CONTROLLER_RESULT_CODE,returnCode );
		
		return map;
	}
	

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: 이지희	
	 * - 설명		: 하루펫츠비 최초로그인 시 인증 화면
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="login/indexPBHRMember")
	public String indexPBHRMember(Session session, ModelMap map, ViewBase view){
		
		String method = "";
		map.put("session", session);
		map.put("view", view);
		
		if(SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB) == null) {
			return "redirect:/indexLogin";
		}
		
		try {
			MemberBaseVO sessionVo = (MemberBaseVO)SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB);
			MemberBaseVO vo = (MemberBaseVO) sessionVo.clone();
			
			if(!StringUtil.isEmpty(vo.getSnsUuid()) && !StringUtil.equals(vo.getSnsUuid(), "")) { 
				SessionUtil.setAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD, vo);
				return "redirect:/login/indexPBHRInfo";
			}
			
			if( (StringUtil.isEmpty(vo.getMobile()) || StringUtil.equals(vo.getMobile(), "")) &&
					(StringUtil.isEmpty(vo.getEmail()) || StringUtil.equals(vo.getEmail(), ""))) {
				return "redirect:/indexLogin?snsExCode=noInfoPBHR";
			}
			else if( !StringUtil.isEmpty(vo.getMobile()) && !StringUtil.equals(vo.getMobile(), "")) 
			{//핸드폰 번호가 있는 경우
				method = "phone";
				vo = sendMsgEmail(vo,method);
				map.put("member",vo );
				map.put("ctfMtd", method);
			}
			else if( !StringUtil.isEmpty(vo.getEmail()) && !StringUtil.equals(vo.getEmail(), "")) 
			{//이메일만 있는 경우
				method = "email";
				vo = sendMsgEmail(vo, method);
				map.put("member",vo );
				map.put("ctfMtd", "email");
			}
		
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		
		return TilesView.login(new String[]{ "indexPBHRMember"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 5. 24.
	* - 작성자		: 이지희
	* - 설명		: 펫츠비 최초 로그인 시  인증메세지,이메일 재전송
	* </pre>
	* @param method
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login/resendMsgEmail")
	@ResponseBody
	public ModelMap resendMsgEmail(String method) {
		ModelMap map = new ModelMap();
		try {
			MemberBaseVO sessionVo = (MemberBaseVO)SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB);
			MemberBaseVO vo = (MemberBaseVO) sessionVo.clone();
		
			vo = sendMsgEmail(vo,method);
			map.put("member",vo );
			map.put("ctfMtd", method);
			
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 5. 24.
	* - 작성자		: 이지희
	* - 설명		:펫츠비 인증 메세지 전송 공통메소드
	* </pre>
	* @param vo
	* @param method
	* @return
	* @throws Exception
	*/
	public MemberBaseVO sendMsgEmail(MemberBaseVO vo, String method) {
		if(StringUtil.equals(method, "phone")) 
		{//핸드폰 번호가 있는 경우
		
			String decryptMob = bizService.twoWayDecrypt(vo.getMobile());
			String maskingMob = MaskingUtil.getTelNo(decryptMob);
			
			vo.setMobile(maskingMob.substring(0, 3)+"-"+maskingMob.substring(3, 7)+"-"+maskingMob.substring(maskingMob.length()-4,maskingMob.length())); 
			vo.setMbrNm( vo.getMbrNm() == null ? "" :   MaskingUtil.getName(bizService.twoWayDecrypt(vo.getMbrNm())));
			vo.setEmail(vo.getEmail() == null ? "" : MaskingUtil.getEmail( bizService.twoWayDecrypt(vo.getEmail())));
			
			// SMS/LMS/MMS/KKO object
			SsgMessageSendPO msg = new SsgMessageSendPO();
			msg.setFuserid(String.valueOf(vo.getMbrNo()));
			
			String ctfNo= StringUtil.randomNumeric(6);
			String message = "【어바웃펫】본인확인 인증번호 ["+ctfNo+"]를 화면에 입력해주세요.";
			msg.setFmessage(message);
			
			msg.setFdestine(decryptMob); // 수신자 번호
			msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
			msg.setMbrNo(vo.getMbrNo());
			msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
			bizService.sendMessage(msg);
			
			SessionUtil.setAttribute(FrontConstants.MEMBER_LOGIN_CFT_CD_PHONE, ctfNo);  
		}
		else if(StringUtil.equals(method, "email") ) 
		{//이메일만 있는 경우
			
			EmailSendPO emailPO = new EmailSendPO();
			emailPO.setTmplNo((long)50); 
			emailPO.setSenderAddress("hello@aboutpet.co.kr"); 

			//수신자 정보
			List<EmailRecivePO> recipients = new ArrayList<EmailRecivePO>();
			
			EmailRecivePO revPO = new EmailRecivePO();
			String decryptEmail = bizService.twoWayDecrypt(vo.getEmail());
			revPO.setAddress(decryptEmail);
			revPO.setName(vo.getMbrNm() == null ? null :bizService.twoWayDecrypt(vo.getMbrNm())); 

			Map<String,String> paramMap =new HashMap<String, String>();
			String ctfNo =  StringUtil.randomNumeric(6);
			
			if(StringUtil.isNotEmpty(vo.getNickNm())) {
				paramMap.put("nick_nm", vo.getNickNm()+"님");
			}else {
				paramMap.put("nick_nm", "");
			}
			
			paramMap.put("ctf_email_no", ctfNo);
			paramMap.put("ctf_type","비밀번호 찾기");
			revPO.setParameters(paramMap);
			recipients.add(revPO);
			
			emailPO.setRecipients(recipients);
			bizService.sendEmail(emailPO);
			
			SessionUtil.setAttribute(FrontConstants.MEMBER_LOGIN_CFT_CD_EMAIL, ctfNo);  

			vo.setMbrNm( vo.getMbrNm() == null ? "" :   MaskingUtil.getName(bizService.twoWayDecrypt(vo.getMbrNm())));
			vo.setEmail(MaskingUtil.getEmail(decryptEmail));
		}
		
		return vo;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 15
	 * - 작성자		: 이지희
	 * - 설명		: otp 체크
	 * </pre>
	 * @param model
	 * @param otpNum
	 * @return
	 */
	@RequestMapping("/login/checkOtp")
	@ResponseBody
	public String incMemberInfo(Model model, String otpNum, String mbrNo, String method){
		
		String ctfNo = StringUtil.equals("phone", method) ? SessionUtil.getAttribute(FrontConstants.MEMBER_LOGIN_CFT_CD_PHONE).toString() : SessionUtil.getAttribute(FrontConstants.MEMBER_LOGIN_CFT_CD_EMAIL).toString();

		//SessionUtil.removeAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD); 
		
		if(ctfNo.equals(otpNum)) {
			SessionUtil.setAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD, ctfNo); 
			
			//인증 로그 저장
			Long ctfLogNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_CERTIFIED_LOG_SEQ);
			MemberCertifiedLogPO certpo = new MemberCertifiedLogPO();
			certpo.setCtfLogNo(ctfLogNo);
			certpo.setCtfMtdCd(FrontConstants.CTF_MTD_OTP);
			certpo.setCtfTpCd(FrontConstants.CTF_TP_PBHR);
			
			certpo.setCtfRstCd("B000") ;// 임시 - 본인인증 따라하기
			certpo.setMbrNo(Long.parseLong(mbrNo));  
			certpo.setSysRegrNo(Long.parseLong(mbrNo));
			
			memberService.insertCertifiedLog(certpo);
			
			return FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS; 
		}else {
			return FrontConstants.CONTROLLER_RESULT_CODE_FAIL; 
		}
		
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 15
	 * - 작성자		: 이지희
	 * - 설명		: otp 세션 제거
	 * </pre>
	 * @param model
	 * @param id
	 * @param ctfCd
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/login/removeOtpSession", method=RequestMethod.POST)
	public String removeOtpSession(Model model, String method) 
	{
		if(StringUtil.equals(method, "phone")) { SessionUtil.removeAttribute(FrontConstants.MEMBER_LOGIN_CFT_CD_PHONE);} 
		else {SessionUtil.removeAttribute(FrontConstants.MEMBER_LOGIN_CFT_CD_EMAIL) ;} 
		
		//SessionUtil.removeAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD); 
		return FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS; 
		
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: 이지희	
	 * - 설명		: 하루펫츠비 최초로그인 시 비밀번호 입력 화면
	 * </pre>
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="login/indexPBHRPswd")
	public String indexPBHRPswd(Session session, ModelMap map, ViewBase view){
		
		MemberBaseVO vo = (MemberBaseVO)SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB);
		map.put("session", session);
		map.put("view", view);

		//그전 페이지에서 인증후 저장한 세션값 갖고오기
		Object sessionVal = SessionUtil.getAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD);
		if(sessionVal == null) {
			//세션 없으면 로그인 페이지로 
			return  TilesView.redirect(new String[]{"indexLogin"});
		}
		

		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(vo.getMbrNo());
		so.setPswd("pswd"); 
		MemberBaseVO mem= this.memberService.getMemberBase(so);
		SessionUtil.setAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD, mem);
		
		/*if(!StringUtil.isEmpty(vo.getSnsLnkCd()) && !StringUtil.equals(vo.getSnsLnkCd(),"")) {
			return indexPBHRInfo(map, view, session);
		}*/
		MemberBaseVO returnMem = new MemberBaseVO();
		returnMem.setLoginId(bizService.twoWayDecrypt(mem.getLoginId())); 
		returnMem.setMobile(bizService.twoWayDecrypt(mem.getMobile()));
		returnMem.setBirth(mem.getBirth() == null ? null : bizService.twoWayDecrypt(mem.getBirth()));
		returnMem.setMbrNo(mem.getMbrNo());
		
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		map.put("RSAModulus", publKeyMap.get("RSAModulus"));
		map.put("RSAExponent", publKeyMap.get("RSAExponent"));
		
		map.put("member",returnMem ); 
		
		return TilesView.login(new String[]{ "indexPBHRPswd"});
	}
		
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 2. 16.
	* - 작성자		: 이지희
	* - 설명		: 하루펫츠비 최초로그인 시 회원정보입력 화면
	* </pre>
	* @param map
	* @param view
	* @param mbrNo
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="login/indexPBHRInfo")
	public String indexPBHRInfo(ModelMap map, ViewBase view, Session session){
		//그전 페이지에서 인증후 저장한 세션값 갖고오기
		MemberBaseVO vo = (MemberBaseVO)SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB);
		MemberBaseVO sessionVal = (MemberBaseVO) SessionUtil.getAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD);
		if(sessionVal == null || Long.compare(sessionVal.getMbrNo() ,vo.getMbrNo()) != 0) {
			//세션 없거나 값 다르면 로그인 페이지로 
			return  TilesView.redirect(new String[]{"indexLogin"});
		}
		
		//sessionVal.setBirth(bizService.twoWayDecrypt(sessionVal.getBirth()));  
		//sessionVal.setMbrNm(bizService.twoWayDecrypt(sessionVal.getMbrNm()));  
		sessionVal.setEmail(bizService.twoWayDecrypt(sessionVal.getEmail()));  
		map.put("member", sessionVal);
		map.put("view", view);
		map.put("session", session);
		return TilesView.login(new String[]{ "indexPBHRInfo"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 02. 16
	 * - 작성자		: 이지희
	 * - 설명		:  하루펫츠비 최초로그인 시 회원정보입력
	 * </pre>
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/login/insertPBHRInfo", method=RequestMethod.POST)
	public ModelMap insertPBHRInfo(MemberBasePO po, HttpServletRequest request, String orgNickNm) 
	{
		po.setNickNm(po.getNickNm().replaceAll(" ", ""));  
		ModelMap map = new ModelMap();
		po.setUpdrIp(RequestUtil.getClientIp());
		
		if(orgNickNm != null && !orgNickNm.equals("") && (po.getNickNm() == null || po.getNickNm().equals(""))) {
			po.setNickNm(orgNickNm); 
		}
		
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setMbrNo(po.getMbrNo());
		//if((po.getNickNm() != null && !po.getNickNm().equals("") )) {
		//금지어체크
		TagBaseSO tagso = new TagBaseSO();
		List<TagBaseVO> taglist = tagService.unmatchedGrid(tagso);
		for(TagBaseVO banTag : taglist) {
			if(po.getNickNm().indexOf(banTag.getTagNm()) > -1) {
				map.put("returnCode", "banWord");
				return map;
			}
		}
		
		//닉네임 중복체크
		mbso.setStId( 1L);
		mbso.setNickNm(po.getNickNm());
		
		boolean nickNmDuplMap = memberService.getMemberLoginDuplicate(mbso);
		if(nickNmDuplMap) {
			map.put("returnCode", "duplicatedNickNm");
			return map;
		}
		//}

		//이메일 중복체크
		po.setEmail(po.getEmail() != null?  bizService.twoWayEncrypt(po.getEmail()):null);
		mbso.setNickNm(null); 
		mbso.setEmail(po.getEmail());
		boolean result = memberService.getMemberLoginDuplicate(mbso);

		if(result) {
			map.put("returnCode", "duplicatedEmail");
			return map;
		}
		
		//기본 정보 세팅
		po.setMbrGbCd(CommonConstants.MBR_GB_CD_20);
		po.setMbrStatCd(CommonConstants.MBR_STAT_10);
		po.setInfoRcvYn("Y");
		po.setSysRegrNo(po.getMbrNo());
		po.setSysUpdrNo(po.getMbrNo());
		
		//가입 환경 설정 -모바일웹,pc웹,안드앱,ios앱
		if(po.getJoinEnvCd() != null && po.getJoinEnvCd().equals("MO")) {
			po.setJoinEnvCd(CommonConstants.JOIN_ENV_WEB_MOB);
		}else if(po.getJoinEnvCd() != null && po.getJoinEnvCd().equals("PC")){
			po.setJoinEnvCd(CommonConstants.JOIN_ENV_WEB_PC);
		}else if(po.getJoinEnvCd() != null && po.getJoinEnvCd().equals("APP")){
			if(po.getDeviceTpCd() != null && po.getDeviceTpCd().equals("10")) {
				po.setJoinEnvCd(CommonConstants.JOIN_ENV_APP_ANDROID);
			}else if(po.getDeviceTpCd() != null && po.getDeviceTpCd().equals("20")) {
				po.setJoinEnvCd(CommonConstants.JOIN_ENV_APP_IOS);
			}
		}
		//회원 정보 저장
		memberService.updateMemberBase(po);
		
		SessionUtil.removeAttribute(FrontConstants.SESSION_HRPB_UPDATE_PSWD);
		
		// 회원등급이력 등록
		int rslt = this.memberService.insertMemberGrade(po);
		if(rslt != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		//로그인 처리
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(po.getMbrNo()); 
		MemberBaseVO loginVo = memberService.getMemberBase(so);
		loginVo.setLoginPathCd(FrontConstants.LOGIN_PATH_ABOUTPET);
		
		if(SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB) != null) {
			MemberBaseVO vo = (MemberBaseVO)SessionUtil.getAttribute(FrontConstants.SESSION_UPDATE_HRPB);
			if(!StringUtil.isEmpty(vo.getSnsLnkCd()) && !StringUtil.equals(vo.getSnsLnkCd(), "")) {
				loginVo.setLoginPathCd(vo.getSnsLnkCd());
			}
		}
		
		if(po.getDeviceToken() != null && !po.getDeviceToken().equals("")) {
			loginVo.setDeviceToken(po.getDeviceToken());
			loginVo.setDeviceTpCd(po.getDeviceTpCd()); 
		}
		frontLoginService.saveLoginSession(loginVo, null);
		
		SessionUtil.removeAttribute(FrontConstants.SESSION_UPDATE_HRPB);
				
		map.put("returnCode", CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS);
		String loginPath = loginVo.getLoginPathCd();
		map.put("loginPathCd" ,StringUtil.equals(loginPath, "10") ? "NAVER": StringUtil.equals(loginPath, "20") ? "KAKAO" : StringUtil.equals(loginPath, "30") ? "GOOGLE" : StringUtil.equals(loginPath, "40") ? "APPLE" : "ABOUTPET");
		return map; 
		
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 03. 02
	 * - 작성자		: 이지희
	 * - 설명		:  어플 설정 화면
	 * </pre>
	 * @param model
	 * @return
	 */	
	@RequestMapping(value="indexLoginSettings")
	public String indexLoginSettings(ModelMap map, Session session, ViewBase view, String returnUrl){
		map.put("session", session);
		map.put("view", view);
		map.put("returnUrl", returnUrl);
		return  TilesView.login(new String[]{"indexLoginSettings"});
	}
	
	@RequestMapping(value="indexSettingTerms")
	public String indexSettingTerms(ModelMap map, Session session, ViewBase view){
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		
		List<TermsVO> termsList = new ArrayList<>();
		
		String osType = "";
		if(view.getOs().equals(CommonConstants.DEVICE_TYPE))  {osType =  CommonConstants.POC_WEB;}
		else {osType=view.getOs();}

		TermsSO so = new TermsSO();
		so.setPocGbCd(osType);
		
		List<TermsVO> allTerms = this.termsService.listTermsForMemberJoin(so);
		termsList = allTerms;
		List<TermsVO> noReqTermsList = new ArrayList<TermsVO>();
	    
	    for(TermsVO vo : termsList) {
	    	if(StringUtil.equals(vo.getRqidYn() , CommonConstants.COMM_YN_N)) {
	    		noReqTermsList.add(vo);
	    	}
	    	
	    }
	    
	    map.put("noReqTermsList", noReqTermsList);
		
		map.put("session", session);
		map.put("view", view);
		map.put("terms", termsList);
		
		return  TilesView.login(new String[]{"indexSettingTerms"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 3. 05.
	* - 작성자		: 이지희
	* - 설명		: 관심태그 변경 시 검색엔진api에 로그 등록
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value="commonTagAction")
	public String indexTagAction(ModelMap map, Session session, ViewBase view , String url, String targetUrl)  throws Exception {

		Map<String,String> paramMap = new HashMap<String, String>();
		paramMap.put("URL", url);
		paramMap.put("TARGET_URL", targetUrl);
		paramMap.put("MBR_NO", session.getMbrNo().toString());
		
		String result = "";
		
		paramMap.put("CONTENT_ID", "");
		result = frontLoginService.setTagAction(paramMap);
		
		return result;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 03. 26
	 * - 작성자		: 이지희
	 * - 설명		:  어플에서 자동로그인 처리를 위한 화면 => sns 로그인 시  후처리를 위한 화면
	 * </pre>
	 * @param model
	 * @return
	 */	
	@RequestMapping("appLoginProcess")
	public String appLoginProcess(ModelMap map ,ViewBase view, String returnUrl, String loginPathCd) {
		
		map.put("view", view);
		map.put("returnUrl", returnUrl);
		if(!StringUtil.isEmpty(loginPathCd)) {
			map.put("loginPathCd", StringUtil.equals(loginPathCd,"10") ? "NAVER": StringUtil.equals(loginPathCd,"20") ? "KAKAO": StringUtil.equals(loginPathCd,"30") ? "GOOGLE" : "APPLE" );
		}
		return  TilesView.login(new String[]{"appLoginProcess"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 3. 30.
	* - 작성자		: 이지희
	* - 설명		: APP 자동로그인 시 이력 등록
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="insertLoginInfoInApp")
	@ResponseBody
	public String insertLoginInfoInApp(ModelMap map, Session session, ViewBase view ,String deviceToken, String deviceType , HttpServletRequest request)  throws Exception {

		if(session.getMbrNo() != null && session.getMbrNo() > 0) {
			session.setLoginPathCd(session.getLoginPathCd()); 
			String ret = memberService.updateMemberSession(session, deviceToken, deviceType);
			//String ret2 =  URLEncoder.encode(ret, java.nio.charset.StandardCharsets.UTF_8.toString() );
			return ret;
		}
		
		return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
	}
	

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 4. 16.
	 * - 작성자		: 이지희
	 * - 설명		: APP 최초 설치 시 메인페이지 설정
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="setMainPathInApp")
	@ResponseBody
	public String setMainPathInApp(ModelMap map, Session session, ViewBase view )  throws Exception {
		
		if(session.getMbrNo() != null && session.getMbrNo() > 0) {
			
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(session.getMbrNo()); 
			MemberBaseVO vo = memberService.getMemberBase(so);
			String returnVal = "SHOP"; //메인화면 설정 기본값 변경 TV->SHOP
			if(vo.getJoinPathCd().equals(FrontConstants.JOIN_PATH_20)) returnVal = "SHOP";
			return returnVal;
		}else {
			return "F";
		}
		
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2021. 4. 16.
	 * - 작성자		: 이지희
	 * - 설명		: 로그인세션 업데이트
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateMemberSession")
	@ResponseBody
	public String updateMemberSession(Session session, ViewBase view )  throws Exception {
		
		if(session.getMbrNo() != null && session.getMbrNo() > 0) {
			return memberService.updateMemberSession(session ,null , null);
		}
		return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
	}
	
	
	
	
	
	/** 임시 로직 */
	@RequestMapping(value = "testLogin")
	public String testLogin(HttpServletRequest request, ModelMap map, ViewBase view, String loginId) {
		MemberBaseSO po = new MemberBaseSO();
		po.setLoginId(bizService.twoWayEncrypt(loginId));
		po.setStId(view.getStId());
		
		MemberBaseVO member = this.memberService.getMemberBase(po);
		if(member == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		frontLoginService.saveLoginSession(member,null);
		
		return "redirect:/";
	}
	
	
	
	
	
	
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2021. 02. 24.
	* - 작성자		: 이지희
	* - 설명		: sns계정 연동 해제된 정보 다시 연동 
	 * </pre>
	 * 
	 * @param  request
	 * @param  chnlId
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping(value="login/reconnectSns", method=RequestMethod.POST)
	@ResponseBody
	public String reconnectSns(String snsUuid, String deviceToken, String deviceTpcd) {
		log.debug("reconnectSnsToken : "+deviceToken); 
		
		//계정 연동 해제된 sns 정보 다시 계정 연동 상태로 update
		SnsMemberInfoPO po = new SnsMemberInfoPO();
		po.setSnsUuid(snsUuid); 
		po.setSnsStatCd(FrontConstants.SNS_STAT_10); 
		memberService.updateSnsMemberInfo(po);
		
		//로그인 처리
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(po.getMbrNo());
		so.setPswd("pswd"); //로그인 시 갖고올 정보 갖고오려구
		MemberBaseVO vo = memberService.getMemberBase(so);
		vo.setLoginPathCd(po.getSnsLnkCd());
		
		if(deviceToken != null && !deviceToken.equals("")) {
			vo.setDeviceToken(deviceToken);
			vo.setDeviceTpCd(deviceTpcd); 
		}
		log.debug("reconnectSnsSaveLogin : {}",vo); 
		frontLoginService.saveLoginSession(vo,null); 
		
		return FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
	}*/
	
	
/*	*//** 임시 로직 *//*
	@RequestMapping(value = "migPetsbe")
	public String migPetsbe(HttpServletRequest request, ModelMap map, ViewBase view) {
		
		List<MemberBaseVO> list = memberService.selectPetsbeMig();
		
		for(MemberBaseVO vo : list) {
			vo.setLoginId(bizService.twoWayEncrypt(vo.getLoginId()));
			vo.setMbrNm(bizService.twoWayEncrypt(vo.getMbrNm()));
			vo.setNickNm(bizService.twoWayEncrypt(vo.getNickNm()));
			vo.setBirth(bizService.twoWayEncrypt(vo.getBirth()));
			vo.setTel(bizService.twoWayEncrypt(vo.getTel()));
			vo.setMobile(bizService.twoWayEncrypt(vo.getMobile()));
			vo.setEmail(bizService.twoWayEncrypt(vo.getEmail())); 
		}
		memberService.updatePetsbeMig(list); 
		
		
		return "redirect:/indexLogin";
	}
	
	
	@RequestMapping(value = "migPetsbe2")
	public String migPetsbe2(HttpServletRequest request, ModelMap map, ViewBase view) {
		
		List<MemberBaseVO> list = memberService.selectPetsbeMig();
		
		for(MemberBaseVO vo : list) {
			vo.setLoginId(bizService.twoWayDecrypt(vo.getLoginId()));
			vo.setMbrNm(bizService.twoWayDecrypt(vo.getMbrNm()));
			vo.setNickNm(bizService.twoWayDecrypt(vo.getNickNm()));
			vo.setBirth(bizService.twoWayDecrypt(vo.getBirth()));
			vo.setTel(bizService.twoWayDecrypt(vo.getTel()));
			vo.setMobile(bizService.twoWayDecrypt(vo.getMobile()));
			vo.setEmail(bizService.twoWayDecrypt(vo.getEmail())); 
			log.debug("!! {}",vo);
		}
		
		return "redirect:/indexLogin";
	}
	*/
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 8. 8.
	* - 작성자		: snw
	* - 설명		: 휴면계정안내
	* </pre>
	* @param session
	* @param map
	* @param view
	* @return
	*/
/*	@RequestMapping(value="indexNotUsingAccount")
	public String indexNotUsingAccount(Session session, ModelMap map, ViewBase view){
		view.setNavigation(NAVIGATION_NOT_USING);
		
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.login(new String[]{"login", "indexNotUsingAccount"});
	}
	
	*//**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 8. 8.
	* - 작성자		: snw
	* - 설명		: 회원 휴면계정 해지
	* </pre>
	* @param certify
	* @param session
	* @return
	*//*
	@RequestMapping(value="saveMemberUse", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap saveMemberUse(NiceCertifyVO certify, Session session){
		String resultCode = null;
		String resultMsg = null;
		
		NiceCertifyDataVO data = null;
		
		log.debug(">>>>>>>>>>>>>>certify="+certify.toString());
//		if("10".equals(certify.getAuthType())){
//			data = niceIpinService.getCertifyData(certify.getEncData(), certify.getParamR1(), certify.getParamR2(), certify.getParamR3(), session.getSessionId());
//		}else{
//			data = niceCheckPlusService.getCertifyData(certify.getEncData(), certify.getParamR1(), certify.getParamR2(), certify.getParamR3(), session.getSessionId());
//		}
		 
		// 인증데이터 복호화 성공
		if(data.isRtnCode()){
			//아래 쿼리 쓰려면 쿼리 수정해야 함!!! 210201-==================================
			Long mbrNo = this.memberService.getMbrNo(data.getDupInfo());

			if(mbrNo == null){
				throw new CustomException(ExceptionConstants.ERROR_REQUEST);
			}
			
			this.memberService.saveMemberUse(mbrNo);
			
			resultCode = "S";
			resultMsg = "휴면계정이 해지 되었습니다. 재로그인 하시기 바랍니다.";
			//httpSession.removeAttribute(FrontWebConstants.SESSION_MEMBER_MBR_NO);
		// 인증데이터 복호화 오류
		}else{
			resultCode = "D";
			resultMsg = data.getRtnMsg();
		}
		
		ModelMap map = new ModelMap();
		
		map.put(FrontWebConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.put(FrontWebConstants.CONTROLLER_RESULT_MSG, resultMsg);
		
		return  map;
	}		
	*/
	

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 3. 2. 
	* - 작성자		: snw
	* - 설명		: 로그인 페이지 팝업 화면
	* </pre>
	* @param login_cd
	* @param map
	* @param view
	* @param param
	* @return
	* @throws Exception
	*/
/*	@RequestMapping(value="popupLogin")
	public String popupLogin(ModelMap map, ViewBase view, LoginParam param){

		map.put("view", view);
		map.put("param", param);
		
		return TilesView.none(
				new String[]{"login", "popupLogin"}
				);
	}
	*//**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: LoginController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 아이디/비밀번호찾기 팝업 화면
	* </pre>
	* @param login_cd
	* @param map
	* @param view
	* @param param
	* @return
	* @throws Exception
	*//*
	@RequestMapping(value="popupFindInfo")
	public String popupFindInfo(ModelMap map, ViewBase view, LoginParam param){

		view.setTitle(message.getMessage("front.web.view.login.find.info.popup.title"));
		map.put("view", view);
		map.put("param", param);
		
		return TilesView.popup(
				new String[] {"login", "popupFindInfo"}
				);
	}	*/
	
	@ResponseBody
	@RequestMapping(value="updateInfoRcvYn")
	public String updateInfoRcvYn(ModelMap map, MemberBasePO po) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		
		int result = frontLoginService.updateInfoRcvYn(po);
		if(result != 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
	
	@LoginCheck
	@RequestMapping(value="indexMyInfo")
	public String indexMyInfo(ModelMap map, ViewBase view, Session session, String returnUrl) {
		map.put("view", view);
		map.put("session", session);
		map.put("returnUrl", returnUrl);
		
		return TilesView.login(new String[]{"indexMyInfo"});		
	}
	
	@RequestMapping(value="EncryptTest")
	public String EncryptTest(String value) {
		
		log.debug("#@#@@# : "+bizService.twoWayDecrypt(value));
		log.debug("#@#@@#2 : "+bizService.twoWayEncrypt(value));
		
		return "";
	}
}