package admin.web.config.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import admin.web.config.view.View;
import biz.app.pay.model.PaymentException;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AdminWebExceptionResolver implements HandlerExceptionResolver {

	@Autowired
	private MessageSourceAccessor message;

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object paramObject, Exception ex) {

		log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);

		ModelAndView mav = new ModelAndView();

		String exCode = null;
		String resultMessage = null;
		String returnUrl = null;
		String viewName = "";
		String[] params = null;
		
		if(checkAjax(request)){
			log.debug("=========================================================");
			log.debug("= Ajax Error");
			log.debug("=========================================================");
			viewName = View.jsonView();
		} else {
			log.debug("=========================================================");
			log.debug("= No Ajax Error");
			log.debug("=========================================================");
			viewName = View.errorView();
		}

		if(ex instanceof CustomException){
			CustomException customEx = (CustomException) ex;
			exCode = customEx.getExCode();
			if(customEx.getParams() != null) {
				params = customEx.getParams();
			}
			if(StringUtil.isNotBlank(customEx.getReturnUrl())) {
				returnUrl = customEx.getReturnUrl();
			}
		} else if(ex instanceof PaymentException){
			PaymentException customEx = (PaymentException) ex;
			exCode = customEx.getExCode();
			if(customEx.getParams() != null) {
				params = customEx.getParams();
			}
			if(StringUtil.isNotBlank(customEx.getReturnUrl())) {
				returnUrl = customEx.getReturnUrl();
			}
		}else {
			exCode = ExceptionConstants.ERROR_CODE_DEFAULT;
		}

		if(params != null) {
			resultMessage = message.getMessage(AdminConstants.EXCEPTION_MESSAGE_COMMON + exCode, params);
		} else {
			resultMessage = message.getMessage(AdminConstants.EXCEPTION_MESSAGE_COMMON + exCode);
		}
		
		//{0} param 없을 경우 치환
		resultMessage = resultMessage.replaceAll("\\{[0-9]+\\}", "");

		mav.addObject("exCode", exCode);
		mav.addObject("exMsg", resultMessage);
		mav.addObject("exUrl", returnUrl);

		mav.setViewName(viewName);
		return mav;
	}

	/*
	 * Request Ajax Check
	 */
	private boolean checkAjax(HttpServletRequest request) {

		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
	}

}
