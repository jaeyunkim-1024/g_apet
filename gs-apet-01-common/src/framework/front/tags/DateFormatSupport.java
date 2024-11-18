package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 문자열 형태의 날짜를 특정 형식으로 출력
 * 
 * @author valueFactory
 * @since 2016. 04. 06.
 */
public class DateFormatSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;

	protected String date;
	protected String type;

	public int doStartTag() throws JspException {
		try {
			format(this.pageContext, this.date, this.type);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void format(PageContext pageContext, String date, String type) throws IOException {

		if (type == null || "".equals(type)) {
			type = "H";
		}
		JspWriter w = pageContext.getOut();

		String dateStr = "";

		if (date != null && !"".equals(date)) {

			String dateFormat = "(\\d{4})(\\d{2})(\\d{2})"; // 년월일
			if ("K".equals(type)) {
				dateStr = date.replaceAll(dateFormat, "$1년 $2월 $3일");
			} else if ("H".equals(type)) {
				dateStr = date.replaceAll(dateFormat, "$1-$2-$3");
			} else if ("S".equals(type)) {
				dateStr = date.replaceAll(dateFormat, "$1/$2/$3");
			} else if ("C".equals(type)) {
				dateStr = date.replaceAll(dateFormat, "$1.$2.$3");
			} else {
				dateStr = date;
			}
		}
		
		w.write(dateStr);

	}

}