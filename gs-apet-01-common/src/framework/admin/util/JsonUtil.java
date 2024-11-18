package framework.admin.util;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import net.sf.json.JSON;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.ibatis.cache.CacheException;

import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JsonUtil<T> {

	@SuppressWarnings("unchecked")
	public List<T> toArray(Class<T> clz, String json, String camelYn) {
		try {
			JSONArray jsonArray = JSONArray.fromObject(StringEscapeUtils.unescapeXml(json));

			List<T> result = new ArrayList<>();
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				Map<String, Object> data = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class);
				T obj = createDomainInstance(clz);
				convertMapToObject(data, obj, camelYn);
				result.add(obj);
			}

			return result;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CacheException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	public List<T> toArray(Class<T> clz, String json) {
		return toArray(clz, json, CommonConstants.COMM_YN_N);
	}

	@SuppressWarnings("unchecked")
	public Object toBean(Class<T> clz, String json, String camelYn) {
		try {
			JSONObject jsonObject = JSONObject.fromObject(StringEscapeUtils.unescapeXml(json));

			Map<String, Object> data = (Map<String, Object>) JSONObject.toBean(jsonObject, HashMap.class);

			Object result = createDomainInstance(clz);

			convertMapToObject(data, result, camelYn);

			return result;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CacheException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	public Object toBean(Class<T> clz, String json) {
		return toBean(clz, json, CommonConstants.COMM_YN_N);
	}

	@SuppressWarnings({ "rawtypes", "cast" })
	private static void convertMapToObject(Map map, Object objClass, String camelYn) {
		Iterator itr = map.keySet().iterator();
		List<Field> list = new ArrayList<>();

		getAllFields(list, objClass.getClass());

		while (itr.hasNext()) {
			String key = (String) itr.next();
			String keyCamel = key;
			String method = null;
			if (StringUtil.isNotBlank(camelYn) && CommonConstants.COMM_YN_Y.equals(camelYn)) {
				keyCamel = StringUtil.toCamelCase(key);
				method = "set" + keyCamel.substring(0, 1).toUpperCase() + keyCamel.substring(1);
			} else {
				method = "set" + key.substring(0, 1).toUpperCase() + key.substring(1);
			}

			try {
				for (Field f : list) {
					if (f.getName().equals(keyCamel)) {
						Object obj = map.get(key);

						String value = null;

						if (obj instanceof String) {
							value = (String) obj;
						}

						if (obj instanceof Integer) {
							value = String.valueOf((Integer) obj);
						}
						
						if (obj instanceof Long) {
							value = String.valueOf((Long) obj);
						}

						if (obj instanceof Double) {
							value = String.valueOf((Double) obj);
						}

						if (obj instanceof Boolean) {
							value = String.valueOf((Boolean) obj);
						}

						if (obj instanceof ArrayList) {
							JSONArray jsonArray = JSONArray.fromObject(obj);
							value = jsonArray.toString();
						}

						if (StringUtil.isBlank(value)) {
							value = (String) obj;
						}

						if (f.getType().getTypeName().equals("java.lang.String[]")) {
							List<String> jsonList = new ArrayList();
							JSONArray jsonArray = JSONArray.fromObject(value);
							for (int i=0; i<jsonArray.size(); i++) {
								jsonList.add(jsonArray.get(i).toString());
							}
							String[] stringArray = jsonList.toArray(new String[jsonList.size()]);
							Class[] argTypes = new Class[] { String[].class };
							objClass.getClass().getMethod(method, argTypes).invoke(objClass, (Object) stringArray);
						}

						if (f.getType().getTypeName().equals("java.lang.String") && StringUtil.isNotBlank(value)) {
							objClass.getClass().getMethod(method, f.getType()).invoke(objClass, value);
						}

						if (f.getType().getTypeName().equals("java.lang.Long")
								|| f.getType().getTypeName().equals("long")) {
							value = value.replaceAll(",", "");
							if (StringUtil.isNotBlank(value)) {
								objClass.getClass().getMethod(method, f.getType()).invoke(objClass,
										Long.parseLong(value));
							}
						}

						if (f.getType().getTypeName().equals("java.lang.Integer")
								|| f.getType().getTypeName().equals("int")) {
							value = value.replaceAll(",", "");
							if (StringUtil.isNotBlank(value)) {
								objClass.getClass().getMethod(method, f.getType()).invoke(objClass,
										Integer.parseInt(value));
							}
						}

						if (f.getType().getTypeName().equals("java.lang.Double")
								|| f.getType().getTypeName().equals("double")) {
							value = value.replaceAll(",", "");
							if (StringUtil.isNotBlank(value)) {
								objClass.getClass().getMethod(method, f.getType()).invoke(objClass,
										Double.parseDouble(value));
							}
						}

						if (f.getType().getTypeName().equals("java.lang.Boolean")
								|| f.getType().getTypeName().equals("boolean")) {
							objClass.getClass().getMethod(method, f.getType()).invoke(objClass,
									Boolean.parseBoolean(value));
						}

						if (f.getType().getTypeName().equals("java.sql.Timestamp")) {
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);

							if (value.length() == 10) {
								sdf.applyPattern("yyyy-MM-dd");
							} else if (value.length() == 19) {
								if (!DateUtil.isTime(value.substring(11))) {
									throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
								}
							} else if (value.length() == 21) {
								if (StringUtil.equals("T", value.substring(10, 11))) {
									sdf.applyPattern("yyyy-MM-dd'T'HH:mm:ss.S");
								} else {
									sdf.applyPattern("yyyy-MM-dd HH:mm:ss.S");
								}
								if (!DateUtil.isTime(value.substring(11, 19))) {
									throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
								}
							} else if (value.length() == 22) {
								if (StringUtil.equals("T", value.substring(10, 11))) {
									sdf.applyPattern("yyyy-MM-dd'T'HH:mm:ss.SS");
								} else {
									sdf.applyPattern("yyyy-MM-dd HH:mm:ss.SS");
								}
								if (!DateUtil.isTime(value.substring(11, 19))) {
									throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
								}
							} else if (value.length() == 23) {
								if (StringUtil.equals("T", value.substring(10, 11))) {
									sdf.applyPattern("yyyy-MM-dd'T'HH:mm:ss.SSS");
								} else {
									sdf.applyPattern("yyyy-MM-dd HH:mm:ss.SSS");
								}
								if (!DateUtil.isTime(value.substring(11, 19))) {
									throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
								}
							} else {
								throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
							}
							
							Date date = sdf.parse(value);
							if (date != null) {
								objClass.getClass().getMethod(method, f.getType()).invoke(objClass,
										new Timestamp(date.getTime()));
							}
							
						}
					}
				}
			} catch (SecurityException | IllegalArgumentException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);		
			} catch (ParseException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
			}
		}
	}

	private static void getAllFields(List<Field> fields, Class<?> type) {
		fields.addAll(Arrays.asList(type.getDeclaredFields()));
		if (type.getSuperclass() != null) {
			getAllFields(fields, type.getSuperclass());
		}
	}

	private T createDomainInstance(Class<T> clz) throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Constructor<T> constructor = clz.getConstructor();
		return constructor.newInstance();
	}

	@SuppressWarnings("unused")
	public static String listToJsonString(List<? extends Object> objectList, String[] set) {

		if (set.length == 0)
			return "";

		JSONArray jsonArray = new JSONArray();
		List<Map<String, Object>> listMap = new ArrayList<>();

		for (Object object : objectList) {
			Map<String, Object> map = new HashMap<>();

			try {
				for (int i = 0; i < set.length; i++) {
					map.put(set[i], PropertyUtils.getProperty(object, set[i]) == null ? ""
							: PropertyUtils.getProperty(object, set[i]));
				}
			} catch (Exception e) {
				return "";
			}
			listMap.add(map);
		}

		for (Map<String, Object> jsonItem : listMap) {
			jsonArray.add(jsonItem);
		}

		return jsonArray.toString();
	}

}
