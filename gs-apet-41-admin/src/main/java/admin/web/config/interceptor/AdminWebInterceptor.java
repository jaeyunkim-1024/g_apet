package admin.web.config.interceptor;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import biz.app.system.model.*;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import biz.app.login.service.AdminLoginService;
import biz.app.system.service.MenuService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.RequestUtil;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AdminWebInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MenuService menuService;

	@Autowired
	private AdminLoginService adminLoginService;
	
	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private CacheService cacheService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// Ajax
		boolean ajaxFlag = checkAjax(request);

		// Language
		String lang = RequestContextUtils.getLocale(request).getLanguage();

		// Theme
		String theme = RequestContextUtils.getTheme(request).getName();

		// uri
		String uri = null;


		//URI 재정의
		String fullUri = request.getRequestURI();
		if(fullUri.indexOf(';') > -1){
			uri = fullUri.substring(0, fullUri.indexOf(';'));
		}else{
			uri = fullUri;
		}


		log.debug("=================================================");
		log.debug("= {} : {}", "Lang", lang);
		log.debug("= {} : {}", "Theme", theme);
		log.debug("= {} : {}", "AjaxFlag", ajaxFlag);
		log.debug("= {} : {}", "Uri", uri);
		log.debug("=================================================");

		// ip allow list 운용 start
		if ((StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_STG) 
				|| StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_DEV) 
				|| StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER))
				&& !(request.getServletPath().contains("/error/"))) {
			CodeDetailVO allowList = cacheService.getCodeCache(CommonConstants.IP_ALLOW_LIST, CommonConstants.IP_ALLOW_LIST_10);
			String clientIp = RequestUtil.getClientIp();
			if (StringUtil.isNotEmpty(allowList) && StringUtil.isNotEmpty(allowList.getUsrDfn2Val()) && DateUtil.isPast(allowList.getUsrDfn2Val())) {
				if (StringUtil.isNotEmpty(allowList.getUsrDfn1Val())) {
					if (allowList.getUsrDfn1Val().indexOf(clientIp) == -1) {
							throw new CustomException(ExceptionConstants.ERROR_NO_CONNECT);
					}
				}
			}
		}
		// ip allow list 운용 end
		Session session = null;



		//동시접속 방지 - 201221 이지희 + 30분 세션 처리 201222
		Session adminSession = AdminSessionUtil.getSession();
		if(adminSession != null && !adminSession.getLoginId().equals("admin") ) {

			//30분간 활동 하지 않은 경우 로그아웃 처리
			Object sessionCheck = SessionUtil.getAttribute(AdminConstants.RECENT_USED_TIME);
			if(sessionCheck != null) {
				Date nowTime = new Date();
				Date sessionTime = (Date) sessionCheck;
				long diff = nowTime.getTime() - sessionTime.getTime();
				long sec = diff / 1000;
				if(sec > 60*30) {
					AdminSessionUtil.removeSession();
					SessionUtil.removeSessionAttribute(AdminConstants.RECENT_USED_TIME);
					SessionUtil.setAttribute(AdminConstants.SESSION_TIME_OUT, "true");
					if(ajaxFlag) {
						response.setStatus(AdminConstants.AJAX_LOGIN_SESSION_ERROR);
						return false;
					} else {
						response.sendRedirect("/login/loginView.do");
						return false;
					}
				}
			}
			SessionUtil.setAttribute(AdminConstants.RECENT_USED_TIME, new Date());


			//동시접속 방지
			Timestamp sessionLoginDtm = adminSession.getLastLoginDtm();

			UserBaseSO so  = new UserBaseSO();
			so.setLoginId(adminSession.getLoginId());
			UserBaseVO usVo = adminLoginService.getUser(so);

			Timestamp checkLastLogin = usVo.getLastLoginDtm();
			if(!StringUtil.isEmpty(sessionLoginDtm) &&  !sessionLoginDtm.equals(checkLastLogin)) {
				AdminSessionUtil.removeSession();
				SessionUtil.setAttribute(AdminConstants.DUPLICATED_LOGOUT, "true");
				if(ajaxFlag) {
					response.setStatus(AdminConstants.AJAX_LOGIN_SESSION_ERROR);
					return false;
				} else {
					response.sendRedirect("/login/loginView.do");
					return false;
				}
			}
		}



		Object dupSession =  SessionUtil.getAttribute(AdminConstants.DUPLICATED_LOGOUT);
		if(dupSession == null) {
			if(uri.indexOf("/login/") == -1
					&& uri.indexOf("/interface/") == -1
					&& uri.indexOf("/common/error.do") == -1) {

				if(AdminSessionUtil.isAdminSession()){
					session = AdminSessionUtil.getSession();
					request.setAttribute(AdminConstants.ADMIN_SESSION_SET_ATTRIBUTE, session);
				} else {
					if(ajaxFlag) {
						response.setStatus(AdminConstants.AJAX_LOGIN_SESSION_ERROR);
						return false;
					} else {
						response.sendRedirect("/login/noSessionView.do");
						return false;
					}
				}
			}

			if(!ajaxFlag && uri.indexOf("/common/") == -1
					&& uri.indexOf("/login/") == -1
					&& uri.indexOf("/interface/") == -1
					&& uri.indexOf("/common/error.do") == -1) {

				List<MenuBaseVO> list = menuService.listCommonMenu(session.getUsrNo());

				List<MenuBaseVO> leftList = new ArrayList<>();
				List<MenuBaseVO> topList = new ArrayList<>();
				MenuBaseVO menuDetail = new MenuBaseVO();

				if(CollectionUtils.isNotEmpty(list)) {
					for(MenuBaseVO menuBaseVO : list) {
						if(menuBaseVO.getListMenuActionVO() != null && menuBaseVO.getListMenuActionVO().size() > 0){
							for(MenuActionVO menuActionVO : menuBaseVO.getListMenuActionVO()) {
								if(StringUtil.isNotBlank(menuActionVO.getUrl()) && uri.indexOf(menuActionVO.getUrl()) > -1) {
									menuDetail.setActNm(menuActionVO.getActNm());
									menuDetail.setActNo(menuActionVO.getActNo());
									menuDetail.setUrl(menuActionVO.getUrl());
									menuDetail.setMenuNo(menuBaseVO.getMenuNo());
									menuDetail.setMenuNm(menuBaseVO.getMenuNm());
									menuDetail.setMenuPathNm(menuBaseVO.getMenuPathNm());
									menuDetail.setMastMenuNo(menuBaseVO.getMastMenuNo());
									menuDetail.setUpMenuNo(menuBaseVO.getUpMenuNo());
								}
							}
						}
					}
				}
				if(StringUtil.isBlank(menuDetail.getUrl()) && uri.indexOf("/main/") == -1) {
					throw new CustomException(ExceptionConstants.ERROR_USER_AUTH);
				}

				// left 메뉴 로직
				if(CollectionUtils.isNotEmpty(list)) {
					for(MenuBaseVO menuBaseVO : list) {
						if(menuDetail.getMastMenuNo() != null && menuDetail.getMastMenuNo().equals(menuBaseVO.getMastMenuNo()) && menuBaseVO.getLevel().equals(2)) {
							MenuBaseVO menuVO = new MenuBaseVO();
							menuVO.setMenuNo(menuBaseVO.getMenuNo());
							menuVO.setMenuNm(menuBaseVO.getMenuNm());
							menuVO.setMenuPathNm(menuBaseVO.getMenuPathNm());
							menuVO.setMastMenuNo(menuBaseVO.getMastMenuNo());
							menuVO.setUpMenuNo(menuBaseVO.getUpMenuNo());
							if(menuBaseVO.getListMenuActionVO() != null && menuBaseVO.getListMenuActionVO().size() > 0) {
								for(MenuActionVO menuActionVO : menuBaseVO.getListMenuActionVO()) {
									if(StringUtil.isNotBlank(menuActionVO.getActGbCd()) && AdminConstants.ACT_GB_10.equals(menuActionVO.getActGbCd())) {
										menuVO.setActNm(menuActionVO.getActNm());
										menuVO.setUrl(menuActionVO.getUrl());
									}
								}
							}

							//targetUrl = StringUtil.equals(uri,menuVO.getUrl()) ? targetUrl : "";

							List<MenuBaseVO> levelList = new ArrayList<>();

							for(MenuBaseVO subVO : list) {
								if(subVO.getUpMenuNo() != null && menuVO.getUpMenuNo() != null && menuVO.getMenuNo().equals(subVO.getUpMenuNo())) {
									MenuBaseVO menuSubVO = new MenuBaseVO();
									menuSubVO.setMenuNo(subVO.getMenuNo());
									menuSubVO.setMenuNm(subVO.getMenuNm());
									menuSubVO.setMenuPathNm(subVO.getMenuPathNm());
									menuSubVO.setMastMenuNo(subVO.getMastMenuNo());
									menuSubVO.setUpMenuNo(subVO.getUpMenuNo());
									if(subVO.getListMenuActionVO() != null && subVO.getListMenuActionVO().size() > 0) {
										for(MenuActionVO menuActionVO : subVO.getListMenuActionVO()) {
											if(StringUtil.isNotBlank(menuActionVO.getActGbCd()) && AdminConstants.ACT_GB_10.equals(menuActionVO.getActGbCd())) {
												menuSubVO.setActNm(menuActionVO.getActNm());
												menuSubVO.setUrl(menuActionVO.getUrl());
											}
										}
									}
									levelList.add(menuSubVO);
								}
							}

							if(CollectionUtils.isNotEmpty(levelList)){
								menuVO.setListMenuBaseVO(levelList);
							}
							leftList.add(menuVO);
						}
					}
				}

				// top 메뉴 로직
				if(CollectionUtils.isNotEmpty(list)) {
					Integer mastMenuNo = null;
					for(MenuBaseVO menuBaseVO : list) {
						if(menuBaseVO.getLevel().equals(1)) {
							mastMenuNo = menuBaseVO.getMenuNo();
							MenuBaseVO menuVO = new MenuBaseVO();
							menuVO.setMenuNo(menuBaseVO.getMenuNo());
							menuVO.setMenuNm(menuBaseVO.getMenuNm());
							menuVO.setMenuPathNm(menuBaseVO.getMenuPathNm());
							menuVO.setMastMenuNo(menuBaseVO.getMastMenuNo());
							menuVO.setUpMenuNo(menuBaseVO.getUpMenuNo());
							for(MenuBaseVO subMenuBaseVO : list) {
								if(subMenuBaseVO.getListMenuActionVO() != null && subMenuBaseVO.getListMenuActionVO().size() > 0) {
									for(MenuActionVO menuActionVO : subMenuBaseVO.getListMenuActionVO()) {
										if(mastMenuNo != null && mastMenuNo.equals(subMenuBaseVO.getMastMenuNo())
												&& StringUtil.isNotBlank(menuActionVO.getActGbCd())
												&& AdminConstants.ACT_GB_10.equals(menuActionVO.getActGbCd())
												&& StringUtil.isBlank(menuVO.getUrl())){

											menuVO.setActNm(menuActionVO.getActNm());
											menuVO.setUrl(menuActionVO.getUrl());
										}
									}
								}
							}
							topList.add(menuVO);
						}
					}
				}

				request.setAttribute("commonMenuDetail", menuDetail);
				request.setAttribute("leftMenuList", leftList);
				request.setAttribute("topMenuList", topList);
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
