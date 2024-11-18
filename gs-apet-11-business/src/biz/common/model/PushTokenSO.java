package biz.common.model;

import java.util.Properties;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: PushTokenSO.java
* - 작성일		: 2016. 4. 21.
* - 작성자		: KKB
* - 설명		: PUSH TOKEN 조회
* </pre>
*/
@Data
public class PushTokenSO  extends BaseSearchVO<PushTokenSO> {

	private static final long serialVersionUID = 1L;

	/** 사용자 아이디 */
	private String userId;
	
	/** 디바이스 토큰 */
	private String deviceToken;
	
	public String getUserId() {
		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
		Properties bizConfig = (Properties) context.getBean("bizConfig");
		String thisEnvmt = bizConfig.getProperty("envmt.gb");
		String toWithEnvmt =((thisEnvmt.equals(CommonConstants.ENVIRONMENT_GB_LOCAL))? CommonConstants.ENVIRONMENT_GB_DEV : thisEnvmt) + "_" + this.userId;
		return toWithEnvmt;
	}
}