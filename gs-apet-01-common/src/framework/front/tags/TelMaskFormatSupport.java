package framework.front.tags;

import java.io.IOException;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 전화번호 정규식 표현
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class TelMaskFormatSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;

	protected String data;

	public int doStartTag() throws JspException {
		try {
			format(this.pageContext, this.data);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void format(PageContext pageContext, String data) throws IOException {

		JspWriter w = pageContext.getOut();

		StringBuilder telStr = new StringBuilder();
		if (data != null && !"".equals(data)) {

			telStr.append(data);

			Matcher matcher = Pattern.compile("(^02.{0}|^01.{1}|[0-9]{3})-?([0-9]+)-?([0-9]{4})").matcher(data);

			if (matcher.matches()) {
				telStr.setLength(0);
				/*
				 * boolean isHyphen = true; if (data.indexOf('-') > -1) { isHyphen = true; }
				 */

				for (int i = 1; i <= matcher.groupCount(); i++) {
					String replaceTarget = matcher.group(i);
					if (i == 2) {
						char[] c = new char[replaceTarget.length()];
						Arrays.fill(c, '*');

						telStr.append(String.valueOf(c));
					} else {
						telStr.append(replaceTarget);
					}

					if (/* isHyphen && */i < matcher.groupCount()) {
						telStr.append("-");
					}
				}
			}
		}
		
		w.write(telStr.toString());

	}

}