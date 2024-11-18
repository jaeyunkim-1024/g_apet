package admin.web.config.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CodeNameTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String grpCd;

	private String dtlCd;

	private String defaultName;

	public void setGrpCd(String grpCd) {
		this.grpCd = grpCd;
	}

	public void setDtlCd(String dtlCd) {
		this.dtlCd = dtlCd;
	}

	public void setDefaultName(String defaultName) {
		this.defaultName = defaultName;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			CacheService cacheService = ac.getBean(CacheService.class);
			String value = cacheService.getCodeName(grpCd, dtlCd);
			if(StringUtil.isBlank(value)) {
				if(StringUtil.isNotBlank(defaultName)){
					value = defaultName;
				}else{
					value = "";
				}
			}
			this.pageContext.getOut().write(value);
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}




}
