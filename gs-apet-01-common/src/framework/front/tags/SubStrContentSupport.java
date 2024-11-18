package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * TextArea 값을 Html로 변환
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class SubStrContentSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;
	
	protected String data;

	protected int length;
	
	public int doStartTag() throws JspException {
		try {
			format(this.pageContext, this.data, this.length);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void format(PageContext pageContext, String data, int length) throws IOException {
		
		JspWriter w = pageContext.getOut();

		String subStr = "";

		if(data != null && !"".equals(data)){

			if(data.length() >= length){
				subStr = data.substring(0, length) + "..."; 
			}else{
				subStr = data;
			}
		}		
	
		w.write(subStr);
		
	}


}