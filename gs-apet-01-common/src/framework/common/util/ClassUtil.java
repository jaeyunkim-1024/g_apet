package framework.common.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.BaseSysVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public final class ClassUtil {

	private ClassUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	@SuppressWarnings("rawtypes")
	public static Class loadClass(String className) throws ClassNotFoundException {
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();

		if (classLoader == null) {
			classLoader = ClassUtil.class.getClassLoader();
		}

		return classLoader.loadClass(className);
	}

	public static Object createInstance(String className)
			throws ClassNotFoundException, IllegalAccessException, InstantiationException {
		return loadClass(className).newInstance();
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map getClassConstants(String className)
			throws ClassNotFoundException, IllegalAccessException {
		Map constants = new HashMap();
		Class clazz = loadClass(className);

		Field[] fields = clazz.getFields();
		for (int i = 0; i < fields.length; ++i) {
			Field field = fields[i];
			int modifiers = field.getModifiers();
			if (((modifiers & 0x8) == 0) || ((modifiers & 0x10) == 0))
				continue;

			Object value = field.get(null);
			if (value != null) {
				constants.put(field.getName(), value);
			}
		}

		return constants;
	}
	
	public static Field getFieldWithName(Object obj, String name) {
		Class<?> cls = obj.getClass();
		if (obj instanceof BaseSysVO) {
			do {
				try {
						Field f = cls.getDeclaredField(name);
						return f;
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			} while ((cls = cls.getSuperclass()) != null);
		}

		return null;
	}
	
	public static boolean objectAllFieldNullCheck(Object obj) {
		Class<?> cls = obj.getClass();
		for (Field field : cls.getDeclaredFields()) {
			field.setAccessible(true);
			try {
				Object value = field.get(obj);
				if (StringUtil.isEmpty(value)) {
					return true;
				}
				if (StringUtil.equals("java.lang.String[]", field.getType().getTypeName())) {
					String[] arr = (String[])value;
					if (arr.length == 0) {
						return true;
					}
				}
			} catch (IllegalArgumentException | IllegalAccessException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		return false;
	}
	
	
	@SuppressWarnings("rawtypes")
	public static List<Field> getAllFields(Class clazz) {
	    if (clazz == null) {
	        return Collections.emptyList();
	    }
	    List<Field> result = new ArrayList<>(getAllFields(clazz.getSuperclass()));
	    List<Field> filteredFields = Arrays.stream(clazz.getDeclaredFields())
	      .collect(Collectors.toList());
	    result.addAll(filteredFields);
	    return result;
	}
}