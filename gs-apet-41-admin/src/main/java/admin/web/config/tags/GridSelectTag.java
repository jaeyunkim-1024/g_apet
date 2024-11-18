package admin.web.config.tags;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class GridSelectTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String grpCd;

	/** 참조1문자값 */
	private String usrDfn1Val;

	/** 참조2문자값 */
	private String usrDfn2Val;

	/** 참조3문자값 */
	private String usrDfn3Val;

	/** 참조4문자값 */
	private String usrDfn4Val;

	/** 참조5문자값 */
	private String usrDfn5Val;

	/** 코드값 표현 */
	private Boolean showValue;

	public void setGrpCd(String grpCd) {
		this.grpCd = grpCd;
	}

	public void setUsrDfn1Val(String usrDfn1Val) {
		this.usrDfn1Val = usrDfn1Val;
	}

	public void setUsrDfn2Val(String usrDfn2Val) {
		this.usrDfn2Val = usrDfn2Val;
	}

	public void setUsrDfn3Val(String usrDfn3Val) {
		this.usrDfn3Val = usrDfn3Val;
	}

	public void setUsrDfn4Val(String usrDfn4Val) {
		this.usrDfn4Val = usrDfn4Val;
	}

	public void setUsrDfn5Val(String usrDfn5Val) {
		this.usrDfn5Val = usrDfn5Val;
	}

	public void setShowValue(Boolean showValue) {
		this.showValue = showValue;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			CacheService cacheService = ac.getBean(CacheService.class);
			List<CodeDetailVO> list = cacheService.listCodeCache(grpCd, usrDfn1Val, usrDfn2Val, usrDfn3Val, usrDfn4Val, usrDfn5Val);
			StringBuilder sb = new StringBuilder();
			if(CollectionUtils.isNotEmpty(list)) {
				for(int i=0; i < list.size(); i++) {
					CodeDetailVO vo = list.get(i);
					if (i > 0) {
						sb.append(";");
					}
					
					if(this.showValue != null && this.showValue.booleanValue()) {
						sb.append(vo.getDtlCd()).append(":").append(vo.getDtlCd()).append(" - ").append(vo.getDtlNm());
					} else {
						sb.append(vo.getDtlCd()).append(":").append(vo.getDtlNm());
					}
				}
//				for(CodeDetailVO vo : list) {
//					if(this.showValue != null && this.showValue.booleanValue() == true ) {
//						sb.append(vo.getDtlCd()).append(":").append(vo.getDtlCd()).append(" - ").append(vo.getDtlNm()).append(";");
//					} else {
//						sb.append(vo.getDtlCd()).append(":").append(vo.getDtlNm()).append(";");
//					}
//				}
				this.pageContext.getOut().write(sb.toString());
			}
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}
}
