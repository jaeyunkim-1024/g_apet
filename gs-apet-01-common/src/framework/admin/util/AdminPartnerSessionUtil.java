package framework.admin.util;

import java.lang.reflect.Method;

import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.SessionUtil;

public class AdminPartnerSessionUtil {

	private AdminPartnerSessionUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	/**
	 * <pre>세션 조회</pre>
	 * 
	 * @param
	 * @return Session
	 */
	public static Session getSession() {
		return (Session) SessionUtil.getAttribute("_http_session_partner");
	}

	/**
	 * <pre>세션 설정</pre>
	 * 
	 * @param session
	 * @return
	 */
	public static void setSession(Session session) {
		SessionUtil.setAttribute("_http_session_partner", session);
	}
	/**
	 * <pre>세션 삭제</pre>
	 * 
	 * @param
	 * @return
	 */
	public static void removeSession() {
		SessionUtil.removeAttribute("_http_session_partner");
	}

	/**
	 * <pre>로그인 여부 체크</pre>
	 * 
	 * @param
	 * @return
	 */
	public static boolean isAdminSession() {
		Session result = getSession();
		return result != null;
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
		if (session != null && obj != null) {
			try {
				Method sysRegrNoMethod = obj.getClass().getMethod("setSysRegrNo", Long.class);
				Method sysUpdrNoMethod = obj.getClass().getMethod("setSysUpdrNo", Long.class);

				sysRegrNoMethod.invoke(obj, session.getUsrNo());
				sysUpdrNoMethod.invoke(obj, session.getUsrNo());
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}
}
