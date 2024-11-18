package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

import framework.common.util.StringUtil;

/**
 * Timestamp의 일자를 특정 형식으로 출력
 * 
 * @author valueFactory
 * @since 2016. 04. 06.
 */
public class TimestampFormatSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;

	protected String date;
	protected String dType;
	protected String tType;

	public int doStartTag() throws JspException {
		try {
			format(this.pageContext, this.date, this.dType, this.tType);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void format(PageContext pageContext, String date, String dType, String tType) throws IOException {

		if (dType == null || "".equals(dType)) {
			dType = "H";
		}
		if (tType == null) {
			tType = "";
		}

		JspWriter w = pageContext.getOut();
		String dateStr = "";

		if (date != null && !"".equals(date)) {
			date = StringUtil.removeFormat(date);
			if (date.length() < 14) {
				date = StringUtil.padValue(date, "0", 14, false);
			}
			date = date.substring(0, 14);

			String dateFormat = "(\\d{4})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})"; // 년월일시분초

			if ("K".equals(dType)) {
				dateStr = date.replaceAll(dateFormat, "$1년 $2월 $3일");
			} else if ("H".equals(dType)) {
				dateStr = date.replaceAll(dateFormat, "$1-$2-$3");
			} else if ("C".equals(dType)) {
				dateStr = date.replaceAll(dateFormat, "$1.$2.$3");
			} else if ("CC".equals(dType)) {
				dateStr = date.replaceAll(dateFormat, "$2.$3");
			} else if ("S".equals(dType)) {
				dateStr = date.replaceAll(dateFormat, "$1/$2/$3");
			} else if ("E".equals(dType)) {
				dateFormat = "(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})"; // 년월일시분초
				dateStr = date.replaceAll(dateFormat, "$2.$3.$4");
			} else if ("KK".equals(dType)) {
				dateStr = date.replaceAll(dateFormat, "$2월 $3일");
			}

			if (!"".equals(tType)) {
				if ("KM".equals(tType)) {
					dateStr += " " + date.replaceAll(dateFormat, "$4시 $5분");
				} else if ("KS".equals(tType)) {
					dateStr += " " + date.replaceAll(dateFormat, "$4시 $5분 $6초");
				} else if ("HM".equals(tType)) {
					dateStr += " " + date.replaceAll(dateFormat, "$4:$5");
				} else if ("HS".equals(tType)) {
					dateStr += " " + date.replaceAll(dateFormat, "$4:$5:$6");
				} else if ("CM".equals(tType)) {
					dateStr += " " + date.replaceAll(dateFormat, "$4.$5");
				} else if ("CS".equals(tType)) {
					dateStr += " " + date.replaceAll(dateFormat, "$4.$5.$6");
				}
			}
		}
		
		w.write(dateStr);

	}

}