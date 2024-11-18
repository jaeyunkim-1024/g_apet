package framework.common.util;

import java.security.SecureRandom;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;

import framework.common.constants.CommonConstants;

public class StringUtil {

	private StringUtil() {
		throw new IllegalStateException("Utility class");
	}

	/**
	 * strTarget이 null 이거나 화이트스페이스 일 경우 strDest을 반환한다.
	 * 
	 * @param strTarget 대상 문자열
	 * @param strDest   대체 문자열
	 * @return strTarget이 null 이거나 화이트스페이스 일 경우 strDest 문자열로 반환
	 */
	public static String nvl(String strTarget, String strDest) {
		String retValue = null;

		if (strTarget == null || "".equals(strTarget)) {
			retValue = strDest;
		} else {
			retValue = strTarget;
		}
		return retValue;
	}

	/**
	 * strTarget이 null 이거나 화이트스페이스 일 경우 화이트스페이스로 반환한다.
	 * 
	 * @param strTarget 대상문자열
	 * @return strTarget이 null 이거나 화이트스페이스 일 경우 화이트스페이스로 반환
	 */
	public static String nvl(String strTarget) {
		return nvl(strTarget, "");
	}

	/**
	 * 대상문자열이 null 인지 여부 확인하기
	 * 
	 * @paramstrTarget 대상 문자열
	 * @return null 여부
	 */
	public static boolean isNull(String strTarget) {
		boolean retValue = false;

		if (strTarget == null) {
			retValue = true;
		}
		else {
			retValue = false;
		}

		return retValue;
	}

	/**
	 * 대상 문자열이 지정한 길이보다 길 경우 지정한 길이만큼 잘라낸 문자열 반환하기
	 * 
	 * @param strTarget 대상 문자열
	 * @param nLimit    길이
	 * @param bDot      잘린 문자열이 존재할 경우 ... 표시 여부
	 * @return 대상 문자열이 지정한 길이보다 길 경우 지정한 길이만큼 잘라낸 문자열
	 */
	@SuppressWarnings("cast")
	public static String cutText(String strTarget, int nLimit, boolean bDot) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		String retValue = null;

		int nLen = strTarget.length();
		int nTotal = 0;
		int nHex = 0;

		String strDot = "";

		if (bDot) {
			strDot = "...";
		}

		for (int i = 0; i < nLen; i++) {
			nHex = (int) strTarget.charAt(i);
			nTotal += Integer.toHexString(nHex).length() / 2;

			if (nTotal > nLimit) {
				retValue = strTarget.substring(0, i) + strDot;
				break;
			} else if (nTotal == nLimit) {
				if (i == (nLen - 1)) {
					retValue = strTarget.substring(0, i - 1) + strDot;
					break;
				}
				retValue = strTarget.substring(0, i + 1) + strDot;
				break;
			} else {
				retValue = strTarget;
			}
		}

