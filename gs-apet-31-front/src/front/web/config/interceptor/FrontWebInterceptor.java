package front.web.config.interceptor;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import framework.common.util.*;
import front.web.config.constants.FrontWebConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;



/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.interceptor
* - 파일명		: FrontWebInterceptor.java
* - 작성일		: 2021. 2. 3.
* - 작성자		: 이지희
* - 설명		: front 인터셉터
* </pre>
*/
@Slf4j
public class FrontWebInterceptor extends HandlerInterceptorAdapter {     
	
	@Autowired
	private CacheService cacheService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private Properties bizConfig;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {    
		
		// Language
		String lang = RequestContextUtils.getLocale(request).getLanguage();
		
		// Ajax
		boolean ajaxFlag = checkAjax(request);
		String uri = request.getRequestURI();

		log.debug(">>>>>>>>lang="+lang+">>>>>>>>ajax="+ajaxFlag);
		log.debug(">>>>>>>>url="+uri);
		log.debug(">>>>>>>>content-type="+request.getContentType());
		log.debug(">>>>>>>>param="+request.getParameterMap().toString());

		/*if(request.getParameterMap() != null){
			for(Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()){
				log.error(">>>>>>>>param  key :  {}", entry.getKey());
				String[] values = entry.getValue();
				for(String val : values){
					log.error(">>>>>>>>param value   : {}", val );
				}
			}
		}*/

		if (request.getServletPath().contains("/_images/") || request.getServletPath().contains("/_script/")
				|| request.getServletPath().contains("/_css/") || request.getServletPath().contains("/_font/")
				) {
			return true;
		}

		Session session = FrontSessionUtil.getSession();
		//로그인 완료 시 , session Expire 시간 체크
		String userAgent = Optional.ofNullable(request.getHeader("user-agent")).orElseGet(()->"");
		// app 아닌 pc,moWeb 일때만 session expire 체크
		// 2021.05.17 주석
		/*if(userAgent.toLowerCase().indexOf("apet") == -1){

			//로그인 시, mbrNo 있을 시
			String expireStr = session.getExpire();
			if(Long.compare(session.getMbrNo(),CommonConstants.NO_MEMBER_NO) != 0){
				if(StringUtil.isEmpty(expireStr)){
					try{
						CodeDetailVO sessionExpire = cacheService.getCodeCache(CommonConstants.VARIABLE_CONSTANTS,CommonConstants.VARIABLE_CONSTATNS_SESSION_EXPIRE);
						if(StringUtil.equals(sessionExpire.getUseYn(),CommonConstants.COMM_YN_Y)){
							String secStr = cacheService.getCodeCache(CommonConstants.VARIABLE_CONSTANTS,CommonConstants.VARIABLE_CONSTATNS_SESSION_EXPIRE).getUsrDfn1Val();
							Integer sec = Integer.parseInt(secStr) * 60;
							Long expireLong = DateUtil.addSeconds(DateUtil.getTimestamp(),sec).getTime(); // expire 시간 현재 시간으로부터 1800초(30분 뒤)
							session.setExpire(expireLong.toString());
							FrontSessionUtil.setSession(session);
						}
					}catch(NullPointerException npe){
						log.error("#### Failed Set Session Expire");
					}catch(Exception e){
						log.info("#### Failed : {}",e.getClass());
					}
				}
			}

			if(StringUtil.isNotEmpty(expireStr)){
				Long expire = Long.parseLong(expireStr);
				Long nowTime = DateUtil.getTimestamp().getTime();
				if(nowTime>expire){
					FrontSessionUtil.removeSession();
					response.sendRedirect("/indexLogin?returnUrl="+request.getParameter("returnUrl"));
					return false;
				}
			}
		}*/

		
		// PRD 임시 ip allow list 운용 start
		if ((StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_STG) 
				|| StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_DEV) 
				|| StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER))
				&& !(request.getServletPath().contains("/error/"))) {
			CodeDetailVO allowList = cacheService.getCodeCache(CommonConstants.IP_ALLOW_LIST, CommonConstants.IP_ALLOW_LIST_10);
			String clientIp = RequestUtil.getClientIp();
			if (StringUtil.isNotEmpty(userAgent)) {
				if (userAgent.toLowerCase().indexOf("apet") == -1) {
					if (StringUtil.isNotEmpty(allowList) && StringUtil.isNotEmpty(allowList.getUsrDfn2Val()) && DateUtil.isPast(allowList.getUsrDfn2Val())) {
						if (StringUtil.isNotEmpty(allowList.getUsrDfn1Val())) {
							if (allowList.getUsrDfn1Val().indexOf(clientIp) == -1) {
								if (uri.indexOf("/error/404/") == -1) {
									response.sendRedirect("/error/404/");
									return false;
								}
							}
						}
					}
				}
			} else {
				if (StringUtil.isNotEmpty(allowList) && StringUtil.isNotEmpty(allowList.getUsrDfn2Val()) && DateUtil.isPast(allowList.getUsrDfn2Val())) {
					if (StringUtil.isNotEmpty(allowList.getUsrDfn1Val())) {
						if (allowList.getUsrDfn1Val().indexOf(clientIp) == -1) {
							if (uri.indexOf("/error/404/") == -1) {
								response.sendRedirect("/error/404/");
								return false;
							}
						}
					}
				}
			}
		}
		// PRD 임시 ip allow list 운용 end
		
		//로그인 하지 않아야 되는 페이지에 로그인 된 경우 들어가려 할 때 메인으로 보내버리기
		if(StringUtil.equals(bizConfig.getProperty("envmt.gb"),session.getEnv())){
			if( (uri.indexOf("/join/") > -1 && uri.indexOf("indexTag") < 0  && uri.indexOf("insertTagInfo") <0 && uri.indexOf("indexResult") < 0 && uri.indexOf("insertMemberPrflInApp") < 0)  
					|| uri.indexOf("/login") > -1
					|| (uri.indexOf("/indexLogin") > -1 && uri.indexOf("/indexLoginSettings") < 0 )
					// || uri.indexOf("/snsLogin") > -1
					|| uri.indexOf("/testLogin") > -1) {
				log.error("frontInterceptor : "+uri); 
				if(session != null ){
					if(session.getMbrNo()!=null && session.getMbrNo() > 0) {
						if(ajaxFlag) {
							response.setStatus(FrontConstants.AJAX_LOGIN_SESSION_ERROR);
							return false;
						} else {
							
							//String returnUrl = "/tv/home";
							String returnUrl = (bizConfig.getProperty("main.home.url"));
							
							if(request.getParameter("returnUrl") != null) returnUrl = request.getParameter("returnUrl"); 
							response.sendRedirect(returnUrl);
							return false;
						}
						
					}
				}
			}
		}
		
		
		//세션 업데이트 
		if(session != null && session.getMbrNo() != null && Long.compare(session.getMbrNo(), CommonConstants.NO_MEMBER_NO) != 0
				&& ( uri.indexOf("/log/home") > -1  || uri.indexOf("/shop/home") > -1
						|| uri.indexOf("/tv/home") > -1 || uri.indexOf("/mypage/indexMyPage/") > -1)) {
			try {
		    	String returnSessionVal = memberService.updateMemberSession(session, null, null);
		    	if(returnSessionVal != "S"){
					
					if("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
						response.setStatus(FrontConstants.AJAX_LOGIN_SESSION_ERROR);
						return false;
					} else {
							response.sendRedirect(returnSessionVal);
						return false;
					}
				}
	    	} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		
			
		return true;
	} 
	
	/*
	 * Request Ajax Check
	 */
	private boolean checkAjax(HttpServletRequest request) {
		
		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
	}

}  
