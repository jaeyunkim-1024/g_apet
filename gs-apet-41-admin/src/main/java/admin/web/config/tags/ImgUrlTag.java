package admin.web.config.tags;

import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ImgUrlTag extends TagSupport {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private String http;

	public void setHttp(String http) {
		this.http = http;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			Properties bizConfig = (Properties)ac.getBean("bizConfig");

			HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

			if(StringUtil.isBlank(http)){
				http = request.getScheme();
			}
			//this.pageContext.getOut().write(http + "://" + bizConfig.getProperty("image.domain"));
			this.pageContext.getOut().write("/common/imageView.do?filePath=");
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}
}