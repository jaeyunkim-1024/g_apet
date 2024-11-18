package framework.common.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;

import org.apache.commons.net.util.Base64;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * Codec 관련 함수 제공
 * 
 * @author valueFactory
 * @since 2015. 06. 12.
 */
public class CodecUtil {

	private CodecUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	public static String encoder(String key, String charset) throws UnsupportedEncodingException {
		String result = "";

		if (key != null && !"".equals(key)) {
			result = new String(Base64.encodeBase64(key.getBytes()), charset);
		}
		return result;
	}

	public static String encoderUTF8(String key) throws UnsupportedEncodingException {
		return encoder(key, "UTF-8");
	}

	public static String decoder(String cipher, String charset) throws UnsupportedEncodingException  {
		String result = "";

		if (cipher != null && !"".equals(cipher)) {
			result = new String(Base64.decodeBase64(cipher.getBytes()), charset);
		}
		return result;
	}

	public static String decoderUTF8(String cipher) throws UnsupportedEncodingException   {

		return decoder(cipher, "UTF-8");
	}

	@SuppressWarnings("rawtypes")
	public static Object encoderAll(Object obj) throws IllegalAccessException, UnsupportedEncodingException  {

		Class cls = obj.getClass();

		Field[] fieldList = cls.getDeclaredFields();

		for (Field field : fieldList) {

			if (field.get(obj) != null && !"".equals(field.get(obj))) {

				//String fieldName = field.getName();
				String fieldValue = (String) field.get(obj);
				String newFieldValue = encoderUTF8(fieldValue);

				if (field.getType() == String.class) {
					field.set(obj, newFieldValue);
				} else if (field.getType() == Integer.class) {
					field.set(obj, Integer.parseInt(newFieldValue));
				} else if (field.getType() == Double.class) {
					field.set(obj, Double.parseDouble(newFieldValue));
				} else if (field.getType() == Long.class) {
					field.set(obj, Long.parseLong(newFieldValue));
				} else if (field.getType() == Byte.class) {
					field.set(obj, Byte.parseByte(newFieldValue));
				} else if (field.getType() == Float.class) {
					field.set(obj, Float.parseFloat(newFieldValue));
				} else if (field.getType() == Short.class) {
					field.set(obj, Short.parseShort(newFieldValue));
				}
			}

		}

		return obj;
	}

	@SuppressWarnings("rawtypes")
	public static Object decoderAll(Object obj) throws IllegalAccessException, UnsupportedEncodingException  {

		Class cls = obj.getClass();

		Field[] fieldList = cls.getDeclaredFields();

		for (Field field : fieldList) {

			if (field.get(obj) != null && !"".equals(field.get(obj))) {

				//String fieldName = field.getName();
				String fieldValue = (String) field.get(obj);
				String newFieldValue = decoderUTF8(fieldValue);

				if (field.getType() == String.class) {
					field.set(obj, newFieldValue);
				} else if (field.getType() == Integer.class) {
					field.set(obj, Integer.parseInt(newFieldValue));
				} else if (field.getType() == Double.class) {
					field.set(obj, Double.parseDouble(newFieldValue));
				} else if (field.getType() == Long.class) {
					field.set(obj, Long.parseLong(newFieldValue));
				} else if (field.getType() == Byte.class) {
					field.set(obj, Byte.parseByte(newFieldValue));
				} else if (field.getType() == Float.class) {
					field.set(obj, Float.parseFloat(newFieldValue));
				} else if (field.getType() == Short.class) {
					field.set(obj, Short.parseShort(newFieldValue));
				}
			}

		}

		return obj;
	}
}
