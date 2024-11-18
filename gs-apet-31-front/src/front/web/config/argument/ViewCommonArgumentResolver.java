package front.web.config.argument;

import java.util.Locale;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.support.RequestContextUtils;

import biz.app.cart.service.CartService;
import biz.app.display.service.DisplayService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.CookieSessionUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.view.ViewCommon;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.config.argument
* - 파일명		: ViewSubArgumentResolver.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명			:
* </pre>
*/
@Slf4j
@Deprecated
public class ViewCommonArgumentResolver extends ViewBaseArgumentResolver {
	
	@Override
	public Object resolveArgument(MethodParameter methodParameter, 
								   ModelAndViewContainer mavContainer, 
								   NativeWebRequest webRequest, 
								   WebDataBinderFactory binderFactory) throws Exception {
		
		ViewCommon view = (ViewCommon) mavContainer.getModel().get(CommonConstants.MODEL_MAP_KEY_VIEW);

		if (view == null) {
			log.debug("##### ViewCommon Argument Resolver #####");
			view = new ViewCommon();
			mavContainer.getModel().put(CommonConstants.MODEL_MAP_KEY_VIEW, view);
		}
		super.resolveArgument(methodParameter, mavContainer, webRequest, binderFactory);

		return view;
	}

	@Override
	public boolean supportsParameter(MethodParameter methodParameter) {
		return methodParameter.getParameterType().equals(ViewCommon.class);
	}
	
}