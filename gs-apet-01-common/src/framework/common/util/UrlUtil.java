package framework.common.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * URL Encoding/Decoding 관련 함수 제공
 * 
 * @author valueFactory
 * @since 2013. 12. 15.
 */
public class UrlUtil {

	private UrlUtil() {
		throw new IllegalStateException("Utility class");
	}

	/**
	 * 단위 객체 Encoding
	 * 
	 * @param String param
	 * @param String encodingType
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws Exception
	 */
	public static String encoder(String param, String encodingType) throws UnsupportedEncodingException{
		return URLEncoder.encode(param, encodingType);
	}

	/**
	 * Object 객체 Encoding 객체안의 String Type만 Encoding한다.
	 * 
	 * @param Object obj
	 * @param String encodingType
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws IllegalAccessException 
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static Object encoderAll(Object obj, String encodingType) throws IllegalAccessException, UnsupportedEncodingException  {

		Class cls = obj.getClass();

		Field[] fieldList = cls.getDeclaredFields();

		for (Field field : fieldList) {
			field.setAccessible(true);
			if (field.get(obj) != null && !"".equals(field.get(obj)) && field.getType() == String.class) {

				String fieldValue = (String) field.get(obj);
				String newFieldValue = URLEncoder.encode(fieldValue, encodingType);
				field.set(obj, newFieldValue);

			}

		}

		return obj;
	}

	/**
	 * 단위 객체 Decoding
	 * 
	 * @param String param
	 * @param String decodingType
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws Exception
	 */
	public static String decoder(String param, String decodingType) throws UnsupportedEncodingException {
		return URLDecoder.decode(param, decodingType);
	}

	/**
	 * Object 객체Decoding 객체안의 String Type만 Decoding한다.
	 * 
	 * @param Object obj
	 * @param String decodingType
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws IllegalAccessException 
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static Object decoderAll(Object obj, String decodingType) throws IllegalAccessException, UnsupportedEncodingException {

		Class cls = obj.getClass();

		Field[] fieldList = cls.getDeclaredFields();

		for (Field field : fieldList) {
			field.setAccessible(true);
			if (field.get(obj) != null && !"".equals(field.get(obj)) && field.getType() == String.class) {

				String fieldValue = (String) field.get(obj);
				String newFieldValue = URLDecoder.decode(fieldValue, decodingType);
				field.set(obj, newFieldValue);

			}

		}

		return obj;
	}
}
