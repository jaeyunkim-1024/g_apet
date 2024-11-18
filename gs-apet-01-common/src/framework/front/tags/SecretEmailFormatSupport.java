package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

import framework.common.util.StringUtil;

/**
 * 이메일 마스킹
 * 
 * @author valueFactory
 * @since 2018. 04. 20.
 */
public class SecretEmailFormatSupport extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

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
		JspWriter jw = pageContext.getOut();
		String strEmail = "";

		if (StringUtil.isNotBlank(data)) {
			String strId = "";
			String[] partArray = data.trim().split("@");
			int idLength = partArray[0].length();

			if (idLength < 4) {
				strId = StringUtil.masking(partArray[0], idLength - 1, idLength, '*');
			} else {
				strId = StringUtil.masking(partArray[0], 3, idLength, '*');
			}

			if (partArray.length > 1) {
				strEmail = strId + "@" + partArray[1];
			} else {
				strEmail = strId;
			}
		}
		jw.write(strEmail);
	}

}
