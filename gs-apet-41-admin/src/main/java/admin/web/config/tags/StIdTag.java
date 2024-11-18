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
public class StIdTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String id;
	private String funcNm;
	private String requireYn;
	private String defaultStId;
	private String defaultStNm;
	private boolean readOnly;

	@Override
	public void setId(String id) {
		this.id = id;
	}
	public void setFuncNm(String funcNm) {
		this.funcNm = funcNm;
	}
	public void setRequireYn(String requireYn) {
		this.requireYn = requireYn;
	}
	public void setDefaultStId(String defaultStId) {
		this.defaultStId = defaultStId;
	}
	public void setDefaultStNm(String defaultStNm) {
		this.defaultStNm = defaultStNm;
	}
	public void setReadOnly(boolean readOnly) {
		this.readOnly = readOnly;
	}

	@Override
	public int doStartTag() throws JspException {
		StringBuilder sb = new StringBuilder (1024);

		if(StringUtil.isEmpty(this.requireYn) ) {
			this.requireYn = "N";
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
					sb.append(" name=\"stId\"");
					sb.append(" id=\"").append(StringUtil.isEmpty(this.id) ? "stId" : this.id +"StId" ).append("\"");
					sb.append(" title=\"사이트ID\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultStId) ? "" : defaultStId ).append("\"");
					sb.append(" />");
					sb.append("<input");
					sb.append(" type=\"text\"");
					if (this.readOnly) {
						sb.append(" readonly");
					}
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"readonly validate[required]\"");
					} else {
						sb.append(" class=\"readonly\"");
					}
					sb.append(" id=\"").append(StringUtil.isEmpty(this.id) ? "stNm" : this.id +"StNm" ).append("\"");
					sb.append(" name=\"stNm\"");
					sb.append(" title=\"사이트명\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultStNm) ? "" : defaultStNm ).append("\"");
					sb.append(" />");
					if (! this.readOnly) {
						sb.append("&nbsp;<button");
						sb.append(" type=\"button\"");
						sb.append(" class=\"btn\"");
						if (StringUtil.isNotEmpty(this.funcNm)) {
							sb.append(" onclick=\"").append(this.funcNm).append(";\"");
						}
						sb.append(" >");
						sb.append("검색");
						sb.append("</button>");
					}

				} else {
					sb.append("<input");
					sb.append(" type=\"hidden\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"validate[required]\"");
					}
					sb.append(" name=\"stId\"");
					sb.append(" id=\"").append(StringUtil.isEmpty(this.id) ? "stId" : this.id +"StId" ).append("\"");
					sb.append(" title=\"사이트ID\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultStId) ? "" : this.defaultStId ).append("\"");
					sb.append(" />");
					sb.append("<input");
					sb.append(" type=\"text\"");
					if (! this.readOnly) {
						sb.append(" readonly");
					}
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"readonly validate[required]\"");
					} else {
						sb.append(" class=\"readonly\"");
					}
					sb.append(" id=\"").append(StringUtil.isEmpty(this.id) ? "stNm" : this.id +"StNm" ).append("\"");
					sb.append(" name=\"stNm\"");
					sb.append(" title=\"사이트명\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultStNm) ? "" : this.defaultStNm ).append("\"");
					// 2017.02.08, 이성용, 사이트를 여러개 사용하는 업체도 있으므로 disable 제거, 버튼 추가함.
					// sb.append(" disabled");
					sb.append(" />");
					if (! this.readOnly) {
						sb.append("&nbsp;<button");
						sb.append(" type=\"button\"");
						sb.append(" class=\"btn\"");
						if (StringUtil.isNotEmpty(this.funcNm)) {
							sb.append(" onclick=\"").append(this.funcNm).append(";\"");
						}
						sb.append(" >");
						sb.append("검색");
						sb.append("</button>");
					}
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
