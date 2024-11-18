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
import framework.common.util.CookieSessionUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.view.ViewCustomer;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.config.argument
* - 파일명		: ViewCustomerArgumentResolver.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: snw
* - 설명			: View Customer 정보 설정
* </pre>
*/
@Slf4j
@Deprecated
public class ViewCustomerArgumentResolver implements HandlerMethodArgumentResolver {

	@Autowired private Properties webConfig;
	@Autowired private Properties bizConfig;
	@Autowired private CacheService cacheService;
	@Autowired private MemberService memberService;
	@Autowired private DisplayService displayService;
	@Autowired private CartService cartService;

	@Override
	public Object resolveArgument(MethodParameter methodParameter,
								   ModelAndViewContainer mavContainer,
								   NativeWebRequest webRequest,
								   WebDataBinderFactory binderFactory) throws Exception {

		log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!! ViewMyPage Argument Resolver !!!!!!!!!!!!!!!!!!!!!!!!!!!");

		HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);

		ViewCustomer view = new ViewCustomer();

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

		//회원 공통정보
		Session mbrsession = new Session();
	    CookieSessionUtil.getCookies(mbrsession);
	
	    if(mbrsession.getMbrNo() != null){
	    	MemberBaseSO so = new MemberBaseSO();
	    	so.setMbrNo(mbrsession.getMbrNo());
	    	MemberBaseVO member = this.memberService.getMemberBase(so);
			view.setMbrGrdCd(member.getMbrGrdCd());
			view.setMbrGrdNm(member.getMbrGrdNm());
	    }
		
		// 장바구니 수
		Session session = FrontSessionUtil.getSession();
	    view.setCartCnt(this.cartService.getCartCnt(view.getStId(), session.getSessionId(), session.getMbrNo()));
		
		return view;
	}

	@Override
	public boolean supportsParameter(MethodParameter methodParameter) {
		return methodParameter.getParameterType().equals(ViewCustomer.class);
	}

}