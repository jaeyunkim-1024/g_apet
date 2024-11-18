package front.web.config.exception;

import biz.app.cart.service.CartService;
import biz.app.member.model.MemberBasePO;
import biz.interfaces.gsr.dao.GsrLogDao;
import biz.interfaces.gsr.model.GsrException;
import biz.interfaces.gsr.model.GsrLnkHistPO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpStatus;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Properties;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.config.exception
* - 파일명		: FrontWebExceptionResolver.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명			:
* </pre>
*/
@Slf4j
public class FrontWebExceptionResolver implements HandlerExceptionResolver  {

	@Autowired private MessageSourceAccessor message;
	@Autowired private Properties webConfig;
	@Autowired private Properties bizConfig;
	@Autowired private CartService cartService;
	@Autowired private GsrLogDao gsrLogDao;

	@SuppressWarnings("unchecked")
	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object paramObject, Exception ex) {

		log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);

		ModelAndView mav = new ModelAndView();

		String exCode = null;
		String loginType = null;
		String[] params = null;
		String exMsg = null;
		StringBuilder returnUrl = new StringBuilder(1024);
		
		if(ex instanceof CustomException){
			log.debug(">>>>>>>>>>>>> Custom Exception");

			CustomException customEx = (CustomException)ex;
			exCode = customEx.getExCode();
			loginType = StringUtil.nvl(customEx.getLoginType());
			params = customEx.getParams();
			if(StringUtil.isNotEmpty(customEx.getReturnUrl())){
				returnUrl.append(customEx.getReturnUrl());
			}
		}else if(ex instanceof GsrException){
			GsrException gsrEx = (GsrException)ex;
			GsrLnkHistPO po = new GsrLnkHistPO();
			Session session  = FrontSessionUtil.getSession();
			po.setMbrNo(session.getMbrNo());
			po.setUpdrIp(RequestUtil.getClientIp());
			po.setReqParam(gsrEx.getReqParam());
			po.setGsrLnkCd(gsrEx.getGsrLnkCd());       // GSR  연동 코드
			po.setReqScssYn("N");           // 요청 성공 여부
			po.setRstCd(gsrEx.getExCode());            // 결과 코드
			gsrLogDao.insertGsrLnkHist(po);

			exCode = gsrEx.getExCode();

			//exCode 가 혹시 탈퇴 라면
			if(StringUtil.equals(exCode,ExceptionConstants.ERROR_GSR_API_DEL_MEMBER)){
				MemberBasePO mpo = new MemberBasePO();
				mpo.setMbrNo(session.getMbrNo());
				mpo.setGsptStateCd(FrontConstants.GSPT_STATE_20);
				gsrLogDao.updateMemberGsrState(mpo);
			}
		}
		else{
			log.debug(">>>>>>>>>>>>> None Custom Exception");
			exCode = ExceptionConstants.ERROR_CODE_DEFAULT;
		}

		log.debug(">>>>>>>>>>>>> exCode=" + exCode);
		log.debug(">>>>>>>>>>>>> loginType=" + loginType);

		if(checkAjax(request)){
			log.debug(">>>>>>>>>>>>> Ajax");
			mav.setViewName(FrontWebConstants.JSON_VIEW_NAME);
			if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)){

				if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR_OD);
				}else if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR_ODS);
				}else{
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR);
					if (StringUtil.isNotEmpty(returnUrl)) {
						try {
							response.setCharacterEncoding("UTF-8");
							response.getWriter().write("returnUrl="+returnUrl.toString());
							response.getWriter().flush();
							response.getWriter().close();
						} catch (Exception e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						}
					}
				}
				
			}else if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP.equals(exCode)){

				if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR_OD);
				}else if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR_ODS);
				}else{
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR);	
				}
			}else if(exCode.indexOf("GSR")>-1){
				response.setCharacterEncoding("UTF-8");
				response.setStatus(HttpStatus.SC_METHOD_FAILURE);
			}
		} else {
			log.debug(">>>>>>>>>>>>> None Ajax");
			if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)){
				mav.setViewName("redirect:/indexLogin");
				mav.addObject("loginType", loginType);
				mav.addObject("returnUrl", request.getRequestURI());
				
				
				returnUrl.append(request.getRequestURI());
				
				boolean paramExt = true;
				if(returnUrl.indexOf("?") < 0){
					paramExt = false;
					returnUrl.append("?");
				}
					
				Enumeration<String> paramNames = request.getParameterNames();
				
				while (paramNames.hasMoreElements()){

				    String name = paramNames.nextElement();
				    String value = request.getParameter(name);

				    if(paramExt){
				    	returnUrl.append("&");
				    }
				    
				    returnUrl.append(name +"=" + value);
				    
				    paramExt = true;
				}
				
				mav.addObject("returnUrl", returnUrl.toString());
				
			}else if(ExceptionConstants.ERROR_GOODS_DENIED.equals(exCode)){
				mav.setViewName(""+FrontWebConstants.EXCEPTION_VIEW_GOODS);
			}else{
				mav.setViewName(FrontWebConstants.EXCEPTION_VIEW_NAME);
			}
		}
		
		if(params != null){
			exMsg = message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode, params);
		}else{
			exMsg = message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode);
		}
		
		if (!ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode) && exCode.indexOf("GSR") == -1) {
			mav.addObject("exCode", exCode);
			mav.addObject("exMsg", exMsg);
		}
		// 디바이스 OS구분
	    String deviceGbCookie = CookieSessionUtil.getCookie(CommonConstants.DEVICE_GB);

	    DeviceUtils.getCurrentDevice(request);
	    String userAgent = request.getHeader("user-agent");
	    ViewBase view = new ViewBase(); 
	    if (StringUtil.isNotEmpty(userAgent)) {
	    	if(userAgent.toLowerCase().indexOf("apet") != -1 ) { 
	    		if(userAgent.toLowerCase().indexOf("android") != -1 ) {
	    			view.setOs(CommonConstants.DEVICE_TYPE_10);
	    		}else {
	    			view.setOs(CommonConstants.DEVICE_TYPE_20);
	    		}
	    	}else {
	    		view.setOs(CommonConstants.DEVICE_TYPE);
	    	}
	    	// 기기구분 [PC, MO, APP]
	    	if(userAgent.toLowerCase().indexOf("apet") != -1 ) { // APP
	    		view.setDeviceGb(CommonConstants.DEVICE_GB_30);
	    	}else if(CommonConstants.DEVICE_GB_20.equals(deviceGbCookie)) { // MO (cookie)
	    		view.setDeviceGb(CommonConstants.DEVICE_GB_20);
	    	}else if(CommonConstants.DEVICE_GB_10.equals(deviceGbCookie)) { // PC (cookie)
	    		view.setDeviceGb(CommonConstants.DEVICE_GB_10);
	    	}else if(!DeviceUtils.getCurrentDevice(request).isNormal()) { 	// MO
	    		view.setDeviceGb(CommonConstants.DEVICE_GB_20);
	    	}else if(DeviceUtils.getCurrentDevice(request).isNormal()) {	// PC
	    		view.setDeviceGb(CommonConstants.DEVICE_GB_10);
	    	}
	    } else {
	    	view.setOs(CommonConstants.DEVICE_TYPE);
	    	view.setDeviceGb(CommonConstants.DEVICE_GB_10);
	    }
	    //
		JSONObject object = new JSONObject();
		object.put("vod_list_api_url", bizConfig.get("vod.list.api.url"));
		object.put("vod_upload_api_url", bizConfig.get("vod.upload.api.url"));
		object.put("vod_info_api_url", bizConfig.get("vod.info.api.url"));
		object.put("vod_group_list_api_url", bizConfig.get("vod.group.list.api.url"));
		object.put("vod_group_add_api_url", bizConfig.get("vod.group.add.api.url"));
		object.put("vod_group_chnl_ord_api_url", bizConfig.get("vod.group.chnl.ord.api.url"));
		object.put("vod_chnl_list_api_url", bizConfig.get("vod.chnl.list.api.url"));
		object.put("vod_api_chnl_id_log", bizConfig.get("vod.api.chnl.id.log"));
		object.put("vod_api_chnl_id_tv", bizConfig.get("vod.api.chnl.id.tv"));
		object.put("vod_group_move_api_url", bizConfig.get("vod.group.move.api.url"));
		object.put("vod_group_default", bizConfig.get("vod.group.default"));
		// 추가
		object.put("fo_mois_post_confmKey", bizConfig.get("fo.mois.post.confmKey")); //행정안전부 우편번호 승인키
		
		//
		try {
			view.setJsonData(URLEncoder.encode(object.toString(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.error("view.setJsonData error", e);
		}

		if(exCode.indexOf("GSR") == -1){
			view.setStId(Long.valueOf(webConfig.getProperty("site.id")));
			view.setStGb(webConfig.getProperty("site.gb"));
			view.setStNm(webConfig.getProperty("site.nm"));
			view.setSvcGbCd(webConfig.getProperty("site.service"));
			Session session = FrontSessionUtil.getSession();
			view.setCartCnt(cartService.getCartCnt(view.getStId(), session.getSessionId(), session.getMbrNo()));
			mav.addObject("view", view);
			mav.addObject("session", session);
			mav.addObject("exMessage", message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + ExceptionConstants.ERROR_SERVER_ERROR));
		}else{
			mav.addObject("exMessage", message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode));
		}
		return mav;
	}

	/*
	 * Request Ajax Check
	 */
	private boolean checkAjax(HttpServletRequest request) {

		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
	}
	
}
