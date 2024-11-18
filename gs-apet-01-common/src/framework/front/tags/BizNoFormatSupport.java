package framework.front.tags;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * 사업자번호 정규식으로 변경
 * 
 * @author valueFactory
 * @since 2018. 04. 22.
 */
public class BizNoFormatSupport extends BodyTagSupport {

	private static final long serialVersionUID = -744952371291368466L;
	
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
		String bizNoStr = "";
		if(data != null && !"".equals(data)){
		     String regEx = "(\\d{3})(\\d{2})(\\d{5})";

		     if(!Pattern.matches(regEx, data)){
		    	 bizNoStr = data;
		     }else{
		    	 bizNoStr = data.replaceAll(regEx, "$1-$2-$3");
		     }
		}		
		w.write(bizNoStr);
	}
}