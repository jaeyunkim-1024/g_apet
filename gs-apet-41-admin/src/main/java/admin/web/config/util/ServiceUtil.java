package admin.web.config.util;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.util.StringUtil;

public class ServiceUtil {

	public static List<CodeDetailVO> listCode(String grpCd) {
		return listCode(grpCd, null, null, null, null, null);
	}

	public static List<CodeDetailVO> listCode(String grpCd, String usrDfn1Val, String usrDfn2Val, String usrDfn3Val, String usrDfn4Val, String usrDfn5Val) {
		CacheService cacheService = getBean(CacheService.class);
		return cacheService.listCodeCache(grpCd, usrDfn1Val, usrDfn2Val, usrDfn3Val, usrDfn4Val, usrDfn5Val);
	}

	public static CodeDetailVO getCode(String grpCd, String dtlCd) {
		if(StringUtil.isNotBlank(dtlCd)) {
			List<CodeDetailVO> list = listCode(grpCd, null, null, null, null, null);
			CodeDetailVO result = null;
			if(list != null) {
				for(CodeDetailVO vo : list) {
					if(dtlCd.equals(vo.getDtlCd())) {
						result = vo;
					}
				}
			}
			return result;
		} else {
			return null;
		}
	}

	private static <T> T getBean(Class<T> calssType) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		return wContext.getBean(calssType);
	}

}
