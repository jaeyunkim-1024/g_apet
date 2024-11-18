package framework.common.util;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Map;

import org.apache.commons.lang3.ObjectUtils;

public class ObjectUtil extends ObjectUtils {

	@SuppressWarnings("rawtypes")
	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}
		
		if(obj instanceof String) {
			return StringUtil.isEmpty(obj);
		}
		if (obj.getClass().isArray()) {
			return Array.getLength(obj) == 0;
		}
		if (obj instanceof CharSequence) {
			return ((CharSequence) obj).length() == 0;
		}
		if (obj instanceof Collection) {
			return ((Collection) obj).isEmpty();
		}
		if (obj instanceof Map) {
			return ((Map) obj).isEmpty();
		}

		// else
		return false;
	}
	
	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}
}
