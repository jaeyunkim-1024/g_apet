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
public class CodeUsrDfnValTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String grpCd;

	private String dtlCd;

	private int usrDfnValIdx;

	public void setGrpCd(String grpCd) {
		this.grpCd = grpCd;
	}

	public void setDtlCd(String dtlCd) {
		this.dtlCd = dtlCd;
	}

	public void setUsrDfnValIdx(int usrDfnValIdx) {
		this.usrDfnValIdx = usrDfnValIdx;
	}

	@Override
	public int doStartTag() throws JspException {
		try {

			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());

			CacheService cacheService = ac.getBean(CacheService.class);
			StringBuilder sb = new StringBuilder();
			List<CodeDetailVO> list = cacheService.listCodeCache(this.grpCd, null, null, null, null, null);

			if(CollectionUtils.isNotEmpty(list)) {
				for(CodeDetailVO vo : list ) {
					if(vo.getDtlCd().equals(this.dtlCd) ) {
						if(this.usrDfnValIdx == 1 ) {
							sb.append(vo.getUsrDfn1Val() );
						} else if(this.usrDfnValIdx == 2 ) {
							sb.append(vo.getUsrDfn2Val() );
						} else if(this.usrDfnValIdx == 3 ) {
							sb.append(vo.getUsrDfn3Val() );
						} else if(this.usrDfnValIdx == 4 ) {
							sb.append(vo.getUsrDfn4Val() );
						} else if(this.usrDfnValIdx == 5 ) {
							sb.append(vo.getUsrDfn5Val() );
						}
					}
				}
			}

			if(log.isDebugEnabled() ) {
				log.debug("########## : {}", sb.toString() );
			}

			this.pageContext.getOut().write(sb.toString());
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}



}
