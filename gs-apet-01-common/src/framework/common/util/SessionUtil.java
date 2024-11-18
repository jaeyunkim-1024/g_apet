package framework.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

public class SessionUtil {

	private SessionUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	/**
	 * <pre>attribute 설정 method</pre>
	 * 
	 * @param name
	 * @return
	 */
	@SuppressWarnings("cast")
	public static Object getAttribute(String name) {
		return (Object) RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * <pre>attribute 설정 method</pre>
	 * 
	 * @param name
	 * @param object
	 */
	public static void setAttribute(String name, Object object) {
		RequestContextHolder.getRequestAttributes().setAttribute(name, object, RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * <pre>설정한 attribute 삭제</pre>
	 * 
	 * @param name
	 */
	public static void removeAttribute(String name) {
		RequestContextHolder.getRequestAttributes().removeAttribute(name, RequestAttributes.SCOPE_SESSION);
	}

	/**
	 * <pre>session id</pre>
	 * 
	 * @return
	 */
	public static String getSessionId() {
		return RequestContextHolder.getRequestAttributes().getSessionId();
	}

	/**
	 * <pre>HttpSession에 주어진 키 값으로 세션 객체를 생성하는 기능</pre>
	 * 
	 * @param keyStr
	 * @param obj
	 */
	public static void setSessionAttribute(String keyStr, Object obj) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		HttpSession session = request.getSession();
		session.setAttribute(keyStr, obj);
	}

	/**
	 * <pre>HttpSession에 존재하는 주어진 키 값에 해당하는 세션 값을 얻어오는 기능</pre>
	 * 
	 * @param keyStr
	 * @return
	 */
	public static Object getSessionAttribute(String keyStr) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		HttpSession session = request.getSession();
		return session.getAttribute(keyStr);
	}

	/**
	 * <pre>HttpSession에 존재하는 세션을 주어진 키 값으로 삭제하는 기능</pre>
	 * 
	 * @param request
	 * @param keyStr
	 */
	public static void removeSessionAttribute(String keyStr) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		HttpSession session = request.getSession();
		session.removeAttribute(keyStr);
	}

	/**
	 * <pre>세션 존재 유무</pre>
	 * 
	 * @param keyStr
	 * @return
	 */
	public static boolean isSessionAttribute(String keyStr) {

		Object result = getSessionAttribute(keyStr);
		return result != null;
	}
}
