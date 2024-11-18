package biz.interfaces.cis.model.request.goods;

import biz.app.goods.model.SkuInfoVO;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Properties;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.interfaces.cis.model.request.goods
* - 파일명 	: SkuInfoInsertPO.java
* - 작성일	: 2021. 2. 18.
* - 작성자	: valfac
* - 설명 		: 
* </pre>
*/
@Data
@JsonIgnoreProperties(value = { "cisDtm", "cisMinute"})
@EqualsAndHashCode(callSuper=true)
public class SkuInfoInsertPO extends SkuInfoVO {

	/** 이미지 경로 */
	private String imgSrc;
	
	/** 화주 코드  개발 : PB, 운영 : AP */ 
	private String ownrCd;
	
	/** 물류센터 코드 개발 : WH01, 운영 : AW01 */
	private String wareCd;

	public String getImgSrc() {
		if(StringUtils.isNotEmpty(imgSrc)) {
			return getBizConfig("naver.cloud.cdn.domain.folder") + imgSrc;
		} else {
			return "https://aboutpet.co.kr/_images/common/img_default_thumbnail_2@2x.png";
		}
	}
	
	public String getOwnrCd() {
		return getBizConfig("cis.api.goods.ownrCd");
	}
	
	public String getWareCd() {
		return getBizConfig("cis.api.goods.wareCd");
	}
	
	public String getBizConfig(String key) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		return bizConfig.getProperty(key);
	}
}
