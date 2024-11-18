package framework.front.tags;

import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import framework.common.util.ClassUtil;

/**
 * <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.front.tags
 * - 파일명		: UseConstantsTag.java
 * - 작성일		: 2020. 5. 4. 
 * - 작성자		: WilLee
 * - 설 명			: Class to Map / pageContext 저장
 * </pre>
 */
public class UseConstantsTag extends TagSupport {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private String className;
	private String scope;
	private String var;

	public String getClassName() {
		return this.className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getScope() {
		return this.scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getVar() {
		return this.var;
	}

	public void setVar(String var) {
		this.var = var;
	}

	@SuppressWarnings("rawtypes")
	public int doStartTag() throws JspException {
		int scope2 = getScope(this.scope, 1);
		if ((this.className != null) && (this.var != null)) {
			Map constants = null;
			try {
				constants = ClassUtil.getClassConstants(this.className);
			} catch (ClassNotFoundException e) {
				throw new JspTagException("Class not found: " + this.className);
			} catch (IllegalArgumentException e) {
				throw new JspTagException("Illegal argument: " + this.className);
			} catch (IllegalAccessException e) {
				throw new JspTagException("Illegal access: " + this.className);
			}
			if ((constants != null) && (!(constants.isEmpty()))) {
				this.pageContext.setAttribute(this.var, constants, scope2);
			}
		}

		return SKIP_BODY;
	}

	public static int getScope(String scope, int defaultScope) throws JspException {
		int pcscope;

		if (scope == null) {
			switch (defaultScope) {
			case 1:
			case 2:
			case 3:
			case 4:
				pcscope = defaultScope;
				break;
			default:
				throw new JspTagException("Invalid default scope: " + defaultScope);
			}
		} else if ("page".equals(scope)) {
			pcscope = 1;
		} else if ("request".equals(scope)) {
			pcscope = 2;
		} else if ("session".equals(scope)) {
			pcscope = 3;
		} else if ("application".equals(scope)) {
			pcscope = 4;
		} else {
			throw new JspTagException("Invalid scope name: " + scope);
		}
		return pcscope;
	}

	public void release() {
		super.release();
		this.className = null;
		this.scope = null;
		this.var = null;
	}
}