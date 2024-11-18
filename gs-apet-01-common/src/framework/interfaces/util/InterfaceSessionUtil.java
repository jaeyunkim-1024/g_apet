package framework.interfaces.util;

import java.lang.reflect.Method;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * Interface 세션 정보 설정
 * 
 * @author valueFactory
 * @since 2017. 6. 28.
 */
public class InterfaceSessionUtil {

	private InterfaceSessionUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	@SuppressWarnings("unused")
	public static void setSysInfo(Object obj) {

		if (obj != null) {
			try {
				Method sysRegrNoMethod = obj.getClass().getMethod("setSysRegrNo", Long.class);
				Method sysUpdrNoMethod = obj.getClass().getMethod("setSysUpdrNo", Long.class);

				sysRegrNoMethod.invoke(obj, CommonConstants.INTERFACE_USR_NO);
				sysUpdrNoMethod.invoke(obj, CommonConstants.INTERFACE_USR_NO);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}
}
