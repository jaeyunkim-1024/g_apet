package front.web.config.aspect;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import biz.app.member.service.MemberService;
import framework.admin.constants.AdminConstants;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.config.aspect
* - 파일명		: LoginCheckAspect.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명			:
* </pre>
*/
@Component
@Aspect
@Slf4j
public class LoginCheckAspect {

	@Autowired HttpServletRequest request;
	@Autowired HttpServletResponse response;
	@Autowired HttpSession httpSession;
	@Autowired MemberService memberService;
	
	@Pointcut("@annotation(loginCheck)")
	private void loginCheckTarget(LoginCheck loginCheck) {
		log.info("loginCheckTarget");
	}

	@Before("loginCheckTarget(loginCheck)")
	public void beforeLogging(JoinPoint joinPoint, LoginCheck loginCheck) {
		log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Login Check !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

		Session session = FrontSessionUtil.getSession();
	    boolean check = true;
		
	    String noMemOrderYn = (String)this.request.getParameter("noMemOrderYn");
	    String returnUrl = (String)this.request.getParameter("returnUrl");
	    
	    
	    //로그인 정보 세션 업데이트 210422
	    if(session != null && session.getMbrNo() != null && Long.compare(session.getMbrNo(), CommonConstants.NO_MEMBER_NO) != 0) {
	    	try {
		    	String returnSessionVal = memberService.updateMemberSession(session, null, null);
		    	if(returnSessionVal != "S"){
					
					if("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
						response.setStatus(AdminConstants.AJAX_LOGIN_SESSION_ERROR);
						return;
					} else {
							response.sendRedirect(returnSessionVal);
						return;
					}
				}
	    	} catch (IOException e) {
				e.printStackTrace();
			}
	    }
	    
	    
	    /*
	     * 주문시 비회원 주문일 경우 로그인 체크 패스
	     */
		if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginCheck.loginType()) && FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo()) && CommonConstants.COMM_YN_Y.equals(noMemOrderYn)){
				check = false;
		}

		/*
		 * 주문 조회 시 비회원의 세션이 존재하면 패스
		 */
		if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginCheck.loginType()) && loginCheck.noMemCheck() && (FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo()) && session.getNoMemOrdNo() != null && !"".equals(session.getNoMemOrdNo()))){
			check = false;
		}
		
		if(check && CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			if(loginCheck.popup()){
				throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP, loginCheck.loginType());
			}else{
				//throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED, loginCheck.loginType());
				throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED, loginCheck.loginType(), returnUrl);
			}
		}
	}

	@AfterReturning("loginCheckTarget(loginCheck)")
	public void returningLogging(JoinPoint joinPoint, LoginCheck loginCheck) {
		log.info("returningLogging");
	}

	@AfterThrowing("loginCheckTarget(loginCheck)")
	public void throwingLogging(JoinPoint joinPoint, LoginCheck loginCheck) {
		log.info("throwingLogging");
	}

}
