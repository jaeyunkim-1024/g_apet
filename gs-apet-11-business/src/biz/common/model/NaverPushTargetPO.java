package biz.common.model;

import java.io.Serializable;
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
* - 파일명		: PushTargetPO.java
* - 작성일		: 2021. 02. 02.
* - 작성자		: KKB
* - 설명		: Push에 사용되는 target po
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class NaverPushTargetPO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/** 수신대상 타입 :  ALL - 서비스에 등록된 모든 디바이스, CHANNEL - 채널에 등록된 모든 디바이스, USER - 사용자에 바인딩된 모든 디바이스*/
	private String type = "USER";
	
	/** 수신대상 디바이스 타입 :GCM - Android, APNS - iOS, (null 일 경우 모든 디바이스) */
	private String deviceType;
	
	/** 수신대상 식별자 : ALL - 입력 필요 없음, CHANNEL - 채널명, USER - 사용자아이디 */
	private String to[];
	
	/** 수신대상 국가코드 */
	private String country[];
	
	public String[] getTo() {
		if(this.to != null && this.to.length != 0) {
			String toWithEnvmt[] = new String[this.to.length];
			WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
			Properties bizConfig = (Properties) context.getBean("bizConfig");
			String thisEnvmt = bizConfig.getProperty("envmt.gb");
			for(int i=0 ; i < this.to.length ; i++) {
				toWithEnvmt[i] = ((thisEnvmt.equals(CommonConstants.ENVIRONMENT_GB_LOCAL))? CommonConstants.ENVIRONMENT_GB_DEV : thisEnvmt) + "_" + this.to[i];
			}
			return toWithEnvmt;
		}
		return new String[0];
	}
}