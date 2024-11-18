package framework.common.util;

import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

@Slf4j
public class DateUtil {

	private DateUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	/**
	 * 현재일자 구하기
	 * 
	 * @return yyyyMMdd
	 */
	public static String getNowDate() {
		return calDate("yyyyMMdd");
	}

	public static String getNowDateTime() {
		return calDate("yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 일자 계산
	 * 
	 * @param date_format
	 * @return
	 */
	public static String calDate(String date_format) {

		DateFormat df = new SimpleDateFormat(date_format);

		Calendar calendar = Calendar.getInstance();

		return df.format(calendar.getTime());
	}

	public static String toDate(String dateFormat) {
		DateFormat df = new SimpleDateFormat(dateFormat);
		Calendar calendar = Calendar.getInstance();
		return df.format(calendar.getTime());
	}

	public static String timeStamp2Str(Timestamp dtm,String dateFormat){
		DateFormat df = new SimpleDateFormat(dateFormat);
		return df.format(dtm);
	}

	public static String addDay(String dateFormat, int addDay) {
		return addData(dateFormat, Calendar.DAY_OF_MONTH, addDay);
	}

	public static String addMonth(String dateFormat, int addMonth) {
		return addData(dateFormat, Calendar.MONTH, addMonth);
	}
	
	public static String addMin(String dateFormat, int addMin) {
		return addMin(dateFormat, Calendar.MINUTE, addMin);
	}

	public static String addData(String dateFormat, int CalendarType, int addMonth) {
		DateFormat df = new SimpleDateFormat(dateFormat);
		Calendar calendar = Calendar.getInstance();
		calendar.add(CalendarType, addMonth);
		return df.format(calendar.getTime());
	}

	public static String addDay(String paramDate, String dateFormat, int addDay) {
		DateFormat df = new SimpleDateFormat(dateFormat);
		Calendar calendar = getCalendar(paramDate);
		if (calendar == null) {
			return StringUtils.EMPTY;
		}
		calendar.add(Calendar.DAY_OF_MONTH, addDay);
		return df.format(calendar.getTime());
	}
	
	/**
	 * 분 더하기 - timestamp
	 * 
	 * @param  date
	 * @param  addMin
	 * @return
	 */
	public static String addMin(String dateFormat, int CalendarType, int addMin) {
		DateFormat df = new SimpleDateFormat(dateFormat);
		Calendar calendar = Calendar.getInstance();
		calendar.add(CalendarType, addMin);
		return df.format(calendar.getTime());
	}
	
	/**
	 * 초 더하기 - timestamp
	 * 
	 * @param  date
	 * @param  second
	 * @return
	 */
	public static Timestamp addSeconds(Timestamp date, int second){
		Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.SECOND, second); 
        return new Timestamp(cal.getTime().getTime());
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

		return StringUtils.substring(strTarget.replaceAll("[$|^|*|+|?|/|:|\\-|,|.|\\s]", ""), 0, 8);
	}

	/**
	 * 월 유효성 채크하기
	 * 
	 * @param strMonth 대상 문자열
	 * @return 1~12 범위의 값이면 true, 그외 값이면 false
	 */
	public static boolean isMonth(String strMonth) {
		if (strMonth == null || strMonth.trim().length() == 0)
			return false;

		boolean retValue = false;
		int nMonth = Integer.parseInt(strMonth);

		if (nMonth >= 1 && nMonth <= 12) {
			retValue = true;
		}

		return retValue;
	}

	/**
	 * 일 유효성 채크하기
	 * 
	 * @param strYYYYMMDD 년월일
	 * @return 일수가 유효한 값이면 true, 유효하지 않는다면 false
	 */
	public static boolean isDay(String strYYYYMMDD) {
		if (strYYYYMMDD == null || strYYYYMMDD.trim().length() == 0)
			return false;

		if (strYYYYMMDD.length() != 8)
			return false;

		int nYear = Integer.parseInt(strYYYYMMDD.substring(0, 4), 10);
		int nMonth = Integer.parseInt(strYYYYMMDD.substring(4, 6), 10) - 1;
		int nDay = Integer.parseInt(strYYYYMMDD.substring(6, 8), 10);

		boolean retValue = false;
		int[] arrLastDay = new int[] { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

		// 윤년일 경우
		if (isLeapYear(nYear)) {
			arrLastDay[1] = 29; // 윤년 2월
		}

		if (nDay >= 1 && nDay <= arrLastDay[nMonth]) {
			retValue = true;
		}

		return retValue;
	}

	/**
	 * 입력한 연도가 윤년인지 채크하기
	 * 
	 * @param nYYYY 연도
	 * @return 해당 연도가 윤년인 경우 true, 윤년이 아닌 경우 false
	 */
	public static boolean isLeapYear(int nYYYY) {
		boolean retValue = false;
		if (((nYYYY % 4 == 0) && (nYYYY % 100 != 0)) || (nYYYY % 400 == 0)) {
			retValue = true;
		}
		
		return retValue;
	}

	/**
	 * 입력한 년월일이 유효한지 채크하기
	 * 
	 * @param strYYYYMMDD 년월일
	 * @return 년월일이 유효하다면 true, 유효하지 않다면 false;
	 */
	public static boolean isDate(String strYYYYMMDD) {
		if (strYYYYMMDD == null || strYYYYMMDD.trim().length() == 0) {
			return false;
		}

		strYYYYMMDD = removeFormat(strYYYYMMDD);

		if (strYYYYMMDD.length() != 8)
			return false;

		String strFormatDate = null;
		SimpleDateFormat objFormat = new SimpleDateFormat("yyyyMMdd");
		try {
			objFormat = new SimpleDateFormat("yyyyMMdd");
			strFormatDate = objFormat.format(objFormat.parse(strYYYYMMDD));
		} catch (ParseException ex) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);
			return false;
		}
		return strYYYYMMDD.equals(strFormatDate);
	}

