package framework.common.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;

/**
 *  Cookie 관련 기능 제공
 * 
 * @author valueFactory
 * @since 2016. 01. 15.
 */
@Slf4j
public class CookieSessionUtil {

	private CookieSessionUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	/**
	 * Object를 쿠키로 생성
	 * 
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static void setCookies(Object obj) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String domain = bizConfig.getProperty("cookie.domain").replaceAll("\r", "").replaceAll("\n", ""); //보안 진단관련 replace 처리
		String envGb = bizConfig.getProperty("envmt.gb");
		PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();

		Cookie cookie = null;
		String fieldName = null;
		String fieldValue = null;
		String sessionKeepYn = null;

		Class<?> cls = obj.getClass();
		Field[] fieldList = cls.getDeclaredFields();

		/*for (Field field : fieldList) {  210326 수정 leejh
			fieldName = field.getName();
			fieldValue = "";
			field.setAccessible(true);

			try {
				if (field.get(obj) != null) {
					fieldValue = field.get(obj).toString();
				}

				if ("keepYn".equals(fieldName) && !"".equals(fieldValue)) {
					sessionKeepYn = "Y";
					break;
				}
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}*/
		String mbrNo = "";
		for (Field field : fieldList) {
			fieldName = field.getName();
			fieldValue = "";
			field.setAccessible(true);

			if (!CommonConstants.SESSION_ID_OBJECT_NAME.equals(fieldName) && !FrontConstants.SESSION_ORDER_PARAM_NAME.equals(fieldName)) {

				try {
					if (field.get(obj) != null) {
						fieldValue = field.get(obj).toString();
						if (StringUtil.equals("mbrNo", fieldName)) {
							mbrNo = fieldValue;
						}
//						fieldValue = CryptoUtil.encryptDES(fieldValue);
						// PetraUtil 로 변경
						fieldValue = PetraUtil.twoWayEncrypt(fieldValue, mbrNo, RequestUtil.getClientIp());
					}
				} catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				cookie = new Cookie(fieldName, fieldValue);
				if ( "keepYn".equals(fieldName) && !"".equals(fieldValue)) {
					cookie.setMaxAge(60 * 60 * 24 * 30);
				} else {
					cookie.setMaxAge(-1);
				}
				cookie.setPath("/");
				if (domain != null && !"".equals(domain)) {
					cookie.setDomain(domain);
				}
				if(!envGb.equals(FrontConstants.ENVIRONMENT_GB_LOCAL)) {cookie.setSecure(true);}
				response.addCookie(cookie);
			}
		}
	}

	/**
	 * <pre>쿠키 생성(브라우저 닫으면 삭제)</pre>
	 * 
	 * @param key
	 * @param value
	 */
	public static void createCookie(String key, String value) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		String domain = bizConfig.getProperty("cookie.domain").replaceAll("\r", "").replaceAll("\n", ""); //보안 진단관련 replace 처리

		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();

		Cookie cookie = new Cookie(key, value);
		cookie.setMaxAge(-1);
		cookie.setPath("/");
		if (domain != null && !"".equals(domain)) {
			cookie.setDomain(domain);
		}
		if(!envGb.equals(FrontConstants.ENVIRONMENT_GB_LOCAL)) {cookie.setSecure(true);}
		response.addCookie(cookie);
	}

	/**
	 * <pre>encodeURIComponent 형식으로 쿠키 생성</pre>
	 * 
	 * @param key
	 * @param value
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static void createCookieEncURI(String key, String value) {
		String encodeURIComponentValue;
		try {
			encodeURIComponentValue = URLEncoder.encode(value, "UTF-8").replaceAll("\\+", "%20")
					.replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(").replaceAll("\\%29", ")")
					.replaceAll("\\%7E", "~");
		} catch (UnsupportedEncodingException e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		createCookie(key, encodeURIComponentValue);
	}

	/**
	 * <pre>encodeURIComponent 형식으로 생성 된 쿠키 정보 반환</pre>
	 * 
	 * @param key
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static String getCookieValueDecURI(String key) {

		String resultValue;
		try {
			resultValue = URLDecoder.decode(getCookie(key), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return resultValue;
	}

	/**
	 * <pre>
	 * 쿠키를 지정된 Object에 저장한다. 쿠키명과 Object의 Field명이 같아야 한다.
	 * Object의 필드 타입은 String, Long만 가능
	 * </pre>
	 * 
	 * @param obj
	 * @return
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 * @throws NumberFormatException 
	 * @throws Exception
	 */
	public static void getCookies(Object obj) throws IllegalAccessException  {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
		Cookie[] cookies = request.getCookies();

		String cookieName = null;
		String cookieValue = null;
		String fieldName = null;
		Class<?> fieldType = null;

		if (obj != null) {
			Class<?> cls = obj.getClass();
			Field[] fieldList = cls.getDeclaredFields();

			if (cookies != null && cookies.length > 0) {
				String mbrNo = "";
				for (Cookie cookie : cookies) {
					cookieName = cookie.getName();
					cookieValue = cookie.getValue();
					if (StringUtil.equals("mbrNo", cookieName)) {
						mbrNo = cookieValue;
					}
					for (Field field : fieldList) {
						fieldName = field.getName();
						fieldType = field.getType();

						field.setAccessible(true);
						// 쿠키명과 Object의 필드명이 같을 경우
						if (cookieName.equals(fieldName)) {

							if (cookieValue != null && !"".equals(cookieValue)) {
//								cookieValue = CryptoUtil.decryptDES(cookieValue);
								// PetraUtil 로 변경
								cookieValue = PetraUtil.twoWayDecrypt(cookieValue, mbrNo, RequestUtil.getClientIp());

								// Object 필드의 타입이 Integer
								if (fieldType == Long.class) {
									field.set(obj, Long.valueOf(cookieValue));
									// Object 필드의 타입이 String
								} else if (fieldType == String.class) {
									field.set(obj, cookieValue);
								} else if( fieldType == Integer.class) {    // Integer인 경우 추가 210219 leejh
									field.set(obj, Integer.valueOf(cookieValue)); 
								}
							} else {
								field.set(obj, null);
							}

						} else if (CommonConstants.SESSION_ID_COOKIE_NAME.equalsIgnoreCase(cookieName)
								&& CommonConstants.SESSION_ID_OBJECT_NAME.equals(fieldName)) {
							field.set(obj, cookieValue);
						}

					}
				}

			} else {
				for (Field field : fieldList) {
					fieldName = field.getName();
					//fieldType = field.getType();

					field.setAccessible(true);

					if (CommonConstants.SESSION_ID_OBJECT_NAME.equals(fieldName)) {
						field.set(obj, "noSession");
					}
				}
			}
		}

	}

	/**
	 * <pre>쿠키 세션 삭제 JSESSIONID는 초기화 하지 않음</pre>
	 * 
	 * @throws Exception
	 */
	public static void removeCookies() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		String domain = bizConfig.getProperty("cookie.domain").replaceAll("\r", "").replaceAll("\n", ""); //보안 진단관련 replace 처리

		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();

		Cookie[] cookies = request.getCookies();

		for (Cookie cookie : cookies) {
			if (!CommonConstants.SESSION_ID_COOKIE_NAME.equalsIgnoreCase(cookie.getName())) {
				cookie.setPath("/");
				cookie.setMaxAge(0);
				cookie.setValue(null);
				if (domain != null && !"".equals(domain)) {
					cookie.setDomain(domain);
				}
				if(!envGb.equals(FrontConstants.ENVIRONMENT_GB_LOCAL)) {cookie.setSecure(true);}
				response.addCookie(cookie);
			}
		}
	}

	/**
	 * <pre>특정 쿠키를 제외한 세션 삭제 JSESSIONID는 초기화 하지 않음</pre>
	 * 
	 * @param cookieName
	 * @throws Exception
	 */
	public static void removeCookiesExcept(String[] cookieName) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		String domain = bizConfig.getProperty("cookie.domain").replaceAll("\r", "").replaceAll("\n", ""); //보안 진단관련 replace 처리

		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();

		try {
			Cookie[] cookies = request.getCookies();
	
			for (Cookie cookie : cookies) {
				if (!CommonConstants.SESSION_ID_COOKIE_NAME.equalsIgnoreCase(cookie.getName())) {
					boolean exist = false;
	
					for (int i = 0; i < cookieName.length; i++) {
						if (cookie.getName().startsWith(cookieName[i])) {
							exist = true;
							break;
						}
					}
	
					if (!exist) {
						cookie.setPath("/");
						cookie.setMaxAge(0);
						cookie.setValue(null);
						if (domain != null && !"".equals(domain)) {
							cookie.setDomain(domain);
						}
						if(!envGb.equals(FrontConstants.ENVIRONMENT_GB_LOCAL)) {cookie.setSecure(true);}
						response.addCookie(cookie);
					}
				}
			}
		}catch (Exception e) {
			log.error(e.getLocalizedMessage());
		}
	}

	public static String getCookie(String cookieName) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		String cookieValue = "";

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookieName.equals(cookie.getName())) {
					cookieValue = cookie.getValue();
				}
			}
		}

		return cookieValue;
	}

}
