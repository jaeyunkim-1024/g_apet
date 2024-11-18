package biz.common.model;

import java.util.Properties;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import framework.common.constants.CommonConstants;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: PushTokenPO.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: PUSH TOKEN PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PushTokenPO {

	/** 사용자 아이디 */
	private String userId;

	/** 디바이스 타입 :  GCM - Android, APNS - iOS*/
	private String deviceType ;
	
	/** 디바이스 토큰 */
	private String deviceToken;
	
	/** 푸시 알림 메시지 수신여부 */
	private Boolean isNotificationAgreement = true;
	
	/** 광고성 메시지 수신여부 */
	private Boolean isAdAgreement = true;
	
	/** 야간 광고성 메시지 수신여부 */
	private Boolean isNightAdAgreement = true;

	public String getUserId() {
		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
		Properties bizConfig = (Properties) context.getBean("bizConfig");
		String thisEnvmt = bizConfig.getProperty("envmt.gb");
		String toWithEnvmt =((thisEnvmt.equals(CommonConstants.ENVIRONMENT_GB_LOCAL))? CommonConstants.ENVIRONMENT_GB_DEV : thisEnvmt) + "_" + this.userId;
		return toWithEnvmt;
	}
}