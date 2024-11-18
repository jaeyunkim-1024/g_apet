package admin.web.config.tags;

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
public class RadioTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String name;

	private String grpCd;

	private String selectKey;

	private String defaultName;

	private String useYn;

	private Boolean disabled = false;

	private String[] excludeOptionArray;

	private Boolean selectKeyOnly = false;

	private Boolean required = false;

	// click event
	private String onClickYn = "";

	// 클릭시 실행할 함수명
	private String funcNm;

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

	private String idIndex = "";

	public void setName(String name) {
		this.name = name;
	}

	public void setGrpCd(String grpCd) {
		this.grpCd = grpCd;
	}

	public void setSelectKey(String selectKey) {
		this.selectKey = selectKey;
	}

	public void setDefaultName(String defaultName) {
		this.defaultName = defaultName;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public void setDisabled(Boolean disabled) {
		this.disabled = disabled;
	}

	public void setExcludeOption(String excludeOption) {
		this.excludeOptionArray = StringUtils.split(excludeOption, ",");
	}

	public void setSelectKeyOnly(Boolean selectKeyOnly) {
		this.selectKeyOnly = selectKeyOnly;
	}

	public void setRequired(Boolean required) {
		this.required = required;
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

	public void setIdIndex(String idIndex) {
		this.idIndex = idIndex;
	}

	public void setOnClickYn(String onClickYn) {
		this.onClickYn = onClickYn;
	}

	public void setFuncNm(String funcNm) {
		this.funcNm = funcNm;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			CacheService cacheService = ac.getBean(CacheService.class);
			List<CodeDetailVO> list = cacheService.listCodeCache(grpCd, StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, this.useYn), usrDfn1Val, usrDfn2Val, usrDfn3Val, usrDfn4Val, usrDfn5Val);
			StringBuilder sb = new StringBuilder();
			String validateRequired = "";

			if(CollectionUtils.isNotEmpty(list)) {
				int i = 0;
				Boolean keyCheck = false;
				if(StringUtil.isNotEmpty(selectKey)){
					for(CodeDetailVO vo : list){
						if( selectKey.equals(vo.getDtlCd()) ){
							keyCheck = true;
						}
					}
				}
				if (required) {
					validateRequired = "class=\"validate[required]\"";
				}

				if ( StringUtil.isNotBlank(defaultName) ) {
					sb.append("<label class=\"fRadio\"><input type=\"radio\" ").append(validateRequired).append("name=\"").append(this.name).append(this.idIndex).append("\" ").append(" value=\"\"");
					if(!keyCheck) {
						sb.append(" checked=\"checked\" ");
					}

					sb.append("> <span id=\"span_").append(defaultName).append("\">").append(defaultName).append("</span></label>\n");
				}

				for(CodeDetailVO vo : list) {
					if (isExcludeOption(vo, excludeOptionArray) || (selectKeyOnly && ! isOnlySelectKey(vo, selectKey))) {
						continue;
					}

					sb.append("<label class=\"fRadio\"><input type=\"radio\" ").append(validateRequired).append("name=\"").append(this.name).append(this.idIndex).append("\" id=\"").append(name).append(vo.getDtlCd()).append(this.idIndex).append("\"").append(" value=\"").append(vo.getDtlCd()).append("\"");
					if(vo.getUsrDfn1Val() != null){
						sb.append("usrDfn1Val=\"").append(vo.getUsrDfn1Val()).append("\"");
					}
					if(keyCheck){
						if( selectKey.equals(vo.getDtlCd()) ){
							sb.append(" checked=\"checked\" ");
						}
					} else {
						if(i == 0 && StringUtil.isBlank(defaultName) ){
							sb.append(" checked=\"checked\" ");
						}
					}
					if(onClickYn.equals("Y")) {
						sb.append(" onClick=\"").append(this.funcNm).append(";\"");
					}
					if(disabled) {
						sb.append("onClick=\"return false;\" ");
					}
					sb.append("> <span id=\"span_").append(name).append(vo.getDtlCd()).append(this.idIndex).append("\">").append(vo.getDtlNm()).append("</span></label>");
					i++;
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

	private boolean isOnlySelectKey(CodeDetailVO vo, String selectKey) {

		return StringUtils.equalsIgnoreCase(vo.getDtlCd(), selectKey);
	}

}