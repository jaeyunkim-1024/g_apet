package framework.batch.util;

import java.lang.reflect.Method;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * Batch 세션 정보 설정
 * 
 * @author valueFactory
 * @since 2017. 2. 1.
 */
public class BatchSessionUtil {

	private BatchSessionUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	/**
	 * <pre>시스템 정보에 세션정보 설정</pre>
	 * 
	 * @param obj
	 */
	@SuppressWarnings("unused")
	public static void setSysInfo(Object obj) {

		if (obj != null) {
			try {
				Method sysRegrNoMethod = obj.getClass().getMethod("setSysRegrNo", Long.class);
				Method sysUpdrNoMethod = obj.getClass().getMethod("setSysUpdrNo", Long.class);

				sysRegrNoMethod.invoke(obj, CommonConstants.COMMON_BATCH_USR_NO);
				sysUpdrNoMethod.invoke(obj, CommonConstants.COMMON_BATCH_USR_NO);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

	}

}
