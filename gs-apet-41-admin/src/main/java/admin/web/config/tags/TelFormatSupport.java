package admin.web.config.tags;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.config.tags
* - 파일명		: TelFormatSupport.java
* - 작성일		: 2017. 3. 22.
* - 작성자		: snw
* - 설명			: 전화번호 정규식 표현
* </pre>
*/
@Slf4j
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

	private static void format(PageContext pageContext, String data) throws IOException {
		
		JspWriter w = pageContext.getOut();

		String telStr = "";

		if(data != null && !"".equals(data)){

		     String regEx = "(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})";

		     if(!Pattern.matches(regEx, data)){
		    	 telStr = data;
		     }else{
		    	 telStr = data.replaceAll(regEx, "$1-$2-$3");
		     }
		}		
		log.debug(">>>>>>>>>>>>>>>>>>telStr="+telStr);

		w.write(telStr);
		
	}


}