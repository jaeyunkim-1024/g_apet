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
 * 주소 정규식으로 변경
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class AddressMaskFormatSupport extends BodyTagSupport {
	
	private static final long serialVersionUID = -6625925182803923843L;
	
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

		StringBuilder replaceString = new StringBuilder();
		if (data != null && !"".equals(data)) {
			replaceString.append(data);

			Matcher matcher = Pattern.compile("^(.*)([로|읍|면|동])(.*)$").matcher(data);

			if (matcher.matches()) {
				replaceString.setLength(0);

				for (int i = 1; i <= matcher.groupCount(); i++) {
					String replaceTarget = matcher.group(i);
					if (i == 3) {
						char[] c = new char[replaceTarget.length()];
						Arrays.fill(c, '*');

						replaceString.append(" "+String.valueOf(c));
					} else {
						replaceString.append(replaceTarget);
					}
				}

			}
		}
		
		w.write(replaceString.toString());
	}

}