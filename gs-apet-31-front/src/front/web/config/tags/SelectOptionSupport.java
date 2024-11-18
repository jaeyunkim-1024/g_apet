package front.web.config.tags;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.util.ObjectUtils;

import biz.app.system.model.CodeDetailVO;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.tags
* - 파일명		: SelectOptionSupport.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
@Slf4j
public class SelectOptionSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;
	
	protected Object items;
	protected boolean all;
	protected String selectKey;
	protected String defaultName;

	public int doStartTag() throws JspException {
		try {
			option(this.pageContext, this.all, this.items, this.selectKey, this.defaultName);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void option(PageContext pageContext, boolean all, Object obj, String selectKey, String defaultName) throws IOException {
		
		JspWriter w = pageContext.getOut();

		StringBuilder optionStr = new StringBuilder(4096);
		
		if(StringUtil.isNotBlank(defaultName)){
			optionStr.append("<option value=\"\" >"+defaultName+"</option>");
		}

		if(!ObjectUtils.isEmpty(obj)){
			@SuppressWarnings("unchecked")
			List<CodeDetailVO> codeList = (List<CodeDetailVO>)obj;
			CodeDetailVO tempCode;
			if(CollectionUtils.isNotEmpty(codeList)){
				for(CodeDetailVO code : codeList){
					tempCode = null;
					if(!all){
						if(CommonConstants.COMM_YN_Y.equals(code.getUseYn()) && CommonConstants.COMM_YN_N.equals(code.getSysDelYn())){
							tempCode = code;
						}
					}else{
						tempCode = code;
					}
						
					if(tempCode != null){
						optionStr.append("<option value=\""+code.getDtlCd()+"\"");
						if(StringUtil.isNotBlank(selectKey) && selectKey.equals(code.getDtlCd())){
							optionStr.append(" selected=\"selected\"");
						}
						optionStr.append(">" +code.getDtlNm() +"</option>");
					}
				}
			}
		}

		log.debug(">>>>>>>>>>>>>>>>>>optionStr="+optionStr.toString());

		w.write(optionStr.toString());
		
	}


}