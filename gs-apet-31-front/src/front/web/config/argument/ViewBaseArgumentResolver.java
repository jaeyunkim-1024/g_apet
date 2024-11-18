package front.web.config.argument;

import java.net.URLEncoder;
import java.util.Locale;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.http.HttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import biz.app.appweb.service.PushService;
import biz.app.cart.service.CartService;
import biz.app.contents.service.SeriesService;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.EventPopupSO;
import biz.app.display.service.DisplayService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.CookieSessionUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.argument
* - 파일명		: ViewBaseArgumentResolver.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: View 기본 정보 설정
* </pre>
*/
@Slf4j
public class ViewBaseArgumentResolver implements HandlerMethodArgumentResolver {

	@Autowired private Properties webConfig;
	@Autowired private Properties bizConfig;
	@Autowired private CartService cartService;
	@Autowired private DisplayService displayService;
	@Autowired private PushService pushService;
	@Autowired private SeriesService seriesService;
	@Autowired private CacheService cacheService;
	
	@SuppressWarnings("unchecked")
	@Override
	public Object resolveArgument(MethodParameter methodParameter, 
								   ModelAndViewContainer mavContainer, 
								   NativeWebRequest webRequest, 
								   WebDataBinderFactory binderFactory) throws Exception {

		log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!! ViewBase Argument Resolver !!!!!!!!!!!!!!!!!!!!!!!!!!!");
		
		HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
		// 20210311 개발서버 proxy 오류 관련 처리
		HttpRequest httpReq = new ServletServerHttpRequest(request); 
		UriComponents uriComp = UriComponentsBuilder.fromHttpRequest(httpReq).build();
		// 20210311 개발서버 proxy 오류 관련 처리
		
		ViewBase view = (ViewBase) mavContainer.getModel().get(CommonConstants.MODEL_MAP_KEY_VIEW);
		if (view == null) {
			log.debug("##### ViewBase Argument Resolver #####");
			view = new ViewBase();
			mavContainer.getModel().put(CommonConstants.MODEL_MAP_KEY_VIEW, view);
		}
		
		view.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		view.setStGb(webConfig.getProperty("site.gb"));
		view.setStNm(webConfig.getProperty("site.nm"));
		view.setSvcGbCd(webConfig.getProperty("site.service"));
//		view.setStDomain(request.getScheme() + "://" + this.webConfig.getProperty("site.domain"));
//		view.setImgDomain(request.getScheme() + "://"+this.bizConfig.getProperty("image.domain"));
//		view.setSchema(request.getScheme());
//		view.setUrl(request.getScheme() + "://" + this.webConfig.getProperty("site.domain")+request.getAttribute("javax.servlet.forward.request_uri"));
		view.setStDomain(uriComp.getScheme() + "://" + this.webConfig.getProperty("site.domain"));
		view.setImgDomain(uriComp.getScheme() + "://"+this.bizConfig.getProperty("image.domain"));
		view.setSchema(uriComp.getScheme());
		view.setUrl(uriComp.getScheme() + "://" + this.webConfig.getProperty("site.domain")+request.getAttribute("javax.servlet.forward.request_uri"));
		view.setEnvmtGbCd(this.bizConfig.getProperty("envmt.gb"));
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
		view.setJsonData(URLEncoder.encode(object.toString(), "UTF-8"));
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
		
		// 펫톡 brand key
		String brandKey = bizConfig.getProperty("aboutpet.cloudgate.webchat.brand.key");
		view.setBrandKey(brandKey);
		
		// 장바구니 수
		Session session = FrontSessionUtil.getSession();
	    view.setCartCnt(this.cartService.getCartCnt(view.getStId(), session.getSessionId(), session.getMbrNo()));
	    	    
//	    view.setDevice(DeviceUtils.getCurrentDevice(request));
	    
	    // 디바이스 OS구분
	    String deviceGbCookie = CookieSessionUtil.getCookie(CommonConstants.DEVICE_GB);
	    DeviceUtils.getCurrentDevice(request);
	    String userAgent = request.getHeader("user-agent");
	    
	    if (StringUtil.isNotEmpty(userAgent) && !DeviceUtils.getCurrentDevice(request).isNormal()) {			// PC의 경우 구분안함
    		if(userAgent.toLowerCase().indexOf("android") != -1 ) {	// AOS, IOS 구분
    			view.setOs(CommonConstants.DEVICE_TYPE_10);
    		}else {
    			view.setOs(CommonConstants.DEVICE_TYPE_20);
    		}
	    }else {
	    	view.setOs(CommonConstants.DEVICE_TYPE);
	    }
	    
	    // 전시 카테고리
	    DisplayCategorySO so = new DisplayCategorySO();
 		so.setStId(view.getStId());
 		so.setDispClsfCd(CommonConstants.DISP_CLSF_10);
 		
	    view.setDisplayCategoryList(cacheService.listDisplayCategory());
	    
	    // 기기구분 [PC, MO, APP]
	    if (StringUtil.isNotEmpty(userAgent)) {
	    	if(userAgent.toLowerCase().indexOf("apet") != -1 ) { // APP
	    		view.setDeviceGb(CommonConstants.DEVICE_GB_30);
	    		if (userAgent.toLowerCase().indexOf("twc") != -1) {
	    			view.setTwcUserAgent(true);
	    		}
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
	    	view.setDeviceGb(CommonConstants.DEVICE_GB_10);
	    }

	    //뒤로가기
	    if(StringUtil.isEmpty(request.getHeader("REFERER")) || request.getHeader("REFERER").indexOf(request.getRequestURI()) != -1){
			view.setGoBackUrl("/");
		}else{
			view.setGoBackUrl(request.getHeader("REFERER"));
		}
	    
	    //이벤트팝업 목록 조회
	    EventPopupSO popLayerEventSO = new EventPopupSO();
	    if(view.getDeviceGb().equals(CommonConstants.DEVICE_GB_30)) {
	    	popLayerEventSO.setEvtpopGbCd("10");
	    }else {
	    	popLayerEventSO.setEvtpopGbCd("20");
	    }
	    view.setPopLayerEventList(displayService.selectPopLayerEventList(popLayerEventSO));


		// deeplink 관련 데이터 처리 =================================================================== START
		view.setDeepLinkYn("");
		view.setRequestURL("");
		StringBuffer inBoundUrl = request.getRequestURL();
		String queryString = request.getQueryString();
		if(StringUtil.isNotEmpty(queryString)
				&& queryString.indexOf("utm_term") > -1
				&& queryString.indexOf("&url=") == -1
				&& queryString.indexOf("returnUrl=") == -1){
			log.info("==> req url  : {}?{}", inBoundUrl, queryString);
			String[] params = queryString.split("&");
			String patten = "^(.*)=(.*)$";
			Pattern paramPattern = Pattern.compile(patten,Pattern.MULTILINE);
			for(String ps : params){
				Matcher para_matcher = paramPattern.matcher(ps);
				String para_name = para_matcher.replaceAll("$1");
				String para_value = para_matcher.replaceAll("$2");
				if(StringUtil.equals(para_name, "utm_term") && StringUtil.equals(para_value, "deeplink")){
					inBoundUrl.append("?");
					inBoundUrl.append(queryString);
					view.setDeepLinkYn("Y");
					view.setRequestURL(inBoundUrl.toString());

					log.info("==> view.getDeepLinkYn() : {}", view.getDeepLinkYn());
					log.info("==> view.getRequestURL() : {}", view.getRequestURL());
					break;
				}
			}
		}
		// deeplink 관련 데이터 처리 ==================================================================== END

		return view;
	}

	@Override
	public boolean supportsParameter(MethodParameter methodParameter) {
		return methodParameter.getParameterType().equals(ViewBase.class);
	}
	
}