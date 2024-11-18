package admin.web.config.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CpNoTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String funcNm;
	private String requireYn;
	private String defaultCpNo;
	private String defaultCpNm;

	public void setFuncNm(String funcNm) {
		this.funcNm = funcNm;
	}
	public void setRequireYn(String requireYn) {
		this.requireYn = requireYn;
	}
	public void setDefaultCpNo(String defaultCpNo) {
		this.defaultCpNo = defaultCpNo;
	}
	public void setDefaultCpNm(String defaultCpNm) {
		this.defaultCpNm = defaultCpNm;
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

			Session session = AdminSessionUtil.getSession();
			if(session != null ) {
				// 관리자 일경우.
				if(AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd()) ) {
					sb.append("<input");
					sb.append(" type=\"hidden\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"validate[required]\"");
					}
					sb.append(" name=\"cpNo\"");
					sb.append(" id=\"cpNo\"");
					sb.append(" title=\"쿠폰번호\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCpNo) ? "" : defaultCpNo ).append("\"");
					sb.append(" />");
					sb.append("<input");
					sb.append(" type=\"text\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"readonly validate[required]\"");
					} else {
						sb.append(" class=\"readonly\"");
					}
					sb.append(" id=\"cpNm\"");
					sb.append(" name=\"cpNm\"");
					sb.append(" title=\"쿠폰명\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCpNm) ? "" : defaultCpNm ).append("\"");
					sb.append(" />");
					sb.append("&nbsp;<button");
					sb.append(" type=\"button\"");
					sb.append(" class=\"btn\"");
					sb.append(" onclick=\"").append(this.funcNm).append(";\"");
					sb.append(" >");
					sb.append("검색");
					sb.append("</button>");

				} else {
					sb.append("<input");
					sb.append(" type=\"hidden\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"validate[required]\"");
					}
					sb.append(" name=\"cpNo\"");
					sb.append(" id=\"cpNo\"");
					sb.append(" title=\"쿠폰번호\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCpNo) ? "" : this.defaultCpNo ).append("\"");
					sb.append(" />");
					sb.append("<input");
					sb.append(" type=\"text\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"readonly validate[required]\"");
					} else {
						sb.append(" class=\"readonly\"");
					}
					sb.append(" id=\"cpNm\"");
					sb.append(" name=\"cpNm\"");
					sb.append(" title=\"쿠폰명\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCpNm) ? "" : this.defaultCpNm ).append("\"");
					sb.append(" disabled");
					sb.append(" />");
				}

			}

			this.pageContext.getOut().write(sb.toString() );
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}
}
