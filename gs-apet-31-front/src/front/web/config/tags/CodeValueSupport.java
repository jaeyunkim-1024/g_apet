package front.web.config.tags;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.collections.CollectionUtils;

import biz.app.system.model.CodeDetailVO;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.tags
* - 파일명		: CodeValueSupport.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
@Slf4j
public class CodeValueSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;
	
	protected Object items;
	protected String dtlCd;
	protected String type;

	public int doStartTag() throws JspException {
		try {
			option(this.pageContext, this.items, this.dtlCd, this.type);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void option(PageContext pageContext, Object obj, String dtlCd, String type) throws IOException {
		
		JspWriter w = pageContext.getOut();

		String valueStr = "";

		if(type == null || "".equals(type) ){
			type = "D";
		}
		
		if(obj != null){
			@SuppressWarnings("unchecked")
			List<CodeDetailVO> codeList = (List<CodeDetailVO>)obj;

			if(CollectionUtils.isNotEmpty(codeList)){
				for(CodeDetailVO code : codeList){
					
					if(dtlCd.equals(code.getDtlCd())){
						if("S".equals(type)){
							valueStr = code.getDtlShtNm();
						}else if("U1".equals(type)){
							valueStr = code.getUsrDfn1Val();
						}else{
							valueStr = code.getDtlNm();
						}
					}
				}
			}
		}

		log.debug(">>>>>>>>>>>>>>>>>>valueStr="+valueStr);

		w.write(valueStr);
		
	}


}