		return retValue;
	}

	/**
	 * 대상문자열에 지정한 문자가 위치한 위치 값을 반환하기(대소문자 무시)
	 * 
	 * @param strTarget 대상 문자열
	 * @param strDest   찾고자 하는 문자열
	 * @param nPos      시작 위치
	 * @return 대상문자열에 지정한 문자가 위치한 위치 값을 반환
	 */
	public static int indexOfIgnore(String strTarget, String strDest, int nPos) {
		if (strTarget == null || strTarget.equals("")) {
			return -1;
		}

		strTarget = strTarget.toLowerCase();
		strDest = strDest.toLowerCase();

		return strTarget.indexOf(strDest, nPos);
	}

	/**
	 * 대상문자열에 지정한 문자가 위치한 위치 값을 반환하기(대소문자 무시)
	 * 
	 * @param strTarget 대상 문자열
	 * @param strDest   찾고자 하는 문자열
	 * @return 대상문자열에 지정한 문자가 위치한 위치 값을 반환
	 */
	public static int indexOfIgnore(String strTarget, String strDest) {
		return indexOfIgnore(strTarget, strDest, 0);
	}

	/**
	 * 대상 문자열 치환하기
	 * 
	 * @param strTarget   대상문자열
	 * @param strOld      찾고자 하는 문자열
	 * @param strNew      치환할 문자열
	 * @param bIgnoreCase 대소문자 구분 여부
	 * @param bOnlyFirst  한 번만 치환할지 여부
	 * @return 치환한 문자열
	 */
	public static String replace(String strTarget, String strOld, String strNew, boolean bIgnoreCase,
			boolean bOnlyFirst) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		StringBuilder objDest = new StringBuilder("");
		int nLen = strOld.length();
		int strTargetLen = strTarget.length();
		int nPos = 0;
		int nPosOld = 0;

		if (bIgnoreCase) { // 대소문자 구분하지 않을 경우
			while ((nPos = indexOfIgnore(strTarget, strOld, nPosOld)) >= 0) {
				objDest.append(strTarget.substring(nPosOld, nPos));
				objDest.append(strNew);
				nPosOld = nPos + nLen;
				if (bOnlyFirst) // 한번만 치환할시
					break;
			}
		} else { // 대소문자 구분하는 경우
			while ((nPos = strTarget.indexOf(strOld, nPosOld)) >= 0) {
				objDest.append(strTarget.substring(nPosOld, nPos));
				objDest.append(strNew);
				nPosOld = nPos + nLen;
				if (bOnlyFirst)
					break;
			}
		}

		if (nPosOld < strTargetLen) {
			objDest.append(strTarget.substring(nPosOld, strTargetLen));
		}

		return objDest.toString();
	}

	/**
	 * 대상 문자열 치환하기
	 * 
	 * @param strTarget 대상문자열
	 * @param strOld    찾고자 하는 문자열
	 * @param strNew    치환할 문자열
	 * @return 치환된 문자열
	 */
	public static String replaceAll(String strTarget, String strOld, String strNew) {
		return replace(strTarget, strOld, strNew, false, false);
	}

	/**
	 * 각종 구분자 제거하기
	 * 
	 * @param strTarget 대상문자열
	 * @return String 구분자가 제거된 문자열
	 */
	public static String removeFormat(String strTarget) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		return strTarget.replaceAll("[$|^|*|+|?|/|:|\\-|,|.|\\s]", "");
	}

	/**
	 * 콤마 제거하기
	 * 
	 * @param strTarget 대상 문자열
	 * @return String 콤마가 제거된 문자열
	 */
	public static String removeComma(String strTarget) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		return strTarget.replaceAll("[,|\\s]", "");
	}

	/**
	 * 값 채우기
	 * 
	 * @param strTarget 대상 문자열
	 * @param strDest   채워질 문자열
	 * @param nSize     총 문자열 길이
	 * @param bLeft     채워질 문자의 방향이 좌측인지 여부
	 * @return 지정한 길이만큼 채워진 문자열
	 */
	public static String padValue(String strTarget, String strDest, int nSize, boolean bLeft) {
		if (strTarget == null) {
			return strTarget;
		}

		String retValue = null;

		StringBuilder objSB = new StringBuilder();

		int nLen = strTarget.length();
		int nDiffLen = nSize - nLen;
		for (int i = 0; i < nDiffLen; i++) {
			objSB.append(strDest);
		}

		if (bLeft) {	// 채워질 문자열의 방향이 좌측일 경우
			retValue = objSB.toString() + strTarget;
		}
		else {				// 채워질 문자열의 방향이 우측일 경우
			retValue = strTarget + objSB.toString();
		}

		return retValue;
	}

	/**
	 * 좌측으로 값 채우기
	 * 
	 * @param strTarget 대상 문자열
	 * @param strDest   채워질 문자열
	 * @param nSize     총 문자열 길이
	 * @return 채워진 문자열
	 */
	public static String padLeft(String strTarget, String strDest, int nSize) {
		return padValue(strTarget, strDest, nSize, true);
	}

	/**
	 * 좌측에 공백 채우기
	 * 
	 * @param strTarget 대상 문자열
	 * @param nSize     총 문자열 길이
	 * @return 채워진 문자열 길이
	 */
	public static String padLeft(String strTarget, int nSize) {
		return padValue(strTarget, " ", nSize, true);
	}

	/**
	 * 우측으로 값 채우기
	 * 
	 * @param strTarget 대상문자열
	 * @param strDest   채워질 문자열
	 * @param nSize     총 문자열 길이
	 * @return 채워진 문자열 길이
	 */
	public static String padRight(String strTarget, String strDest, int nSize) {
		return padValue(strTarget, strDest, nSize, false);
	}

	/**
	 * 우측으로 공백 채우기
	 * 
	 * @param strTarget 대상문자열
	 * @param nSize     총 문자열 길이
	 * @return 채워진 문자열
	 */
	public static String padRight(String strTarget, int nSize) {
		return padValue(strTarget, " ", nSize, false);
	}

	/**
	 * 대상 문자열을 금액형 문자열로 변환하기
	 * 
	 * @param strTarget 대상 문자열
	 * @return 금액형 문자열
	 */
	@SuppressWarnings("null")
	public static String formatMoney(String strTarget) {
		if (strTarget == null || strTarget.trim().length() == 0) {
			return "0";
		}

		strTarget = removeComma(strTarget);

		String strSign = strTarget.substring(0, 1);
		if (strSign.equals("+") || strSign.equals("-")) {	// 부호가 존재할 경우
			strSign = strTarget.substring(0, 1);
			strTarget = strTarget.substring(1);
		} else {
			strSign = "";
		}

		String strDot = "";
		if (strTarget.indexOf('.') != -1) {					// 소숫점이 존재할 경우
			int nPosDot = strTarget.indexOf('.');
			strDot = strTarget.substring(nPosDot, strTarget.length());
			strTarget = strTarget.substring(0, nPosDot);
		}

		StringBuilder objSB = new StringBuilder(strTarget);
		int nLen = strTarget.length();
		for (int i = nLen; 0 < i; i -= 3) {					// Comma 단위
			objSB.insert(i, ",");
		}
		return strSign + objSB.substring(0, objSB.length() - 1) + strDot;
	}

	/**
	 * 대상문자열의 소숫점 설정하기
	 *
	 * @param strTarget 대상문자열
	 * @param nDotSize  소숫점 길이
	 * @return
	 */
	public static String round(String strTarget, int nDotSize) {
		if (strTarget == null || strTarget.trim().length() == 0) {
			return strTarget;
		}

		String strDot = null; 

		int nPosDot = strTarget.indexOf('.');
		if (nPosDot == -1) {		// 소숫점이 존재하지 않을 경우
			strDot = (nDotSize == 0) ? padValue("", "0", nDotSize, false) : "." + padValue("", "0", nDotSize, false);
		} else {					// 소숫점이 존재할 경우

			String strDotValue = strTarget.substring(nPosDot + 1);	// 소숫점 이하 값
			strTarget = strTarget.substring(0, nPosDot);			// 정수 값

			if (strDotValue.length() >= nDotSize) {		// 실제 소숫점 길이가 지정한 길이보다 크다면 지정한 소숫점 길이 만큼 잘라내기
				strDot = "." + strDotValue.substring(0, nDotSize);
			} else {									// 실제 소숫점길이가 지정한 길이보다 작다면 지정한 길이만큼 채우기
				strDot = "." + padValue(strDotValue, "0", nDotSize, false);
			}
		}
		return strTarget + strDot;
	}

	/**
	 * 대상 문자열을 날짜 포멧형 문자열로 변환하기
	 * 
	 * @param strTarget 대상 문자열
	 * @return 날짜 포멧 문자열로 변환하기
	 */
	public static String formatDate(String strTarget) {
		String strValue = removeFormat(strTarget);
		
		if (strValue != null && strValue.length() != 8) {
			return strTarget;
		}

		StringBuilder objSB = new StringBuilder(strValue);
		objSB.insert(4, "-");
		objSB.insert(7, "-");

		return objSB.toString();
	}

	/**
	 * 대상 문자열을 주민등록번호 포멧 문자열로 변환하기
	 * 
	 * @param strTarget 대상 문자열
	 * @return 주민등록번호 포멧 문자열
	 */
	public static String formatJuminID(String strTarget) {
		String strValue = removeFormat(strTarget);

		if (strValue != null && strValue.length() != 13) {
			return strTarget;
		}

		StringBuilder objSB = new StringBuilder(strValue);
		objSB.insert(6, "-");

		return objSB.toString();
	}

	/**
	 * 대상 문자열을 전화번호 포멧 문자열로 변환하기
	 * 
	 * @param strTarget 대상문자열
	 * @return 전화번호 포멧 문자열
	 */
	public static String formatPhone(String strTarget) {
		if(strTarget == null) {
			return null;
		}
		String strValue = removeFormat(strTarget);
		int nLength = strValue != null ? strValue.length() : 0;

		if (nLength < 9 || nLength > 12) { // 9 ~ 12 占쏙옙' 占쏙옙占쏙옙 占쏙옙占�
			return strTarget;
		}

		StringBuilder objSB = new StringBuilder(strValue);

		// 서울지역일 경우
		if ( strValue.startsWith("02")) {	
			if (nLength == 9) {
				objSB.insert(2, "-");
				objSB.insert(6, "-");
			} else {
				objSB.insert(2, "-");
				objSB.insert(7, "-");
			}
		}
		// 서울외 지역 또는 휴대폰 일 경우
		else {
			if (nLength == 10) {
				objSB.insert(3, "-");
				objSB.insert(7, "-");
			}
			// 내선번호등과 같은 특수 번호일 경우
			else { 
				objSB.insert(3, "-");
				objSB.insert(8, "-");
			}
		}
		return objSB.toString();
	}

	/**
	 * <pre>숫자형 문자열에 콤마 추가하기</pre>
	 * 
	 * @param strTarget
	 * @return
	 */
	public static String formatNum(String strTarget) {
		String amtStr = "";

		if (strTarget != null && !"".equals(strTarget)) {
			DecimalFormat df = new DecimalFormat("#,###");
			amtStr = df.format(Long.parseLong(strTarget));
		} else {
			amtStr = "0";
		}

		return amtStr;
	}

	/**
	 * 대상문자열을 우편번호 포멧형식으로 변환하기
	 * 
	 * @param strTarget 대상문자열
	 * @return 우편번호 포멧형 문자열
	 */
	public static String formatPost(String strTarget) {
		String strValue = removeFormat(strTarget);

		if (strValue != null && strValue.length() != 6) {
			return strTarget;
		}

		StringBuilder objSB = new StringBuilder(strValue);
		objSB.insert(3, "-");

		return objSB.toString();
	}

	/**
	 * 문자열 Byte Length 구하기(EUC-KR)
	 * 
	 * @param str
	 * @return
	 */
	public static int getByteLength(String str) {

		int strLength = 0;

		char[] tempChar = new char[str.length()];

		for (int i = 0; i < tempChar.length; i++) {
			tempChar[i] = str.charAt(i);

			if (tempChar[i] < 128) {
				strLength++;
			} else {
				strLength += 2;
			}
		}

		return strLength;
	}

	/**
	 * HTML 태그 제거하기
	 * 
	 * @param strTarget 대상문자열
	 * @return 태그가 제거된 문자열
	 */
	public static String removeHTML(String strTarget) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		return strTarget.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	/**
	 * HTML 태그 제거하기
	 * 
	 * @param strTarget 대상문자열
	 * @return 태그가 제거된 문자열
	 */
	public static String removeHTMLAttr(String strTarget, String attrName) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		return strTarget.replaceAll(attrName + "=(\"|\')?([^\"\']+)(\"|\')?", "");
	}

	/**
	 * HTML을 캐리지 리턴 값으로 변환하기
	 * 
	 * @param strTarget 대상 문자열
	 * @return HTML을 캐리지 리턴값으로 반환한 문자열
	 */
	public static String encodingHTML(String strTarget) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		strTarget = strTarget.replaceAll("<br>", "\r\n");
		strTarget = strTarget.replaceAll("<q>", "'");
		strTarget = strTarget.replaceAll("&quot;", "\"");
		
		return strTarget;
	}

	/**
	 * 캐리지리턴값을 HTML 태그로 변환하기
	 * 
	 * @param strTarget 대상 문자열
	 * @return 캐리지 리턴값을 HTML 태그로 변환한 문자열
	 */
	public static String decodingHTML(String strTarget) {
		if (strTarget == null || strTarget.equals("")) {
			return strTarget;
		}

		strTarget = strTarget.replaceAll("\r\n", "<br/>");
		strTarget = strTarget.replaceAll("\n", "<br/>");
		strTarget = strTarget.replaceAll("\u0020", "&nbsp;");
		strTarget = strTarget.replaceAll("'", "<q>");
		strTarget = strTarget.replaceAll("\"", "&quot;");
		
		return strTarget;
	}

	/**
	 * <pre>
	 * 문자열(String)을 카멜표기법으로 표현한다.
	 *
	 * StringUtils.toUnCamelCase("ItemCode") = "ITEM_CODE"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return 카멜표기법을 일반 디비 문자열
	 */
	public static String toUnCamelCase(String str) {
		// 숫자가 있는 경우 제대로 변환이 안되므로 수정
		// String regex = "([a-z])([A-Z])";
		// String replacement = "$1_$2";
		String regex = "([a-z\\d]+)(?=([A-Z][a-z\\d]+))";
		String replacement = "$1_";

		String value = "";
		value = str.replaceAll(regex, replacement).toUpperCase();
		return value;
	}

	/**
	 * <pre>
	 * 문자열(String)을 카멜표기법으로 표현한다.
	 * 
	 * StringUtils.toCamelCase("ITEM_CODE", true)  = "ItemCode"
	 * StringUtils.toCamelCase("ITEM_CODE", false) = "itemCode"
	 * </pre>
	 *
	 * @param str                     문자열
	 * @param firstCharacterUppercase 첫문자열을 대문자로 할지 여부
	 * @return 카멜표기법으로 표현환 문자열
	 */
	public static String toCamelCase(String str, boolean firstCharacterUppercase) {
		if (str == null) {
			return null;
		}

		StringBuilder sb = new StringBuilder();

		boolean nextUpperCase = false;
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);

			if (c == '_') {
				if (sb.length() > 0) {
					nextUpperCase = true;
				}
			} else {
				if (nextUpperCase) {
					sb.append(Character.toUpperCase(c));
					nextUpperCase = false;
				} else {
					sb.append(Character.toLowerCase(c));
				}
			}
		}

		if (firstCharacterUppercase) {
			sb.setCharAt(0, Character.toUpperCase(sb.charAt(0)));
		}
		return sb.toString();
	}

	/**
	 * <pre>
	 * 문자열(String)을 카멜표기법으로 표현한다.
	 * 
	 * StringUtils.toCamelCase("ITEM_CODE") = "itemCode"
	 * </pre>
	 *
	 * @param str 문자열
	 * @return 카멜표기법으로 표현환 문자열
	 */
	public static String toCamelCase(String str) {
		return toCamelCase(str, false);
	}
	
	/**
	 * <pre>
	 * String 문자열1, String 문자열2 비교
	 * </pre>
	 * @param str1 비교 문자열1
	 * @param str2 비교 문자열2
	 * @return
	 */
	public static boolean equals(String str1, String str2) {		
		return StringUtils.isEmpty(str1) ? false : ( StringUtils.isEmpty(str2) ? false : StringUtils.equals(str1, str2) );
	}

	/**
	 * 대상문자열이 null 인지 여부 확인하기
	 * 
	 * @paramstrTarget 대상 문자열
	 * @return null 여부
	 */
	public static boolean isEmpty(Object obj) {
		return ((obj == null) || ("".equals(obj)));
	}

	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}

	public static boolean isEmpty(String str) {
		return StringUtils.isEmpty(str);
	}

	public static boolean isNotEmpty(String str) {
		return StringUtils.isNotEmpty(str);
	}

	public static boolean isBlank(String str) {
		return StringUtils.isBlank(str);
	}

	public static boolean isNotBlank(String str) {
		return StringUtils.isNotBlank(str);
	}

	public static boolean isNumeric(String str) {
		return StringUtils.isNumeric(str);
	}

	public static boolean isNumericSpace(String str) {
		return StringUtils.isNumericSpace(str);
	}

	public static String[] splitEnter(String str) {
		return StringUtils.split(str, "\r\n");
	}

	public static String unSplit(String[] str, String separatorChars) {
		StringBuilder result = new StringBuilder();
		if (str != null && str.length > 0) {
			for (int i = 0; i < str.length; i++) {
				if (i > 0) {
					result.append(separatorChars);
				}
				result.append(str[i]);
			}
		}

		return result.toString();
	}

	public static String[] split(String str, String separatorChars) {
		return StringUtils.split(str, separatorChars);
	}

	/**
	 * <pre>입력받은 숫자 자리수만큼의 숫자를 리턴한다.</pre>
	 * 
	 * @param length 랜덤으로 생성할 문자열 길이
	 * @return 입력받은 파라메터 길이만큼 랜덤한 0-9까지의 문자열
	 * </pre>
	 */
	public static String randomNumeric(int length) {
		return RandomStringUtils.randomNumeric(length);
	}

	/**
	 * <pre>128bit Random UiqueID를 생성한다.</pre>
	 * 
	 * @return
	 */
	public static String getUniqueId() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public static <T> boolean isEmpty(List<T> list) {
		if (list == null || list.isEmpty()) {
			return true;
		}
		
		return false;
	}

	public static String phoneNumber(String s) {
		if (isEmpty(s)) {
			return "";
		} 
		
		String result = "";
		if (s.length() == 9) {
			result = s.substring(0, 2) + "-" + s.substring(2, 5) + "-" + s.substring(5);
		} else if (s.length() == 10) {
			if ("02".equals(s.substring(0, 2))) {
				result = s.substring(0, 2) + "-" + s.substring(2, 6) + "-" + s.substring(6);
			} else {
				result = s.substring(0, 3) + "-" + s.substring(3, 6) + "-" + s.substring(6);
			}
		} else if (s.length() == 11) {
			result = s.substring(0, 3) + "-" + s.substring(3, 7) + "-" + s.substring(7);
		} else if (s.length() == 12) {
			result = s.substring(0, 4) + "-" + s.substring(4, 8) + "-" + s.substring(8);
		}
		return result;
	}

	public static String bizNo(String s) {
		if (isEmpty(s)) {
			return "";
		} 
		
		if (s.length() == 10) {
			return s.substring(0, 3) + "-" + s.substring(3, 5) + "-" + s.substring(5);
		} 
		
		return s;
	}

	/**
	 * <pre>한글 문자열의 초성코드 추출</pre>
	 * 
	 * @param str
	 * @return
	 */
	public static String getInitCharKoCode(String str) {
		String cd = "";

		if (isEmpty(str)) {
			cd = "";
		} else {
			char strAt = str.charAt(0);

			int first = (strAt - 44032) / (21 * 28);

			switch (first) {
			case 0:
				cd = CommonConstants.INIT_CHAR_K1;
				break;
			case 1:
				cd = CommonConstants.INIT_CHAR_K1;
				break;
			case 2:
				cd = CommonConstants.INIT_CHAR_K2;
				break;
			case 3:
				cd = CommonConstants.INIT_CHAR_K3;
				break;
			case 4:
				cd = CommonConstants.INIT_CHAR_K3;
				break;
			case 5:
				cd = CommonConstants.INIT_CHAR_K4;
				break;
			case 6:
				cd = CommonConstants.INIT_CHAR_K5;
				break;
			case 7:
				cd = CommonConstants.INIT_CHAR_K6;
				break;
			case 8:
				cd = CommonConstants.INIT_CHAR_K6;
				break;
			case 9:
				cd = CommonConstants.INIT_CHAR_K7;
				break;
			case 10:
				cd = CommonConstants.INIT_CHAR_K7;
				break;
			case 11:
				cd = CommonConstants.INIT_CHAR_K8;
				break;
			case 12:
				cd = CommonConstants.INIT_CHAR_K9;
				break;
			case 13:
				cd = CommonConstants.INIT_CHAR_K9;
				break;
			case 14:
				cd = CommonConstants.INIT_CHAR_K10;
				break;
			case 15:
				cd = CommonConstants.INIT_CHAR_K11;
				break;
			case 16:
				cd = CommonConstants.INIT_CHAR_K12;
				break;
			case 17:
				cd = CommonConstants.INIT_CHAR_K13;
				break;
			case 18:
				cd = CommonConstants.INIT_CHAR_K14;
				break;
			default:
				cd = "";
			}

		}

		return cd;
	}

	/**
	 * <pre>영문 문자열의 초성 코드 추출</pre>
	 * 
	 * @param str
	 * @return
	 */
	public static String getInitCharEnCode(String str) {
		String cd = "";

		if (isEmpty(str)) {
			cd = "";
		} else {
			String firstStr = str.substring(0, 1).toUpperCase();

			switch (firstStr) {
			case "A":
				cd = CommonConstants.INIT_CHAR_E1;
				break;
			case "B":
				cd = CommonConstants.INIT_CHAR_E2;
				break;
			case "C":
				cd = CommonConstants.INIT_CHAR_E3;
				break;
			case "D":
				cd = CommonConstants.INIT_CHAR_E4;
				break;
			case "E":
				cd = CommonConstants.INIT_CHAR_E5;
				break;
			case "F":
				cd = CommonConstants.INIT_CHAR_E6;
				break;
			case "G":
				cd = CommonConstants.INIT_CHAR_E7;
				break;
			case "H":
				cd = CommonConstants.INIT_CHAR_E8;
				break;
			case "I":
				cd = CommonConstants.INIT_CHAR_E9;
				break;
			case "J":
				cd = CommonConstants.INIT_CHAR_E10;
				break;
			case "K":
				cd = CommonConstants.INIT_CHAR_E11;
				break;
			case "L":
				cd = CommonConstants.INIT_CHAR_E12;
				break;
			case "M":
				cd = CommonConstants.INIT_CHAR_E13;
				break;
			case "N":
				cd = CommonConstants.INIT_CHAR_E14;
				break;
			case "O":
				cd = CommonConstants.INIT_CHAR_E15;
				break;
			case "P":
				cd = CommonConstants.INIT_CHAR_E16;
				break;
			case "Q":
				cd = CommonConstants.INIT_CHAR_E17;
				break;
			case "R":
				cd = CommonConstants.INIT_CHAR_E18;
				break;
			case "S":
				cd = CommonConstants.INIT_CHAR_E19;
				break;
			case "T":
				cd = CommonConstants.INIT_CHAR_E20;
				break;
			case "U":
				cd = CommonConstants.INIT_CHAR_E21;
				break;
			case "V":
				cd = CommonConstants.INIT_CHAR_E22;
				break;
			case "W":
				cd = CommonConstants.INIT_CHAR_E23;
				break;
			case "X":
				cd = CommonConstants.INIT_CHAR_E24;
				break;
			case "Y":
				cd = CommonConstants.INIT_CHAR_E25;
				break;
			case "Z":
				cd = CommonConstants.INIT_CHAR_E26;
				break;
			default:
				cd = "";
			}

		}

		return cd;
	}

	public static String recoPickRegularEx(String strData) {
		String str = "";

		str = strData.replaceAll("\"id\"", "id");
		str = str.replaceAll("\"count\"", "count");
		str = str.replaceAll("\"total_sales\"", "total_sales");
		str = str.replaceAll("\\[", "");
		str = str.replaceAll("\\]", "");
		str = str.replaceAll("\"", "\'");
		
		return str;

	}

	public static String arrayToStr(Object paramStr) {
		if (paramStr == null || "".equals(paramStr)) {
			return "";
		}
		StringBuilder result = new StringBuilder();
		String[] pStr = paramStr.toString().split(",");
		if (pStr == null || pStr.length == 0) {
			return paramStr.toString();
		}

		for (int i = 0; i < pStr.length; i++) {
			result.append("'" + pStr[i] + "'");
			if (i < pStr.length - 1)
				result.append(",");
		}
		return result.toString();
	}

	/**
	 * <pre>한글에 조사 붙이기</pre>
	 * 
	 * @param name
	 * @param firstValue
	 * @param secondValue
	 * @return
	 */
	public static String getCompleteWordJosa(String name, String firstValue, String secondValue) {
		char lastName = name.charAt(name.length() - 1);

		// 한글의 제일 처음과 끝의 범위밖일 경우
		if (lastName < 0xAC00 || lastName > 0xD7A3) {
			return name;
		}

		String seletedValue = secondValue;

		if ((lastName - 0xAC00) % 28 > 0) {
			seletedValue = firstValue;
		}

		return name + seletedValue;
	}

	/**
	 * <pre>문자열 마스킹</pre>
	 * 
	 * @param strText
	 * @param startIndex
	 * @param endIndex
	 * @param maskChar
	 * @return
	 */
	public static String masking(String strText, int startIndex, int endIndex, char maskChar) {
		if (StringUtils.isBlank(strText)) {
			return "";
		}

		if (startIndex < 0) {
			startIndex = 0;
		}

		if (endIndex > strText.length()) {
			endIndex = strText.length();
		}

		if (startIndex > endIndex) {
			return strText;
		}

		int maskLength = endIndex - startIndex;

		if (maskLength == 0) {
			return strText;
		}

		int m = 0;
		StringBuilder sb = new StringBuilder(maskLength);

		for (m = 0; m < maskLength; m++) {
			sb.append(maskChar);
		}

		return strText.substring(0, startIndex) + sb.toString() + strText.substring(startIndex + maskLength);
	}

	/**
	 * <pre>NICE 제공함수</pre>
	 *
	 * @Method Name : requestReplace
	 * @param paramValue
	 * @param gubun
	 * @return String
	 */
	public static String requestReplace(String paramValue, final String gubun) {
		String result = "";

		if (paramValue != null) {
			paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

			paramValue = paramValue.replaceAll("\\*", "");
			paramValue = paramValue.replaceAll("\\?", "");
			paramValue = paramValue.replaceAll("\\[", "");
			paramValue = paramValue.replaceAll("\\{", "");
			paramValue = paramValue.replaceAll("\\(", "");
			paramValue = paramValue.replaceAll("\\)", "");
			paramValue = paramValue.replaceAll("\\^", "");
			paramValue = paramValue.replaceAll("\\$", "");
			paramValue = paramValue.replaceAll("'", "");
			paramValue = paramValue.replaceAll("@", "");
			paramValue = paramValue.replaceAll("%", "");
			paramValue = paramValue.replaceAll(";", "");
			paramValue = paramValue.replaceAll(":", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll("#", "");
			paramValue = paramValue.replaceAll("--", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll(",", "");

			if ( "encodeData".equals(gubun)) {
				paramValue = paramValue.replaceAll("\\+", "");
				paramValue = paramValue.replaceAll("/", "");
				paramValue = paramValue.replaceAll("=", "");
			}

			result = paramValue;

		}
		return result;
	}

	/**
	 * 비밀번호 정책 적용 - 임시 비밀번호
	 * @param size
	 * @return password
	 */
	public static String temporaryPassword(int size) {
		StringBuffer buffer = new StringBuffer();
		SecureRandom random = new SecureRandom();

		//String chars1[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
		String chars1[] = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
		String chars2[] = "0,1,2,3,4,5,6,7,8,9".split(",");
		String chars3[] = "!,@,#,$,%,^,&,*".split(",");
		for (int i = 0; i < size; i++) {
			if((i+1)%4 == 1) {
				buffer.append(chars1[random.nextInt(chars1.length)]);
			}else if((i+1)%4 == 2){
				buffer.append(chars1[random.nextInt(chars1.length)]);
			}else if((i+1)%4 == 3){
				buffer.append(chars2[random.nextInt(chars2.length)]);
			}else {
				buffer.append(chars3[random.nextInt(chars3.length)]);
			}
		}
		
		return buffer.toString();
	}
	

	/**
	 * String 태그 추출 (구분)
	 * @param str
	 * @param gb
	 * @return String tags
	 */
	public static List<String> getTags(String str, String gb) {
		// 정규식 - 공백과 구분자만 제외
		//Pattern pattern = Pattern.compile(gb+"[\\d|A-Z|a-z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*", Pattern.CASE_INSENSITIVE); // 대소문자 구분 안함
		if(!StringUtil.equals(gb, "@")) {
			str = str.replaceAll("&#39;", " ");
			str = str.replaceAll("&lt;", " ");
			str = str.replaceAll("&gt;", " ");
			str = str.replaceAll("&amp;", " ");
		}
		Pattern pattern = Pattern.compile(gb+"[^"+gb+"\\s\\@]*", Pattern.CASE_INSENSITIVE); // 대소문자 구분 안함
		// 검색 결과를 Matcher에 저장
        Matcher matcher = pattern.matcher(str);
        List<String> allTags = new ArrayList<String>();
      	while(matcher.find()) {
      		String thisTag = matcher.group().replaceAll(gb, "");
      		if(StringUtil.isNotBlank(thisTag)) {
      			allTags.add(thisTag);
      		}
      	}
      	return allTags;
	}
	
	/**
	 * String 태그 추출
	 * @param String
	 * @return String tags
	 */
	public static List<String> getTags(String str) {		
      	return getTags(str, "#");
	}
	
	/**
	 * String 프로토콜 제거
	 * @param str
	 * @return String tags
	 */
	public static String removeProtocol(String str) {
		str = StringUtils.stripStart(str, "http:");
		str= StringUtils.stripStart(str, "https:");
      	return str;
	}

	/**
	 * 이모티콘 제거
	 */
	public static String removeEmoji(String content) {
//		Pattern emoticons = Pattern.compile("[\\uD83C-\\uDBFF\\uDC00-\\uDFFF]+");
//		Matcher emoticonsMatcher = emoticons.matcher( content );
//		content = emoticonsMatcher.replaceAll("");
//		return content;
        String regex = "[^\\p{L}\\p{N}\\p{P}\\p{Z}]";
        String result = content.replaceAll(regex, "");
        return result;
	}

}
