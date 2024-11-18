package admin.web.view.login.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import admin.web.config.view.View;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.login.service.AdminLoginService;
import biz.app.system.model.UserAgreeInfoPO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.service.AuthService;
import biz.app.system.service.UserService;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import framework.common.util.security.PBKDF2PasswordEncoder;
import lombok.extern.slf4j.Slf4j;

/**
 * 로그인 Controller
 * @author	valueFactory
 * @since	2016.02.25
 */
/**
 * 네이밍 룰
 * View 화면
 * Grid 그리드
 * Tree 트리
 * Ajax Ajax
 * Insert 입력
 * Update 수정
 * Delete 삭제
 * Save 입력 / 수정
 */
@Slf4j
@Controller
public class LoginController {
	
	protected final Logger logger = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 관리자 로그인 서비스
	 */
	@Autowired
	private AdminLoginService adminLoginService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private BizService bizService;

	/**
	 * 권한 서비스
	 */
	@Autowired
	private AuthService authService;

	/**
	 * 통합 메시지
	 */
	@Autowired
	private MessageSourceAccessor message;
	
	@Autowired 
	private PBKDF2PasswordEncoder passwordEncoder;
	
	@Autowired
	private PushService pushService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 로그인 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/login/loginView.do")
	public String loginView(Model model, HttpServletRequest request) {
		
		/*WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		model.addAttribute("env",envGb);*/
		
		if(AdminSessionUtil.isAdminSession()){
			String returnUrl = AdminConstants.MAIN_URL;
			return View.redirect(returnUrl);
		} else {
			String duplicateFlag=  Optional.ofNullable(SessionUtil.getSessionAttribute(AdminConstants.DUPLICATED_LOGOUT)).orElseGet(()->"").toString();
			if(SessionUtil.getAttribute(AdminConstants.SESSION_TIME_OUT)!=null 
					&&SessionUtil.getAttribute(AdminConstants.SESSION_TIME_OUT).toString().equals("true")) {
				model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG , message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_LOGIN_NOT_USED));
			}
			else if(!StringUtil.isEmpty(duplicateFlag)) {
				model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG , message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_LOGIN_DUPLICATE));
				SessionUtil.removeSessionAttribute(AdminConstants.DUPLICATED_LOGOUT);
			}

			// PO 배포시
			// return /login/poLoginView;
			
			// BO 배포시 
			return "/login/loginView";
		}
	}
	
	@RequestMapping("/login/loginOtpCertifyPop.do")
	public String incMemberInfo(Model model){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		model.addAttribute("env",envGb);
		
		//if(!envGb.equals(CommonConstants.ENVIRONMENT_GB_OPER))  model.addAttribute("otpNum",otpNum); //임시로 해놓은 것 
		return "/login/include/otpCertifyPop";
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2020. 12. 15
	 * - 작성자		: 이지희
	 * - 설명		: 로그인정보 확인 & 문자전송 / 비밀번호 변경 시 otp 문자 전송
	 * </pre>
	 * 
	 * @param  model
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value = "/login/getUser.do", method = RequestMethod.POST)
	public String getUser(Model model,  @RequestParam("loginId") String loginId, @RequestParam(value="password",required=false) String password) 
	{
		
		loginId = loginId.replaceAll(" ", ""); 
		if(password != null ) password = password.replaceAll(" ", "");
		
		UserBaseSO so = new UserBaseSO();
		so.setLoginId(loginId);
		if(!StringUtil.isEmpty(password)) so.setPswd(password);  
		
		//계정 정보 조회 - 유효성체크도 같이
		Map<String, Object> result = adminLoginService.getUserWithCheck(so);
		
		String exCode = result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
		String resultMsg = null;
		
		if(StringUtil.isNotBlank(exCode)) { //유효성체크 실패
			resultMsg = message.getMessage("business.exception." + exCode);
			return exCode + "|" +resultMsg;
		} 
		else 
		{
			UserBaseVO vo = (UserBaseVO) result.get("user");
			
			if(vo != null && StringUtil.isNotEmpty(vo.getMobile())) {
				
				// 인증값 session 저장
				String ctf_no = StringUtil.randomNumeric(6);
				SessionUtil.setAttribute(AdminConstants.USER_LOGIN_CFT_CD, ctf_no);
				
				// 문자 발송
				// SMS/LMS/MMS/KKO object
				SsgMessageSendPO msg = new SsgMessageSendPO();
				
				// 1. SMS / LMS
				msg.setFuserid(String.valueOf(vo.getUsrNo())); 

				String templatekey = "K_A_etc_0001"; //BO본인인증
				
				PushSO pso = new PushSO();
				pso.setTmplCd(templatekey);
				
				PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
				String message = "";
				if(StringUtil.isNotEmpty(pvo)) {
					if(pvo.getContents().indexOf("${") == 0) {
						message = StringUtil.replaceAll(pvo.getContents(), "ctf_no", ctf_no);
					} else {
						message = StringUtil.replaceAll(pvo.getContents(), "${ctf_no}", ctf_no);
					}
				}
				
				
				msg.setFmessage(message);// 템플릿 내용 replace(데이터 바인딩)
				msg.setFtemplatekey(templatekey);
				msg.setFdestine(vo.getMobile()); // 수신자 번호--임시
				//msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
				msg.setSndTypeCd(CommonConstants.SND_TYPE_30); // KKO
				msg.setMbrNo(vo.getUsrNo());
				msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
				int msgresult = bizService.sendMessage(msg);
				
				if(msgresult > 0) {
					model.addAttribute("exCode", AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS);
					//model.addAttribute("ctfCd", ctfCd); //임시로 같이 보내기
				}
				return AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS+"|" ; //임시로 같이 보내기
				
			}
			else {
				return ExceptionConstants.ERROR_CODE_LOGIN_ID_FAIL + "|" + message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_LOGIN_ID_FAIL);
			}
		}
		
	}

	

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 로그인
	 * </pre>
	 * @param model
	 * @param id
	 * @param pwd
	 * @return
	 */
	@RequestMapping(value="/login/login.do", method=RequestMethod.POST)
	public String login(Model model	, @RequestParam("loginId") String id, @RequestParam("password") String pwd,  String ctfCd) {

		id = id.replaceAll(" ", ""); 
		pwd = pwd.replaceAll(" ", "");  
		
		log.debug("************************************["+userService.getDemoPasswd(pwd)+"]**");
		
		String sessionCtfCd = (String) SessionUtil.getAttribute(AdminConstants.USER_LOGIN_CFT_CD);
		
		log.debug("ctfSessionCd : "+sessionCtfCd); 
		String resultCode = null;
		String resultMsg = null;
		String returnUrl = null;
		
		if(sessionCtfCd != null && !sessionCtfCd.equals("") ) 
		{
			if(!sessionCtfCd.equals(ctfCd)) 
			{ // 인증번호 틀린경우
				resultCode =  AdminConstants.USER_WRONG_CFT;
			}
			else 
			{ //인증번호 맞은경우
				Map<String, Object> result =adminLoginService.getLoginCheck(id, pwd);
				
				String exCode = result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
				if(exCode != null && exCode.equals( ExceptionConstants.ERROR_CODE_PSWD_HIST_FAIL)) { 
					// 비밀번호 변경 90일지난경우 
					resultCode = AdminConstants.CONTROLLER_RESULT_CODE_LEAVE;
					resultMsg = message.getMessage("business.exception." + exCode);
				} 
				else if(exCode != null && exCode.equals(AdminConstants.PO_USER_FIRST_LOGIN)) {
					// po 사용자 최초 로그인
					resultCode = exCode;
				}
				else if(exCode != null) { // 쿼리 에러
					resultCode = AdminConstants.CONTROLLER_RESULT_CODE_FAIL;
					resultMsg = message.getMessage("business.exception." + exCode);
				}
				else {
					resultCode = AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS;
					returnUrl = AdminConstants.MAIN_URL;
				}
			}
		}
		else 
		{ // 저장된 인증번호가 없는 경우
			resultCode = AdminConstants.CONTROLLER_RESULT_CODE_FAIL;
		}
		
		model.addAttribute(AdminConstants.CONTROLLER_RESULT_CODE, resultCode);
		model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG, resultMsg);
		model.addAttribute("returnUrl", returnUrl);
		
		return View.jsonView();
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 로그아웃
	 * </pre>
	 * @param request
	 * @return
	 */
	@RequestMapping("/login/logout.do")
	public String logout(HttpServletRequest request) {

		HttpSession session = request.getSession(false);

		if(session != null){
			session.invalidate();
		}

		return View.redirect("/login/loginView.do");
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 세션 종료
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/login/noSessionView.do")
	public String noSessionView(Model model) {
		log.debug("================================");
		log.debug("Start : " + "로그인 페이지 시작");
		log.debug("================================");
		
		if(SessionUtil.getAttribute(AdminConstants.SESSION_TIME_OUT)!=null 
				&& SessionUtil.getAttribute(AdminConstants.SESSION_TIME_OUT).toString().equals("true")) 
		{ //사용한지 30분 넘은 경우
			SessionUtil.removeSessionAttribute(AdminConstants.SESSION_TIME_OUT);
			model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG , message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_LOGIN_NOT_USED));
		}
		else if(SessionUtil.getAttribute(AdminConstants.DUPLICATED_LOGOUT)!=null) 
		{//중복로그인 된 경우
			SessionUtil.removeSessionAttribute(AdminConstants.DUPLICATED_LOGOUT);
			model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG , message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_LOGIN_DUPLICATE));
		}
		else 
		{
			model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG , message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_LOGIN_SESSION));
		}
		
		return "/login/noSessionView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2020. 12. 23.
	 * - 작성자		: 이지희
	 * - 설명		: 비밀번호 변경 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/login/pswdChangeView.do")
	public String passwordChangeViewPop(Model model, String loginId) {
		model.addAttribute("loginId" , loginId);
		return "/login/pswdChangeView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2020. 12. 23.
	 * - 작성자		: 이지희
	 * - 설명		: otp 번호 체크
	 * </pre>
	 * @param model
	 * @param id
	 * @param ctfCd
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/login/checkOtp.do", method=RequestMethod.POST)
	public Map<String,Object> checkOtp(Model model, @RequestParam("loginId") String id,  String ctfCd) 
	{
		Map<String,Object> map = new HashMap<String, Object>();
		String resultCode = AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		String sessionCtfCd = (String) SessionUtil.getAttribute(AdminConstants.USER_LOGIN_CFT_CD);
		
		if(sessionCtfCd != null && !sessionCtfCd.equals("") ) 
		{
			if(!sessionCtfCd.equals(ctfCd)) {
				resultCode =  AdminConstants.USER_WRONG_CFT;
			}else {
				SessionUtil.setAttribute("loginId", id);
				
				//비밀번호- 개인정보 포함인지 체크하려고 
				UserBaseSO so = new UserBaseSO();
				so.setLoginId(id); 
				UserBaseVO vo = adminLoginService.getUser(so);
				map.put("user", vo);
				
			}
		}
		map.put(AdminConstants.CONTROLLER_RESULT_CODE, resultCode);
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2020. 12. 31
	 * - 작성자		: 이지희
	 * - 설명		: otp 세션 제거
	 * </pre>
	 * @param model
	 * @param id
	 * @param ctfCd
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/login/removeOtpSession.do", method=RequestMethod.POST)
	public String removeOtpSession(Model model) 
	{
		SessionUtil.removeAttribute(AdminConstants.USER_LOGIN_CFT_CD); 
		//log.debug("@@@ :"+SessionUtil.getAttribute(AdminConstants.USER_LOGIN_CFT_CD)); 
		return AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS; 
		
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: LoginController.java
	 * - 작성일		: 2020. 12. 24.
	 * - 작성자		: 이지희
	 * - 설명		: 사용자 비밀번호 변경
	 * </pre>
	 * @param UserBasePO po
	 * @return map
	 */
	@ResponseBody
	@RequestMapping(value="/login/updateUserPw.do")
	public Map<String,Object>  updateUserPw(UserBasePO po, HttpServletRequest request) { 
		Map<String,Object> map = new HashMap<>();
		
		po.setSysUpdrNo(po.getUsrNo()); 
		
 		
 		//최근 3개의 비번 이력과 같으면 오류!
		UserBaseSO so = new UserBaseSO();
		so.setUsrNo(po.getUsrNo()); 
		List<String> pwdHist = userService.selectPswdHist(so); 
		
		for(String prePwd : pwdHist) {
			if(passwordEncoder.check(prePwd, po.getPswd())) {
				map.put(AdminConstants.CONTROLLER_RESULT_CODE,AdminConstants.USER_PSWD_EQUAL);
				return map;
			}
		}

		if(AdminSessionUtil.isAdminSession()) {
			AdminSessionUtil.removeSession();
			HttpSession session = request.getSession(false);
			if(session != null){
				session.invalidate();
			}
		}
		
		String encryptPswd = passwordEncoder.encode(po.getPswd());
 		po.setPswd(encryptPswd);
 		int result = userService.updateNewPswd(po);
 		if(result > 1) { 
 			map.put(AdminConstants.CONTROLLER_RESULT_CODE, AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS); 
 		}else {
 			map.put(AdminConstants.CONTROLLER_RESULT_CODE, AdminConstants.USER_WRONG_CFT);
 		}
 		return map;
	}
	
	
	
	
	/*	@RequestMapping(value="/login/checkPrePassword.do")
	public String checkPrePassword(Model model, UserBaseSO so) {
		boolean isEqualPrePswd = false;
		UserBaseVO vo = adminLoginService.getUser(so);
		
		if(vo != null) {
			//이전 패스워드 일치 여부
			if(passwordEncoder.check(vo.getPswd(), so.getPswd())) {
				isEqualPrePswd = true;
			}
		}
		
		model.addAttribute("isEqualPrePswd", isEqualPrePswd);
		return View.jsonView();
	}
	
	@RequestMapping(value="/login/changePw.do")
	public String changePw(UserBasePO po) {
		
		UserBaseSO so = new UserBaseSO();
		so.setLoginId(po.getLoginId());
		UserBaseVO vo = adminLoginService.getUser(so);
		
		if(vo != null) {
			//이전 비밀번호 비교
			if (!passwordEncoder.check(vo.getPswd(), po.getPrePswd())) {
				throw new CustomException(ExceptionConstants.ERROR_REQUEST);
			}
			
			po.setUsrNo(vo.getUsrNo());
			
			userService.updatePassword(po);
		}else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return View.jsonView();
	}*/

	
	@RequestMapping("/login/loginTermsPop.do")
	public String loginTermsPop(Model model){
		return "/login/include/loginTermsPop";
	}
	
	@RequestMapping("/login/insertUserAgreeInfo.do")
	public String insertUserAgreeInfo(Model model, UserBaseSO userSO, UserAgreeInfoPO po) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		
		int result = adminLoginService.insertUserAgreeInfo(userSO, po);
		if(result != 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		model.addAttribute("resultCode", resultCode);
		
		return View.jsonView();
	}
}