	/**
	 * 문자열이 유효한 날짜인지 확인
	 * 
	 * @author tigerfive
	 * @param dateString [ yyyyMMdd | yyyyMMddHHmmss ]
	 * @param isAllow8   8자리 문자열 허용 (yyyyMMdd)
	 * @param isAllow14  14자리 문자열 허용 (yyyyMMddHHmmss)
	 * @return boolean
	 */
	@SuppressWarnings("unused")
	public static boolean isDate(String dateString, boolean isAllow8, boolean isAllow14) {
		if (StringUtils.isBlank(dateString)) {
			return false;
		}

		int length = dateString.length();
		if (length != 8 && length != 14) {
			return false;
		}
		if (length == 8 && !isAllow8) {
			return false;
		}
		if (length == 14 && !isAllow14) {
			return false;
		}

		String format = "yyyyMMdd";
		if (length == 14) {
			format = "yyyyMMddHHmmss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date testDate = null;

		try {
			testDate = sdf.parse(dateString);
		} catch (ParseException e) {
			return false;
		}

		return sdf.format(testDate).equals(dateString);
	}

	public static boolean isTime(String sTime) {
		boolean result = false;
		String timeStr = sTime;

		if (StringUtil.isNotBlank(sTime)) {
			if (sTime.length() == 8) {
				timeStr = StringUtils.remove(sTime, ":");
			} else if (sTime.length() > 8) {
				return result;
			}

			Calendar cal = Calendar.getInstance();

			cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(timeStr.substring(0, 2)));
			cal.set(Calendar.MINUTE, Integer.parseInt(timeStr.substring(2, 4)));
			cal.set(Calendar.SECOND, Integer.parseInt(timeStr.substring(4, 6)));

			String hh = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
			String mm = String.valueOf(cal.get(Calendar.MINUTE));
			String ss = String.valueOf(cal.get(Calendar.SECOND));
			String retHH = ("00" + hh).substring(hh.length());
			String retMM = ("00" + mm).substring(mm.length());
			String retSS = ("00" + ss).substring(ss.length());
			String retTime = retHH + retMM + retSS;
			if (timeStr.equals(retTime)) {
				result = true;
			}

			return result;
		} 
		
		return result;
	}

