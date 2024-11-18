package framework.front.tags;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 전화번호 정규식 표현
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class TelFormatSupport extends BodyTagSupport {

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

		String telStr = "";

		if (data != null && !"".equals(data)) {

			String regEx = "(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})";

			if (!Pattern.matches(regEx, data)) {
				telStr = data;
			} else {
				telStr = data.replaceAll(regEx, "$1-$2-$3");
			}
		}
	
		w.write(telStr);

	}

}