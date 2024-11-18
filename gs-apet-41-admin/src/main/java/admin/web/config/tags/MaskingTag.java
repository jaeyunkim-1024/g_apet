package admin.web.config.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import framework.common.constants.CommonConstants;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MaskingTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String value;

	private String type;

	public void setType(String type) {
		this.type = type;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			String resultValue = "";

			if(StringUtil.isNotBlank(value) && StringUtil.isNotBlank(type)) {
				if(type.equalsIgnoreCase("name")) {
					resultValue = MaskingUtil.getName(value);
				}
				if(type.equalsIgnoreCase("email")) {
					resultValue = MaskingUtil.getEmail(value);
				}
				if(type.equalsIgnoreCase("tel")) {
					resultValue = MaskingUtil.getTelNo(value);
				}
				if(type.equalsIgnoreCase("id")) {
					resultValue = MaskingUtil.getId(value);
				}
				if(type.equalsIgnoreCase("address")) {
					resultValue = MaskingUtil.getMaskedAll(value);
				}
			}

			this.pageContext.getOut().write(resultValue);
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}





}
