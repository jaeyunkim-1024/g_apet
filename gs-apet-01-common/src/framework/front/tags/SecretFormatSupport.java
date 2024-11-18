package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 
 * 
 * @author valueFactory
 * @since 2016. 04. 07.
 */
public class SecretFormatSupport extends BodyTagSupport {

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

		int secretLength = 4;
		String secStr = "";

		if (data != null && !"".equals(data)) {
			if (data.length() > secretLength) {
				secStr = data.substring(0, data.length() - secretLength);
				secStr += "****";
			} else {
				secStr = data;
			}
		} else {
			secStr = "****";
		}
		
		w.write(secStr);

	}

}