	/**
	 * 입력한 날짜가 미래인지 채크하기
	 * 
	 * @param strYYYYMMDD 년월일 문자열
	 * @return 미래이면 true 과거이면 false
	 */
	public static boolean isFuture(String strYYYYMMDD) {
		boolean retValue = false;

		Calendar objTarget = getCalendar(strYYYYMMDD);
		Calendar objNow = getCalendar();

		if (objNow.after(objTarget)) {
			retValue = true;
		}

		return retValue;
	}

	/**
	 * 입력한 날짜가 과거인지 채크하기
	 * 
	 * @param strYYYYMMDD 년월일 문자열
	 * @return 과거이면 true 미래이면 false
	 */
	public static boolean isPast(String strYYYYMMDD) {
		boolean retValue = false;

		Calendar objTarget = getCalendar(strYYYYMMDD);
		Calendar objNow = getCalendar();

		if (objNow.before(objTarget)) {
			retValue = true;
		}

		return retValue;
	}

	/**
	 * 입력된 문자열(yyyyMMdd 혹은 yyyyMMddHHmmss)이 유효한 기간인지 확인
	 * 
	 * @author tigerfive
	 * @param fromDate [ yyyyMMdd | yyyyMMddHHmmss ]
	 * @param toDate   [ yyyyMMdd | yyyyMMddHHmmss ]
	 * @param length   [ 8 | 14 ]
	 * @return boolean
	 */
	public static Boolean isPeriod(String fromDate, String toDate, int length) {
		if (StringUtils.isBlank(fromDate) || StringUtils.isBlank(toDate) || (length != 8 && length != 14)) {
			return false;
		}

		String fromFormat = (length == 14) ? "yyyyMMddHHmmss" : "yyyyMMdd";
		String toFormat = (length == 14) ? "yyyyMMddHHmmss" : "yyyyMMdd";

		Timestamp from = DateUtil.getTimestamp(fromDate, fromFormat);
		Timestamp to = DateUtil.getTimestamp(toDate, toFormat);

		return from != null && !from.after(to);
	}

	/**
	 * 현재 날짜를 Calendar 타입으로 반환하기
	 * 
	 * @return 현재 날짜
	 */
	public static Calendar getCalendar() {
		return Calendar.getInstance();
	}

	/**
	 * 지정한 년월일 문자열을 Calendar 타입으로 변환하기
	 * 
	 * @param strYYYYMMDD Calendar 타입으로 변환할 년월일 문자열
	 * @return 변환된 Calenar 타입
	 */
	public static Calendar getCalendar(String strYYYYMMDD) {
		Calendar objCal = null;

		if (strYYYYMMDD == null || strYYYYMMDD.trim().length() == 0) {
			return null;
		}

		log.debug("RHEE 1 : " + strYYYYMMDD);
		strYYYYMMDD = removeFormat(strYYYYMMDD);
		log.debug("RHEE 2 : " + strYYYYMMDD);
		if (strYYYYMMDD.length() != 8) {
			return null;
		} 
		
		int nYear = Integer.parseInt(strYYYYMMDD.substring(0, 4));
		int nMonth = Integer.parseInt(strYYYYMMDD.substring(4, 6)) - 1;
		int nDay = Integer.parseInt(strYYYYMMDD.substring(6, 8));

		objCal = Calendar.getInstance();
		objCal.set(nYear, nMonth, nDay, 0, 0, 0);
		
		return objCal;
	}

