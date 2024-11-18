package admin.web.config.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CompNoTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String funcNm;
	private String requireYn;
	private String defaultCompNo;
	private String defaultCompNm;
	private String placeholder;
	private String disableSearchYn;
	private String idIndex = "";
	private Boolean forceDefaultValue = false;

	public void setFuncNm(String funcNm) {
		this.funcNm = funcNm;
	}
	public void setRequireYn(String requireYn) {
		this.requireYn = requireYn;
	}
	public void setDefaultCompNo(String defaultCompNo) {
		this.defaultCompNo = defaultCompNo;
	}
	public void setDefaultCompNm(String defaultCompNm) {
		this.defaultCompNm = defaultCompNm;
	}
	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}
	public void setDisableSearchYn(String disableSearchYn) {
		this.disableSearchYn = disableSearchYn;
	}
	public void setIdIndex(String idIndex) {
		this.idIndex = idIndex;
	}
	public void setForceDefaultValue(Boolean forceDefaultValue) {
		this.forceDefaultValue = forceDefaultValue;
	}

	@Override
	public int doStartTag() throws JspException {
		StringBuilder sb = new StringBuilder (1024);

		if(StringUtil.isEmpty(this.defaultCompNo) ) {
			this.defaultCompNo = "";
		}
		if(StringUtil.isEmpty(this.defaultCompNm) ) {
			this.defaultCompNm = "";
		}
		if(StringUtil.isEmpty(this.requireYn) ) {
			this.requireYn = "N";
		}
		if(StringUtil.isEmpty(this.funcNm) ) {
			this.funcNm = "searchCompany";
		}
		if(StringUtils.isEmpty(this.disableSearchYn) ){
			this.disableSearchYn = "N";
		}

		try {

			Session session = AdminSessionUtil.getSession();
			if(session != null ) {
				// 관리자 일경우.
				if(AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd())) {
					sb.append("<input");
					sb.append(" type=\"hidden\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"validate[required, custom[onlyNum]]\"");
					}
					sb.append(" name=\"compNo" + this.idIndex + "\"");
					sb.append(" id=\"compNo" + this.idIndex + "\"");
					sb.append(" title=\"업체번호\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCompNo) ? "" : defaultCompNo ).append("\"");
					sb.append(" />");
					sb.append("<input");
					sb.append(" type=\"text\" readOnly");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"readonly validate[required]\"");
					} else {
						sb.append(" class=\"readonly\"");
					}
					sb.append(" id=\"compNm" + this.idIndex + "\"");
					sb.append(" name=\"compNm" + this.idIndex + "\"");
					sb.append(" title=\"업체명\"");
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCompNm) ? "" : defaultCompNm ).append("\"");
					sb.append(" placeholder=\"").append(StringUtil.isEmpty(this.placeholder) ? "" : placeholder ).append("\"");

					if( this.disableSearchYn.equals("Y")){
						sb.append(" disabled");
						sb.append(" />");
					}else{
						sb.append(" />");
						sb.append("&nbsp;<button");
						sb.append(" type=\"button\"");
						sb.append(" class=\"btn\"");
						sb.append(" onclick=\"").append(this.funcNm).append("(" + this.idIndex + ");\"");
						sb.append(" >");
						sb.append("검색");
						sb.append("</button>");
					}

				} else {
					sb.append("<input");
					sb.append(" type=\"hidden\"");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"validate[required, custom[onlyNum]]\"");
					}
					sb.append(" name=\"compNo" + this.idIndex + "\"");
					sb.append(" id=\"compNo" + this.idIndex + "\"");
					sb.append(" title=\"업체번호\"");
					String tempVal1 =( this.forceDefaultValue ? this.defaultCompNo : session.getCompNo().toString() );
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCompNo) ? tempVal1 : this.defaultCompNo ).append("\"");
					sb.append(" />");
					sb.append("<input");
					sb.append(" type=\"text\" readOnly");
					if(this.requireYn.equals("Y") ) {
						sb.append(" class=\"readonly validate[required]\"");
					} else {
						sb.append(" class=\"readonly\"");
					}
					sb.append(" id=\"compNm" + this.idIndex + "\"");
					sb.append(" name=\"compNm" + this.idIndex + "\"");
					sb.append(" title=\"업체명\"");
					String tempVal2 = ( this.forceDefaultValue ? this.defaultCompNm : session.getCompNm() );
					sb.append(" value=\"").append(StringUtil.isEmpty(this.defaultCompNm) ? tempVal2  : this.defaultCompNm ).append("\"");
					sb.append(" placeholder=\"").append(StringUtil.isEmpty(this.placeholder) ? "" : placeholder ).append("\"");

					sb.append(" disabled");
					sb.append(" />");
					
					/*if(StringUtils.equals(AdminConstants.USR_GB_2030, session.getUsrGbCd())) {
						if( this.disableSearchYn.equals("Y")){
							sb.append(" disabled");
							sb.append(" />");
						}else{
							sb.append(" />");
							sb.append("&nbsp;<button");
							sb.append(" type=\"button\"");
							sb.append(" class=\"btn\"");
							sb.append(" onclick=\"").append(this.funcNm).append("(" + this.idIndex + ");\"");
							sb.append(" >");
							sb.append("검색");
							sb.append("</button>");
						}
					} else {
						sb.append(" disabled");
						sb.append(" />");
					}*/
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
