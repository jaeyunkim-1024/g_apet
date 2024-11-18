package admin.web.config.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BndNoTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String funcNm;
	private String requireYn;
	private String defaultBndNo;
	private String defaultBndNmKo;
	private String defaultBndNmEn;

	public void setFuncNm(String funcNm) {
		this.funcNm = funcNm;
	}
	public void setRequireYn(String requireYn) {
		this.requireYn = requireYn;
	}
	public void setDefaultBndNo(String defaultBndNo) {
		this.defaultBndNo = defaultBndNo;
	}
	public void setDefaultBndNmKo(String defaultBndNmKo) {
		this.defaultBndNmKo = defaultBndNmKo;
	}
	public void setDefaultBndNmEn(String defaultBndNmEn) {
		this.defaultBndNmEn = defaultBndNmEn;
	}

	@Override
	public int doStartTag() throws JspException {
		StringBuilder sb = new StringBuilder (1024);

		if(StringUtil.isEmpty(this.requireYn) ) {
			this.requireYn = "N";
		}
		if(StringUtil.isEmpty(this.funcNm) ) {
			this.funcNm = "searchStany";
		}

		try {
			sb.append("<input");
			sb.append(" type=\"hidden\"");
			if(this.requireYn.equals("Y") ) {
				sb.append(" class=\"validate[required]\"");
			}
			sb.append(" name=\"bndNo\"");
			sb.append(" id=\"bndNo\"");
			sb.append(" title=\"브랜드 번호\"");
			sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultBndNo) ? "" : defaultBndNo ).append("\"");
			sb.append(" />");
			sb.append("<input");
			sb.append(" type=\"text\"");
			if(this.requireYn.equals("Y") ) {
				sb.append(" class=\"readonly validate[required]\"");
			} else {
				sb.append(" class=\"readonly\"");
			}
			sb.append(" id=\"bndNmKo\"");
			sb.append(" name=\"bndNmKo\"");
			sb.append(" title=\"브랜드 명 국문\"");
			sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultBndNmKo) ? "" : defaultBndNmKo ).append("\"");
			sb.append(" />");
			sb.append("<input");
			sb.append(" type=\"text\"");
			if(this.requireYn.equals("Y") ) {
				sb.append(" class=\"readonly validate[required]\"");
			} else {
				sb.append(" class=\"readonly\"");
			}
			sb.append(" id=\"bndNmEn\"");
			sb.append(" name=\"bndNmEn\"");
			sb.append(" title=\"브랜드 명 영문\"");
			sb.append(" style=\"margin-left:5px;\"");
			sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultBndNmEn) ? "" : defaultBndNmEn ).append("\"");
			sb.append(" />");
			sb.append("&nbsp;<button");
			sb.append(" type=\"button\"");
			sb.append(" class=\"btn\"");
			sb.append(" onclick=\"").append(this.funcNm).append(";\"");
			sb.append(" >");
			sb.append("검색");
			sb.append("</button>");

			this.pageContext.getOut().write(sb.toString() );
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}
}