	/**
	 * 지정한 년월일 문자열을 Calendar 타입으로 변환하기
	 * 
	 * @param strYYYYMMDDHHMM Calendar 타입으로 변환할 년월일시간분 문자열
	 * @return 변환된 Calenar 타입
	 */
	public static Calendar getCalendarTime(String strYYYYMMDDHHMM) {
		Calendar objCal = null;

		if (strYYYYMMDDHHMM == null || strYYYYMMDDHHMM.trim().length() == 0) {
			return null;
		}

		strYYYYMMDDHHMM = strYYYYMMDDHHMM.replaceAll("[$|^|*|+|?|/|:|\\-|,|.|\\s]", "");

		if (strYYYYMMDDHHMM.length() != 12) {
			return null;
		} 
		
		int nYear = Integer.parseInt(strYYYYMMDDHHMM.substring(0, 4));
		int nMonth = Integer.parseInt(strYYYYMMDDHHMM.substring(4, 6)) - 1;
		int nDay = Integer.parseInt(strYYYYMMDDHHMM.substring(6, 8));

		int nHour = Integer.parseInt(strYYYYMMDDHHMM.substring(8, 10));
		int nMinute = Integer.parseInt(strYYYYMMDDHHMM.substring(10, 12));

		objCal = Calendar.getInstance();
		objCal.set(nYear, nMonth, nDay, nHour, nMinute, 0);
		
		return objCal;
	}

	/**
	 * Calendar 타입을 String 타입으로 반환하기
	 * 
	 * @param objCalendar 문자열로 변환할 Calendar
	 * @return 변환된 문자열
	 */
	public static String getCalendar(Calendar objCalendar) {
		if (objCalendar == null) {
			return null;
		}
		DecimalFormat objFormat = new DecimalFormat("00");

		String strYear = String.valueOf(objCalendar.get(Calendar.YEAR));
		int nMonth = objCalendar.get(Calendar.MONTH) + 1;
		int nDate = objCalendar.get(Calendar.DATE);

		String strMonth = objFormat.format(nMonth);
		String strDate = objFormat.format(nDate);

		return strYear + strMonth + strDate;
	}

	/**
	 * Calendar 타입을 포멧형태 맞춰 문자열로 반환하기
	 * 
	 * @param objCalendar Calendar 타입
	 * @param strFormat   포멧(ex : yyyy-MM-dd HH:mm:ss)
	 * @return 포멧형태의 문자열
	 */
	public static String getFormatDate(Calendar objCalendar, String strFormat) {
		if (objCalendar == null || strFormat == null || strFormat.trim().length() == 0) {
			return null;
		}

		SimpleDateFormat objFormat = new SimpleDateFormat(strFormat, Locale.KOREA);

		return objFormat.format(objCalendar.getTime());
	}

	/**
	 * Calendar 타입을 포멧형태 맞춰 문자열로 반환하기
	 * 
	 * @param objCalendar Calendar 타입
	 * @param strFormat   포멧(ex : yyyy-MM-dd HH:mm:ss)
	 * @return 포멧형태의 문자열
	 */
	public static String getFormatDate(String strYYYYMMDD, String strFormat) {
		return getFormatDate(getCalendar(strYYYYMMDD), strFormat);
	}

	/**
	 * String 타입을 Timestamp 변경 후 포멧형태 맞춰 문자열로 반환하기
	 * 
	 * @param String    타입
	 * @param strFormat 포멧(ex : yyyy-MM-dd HH:mm:ss)
	 * @return 포멧형태의 문자열
	 */
	public static String getFormatTimestamp(String strYYYYMMDD, String strFormat) {
		if (strYYYYMMDD == null || strYYYYMMDD.trim().length() == 0 || strFormat == null
				|| strFormat.trim().length() == 0) {
			return null;
		}

		SimpleDateFormat objFormat = new SimpleDateFormat(strFormat, Locale.KOREA);
		Timestamp timestamp = Timestamp.valueOf(strYYYYMMDD);

		return objFormat.format(timestamp);
	}

	/**
	 * 입력한 년월일의 마지막 일수 반환하기
	 * 
	 * @param strYYYYMMDD 년월일
	 * @return 마지막 일수
	 */
	public static int getLastDay(String strYYYYMMDD) {
		Calendar objCal = getCalendar(strYYYYMMDD);
		if(objCal == null) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		return objCal.getActualMaximum(Calendar.DATE);
	}

