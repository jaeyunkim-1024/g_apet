package admin.web.config.util;

import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;

/**
 * 이미지 관련 Util
 * 
 * @author valueFactory
 */
public class ImagePathUtil {

	private static Properties bizConfig;

	public static String imagePath(String filePath, String dtlCd) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		bizConfig = (Properties) wContext.getBean("bizConfig");
		CacheService cacheService = (CacheService) wContext.getBean("cacheService");
		CodeDetailVO vo = cacheService.getCodeCache(CommonConstants.IMG_OPT_QRY, dtlCd);
		String queryString = "";
		if (StringUtil.isNotEmpty(vo)) {
			if (!StringUtils.startsWith(vo.getUsrDfn1Val(), "?")) {
				vo.setUsrDfn1Val("?" + vo.getUsrDfn1Val());
			}
			queryString = vo.getUsrDfn1Val();
			return bizConfig.getProperty("naver.cloud.optimizer.domain") + filePath + queryString;
		} else {
			return bizConfig.getProperty("naver.cloud.cdn.domain.folder") + filePath;
		}
	}
	
	public static String imagePath(String filePath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		bizConfig = (Properties) wContext.getBean("bizConfig");
		return bizConfig.getProperty("naver.cloud.cdn.domain.folder") + filePath;
	}

}
