package framework.common.util;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

public class MaskingUtil {

	private MaskingUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}
	
	// 이름
	public static final String REGEX_NAME_KO	= "([가-힣]*)";
	public static final String REGEX_NAME_ENG	= "([a-zA-Z]{1})([a-zA-Z]*)(\\s*)([a-zA-Z]*)"; 
	
	// 전화번호 (-)
	public static final String REGEX_TEL_NO		= "(01{1}\\d{1}|02{1}|0{1}\\d{2})([-]*)(\\d{1,2})(\\d{2})([-]*)(\\d{2})(\\d{2})";

	// email
	public static final String REGEX_EMAIL		= "([a-zA-Z0-9\\w\\._-]*)([a-zA-Z0-9\\w\\._-]{2})@([a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z0-9][a-zA-Z0-9\\.]*[a-zA-Z0-9]$)";
	public static final String MASK_EMAIL		= "$1**@$3";
	
	// 주민번호
	public static final String REGEX_RES_NO		= "(\\d{2})(\\d{2})(\\d{2})([-]*)(\\d{1})(\\d{6})";
	public static final String MASK_RES_NO_2	= "$1****$4*******";
	public static final String MASK_RES_NO_4	= "$1$2**$4*******";
	public static final String MASK_RES_NO_6	= "$1$2$3$4*******";
	public static final String MASK_RES_NO_7	= "$1$2$3$4$5******";
	
	// 생년월일
	public static final String REGEX_BIRTH		= "(\\d{4})([-]*)(\\d{2})([-]*)(\\d{2})";
	public static final String MASK_BIRTH		= "$1$2$3$4**";
	
	// 운전면허 번호
	public static final String REGEX_DRS_LCNS_NO= "([가-힣]*\\s*)(\\d{0,2}[-]*)(\\d{2})([-]*)(\\d{5,6})([-]*)(\\d{2})";
	public static final String MASK_DRS_LCNS_NO	= "$1$2$3$4*****$6$7";
	
	// 사업자/법인번호
	public static final String REGEX_BUSI_NO	= "(\\d{2})(\\d{1})([-]*)(\\d{2})([-]*)(\\d{1})(\\d{4})"; 
	public static final String MASK_BUSI_NO		= "$1*$3**$5$6****";
	
	// QR코드
	public static final String REGEX_QRCODE		= "(\\d{3})([-]*)(\\d{1})([-]*)(\\d{4})([-]*)(\\d{4})"; 
	public static final String MASK_QRCODE		= "$1$2$3$4****$6****";
	
	// IP
	public static final String REGEX_IP			= "(\\d{1,3})([.]{1})(\\d{1,3})([.]{1})(\\d{1,3})([.]{1})(\\d{1,3})"; 
	public static final String MASK_IP			= "$1$2$3$4***$6$7";

	// 전화번호(444)
	public static final String REGEX_TEL_444	= "(\\d{4})(\\d{2})(\\d{2})(\\d{1})(\\d{3})"; 
	public static final String MASK_TEL_444		= "$1$2***$5";
	
	// 카드
	public static final String REGEX_CASH_RECEIPT 	= "([\\d\\*]{4})([-]*)([\\d\\*]{4})([-]*)([\\d\\*]{4})([-]*)([\\d\\*]{6})";
	public static final String MASK_CASH_RECEIPT  	= "$1$2$3$4****$6$7";
	public static final String REGEX_CARD_11 		= "([\\d\\*]{4})([-]*)([\\d\\*]{2})([\\d\\*]{2})([-]*)([\\d\\*]{2})([\\d\\*]{1})";
	public static final String MASK_CARD_11 		= "$1-$3**-**$7";
	public static final char MASK_CHAR = '*';

		
	// 이름 & 영문 이름
	public static String getName(String value){
		//한글자인 이름은 마스킹 하지 않기로 처리 210514
		if(StringUtil.isBlank(value) || value.length() < 2) return value;
		Matcher matcher = Pattern.compile(REGEX_NAME_ENG).matcher(value);
		if(matcher.find()) {
			String replaceTarget = matcher.group(2);
			String secGroupString = "";
			if(replaceTarget != null) { 
				char[] c = new char[(replaceTarget.length() > 1)? (replaceTarget.length()-1) : replaceTarget.length()];
				Arrays.fill(c, MASK_CHAR);
				secGroupString = String.valueOf(c)+((replaceTarget.length() > 1)? replaceTarget.substring(replaceTarget.length()-1) : "");
			}
			return matcher.group(1)+secGroupString+matcher.group(3)+matcher.group(4);
		}else if(Pattern.matches(REGEX_NAME_KO,value)) {
			return getMaskedValue(value,1,2);
		}
		return value;
	}
	
	//  전화번호
	public static String getTelNo(String value) {
		if(StringUtil.isBlank(value)) return value;
		Matcher matcher = Pattern.compile(REGEX_TEL_NO).matcher(value);
		if(matcher.find()) {
			return matcher.group(1)+matcher.group(2)+matcher.group(3)+MASK_CHAR+MASK_CHAR+matcher.group(5)+MASK_CHAR+MASK_CHAR+matcher.group(7);
		}
		return value;
	}

	// 주소
	public static String getAddress(String addr1, String addr2) {
		if(StringUtil.isBlank(addr1+addr2)) return addr1+addr2;
			String addr = ((StringUtil.isBlank(addr1))?"":(addr1.trim())+ " ") + ((StringUtil.isBlank(addr2))?"":addr2);

			// 면,읍,리,동,로,길,가
			int idxMyun = addr.indexOf("면 ");
			int idxUb = addr.indexOf("읍 ");
			int idxRi = addr.indexOf("리 ");
			int idxDong = addr.indexOf("동 ");
			int idxRo = addr.indexOf("로 ");
			int idxGil = addr.indexOf("길 ");
			int idxGa = addr.indexOf("가 ");

			int idxMaskingStart = 0;
			if (idxGa != -1) {
				idxMaskingStart = idxGa;
			} else if (idxRo != -1) {
				idxMaskingStart = idxRo;
			} else if (idxGil != -1) {
				idxMaskingStart = idxGil;
			} else if (idxRi != -1) {
				idxMaskingStart = idxRi;
			} else if (idxUb != -1) {
				idxMaskingStart = idxUb;
			} else if (idxMyun != -1) {
				idxMaskingStart = idxMyun;
			} else if (idxDong != -1) {
				idxMaskingStart = idxDong;
			}
		return getMaskedValue(addr, idxMaskingStart+2, true, false);
	}

	// email
	public static String getEmail(String value) {
		if(StringUtil.isBlank(value)) return value;
		String ret = "";
		int indexAtSign = value.indexOf('@');
		ret = value.replaceAll(REGEX_EMAIL,MASK_EMAIL);
		ret = getMaskedValue(ret,indexAtSign+1,ret.length());
		return ret;
	}

	// 주민번호
	public static String getResNo(String value) {
		return getResNo(value, 6);	// 기본 6자리 노출
	}	
	public static String getResNo(String value, int idx) {
		if(StringUtil.isBlank(value)) return value;
		if(idx == 2) {
			return value.replaceAll(REGEX_RES_NO,MASK_RES_NO_2);
		}else if(idx == 4) {
			return value.replaceAll(REGEX_RES_NO,MASK_RES_NO_4);
		}else if(idx == 7) {
			return value.replaceAll(REGEX_RES_NO,MASK_RES_NO_7);
		}else {
			return value.replaceAll(REGEX_RES_NO,MASK_RES_NO_6);
		}
	}
	
	// 생년월일
	public static String getBirth(String value) {
		if(StringUtil.isBlank(value)) return value;
		return value.replaceAll(REGEX_BIRTH,MASK_BIRTH);
	}	
	
	// 운전면허 번호
	public static String getDrsLcnsNo(String value) {
		if(StringUtil.isBlank(value)) return value;
		return value.replaceAll(REGEX_DRS_LCNS_NO,MASK_DRS_LCNS_NO);
	}	
	
	// 여권번호
	public static String getPrtNo(String value) {
		if(StringUtil.isBlank(value)) return value;
		return getMaskedValue(value, 4, false);
	}	
	
	// 카드
	public static String getCard(String value) {
		if(StringUtil.isBlank(value)) return value;
		String removedDashStr = value.replaceAll("[-]","");
		if(Pattern.matches(REGEX_CASH_RECEIPT,removedDashStr)) {
			return removedDashStr.replaceAll(REGEX_CASH_RECEIPT, MASK_CASH_RECEIPT);
		}else if(Pattern.matches(REGEX_CARD_11,removedDashStr)) {
			return removedDashStr.replaceAll(REGEX_CARD_11, MASK_CARD_11);
		}else {
			char[] strToChar = removedDashStr.toCharArray();
			char[] maskedChar = new char[removedDashStr.length()+Math.floorDiv(removedDashStr.length(),4)];
			int maskedCharCnt = 0;
			for(int i=0; i<strToChar.length ; i++) {
				if(i%4 ==0 && i!=0 ) {
					maskedChar[maskedCharCnt++] = '-';
				}
				if(maskedCharCnt > 4 && maskedCharCnt <15) {
					maskedChar[maskedCharCnt++] = MASK_CHAR;
				}else {
					maskedChar[maskedCharCnt++] = strToChar[i];
				}
			}
			return new String(maskedChar);
		}
	}
	
	// 사업자 등록번호
	public static String getBizNo(String value) {
		if(StringUtil.isBlank(value)) return value;
		return value.replaceAll(REGEX_BUSI_NO, MASK_BUSI_NO);
	}
	
	// 계좌번호
	public static String getBankNo(String value) {
		if(StringUtil.isBlank(value)) return value;
		return getMaskedValue(value,5,value.length());
	}
	
	// QR코드
	public static String getQrcode(String value) {
		if(StringUtil.isBlank(value)) return value;
		return value.replaceAll(REGEX_QRCODE, MASK_QRCODE);
	}
	
	// IP
	public static String getIp(String value) {
		if(StringUtil.isBlank(value)) return value;
		return value.replaceAll(REGEX_IP, MASK_IP);
	}
	
	// ID
	public static String getId(String value) {
		if(StringUtil.isBlank(value)){
			return value;
		}else if(value.matches(REGEX_EMAIL)){
			return getEmail(value);
		}else{
			return getMaskedValue(value, 2, false);
		}
	}
	

	public static String getMaskedValue(String orgValue, int maskLength, boolean dirOption) {
		String result = "";
		if (StringUtil.isNotEmpty(orgValue)) {
			int length = orgValue.length();
			int startIdx = 0;
			int endIdx = 0;
			if (length > 0) {
				StringBuilder sb = new StringBuilder(orgValue);
				if (dirOption) {	// true 앞
					startIdx = 0;
					endIdx = maskLength;
				} else {			// false 뒤
					startIdx = length - maskLength;
					endIdx = length;
				}
				for (int i = startIdx; i < endIdx; i++) {
					sb.setCharAt(i, MASK_CHAR);
				}

				result = sb.toString();
			}
		}
		return result;
	}

	public static String getMaskedValue(String orgValue, int maskLength, boolean dirOption, boolean toggle) {
		String result = "";
		if (StringUtil.isNotEmpty(orgValue)) {
			int length = orgValue.length();
			int startIdx = 0;
			int endIdx = 0;
			if (length > 0) {
				StringBuilder sb = new StringBuilder(orgValue);

				if (dirOption && toggle) {			// true 앞, masking
					startIdx = 0;
					endIdx = maskLength;
				} else if (!dirOption && toggle) {	// false 뒤, masking
					startIdx = length - maskLength;
					endIdx = length;
				} else if (dirOption ) {	// true 앞,나머지를 masking
					startIdx = maskLength;
					endIdx = length;
				} else {	// false 뒤,나머지를 masking
					startIdx = 0;
					endIdx = length - maskLength;
				}

				for (int i = startIdx; i < endIdx; i++) {
					sb.setCharAt(i, MASK_CHAR);
				}
				result = sb.toString();
			}
		}
		return result;
	}

	public static String getMaskedValue(String orgValue, int sidx, int eidx) {
		String result = "";
		if (StringUtil.isNotEmpty(orgValue)) {
			int length = orgValue.length();
			if (length > 0) {
				StringBuilder sb = new StringBuilder(orgValue);

				for (int i = sidx; i < eidx; i++) {
					sb.setCharAt(i, MASK_CHAR);
				}
				result = sb.toString();
			}
		}
		return result;
	}

	public static String getMaskedAll(String orgValue) {
		String result = "";
		if (StringUtil.isNotEmpty(orgValue)) {
			int length = orgValue.length();
			if (length > 0) {
				StringBuilder sb = new StringBuilder(orgValue);

				for (int i = 0; i < length; i++) {
					sb.setCharAt(i, MASK_CHAR);
				}
				result = sb.toString();
			}
		}
		return result;
	}

	public static String getMaskedByValue(String orgValue, int maskLength, boolean dirOption) {
		String result = "";
		int sMaskLength = maskLength;
		if (StringUtil.isNotEmpty(orgValue)) {
			int length = orgValue.length();
			int startIdx = 0;
			int endIdx = 0;
			if (length > 0) {
				StringBuilder sb = new StringBuilder(orgValue);

				if (orgValue.length() < sMaskLength) {
					sMaskLength = orgValue.length();
				}
				if (dirOption) {		// true 앞
					startIdx = 0;
					endIdx = sMaskLength;
				} else {				// false 뒤
					startIdx = length - sMaskLength;
					endIdx = length;
				}
				for (int i = startIdx; i < endIdx; i++) {
					sb.setCharAt(i, MASK_CHAR);
				}
				result = sb.toString();
			}
		}
		return result;
	}
}
