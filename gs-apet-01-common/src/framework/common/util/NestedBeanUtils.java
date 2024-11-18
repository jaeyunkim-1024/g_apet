package framework.common.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;

public class NestedBeanUtils {

	private NestedBeanUtils() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	@SuppressWarnings("unused")
	public static void setProperty(final Object bean, final String propertyName, final Object value)
			throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		if (propertyName.contains(".")) {
			String[] tokens = propertyName.split("\\.");
			Object owner = bean;
			for (String subPropertyName : tokens) {
				Method getMethod = owner.getClass().getMethod("get" + subPropertyName.substring(0, 1).toUpperCase() + subPropertyName.substring(1));
				Object property = getMethod.invoke(owner, (Object[]) null);
				if (property == null) {
					Class<?> clazz = getMethod.getReturnType();
					try {
						property = clazz.newInstance();
					} catch (Exception e) {
						// 생성 불가능한 클래드들일경우( Long, Interger 등) 셋업을 중지
						break;
					}
					Method setMethod = owner.getClass().getMethod("set" + subPropertyName.substring(0, 1).toUpperCase() + subPropertyName.substring(1), clazz);
					setMethod.invoke(owner, property);
				}
				owner = property;
			}
		}

		DateFormat dt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dt.setLenient(false);

		try {
			Timestamp timestamp =  new Timestamp(dt.parse(value.toString()).getTime());
			DateUtil.getTimestampToString(timestamp, CommonConstants.COMMON_DATE_FORMAT);
			BeanUtils.setProperty(bean, propertyName, DateUtil.getTimestampToString(timestamp, CommonConstants.COMMON_DATE_FORMAT));
		} catch (Exception e) {
			BeanUtils.setProperty(bean, propertyName, value);
		}
	}

	public static Object getProperty(Object bean, String fieldName) {
		try {
			return PropertyUtils.getProperty(bean, fieldName);
		} catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
			throw new IllegalArgumentException(e);
		}
	}

}
