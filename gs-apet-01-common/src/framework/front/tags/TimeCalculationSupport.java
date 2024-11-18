package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 초단위의 숫자를 시간으로 계산
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class TimeCalculationSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;

	protected String time;
	protected String type;

	public int doStartTag() throws JspException {
		try {
			format(this.pageContext, this.time, this.type);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void format(PageContext pageContext, String time, String type) throws IOException {

		if (type == null || "".equals(type)) {
			type = "M";
		}
		JspWriter w = pageContext.getOut();

		String timeStr = "";

		if (time != null && !"".equals(time)) {

			int times = Integer.parseInt(time);

			// 시간
			int hours = times / 3600;
			String hoursStr = "";
			if (hours > 0) {
				hoursStr = hours + "시간";
			}

			times = times - (hours * 3600);
			// 분
			int minute = times / 60;
			String minuteStr = "";
			if (minute > 0) {
				minuteStr = minute + "분";
			}

			times = times - (minute * 60);

			// 초
			int second = times;
			String secondStr = second + "초";

			if ("M".equals(type)) {
				timeStr = hoursStr + " " + minuteStr;
			} else if ("H".equals(type)) {
				timeStr = hoursStr;
			} else if ("S".equals(type)) {
				timeStr = hoursStr + " " + minuteStr + " " + secondStr;
			}
		}
		
		w.write(timeStr);
	}
}