	/**
	 * 초를 시분초로 변환하기
	 * 
	 * @param nSeconds 초
	 * @return 시분초
	 */
	public static String getTime2Cecond(int nSeconds) {
		int nHours = nSeconds / (60 * 60); // 3600으로 나눈 몫이 시간
		nSeconds = nSeconds % (60 * 60); // 3600으로 나눈 나머지가 초
		int nMinutes = nSeconds / 60; // 60으로 나눈 몫이 분

		DecimalFormat objFormat = new DecimalFormat("00");

		String strHours = objFormat.format(nHours);
		String strMinutes = objFormat.format(nMinutes);
		String strSeconds = objFormat.format(nSeconds);

		return strHours + ":" + strMinutes + ":" + strSeconds;
	}

	/**
	 * 지정한 날짜의 년중 주차 구하기
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @return 연중 몇번째 주차
	 */
	public static int getWeekOfYear(String strYYYYMMDD) {
		Calendar objCal = getCalendar(strYYYYMMDD);
		if(objCal == null) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		return objCal.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 * 지정한 날짜의 달중 주차 구하기
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @return 달의 몇번째 주차
	 */
	public static int getWeekOfMonth(String strYYYYMMDD) {
		Calendar objCal = getCalendar(strYYYYMMDD);
		if(objCal == null) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		return objCal.get(Calendar.WEEK_OF_MONTH);
	}

	/**
	 * 지정한 날짜의 요일 구하기
	 * 
	 * @param strYYYYMMDD
	 * @return 요일 코드(1: 일요일 ~7:토요일)
	 */
	public static int getDate(String strYYYYMMDD) {
		Calendar objCal = getCalendar(strYYYYMMDD);
		if(objCal == null) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		return objCal.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 지정한 날짜가 금일인가?
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @return 금일이면 true, 아니면 false
	 */
	public static boolean isToday(String strYYYYMMDD) {
		boolean retValue = true;
		Calendar objToDay = getCalendar();
		Calendar objCal = getCalendar(strYYYYMMDD);

		if (objCal == null) {
			return false;
		}
		if (objToDay.get(Calendar.YEAR) != objCal.get(Calendar.YEAR)) {
			retValue = false;
		}
		if (objToDay.get(Calendar.MONTH) != objCal.get(Calendar.MONTH)) {
			retValue = false;
		}
		if (objToDay.get(Calendar.DATE) != objCal.get(Calendar.DATE)) {
			retValue = false;
		}

		return retValue;
	}

	/**
	 * 지정한 날짜가 금주인가?
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @return금주이면 true, 아니면 false
	 */
	public static boolean isThisWeek(String strYYYYMMDD) {
		boolean retValue = false;
		int nWeekTarget = getWeekOfYear(strYYYYMMDD);
		int nWeekToday = getWeekOfYear(getCalendar(getCalendar()));

		if (nWeekTarget == nWeekToday) {
			retValue = true;
		}

		return retValue;
	}

	/**
	 * 지정한 날짜의 포함한 한주 날짜를 반환하기
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @return 해당 주에 포함된 월요일부터 일요일까지의 문자열 배열
	 */
	public static String[] getWeekDate(String strYYYYMMDD) {
		String[] retValue = new String[7];
		Calendar objCal = Calendar.getInstance();
		objCal.set(Calendar.WEEK_OF_YEAR, getWeekOfYear(strYYYYMMDD));

		for (int i = 1; i <= 7; i++) {
			objCal.set(Calendar.DAY_OF_WEEK, i);
			retValue[i - 1] = getCalendar(objCal);
		}

		return retValue;
	}

	/**
	 * 지정한 요일 코드(상수)를 한글로 반환하기
	 * 
	 * @param nDate 요일 코드
	 * @return
	 */
	public static String getKoreanDay(int nDate) {
		String retValue = null;

		switch (nDate) {
		case Calendar.MONDAY:
			retValue = "월";
			break;
		case Calendar.TUESDAY:
			retValue = "화";
			break;
		case Calendar.WEDNESDAY:
			retValue = "수";
			break;
		case Calendar.THURSDAY:
			retValue = "목";
			break;
		case Calendar.FRIDAY:
			retValue = "금";
			break;
		case Calendar.SATURDAY:
			retValue = "토";
			break;
		case Calendar.SUNDAY:
			retValue = "일";
			break;
		default:
			break;
		}
		return retValue;
	}

	/**
	 * 초를 시분초로 변환하기
	 * 
	 * @param strSeconds 초
	 * @return 시분초
	 */
	public static String getTime2Cecond(String strSeconds) {
		if (strSeconds == null || strSeconds.trim().length() == 0) {
			return strSeconds;
		}

		int nSeconds = Integer.parseInt(strSeconds);

		return getTime2Cecond(nSeconds);
	}

	/**
	 * 지정한 두 날짜 값의 달수 차 구하기
	 * 
	 * @param strFromYYYYMMDD 지정한 날로부터
	 * @param strToYYYYMMDD   지정한 날까지
	 * @return 지정한 두 날짜의 달 수 차
	 */

	public static int intervalMonth(String strFromYYYYMMDD, String strToYYYYMMDD) {
		Calendar objFromCal = getCalendar(strFromYYYYMMDD);
		Calendar objToCal = getCalendar(strToYYYYMMDD);
		if(objFromCal == null || objToCal == null ) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		int nYear = objToCal.get(Calendar.YEAR) - objFromCal.get(Calendar.YEAR);
		int nMonth = objToCal.get(Calendar.MONTH) - objFromCal.get(Calendar.MONTH);
		int nDate = objToCal.get(Calendar.DATE) - objFromCal.get(Calendar.DATE);

		// nYear * 12 : 년수를 달로 환산
		// 일수 계산 값이 마이너스일 경우 한달을 뺌.
		return (nYear * 12 + nMonth + (nDate >= 0 ? 0 : -1));
	}

	/**
	 * 지정한 두 날짜 값의 일수 차 구하기
	 * 
	 * @param strFromYYYYMMDD 지정한 날로부터
	 * @param strToYYYYMMDD   지정한 날까지
	 * @return 지정한 두 날짜의 날 수 차
	 */
	public static int intervalDay(String strFromYYYYMMDD, String strToYYYYMMDD) {
		Calendar objFromCal = getCalendar(strFromYYYYMMDD);
		Calendar objToCal = getCalendar(strToYYYYMMDD);
		if(objFromCal == null || objToCal == null ) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		int nFromDays = objFromCal.get(Calendar.DAY_OF_YEAR);
		int nToDays = objToCal.get(Calendar.DAY_OF_YEAR);

		return nToDays - nFromDays;
	}

	/**
	 * 지정한 날짜에 입력한 년수 계산하기
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @param nYears      계산하고자 하는 년 수
	 * @return 계산된 날짜
	 */
	public static String addYears(String strYYYYMMDD, int nYears) {

		Calendar objCal = getCalendar(strYYYYMMDD);
		if (objCal == null) {
			return StringUtils.EMPTY;
		}
		objCal.add(Calendar.YEAR, nYears);

		return getCalendar(objCal);
	}

	/**
	 * 지정한 날짜에 입력한 달수 계산하기
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @param nMonths     계산하고자 하는 달 수
	 * @return 계산된 날짜
	 */
	public static String addMonths(String strYYYYMMDD, int nMonths) {
		Calendar objCal = getCalendar(strYYYYMMDD);
		if (objCal == null) {
			return StringUtils.EMPTY;
		}
		objCal.add(Calendar.MONTH, nMonths);

		return getCalendar(objCal);
	}

	/**
	 * 지정한 날짜에 입력한 일수 계산하기
	 * 
	 * @param strYYYYMMDD 지정한 날짜
	 * @param nDays       계산하고자 하는 일 수
	 * @return 계산된 날짜
	 */
	public static String addDays(String strYYYYMMDD, int nDays) {
		Calendar objCal = getCalendar(strYYYYMMDD);
		if (objCal == null) {
			return StringUtils.EMPTY;
		}
		objCal.add(Calendar.DATE, nDays);

		return getCalendar(objCal);
	}

	/**
	 * 지정한 날짜를 비교하기
	 * 
	 * @param strYYYYMMDD1 날짜1
	 * @param strYYYYMMDD2 날짜2
	 * @return 날짜1이 날짜2와 동일하다면 0, 날짜1이 크다면 음수, 날짜2가 크다면 양수
	 */
	public static int compareToCalerdar(String strYYYYMMDD1, String strYYYYMMDD2) {
		Calendar objCal1 = getCalendar(strYYYYMMDD1);
		Calendar objCal2 = getCalendar(strYYYYMMDD2);
		if(objCal1 == null || objCal2 == null ) {
			log.error(CommonConstants.LOG_EXCEPTION_DATE);
			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
		}
		return objCal1.compareTo(objCal2);
	}

	/**
	 * 날짜 또는 주민등록번호로 현재 나이 구하기
	 * 
	 * @param strYYYYMMDDOrJuminNum
	 * @return
	 */
	public static int getAge(String strYYYYMMDDOrJuminNum) {
		int retValue = 0;
		// 주민번호 : 7704011122816 - 13
		if (strYYYYMMDDOrJuminNum.length() == 13) { // 주민번호일 경우
			retValue = getAgeByJuminNum(strYYYYMMDDOrJuminNum);
		} else { // 날짜인 경우
			retValue = getAgeByDate(strYYYYMMDDOrJuminNum);
		}
		return retValue;
	}

	/**
	 * 날짜로 나이 구하기
	 * 
	 * @param strYYYYMMDD 생일 날짜
	 * @return 나이
	 */
	private static int getAgeByDate(String strYYYYMMDD) {
		int retValue = 0;

		if (strYYYYMMDD == null || strYYYYMMDD.length() != 8) {
			return -1;
		}

		Calendar objCal = Calendar.getInstance();
		int nCurYear = objCal.get(Calendar.YEAR);
		int nBirthYear = Integer.parseInt(strYYYYMMDD.substring(0, 4));

		retValue = nCurYear - nBirthYear + 1;

		return retValue;
	}

	/**
	 * 주민등록번호로 나이 구하기
	 * 
	 * @param strJuminNum 주민등록번호
	 * @return 나이
	 */
	private static int getAgeByJuminNum(String strJuminNum) {
		if (strJuminNum == null || strJuminNum.length() != 13) {
			return -1;
		}

		Calendar objCal = Calendar.getInstance();
		int nCurYear = objCal.get(Calendar.YEAR);
		int nSexCode = Integer.parseInt(strJuminNum.substring(7, 8));
		// 성별을 2로 나눈 이유 : 2000년 이전 성별 코드 1, 2를 2로 나눠 올림을 적용하면 1 값이 나옴 : 1 + 18
		// *100 = 1900
		// 2000년 이후 성별 코드 3, 4를 2로 나눠 올림을 적용하면 2 값이 나옴 : 2 + 18 *100 = 2000
		int nBirthYear = (((int) ((nSexCode / 2.0) + 0.5)) + 18) * 100 + Integer.parseInt(strJuminNum.substring(0, 2));

		return nCurYear - nBirthYear + 1;
	}

	/**
	 * yyyy-MM-dd HH:mm:ss 형태의 문자열을 캘린더 객체로 변환합니다. 만약 변환에 실패할 경우 오늘 날짜를 반환합니다.
	 *
	 * @param date 날짜를 나타내는 문자열
	 * @return 변환된 캘린더 객체
	 */
	public static Calendar calendarFromString(String date, String format) {
		Calendar cal = Calendar.getInstance();
		try {
			SimpleDateFormat formatter = new SimpleDateFormat(format);
			cal.setTime(formatter.parse(date));
		} catch (ParseException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} 
		return cal;
	}

	/**
	 * time stamp
	 *
	 * @param
	 * @return timestamp
	 */
	public static Timestamp getTimestamp() {
		Date date = new Date();

		return new Timestamp(date.getTime());
	}

	public static Timestamp getTimestamp(String date, String format) {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat(format);
			return new Timestamp(formatter.parse(date).getTime());
		} catch (ParseException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return null;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return null;
		}
	}

	public static String getTimestampToString(Timestamp date, String format) {
		if (date == null || format == null) {
			return null;
		}
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		return formatter.format(date);
	}

	public static String getTimestampToString(Timestamp date) {
		return getTimestampToString(date, "yyyyMMdd");
	}

	/**
	 * 날짜 조회용 Timestamp 변환
	 *
	 * @param type (S : 시작날짜, E : 종료날짜)
	 * @param date (null : default 1개월)
	 * @return timestamp
	 */
	public static Timestamp convertSearchDate(String type, Timestamp searchDay) {
		Date date = null;
		String format = "";

		if (searchDay == null) {
			Calendar calendar = Calendar.getInstance();

			if ("S".equals(type)) {
				format = "yyyy-MM-dd 00:00:00";
				calendar.add(Calendar.MONTH, -1);
				calendar.add(Calendar.DATE, +1);
			} else if ("E".equals(type)) {
				format = "yyyy-MM-dd 23:59:59";
			}
			date = calendar.getTime();

		} else {
			Timestamp timestamp = searchDay;
			long time = timestamp.getTime();
			date = new Date(time);

			if ("S".equals(type)) {
				format = "yyyy-MM-dd 00:00:00";
			} else if ("E".equals(type)) {
				format = "yyyy-MM-dd 23:59:59";
			}
		}
		String day = new SimpleDateFormat(format).format(date);

		return DateUtil.getTimestamp(day, CommonConstants.COMMON_DATE_FORMAT);
	}
	
	/**
	 * 날짜 조회용 Timestamp 변환
	 *
	 * @param type (S : 시작날짜, E : 종료날짜)
	 * @param date (null : default 3개월)
	 * @return timestamp
	 */
	public static Timestamp convertSearchOrderDate(String type, Timestamp searchDay) {
		Date date = null;
		String format = "";

		if (searchDay == null) {
			Calendar calendar = Calendar.getInstance();

			if ("S".equals(type)) {
				format = "yyyy-MM-dd 00:00:00";
				calendar.add(Calendar.MONTH, -3);
				calendar.add(Calendar.DATE, +1);
			} else if ("E".equals(type)) {
				format = "yyyy-MM-dd 23:59:59";
			}
			date = calendar.getTime();

		} else {
			Timestamp timestamp = searchDay;
			long time = timestamp.getTime();
			date = new Date(time);

			if ("S".equals(type)) {
				format = "yyyy-MM-dd 00:00:00";
			} else if ("E".equals(type)) {
				format = "yyyy-MM-dd 23:59:59";
			}
		}
		String day = new SimpleDateFormat(format).format(date);

		return DateUtil.getTimestamp(day, CommonConstants.COMMON_DATE_FORMAT);
	}

	public static Timestamp getHistoryDate(Timestamp historyDate, int sec) {
		long targetDate = historyDate.getTime();
		targetDate += (1000 * sec);
		return new Timestamp(targetDate);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 01.common
	* - 파일명		: DateUtil.java
	* - 작성일		: 2017. 7. 19.
	* - 작성자		: Administrator
	* - 설명			: 날짜를 특정 모양으로 변경
	 * </pre>
	 * 
	 * @param date yyyyMMdd
	 * @param type H : yyyy년 MM월 dd일
	 * @return
	 */
	public static String convertDateToString(String date, String type) {
		String result = "";

		if (date != null && !"".equals(date) && date.length() == 8) {

			if ("H".equals(type)) {
				result += date.substring(0, 4) + "년 ";
				result += date.substring(4, 6) + "월 ";
				result += date.substring(6, 8) + "일";
			}

		} else {
			result = date;
		}

		return result;
	}

	public static String getDatePickerValue(int n,String type){
		if(StringUtil.equals(type,"Y")){
			return getFormatDate(addYears(calDate("yyyyMMdd"),n), "yyyy-MM-dd");
		}
		else if(StringUtil.equals(type,"M")){
			return getFormatDate(addMonths(calDate("yyyyMMdd"),n), "yyyy-MM-dd");
		}
		else{
			return getFormatDate(addDays(calDate("yyyyMMdd"),n), "yyyy-MM-dd");
		}
	}
}
