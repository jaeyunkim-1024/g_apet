package admin.web.config.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BndCntsNoTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String funcNm;
	private String requireYn;
	private String defaultBndCntsNo;
	private String defaultCntsTtl;

	public void setFuncNm(String funcNm) {
		this.funcNm = funcNm;
	}
	public void setRequireYn(String requireYn) {
		this.requireYn = requireYn;
	}
	public void setDefaultBndCntsNo(String defaultBndCntsNo) {
		this.defaultBndCntsNo = defaultBndCntsNo;
	}
	public void setDefaultCntsTtl(String defaultCntsTtl) {
		this.defaultCntsTtl = defaultCntsTtl;
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
			sb.append(" name=\"bndCntsNo\"");
			sb.append(" id=\"bndCntsNo\"");
			sb.append(" title=\"브랜드 콘텐츠 번호\"");
			sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultBndCntsNo) ? "" : defaultBndCntsNo ).append("\"");
			sb.append(" />");
			sb.append("<input");
			sb.append(" type=\"text\"");
			if(this.requireYn.equals("Y") ) {
				sb.append(" class=\"readonly validate[required]\"");
			} else {
				sb.append(" class=\"readonly\"");
			}
			sb.append(" id=\"cntsTtl\"");
			sb.append(" name=\"cntsTtl\"");
			sb.append(" title=\"콘텐츠 타이틀\"");
			sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCntsTtl) ? "" : defaultCntsTtl ).append("\"");
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
