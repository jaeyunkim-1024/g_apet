package framework.common.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

public class RequestUtil {

	private RequestUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	public static String getClientIp() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		String clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
		
		if (StringUtils.isBlank(clientIp) || "unknown".equalsIgnoreCase(clientIp)) {
			clientIp = request.getHeader("X-Forwarded-For");
		}
		
		if (StringUtils.isBlank(clientIp) || "unknown".equalsIgnoreCase(clientIp)) {
			clientIp = request.getHeader("ns-client-ip");
		}

		if (StringUtils.isBlank(clientIp) || "unknown".equalsIgnoreCase(clientIp)) {
			clientIp = request.getHeader("Proxy-Client-IP");
		}

		if (StringUtils.isBlank(clientIp) || "unknown".equalsIgnoreCase(clientIp)) {
			clientIp = request.getRemoteAddr();
		}

		if (StringUtils.isBlank(clientIp) || "unknown".equalsIgnoreCase(clientIp)) {
			clientIp = request.getHeader("WL-Proxy-Client-IP");
		}

		if (StringUtils.isBlank(clientIp) || "unknown".equalsIgnoreCase(clientIp)) {
			clientIp = request.getHeader("HTTP_CLIENT_IP");
		}
		
		// X-Forwarded-For IP 2개 A,B 일경우 예외
		if(clientIp.indexOf(",") > -1) {
			clientIp = clientIp.split(",")[0];
		}
		
		return clientIp;
	}

}
