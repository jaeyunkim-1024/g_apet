package framework.front.tags;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.util.StringUtil;

/**
 * 상품 이미지 경로 생성
 *
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class GoodsImageSupport extends BodyTagSupport {

	private static final long serialVersionUID = 7742385752810440928L;

	private Properties bizConfig;
	private Properties webConfig;

	protected String imgPath;
	protected String goodsId;
	protected Integer seq;
	protected String gb;
	protected String[] size;
	protected String cls;
	protected String alt;
	protected String noImg;

	public int doStartTag() throws JspException {
		try {
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			bizConfig = (Properties) ac.getBean("bizConfig");
			webConfig = (Properties) ac.getBean("webConfig");

			goodsImage(this.pageContext, this.bizConfig, this.imgPath, this.goodsId, this.seq, this.gb, this.size, this.cls, this.alt, this.noImg, this.webConfig);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	public static void goodsImage(PageContext pageContext, Properties bizConfig, String imgPath, String goodsId,
			Integer seq, String gb, String[] size, String cls, String alt, String noImg, Properties webConfig) throws IOException {
		
		JspWriter w = pageContext.getOut();

		if (gb == null) {
			gb = "";
		}

		if (cls == null) {
			cls = "";
		}

		String ext = FilenameUtils.getExtension(imgPath);

		String imageStr = "";

		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

		String httpScheme = request.getScheme();

		String src = httpScheme + "://" + bizConfig.getProperty("image.domain");

		src += "/goods/" + goodsId + "/" + goodsId + "_" + seq + gb + "_" + size[0] + "x" + size[1] + "." + ext;

		String onerror = "";
		if (StringUtil.isNotBlank(noImg)) {
			onerror = "onerror=\"this.src='"+ noImg + "';\"";
		}else{
			// noImg 지정하지 않았으면 이미지 에러시 디폴트 이미지
			noImg = webConfig.getProperty("default.noImagePath");

			if( StringUtils.isNotEmpty(noImg) ){
				onerror = "onerror=\"this.src='"+ noImg + "';\"";
			}
		}

		imageStr="<img src=\""+src+"\" class=\""+cls+"\" alt=\""+ alt +"\" " + onerror + " />";

		w.write(imageStr);
	}
}