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

import biz.common.service.CacheService;
import front.web.config.view.ViewPopup;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.config.argument
* - 파일명		: ViewPopupArgumentResolver.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명			:
* </pre>
*/
@Slf4j
@Deprecated
public class ViewPopupArgumentResolver implements HandlerMethodArgumentResolver {

	@Autowired private Properties webConfig;
	@Autowired private Properties bizConfig;
	
	@Autowired private CacheService cacheService;
	
	@Override
	public Object resolveArgument(MethodParameter methodParameter, 
								   ModelAndViewContainer mavContainer, 
								   NativeWebRequest webRequest, 
								   WebDataBinderFactory binderFactory) throws Exception {

		log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!! ViewPopup Argument Resolver !!!!!!!!!!!!!!!!!!!!!!!!!!!");
		
		HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);


		ViewPopup view = new ViewPopup();
		
		
		view.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		view.setStNm(webConfig.getProperty("site.nm"));
		view.setSvcGbCd(webConfig.getProperty("site.service"));
		view.setStDomain(request.getScheme() + "://" + this.webConfig.getProperty("site.domain"));
		view.setImgDomain( request.getScheme() + "://"+this.bizConfig.getProperty("image.domain"));
		view.setSchema(request.getScheme());
		view.setEnvmtGbCd(this.bizConfig.getProperty("envmt.gb"));
		view.setGaKey(this.bizConfig.getProperty("google.analytics.key"));

		// 언어
		Locale locale = RequestContextUtils.getLocale(request);
		view.setLang(locale.getLanguage());
		
		// 이미지경로
		String imagePath = webConfig.getProperty("default.imagePath");
		view.setImgPath(imagePath);

		String imageCommonPath = webConfig.getProperty("default.imageCommonPath");
		view.setImgComPath(imageCommonPath);

		// no Image path
		String noImagePath = webConfig.getProperty("default.noImagePath");
		view.setNoImgPath( noImagePath );

		view.setMainDispClsfNo(Long.valueOf(webConfig.getProperty("site.main.disp.clsf.no")));
		view.setDispCornNoBest(Long.valueOf(webConfig.getProperty("disp.corn.no.best")));
		view.setDisplayCategoryList(this.cacheService.listDisplayCategory());
		
		return view;
	}

	@Override
	public boolean supportsParameter(MethodParameter methodParameter) {
		return methodParameter.getParameterType().equals(ViewPopup.class);
	}
	
}