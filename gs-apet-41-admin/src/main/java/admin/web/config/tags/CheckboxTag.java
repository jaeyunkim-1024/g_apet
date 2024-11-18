package admin.web.config.tags;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CheckboxTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String name;

	private String grpCd;

	private String defaultName;

	private String defaultChecked;

	private String defaultId;

	private String dtlShtNm;

	private String[] excludeOptionArray;
	
	private String[] checkedArray;

	private String useYn;
	
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

	/** 비활성화 여부 */
	private String disabled;

	public void setName(String name) {
		this.name = name;
	}

	public void setGrpCd(String grpCd) {
		this.grpCd = grpCd;
	}

	public void setDefaultName(String defaultName) {
		this.defaultName = defaultName;
	}

	public void setDtlShtNm(String dtlShtNm) { this.dtlShtNm = dtlShtNm; }

	public void setDefaultChecked(String defaultChecked) {
		this.defaultChecked = defaultChecked;
	}

	public void setDefaultId(String defaultId) {
		this.defaultId = defaultId;
	}

	public void setExcludeOption(String excludeOption) {
		this.excludeOptionArray = StringUtils.split(excludeOption, ",");
	}
	
	public void setCheckedArray(String checkedArray) {
		this.checkedArray = StringUtils.split(checkedArray, ",");
	}
	
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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

	public void setDisabled(String disabled) { this.disabled = disabled; }

	@Override
	public int doStartTag() throws JspException {
		try {
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			CacheService cacheService = ac.getBean(CacheService.class);
			List<CodeDetailVO> list = cacheService.listCodeCache(this.grpCd, StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, this.useYn), this.usrDfn1Val, this.usrDfn2Val, this.usrDfn3Val, this.usrDfn4Val, this.usrDfn5Val);
			StringBuilder sb = new StringBuilder();
			if ( StringUtil.isNotBlank(defaultName) ) {
				String valueChecked = "checked=\"checked\"";
				if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_N, defaultChecked)) {
					valueChecked = "";
				}

				String valueId = defaultId;
				if (StringUtils.isEmpty(defaultId)) {
					valueId = "";
				}

				sb.append("<label class=\"fCheck\"><input type=\"checkbox\" name=\"").append(this.name).append("\" id=\"").append(valueId).append("\"").append(" value=\"\" ").append(valueChecked).append("> <span id=\"span_>").append(valueId).append("\">").append(defaultName).append("</span></label>");
			}
			if(CollectionUtils.isNotEmpty(list)) {
				for(CodeDetailVO vo : list) {
					if (isExcludeOption(vo, excludeOptionArray)) {
						continue;
					}
					
					String valueChecked = "";
					if(!Objects.isNull(checkedArray) && Arrays.asList(checkedArray).contains(vo.getDtlCd())) {
						valueChecked = "checked=\"checked\"";
					}

					String disabledChecked = "";
					if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, disabled)) {
						disabledChecked = " disabled=\"disabled\"";
					}


					String value = vo.getDtlNm();
					if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, dtlShtNm)) {
						value = vo.getDtlShtNm();
					}

					sb.append("<label class=\"fCheck\"><input type=\"checkbox\" name=\"").append(this.name).append("\" id=\"").append(name).append(vo.getDtlCd()).append("\"").append("value=\"").append(vo.getDtlCd()).append("\"").append(valueChecked).append(disabledChecked).append("> <span id=\"span_>").append(name).append(vo.getDtlCd()).append("\">").append(value).append("</span></label>");
				}
			}
			this.pageContext.getOut().write(sb.toString());
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}

	private boolean isExcludeOption(CodeDetailVO vo, String[] excludeOptionArray) {
		boolean excludeOption = false;

		if (Objects.isNull(excludeOptionArray)) {
			return excludeOption;
		}

		for (int idx = 0; idx < excludeOptionArray.length; idx++) {
			if (StringUtils.equalsIgnoreCase(excludeOptionArray[idx], vo.getDtlCd())) {
				excludeOption = true;
			}
		}

		return excludeOption;
	}

}
