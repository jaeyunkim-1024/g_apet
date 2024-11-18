package front.web.config.argument;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.common.service.BizService;
import framework.common.util.CookieSessionUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import framework.front.model.Session.OrderParam;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.argument
* - 파일명		: SessionArgumentResolver.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 세션정보를 반환하는 Argument Resolver
* </pre>
*/
@Slf4j
public class SessionArgumentResolver implements HandlerMethodArgumentResolver {
	
/*	@Autowired private MemberBaseDao memberBaseDao;
	
	@Autowired private BizService bizService;

	@Autowired private Properties webConfig;*/

	
	@Override
	public Object resolveArgument(MethodParameter methodParameter, 
								   ModelAndViewContainer mavContainer, 
								   NativeWebRequest webRequest, 
								   WebDataBinderFactory binderFactory) throws Exception {

		Session session = FrontSessionUtil.getSession();
		
		//getSession 에서 set 함. 아래 set 필요없음.
	    OrderParam param = session.getOrder();
	    param.setOrderType(CookieSessionUtil.getCookie(FrontWebConstants.SESSION_ORDER_PARAM_TYPE));
	    param.setCartIds(StringUtil.split(CookieSessionUtil.getCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS), FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS_SEPARATOR));
	    session.setOrder(param);

		return session;
	}

	@Override
	public boolean supportsParameter(MethodParameter methodParameter) {
		return methodParameter.getParameterType().equals(Session.class);
	}
	
}