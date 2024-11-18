package framework.common.util;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.common.base.CaseFormat;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.BaseSysVO;
import framework.common.model.CompareBeanPO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BeanCompareUtil {

	private BeanCompareUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	private static MessageSourceAccessor message;

	/**
	 * <pre>Bean Compare</pre>
	 * 
	 * @param bean1
	 * @param bean2
	 * @param propertyNames
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List<CompareBeanPO> compareBean(Object next, Object before, String... propertyNames) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(context);
		message = ac.getBean(MessageSourceAccessor.class);

		List<CompareBeanPO> compareValueList = new ArrayList<>();

		try {
			Map names = new HashMap();
			Set includeNames = new HashSet(Arrays.asList(propertyNames));

			BeanInfo bean1Info = Introspector.getBeanInfo(next.getClass());
			BeanInfo bean2Info = Introspector.getBeanInfo(before.getClass());

			for (PropertyDescriptor prop : bean1Info.getPropertyDescriptors()) {
				if (includeNames.contains(prop.getName())) {
					names.put(prop.getName(), prop);
				}
			}

			for (PropertyDescriptor prop : bean2Info.getPropertyDescriptors()) {
				// look for same property name and check for the value
				if (includeNames.remove(prop.getName())) {
					PropertyDescriptor bean1Descriptor = (PropertyDescriptor) names.get(prop.getName());
					Method getter1 = bean1Descriptor.getReadMethod();
					Method getter = prop.getReadMethod();
					Object value1 = null;
					Object value2 = null;
				
					value1 = getter1.invoke(next);
					value2 = getter.invoke(before);				

					if (value1 == null && value2 != null || value1 != null && value2 == null || (value1 != null && value2 != null && !value1.equals(value2))) {
						CompareBeanPO bean = new CompareBeanPO();

						bean.setSysRegDtm(((BaseSysVO) next).getSysRegDtm());
						bean.setSysRegrNm(((BaseSysVO) next).getSysRegrNm());
						bean.setSysUpdDtm(((BaseSysVO) next).getSysUpdDtm());
						bean.setSysUpdrNm(((BaseSysVO) next).getSysUpdrNm());
						bean.setColumnId(prop.getName());
						bean.setColumnNm(message.getMessage("column." + convertToCamelCase(prop.getName())));
						bean.setValue1(value2);
						bean.setValue2(value1);

						compareValueList.add(bean);
					}
				}
			}

			if (!includeNames.isEmpty()) {
				log.debug("Comparison failed. Property name " + " " + includeNames.toString() + " not found in " + before.getClass());
			}

		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}

		return compareValueList;
	}

	public static String convertToCamelCase(String column) {
		return CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, column);
	}

}
