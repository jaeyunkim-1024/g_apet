package framework.admin.util;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LogUtil {

	private LogUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	public static void log(Object... args) {
		log.debug("==================================================================");
		for (Object obj : args) {
			log.debug("= 파라미터 : {} ", ToStringBuilder.reflectionToString(obj, ToStringStyle.MULTI_LINE_STYLE));
		}
		log.debug("==================================================================");
	}

	public static void log(String name, Object... args) {
		log.debug("==================================================================");
		log.debug("= {}", name);
		log.debug("------------------------------------------------------------------");
		for (Object obj : args) {
			log.debug("= {} ", ToStringBuilder.reflectionToString(obj, ToStringStyle.MULTI_LINE_STYLE));
		}
		log.debug("==================================================================");
	}
}
