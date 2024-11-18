package admin.web.config.tags;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DatepickerTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String prefixId;
	private String startDate;
	private String endDate;
	private String startHour;
	private String endHour;
	private String startMin;
	private String endMin;
	private String startSec;
	private String endSec;
	private String startValue;
	private String endValue;
	private Integer period;
	private String format;
	private String required;
	private String readonly;

	public void setPrefixId(String prefixId) { this.prefixId = prefixId; }

	public void setStartDate(String startDate) {this.startDate = startDate;}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}

	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}

	public void setStartMin(String startMin) {
		this.startMin = startMin;
	}

	public void setEndMin(String endMin) {
		this.endMin = endMin;
	}

	public void setStartValue(String startValue) {
		this.startValue = startValue;
	}

	public void setEndValue(String endValue) {
		this.endValue = endValue;
	}

	public void setPeriod(Integer period) {
		this.period = period; 
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public void setStartSec(String startSec) {
		this.startSec = startSec;
	}

	public void setEndSec(String endSec) {
		this.endSec = endSec;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public void setReadonly(String readonly) {
		this.readonly = readonly;
	}

	@Override
	public int doStartTag() throws JspException {

		try {
			StringBuilder sb = new StringBuilder();
			String tmpStr = null;
			Calendar startCal = null;
			Calendar endCal = null;

			// yyyy-MM-dd HH:mm, yyyy-MM-dd HH:mm:ss
			if (StringUtil.isEmpty(this.format)) {
				this.format = "yyyy-MM-dd HH:mm:ss";
			}

			//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			// 태그에서 시작날짜를 지정하지 않은 경우 오늘 날짜를 시작날짜로 정함.
			if (StringUtils.isEmpty(this.startValue)) {
				// 현재날짜
				java.util.Date d = new java.util.Date();
				this.startValue = df.format(d);
			} else {
				String strYYYYMMDD = this.startValue.replaceAll("[^0-9]", "");
				if (DateUtil.isDate(strYYYYMMDD, true, false)) {
					if (DateUtil.getNowDate().equals(strYYYYMMDD)) {
						// 현재날짜일경우 현재 시분초까지 return
						java.util.Date d = new java.util.Date();
						this.startValue = df.format(d);
					} else {
						this.startValue = DateUtil.getFormatDate(strYYYYMMDD, "yyyy-MM-dd HH:mm:ss");
					}
				}

			}

			// endValue 값이 null 일 때 로직 추가
			if (StringUtils.isEmpty(this.endValue)) {
				// 현재날짜
				java.util.Date d = new java.util.Date();
				this.endValue = df.format(d);
			} else {
				String endYYYYMMDD = this.endValue.replaceAll("[^0-9]", "");
				if (DateUtil.isDate(endYYYYMMDD, true, false)) {
					if (DateUtil.getNowDate().equals(endYYYYMMDD)) {
						// 현재날짜일경우 현재 시분초까지 return
						java.util.Date d = new java.util.Date();
						this.endValue = df.format(d);
					} else {
						this.endValue = DateUtil.getFormatDate(endYYYYMMDD, "yyyy-MM-dd HH:mm:ss");
					}
				}
			}

			startCal = DateUtil.calendarFromString(this.startValue, this.format);
			if (log.isDebugEnabled()) {
				log.debug("########## START : " + DateUtil.getFormatDate(startCal, this.format));
			}

			log.debug("################# this.endValue : " + this.endValue);
			endCal = DateUtil.calendarFromString(this.endValue, this.format);
			log.debug("################# endCal : " + endCal);

			// if (StringUtil.isEmpty(endValue)) {
//				if (this.period != null) {
//					if (this.period >= 0) {
//						endCal.add(Calendar.DAY_OF_MONTH, this.period.intValue());
//					} else {
//						startCal.add(Calendar.DAY_OF_MONTH, this.period.intValue());
//					}
//				}
			// }

			if (log.isDebugEnabled()) {
				log.debug("########## END : " + DateUtil.getFormatDate(endCal, this.format));
			}

			if (!StringUtil.isEmpty(this.startDate)) {

				String startDateId = this.startDate;
				if(StringUtils.isNotEmpty(prefixId)) {
					startDateId = prefixId + StringUtils.capitalize(this.startDate);
				}

				sb.append("<div class=\"mCalendar typeLayer\">");
				sb.append("<span class=\"date_picker_box\">");
				sb.append("<input type=\"text\" ");
				sb.append("id=\"").append(startDateId).append("\" ");
				sb.append("name=\"").append(this.startDate).append("\" ");
				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("class=\"input_date readonly\" readonly=\"readonly\" ");
				} else {
					sb.append("class=\"input_date datepicker ");
					if (!StringUtil.isEmpty(required) && required.equals("Y")) {
						sb.append("validate[required,custom[date]]");
						sb.append("\" ");
					}
					if (!StringUtil.isEmpty(required) && required.equals("D")) {
						sb.append("validate[required]");
						sb.append("\" ");
					}
				}
				sb.append("title=\"날짜선택\" value=\"").append(DateUtil.getFormatDate(startCal, "yyyy-MM-dd"))
						.append("\" />");

				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("<img src=\"/images/calendar_icon.png\" alt=\"날짜선택\" />");
				}
				else {
					sb.append("<img src=\"/images/calendar_icon.png\" class=\"datepickerBtn\" alt=\"날짜선택\" />");
				}

				sb.append("</span>");
				sb.append("</div>");
			}
			if (!StringUtil.isEmpty(this.startHour)) {

				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("<select class=\"ml5 w60 readonly\" ");
				}else {
					sb.append("<select class=\"ml5 w60\" ");
				}
				sb.append("id=\"").append(this.startHour).append("\" ");
				sb.append("name=\"").append(this.startHour).append("\" ");
				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("readonly=\"readonly\"");
				}
				sb.append(">");
				for (int i = 0; i < 24; i++) {
					tmpStr = StringUtil.padLeft(String.valueOf(i), "0", 2);
					sb.append("<option");
					sb.append(" value=\"").append(tmpStr).append("\" ");
					if (startCal.get(Calendar.HOUR_OF_DAY) == i) {
						sb.append("selected=\"selected\" ");
					}
					sb.append(">");
					sb.append(tmpStr + "시");
					sb.append("</option>");
				}
				sb.append("</select>");

				if (!StringUtil.isEmpty(this.startMin)) {
					
					if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
						sb.append("<select class=\"ml5 w60 readonly\" ");
					}else {
						sb.append("<select class=\"ml5 w60\" ");
					}
					sb.append("id=\"").append(this.startMin).append("\" ");
					sb.append("name=\"").append(this.startMin).append("\" ");
					if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
						sb.append("readonly=\"readonly\"");
					}
					sb.append(">");
					for (int i = 0; i < 60; i++) {
						tmpStr = StringUtil.padLeft(String.valueOf(i), "0", 2);
						sb.append("<option");
						sb.append(" value=\"").append(tmpStr).append("\" ");
						if (startCal.get(Calendar.MINUTE) == i) {
							sb.append("selected=\"selected\" ");
						}
						sb.append(">");
						sb.append(tmpStr + "분");
						sb.append("</option>");
					}
					sb.append("</select>");

					if (!StringUtil.isEmpty(this.startSec)) {
						sb.append("<input type=\"hidden\" ");
						sb.append("id=\"").append(this.startSec).append("\" ");
						sb.append("name=\"").append(this.startSec).append("\" ");
						sb.append("value=\"").append("00").append("\" ");
						sb.append("/>");
					}

				}
			}

			if (!StringUtil.isEmpty(this.endDate)) {

				String endDateId = this.endDate;
				if(StringUtils.isNotEmpty(prefixId)) {
					endDateId = prefixId + StringUtils.capitalize(this.endDate);
				}

				sb.append("&nbsp;~&nbsp;");
				sb.append("<div class=\"mCalendar typeLayer\">");
				sb.append("<span class=\"date_picker_box\">");
				sb.append("<input type=\"text\" ");
				sb.append("id=\"").append(endDateId).append("\" ");
				sb.append("name=\"").append(this.endDate).append("\" ");
				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("class=\"input_date readonly\" readonly=\"readonly\" ");
				} else {
					sb.append("class=\"input_date datepicker ");
					if (!StringUtil.isEmpty(required) && required.equals("Y")) {
						sb.append("validate[required,custom[date]]");
						sb.append("\" ");
					}
					if (!StringUtil.isEmpty(required) && required.equals("D")) {
						sb.append("validate[required]");
						sb.append("\" ");
					}
				}
				sb.append("title=\"날짜선택\" value=\"").append(DateUtil.getFormatDate(endCal, "yyyy-MM-dd")).append("\" />");

				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("<img src=\"/images/calendar_icon.png\" alt=\"날짜선택\" />");
				}
				else {
					sb.append("<img src=\"/images/calendar_icon.png\" class=\"datepickerBtn\" alt=\"날짜선택\" />");
				}

				sb.append("</span>");
				sb.append("</div>");
			}
			if (!StringUtil.isEmpty(this.endHour)) {
				
				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("<select class=\"ml5 w60 readonly\" ");
				}else {
					sb.append("<select class=\"ml5 w60\" ");
				}
				
				sb.append("id=\"").append(this.endHour).append("\" ");
				sb.append("name=\"").append(this.endHour).append("\" ");
				if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
					sb.append("readonly=\"readonly\"");
				}
				sb.append(">");
				for (int i = 0; i < 24; i++) {
					tmpStr = StringUtil.padLeft(String.valueOf(i), "0", 2);
					sb.append("<option");
					sb.append(" value=\"").append(tmpStr).append("\" ");
					if (endCal.get(Calendar.HOUR_OF_DAY) == i) {
						sb.append("selected=\"selected\" ");
					}
					sb.append(">");
					sb.append(tmpStr + "시");
					sb.append("</option>");
				}
				sb.append("</select>");

				if (!StringUtil.isEmpty(this.endMin)) {
					if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
						sb.append("<select class=\"ml5 w60 readonly\" ");
					}else {
						sb.append("<select class=\"ml5 w60\" ");
					}
					sb.append("id=\"").append(this.endMin).append("\" ");
					sb.append("name=\"").append(this.endMin).append("\" ");
					if (!StringUtil.isEmpty(readonly) && readonly.equals("Y")) {
						sb.append("readonly=\"readonly\"");
					}
					sb.append(">");
					for (int i = 0; i < 60; i++) {
						tmpStr = StringUtil.padLeft(String.valueOf(i), "0", 2);
						sb.append("<option");
						sb.append(" value=\"").append(tmpStr).append("\" ");
						if (endCal.get(Calendar.MINUTE) == i) {
							sb.append("selected=\"selected\" ");
						}
						sb.append(">");
						sb.append(tmpStr + "분");
						sb.append("</option>");
					}
					sb.append("</select>");

				}

				if (!StringUtil.isEmpty(this.endSec)) {
					sb.append("<input type=\"hidden\" ");
					sb.append("id=\"").append(this.endSec).append("\" ");
					sb.append("name=\"").append(this.endSec).append("\" ");
					sb.append("value=\"").append("59").append("\" ");
					sb.append("/>");
				}

			}

			this.pageContext.getOut().write(sb.toString());
			return SKIP_BODY;

		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}

	}

}
