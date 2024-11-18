package framework.common.util;

import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 이미지 관련 Util
 * 
 * @author valueFactory
 */
public class ImagePathUtil {

	private static Properties bizConfig;

	public static String getImagePath(String imageGb, Object id, Object seq) {
		String newImagePath = "";

		return newImagePath;
	}

	/**
	 * <pre>상품 등록시 파일명 생성</pre>
	 * 
	 * @param orgFileNm
	 * @param goodsId
	 * @param imgSeq
	 * @param rvsYn
	 * @param size
	 * @return
	 */
	public static String makeGoodsImagePath(String orgFileNm, String goodsId, Integer imgSeq, boolean rvsYn, String[] size) {
		if ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes() != null) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			ServletContext context = request.getSession().getServletContext();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

			bizConfig = (Properties)wContext.getBean("bizConfig");
		}

		String path = bizConfig.getProperty("common.file.upload.base");		// /upload
		String ext = FilenameUtils.getExtension(orgFileNm);

		String imgPath = path + FileUtil.SEPARATOR; 						// /upload
		imgPath += "goods" + FileUtil.SEPARATOR; 							// goods/
		imgPath += goodsId + FileUtil.SEPARATOR; 							// goodsId/

		String imgName = null;
		if (StringUtil.isEmpty(size)) {
			imgName = String.format("%s_%s%s.%s", goodsId, String.valueOf(imgSeq), rvsYn ? "R" : "", ext);
		} else {
			imgName = String.format("%s_%s%s_%s.%s", goodsId, String.valueOf(imgSeq), rvsYn ? "R" : "", size[0] + "x" + size[1], ext);
		}

		return (imgPath + imgName);
	}

	public static String makeGoodsImagePath(String orgFileNm, String goodsId, Integer imgSeq, boolean rvsYn) {
		return makeGoodsImagePath(orgFileNm, goodsId, imgSeq, rvsYn, null);
	}

}
