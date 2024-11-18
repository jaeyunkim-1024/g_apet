package biz.app.goods.validation;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

import framework.common.util.StringUtil;

public class ValidationUtil {

	// NotNull 검증
	public static String notNull (String strValue, String key ) {
		String rtnVal = "";

		if (StringUtil.isEmpty(strValue) ) {
			// [%s row] : %s 정보없음
			rtnVal = String.format("<b>[%s]</b> 정보 없음", key);
		}
		return rtnVal;
	}
	
	// NotBlank 검증
	public static String notBlank (String strValue, String key ) {
		String rtnVal = "";

		if (StringUtils.isBlank(strValue) ) {
			// [%s row] : %s 정보없음
			rtnVal = String.format("<b>[%s]</b> 정보 없음", key);
		}
		return rtnVal;
	}

	// NotNull 검증
	public static String notNull (Object strValue, String key ) {
		String rtnVal = "";

		if (StringUtil.isEmpty(strValue) ) {
			// [%s row] : %s 정보없음
			rtnVal = String.format("<b>[%s]</b> 정보 없음", key);
		}
		return rtnVal;
	}

	// Length 검증
	public static String length (String strValue, String key, int length ) {
		return length (strValue, key, length, length);
	}
	public static String length (String strValue, String key, int min, int max) {
		String rtnVal = "";

		if (StringUtil.isEmpty(strValue) ) {
			rtnVal = String.format("<b>[%s]</b> 입력값 없음", key);
			return rtnVal;
		}

		if (min == max && strValue.length() != min) {
			rtnVal = String.format("<b>[%s]</b> 글자수 맞지않음 (%s자)", key, min);
		} else if (min != 0 && strValue.length() < min) {
			rtnVal = String.format("<b>[%s]</b> 글자수 맞지않음 (%s자 이상)", key, min);
		} else if (max != 0 && strValue.length() > max) {
			rtnVal = String.format("<b>[%s]</b> 글자수 맞지않음 (%s자 이하)", key, max);
		}

		return rtnVal;
	}


	// Int 검증
	public static String validInt (String strValue, String key) {
		String rtnVal = "";

		if (StringUtil.isEmpty(strValue) ) {
			rtnVal = String.format("<b>[%s]</b> 입력값 없음", key);
			return rtnVal;
		}

		try {
			Double.valueOf(strValue);
		} catch (NumberFormatException e) {
			rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
		}

		return rtnVal;
	}


	// Digit 검증
	public static String digit (String strValue, String key) {
		String rtnVal = "";

		try {
			if(StringUtil.isEmpty(strValue) ) {
				rtnVal = String.format("<b>[%s]</b> 입력값 없음", key);
				return rtnVal;
			} else {
				if(!StringUtils.isNumeric(strValue)) {
					rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
				}
			}

		} catch (NumberFormatException e) {
			rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
		}

		return rtnVal;
	}


	// Default
	public static String validDefault (String strValue, String defalut) {
		if(StringUtil.isEmpty(strValue) ) {
			return defalut;
		}

		return strValue;
	}


	// IntRange
	public static String digitRange (Double value, String key, int min, int max) {
		String rtnVal = "";

		if (StringUtil.isEmpty(value) ) {
			rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
		} else {
			if (min != 0 && value < min) {
				rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
			}
			if (max != 0 && value > max) {
				rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
			}
		}

		return rtnVal;
	}


	// IntNoError
	public static String intNoError (String strValue) {
		String rtnVal = "";

		if (StringUtil.isEmpty(strValue) ) {
			strValue = "0";
		}

		Double doubleValue = null;
		try {
			doubleValue = Double.valueOf(strValue);
			rtnVal = String.valueOf(doubleValue.intValue());
		} catch (NumberFormatException e) {
			rtnVal = "0";
		}

		return rtnVal;
	}


	// Selective
	public static String selective (String strValue, String key, String[] values) {
		String rtnVal = "";

		if (StringUtil.isEmpty(strValue) ) {
			// 비어있는 값은 확인하지 않음.
			return rtnVal;
		}
		if (!ArrayUtils.contains(values, strValue)) {
			// [%s row] : 잘못된 %
			rtnVal = String.format("<b>[%s]</b> 잘못된 입력값", key);
		}

		return rtnVal;
	}

}
