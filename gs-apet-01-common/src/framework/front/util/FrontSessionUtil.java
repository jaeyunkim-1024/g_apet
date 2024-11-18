package framework.front.util;

import java.lang.reflect.Method;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.CryptoUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.model.Session.OrderParam;

/**
 * Front 세션 유틸
 * 
 * @author valueFactory
 * @since 2017. 2. 1.
 */
public class FrontSessionUtil {

	private FrontSessionUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	/**
	 * <pre>세션 설정</pre>
	 * 
	 * @param session
	 * @return
	 */
	public static void setSession(Session session) {
		session.setSessionId(CookieSessionUtil.getCookie(CommonConstants.SESSION_ID_COOKIE_NAME));

		CookieSessionUtil.setCookies(session);
	}

	/**
	 * <pre>세션 조회</pre>
	 * 
	 * @param 
	 * @return Session
	 */
	@SuppressWarnings("unused")
	public static Session getSession() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();

		Session session = new Session();

		try {
			CookieSessionUtil.getCookies(session);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if (session.getMbrNo() == null) {
			session.setMbrNo(CommonConstants.NO_MEMBER_NO);
			session.setMbrNm(CommonConstants.NO_MEMBER_NM);
		}

		session.setSessionIp(RequestUtil.getClientIp());

		String full_uri = request.getRequestURI();
		if (full_uri.indexOf(';') > -1) {
			session.setReqUri(full_uri.substring(0, full_uri.indexOf(';')));
		} else {
			session.setReqUri(full_uri);
		}

		if (session.getSessionId() == null || "".equals(session.getSessionId())) {
			session.setSessionId("guest");
		}

		/*
		 * 주문관련 세션 정보
		 */
		OrderParam param = session.getOrder();
		param.setOrderType(CookieSessionUtil.getCookie(FrontConstants.SESSION_ORDER_PARAM_TYPE));
		param.setCartIds(StringUtil.split(CookieSessionUtil.getCookie(FrontConstants.SESSION_ORDER_PARAM_CART_IDS),
				FrontConstants.SESSION_ORDER_PARAM_CART_IDS_SEPARATOR));
		param.setCartGoodsCpInfos(StringUtil.split(CookieSessionUtil.getCookie(FrontConstants.SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS),
				FrontConstants.SESSION_ORDER_PARAM_CART_IDS_SEPARATOR));
		param.setCartYn(CookieSessionUtil.getCookie(FrontConstants.SESSION_ORDER_PARAM_CART_YN));
		session.setOrder(param);

		return session;
	}

	/**
	 * <pre>세션 삭제</pre>
	 * 
	 * @param 
	 * @return
	 */
	public static void removeSession() {
		CookieSessionUtil.removeCookies();
	}

	/**
	 * <pre>특정 쿠키를 제외한 세션 삭제</pre>
	 * 
	 * @param cookieName
	 * @return
	 */
	public static void removeSessionExcept(String[] cookieName) {
		CookieSessionUtil.removeCookiesExcept(cookieName);
	}

	/**
	 * <pre>시스템 정보에 세션 설정</pre>
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("unused")
	public static void setSysInfo(Object obj) {
		Session session = getSession();

		if (obj != null) {
			try {
				Method sysRegrNoMethod = obj.getClass().getMethod("setSysRegrNo", Long.class);
				Method sysUpdrNoMethod = obj.getClass().getMethod("setSysUpdrNo", Long.class);
				sysRegrNoMethod.invoke(obj, session.getMbrNo());
				sysUpdrNoMethod.invoke(obj, session.getMbrNo());
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}

	/**
	 * <pre>비회원 주문 체크 코드 생성</pre>
	 * 
	 * @param session
	 * @param ordNo
	 * @return
	 */
	@SuppressWarnings("unused")
	public static String makeNoMemOrderCheckCode(Session session, String ordNo) {
		try {
			return FrontSessionUtil.makeCheckCode(session, ordNo, StringUtils.defaultIfEmpty(session.getLoginId(), "SALT"));
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@SuppressWarnings("unused")
	private static String makeCheckCode(Session session, String ordNo, String salt) {
		try {
			return CryptoUtil.encryptMD5(session.getSessionId() + ordNo + salt);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

}
