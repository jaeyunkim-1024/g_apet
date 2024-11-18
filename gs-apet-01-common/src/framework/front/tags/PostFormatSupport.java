package framework.front.tags;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 우편번호 포맷 변경
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class PostFormatSupport extends BodyTagSupport {

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

		String postStr = "";

		if (data != null && !"".equals(data)) {

			String postFormat = "(\\d{3})(\\d{3})";

			if (Pattern.matches(postFormat, data)) {
				postStr = data.replaceAll(postFormat, "$1-$2");
			} else {
				postStr = data;
			}
		}

		w.write(postStr);

	}

}