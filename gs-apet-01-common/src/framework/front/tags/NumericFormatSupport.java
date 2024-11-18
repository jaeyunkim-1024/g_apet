package framework.front.tags;

import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 숫자 포맷 변경 (3자리마다 , 처리)
 * 
 * @author valueFactory
 * @since 2016. 05. 03.
 */
public class NumericFormatSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;

	protected String data;

	@Override
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

		String amtStr = "";

		if (data != null && !"".equals(data)) {

			DecimalFormat df = new DecimalFormat("#,###");
			amtStr = df.format(Long.parseLong(data));

		} else {
			amtStr = "0";
		}
	
		w.write(amtStr);

	}

}