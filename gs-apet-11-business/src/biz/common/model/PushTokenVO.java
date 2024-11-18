package biz.common.model;

import java.util.Date;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: PushTokenVO.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: PUSH TOKEN VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PushTokenVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 사용자 아이디 */
	private String userId;
	
	/** 국가코드 */
	private String country;
	
	/** 언어코드 */
	private String language;
	
	/** 타임존 */
	private Integer timezone;
	
	/** 등록된 채널명 */
	private String channelName;
	
	/** 푸시 알림 메시지 수신여부 */
	private String notificationAgreement;
	
	/** 광고성 메시지 수신여부 */
	private String adAgreement;
	
	/** 야간 광고성 메시지 수신여부 */
	private String nightAdAgreement;
	
	/** 푸시 알림 메시지 수신동의 시간 */
	private Date notificationAgreementTime;
	
	/** 광고성 메시지 수신동의 시간 */
	private Date adAgreementTime;
	
	/** 야간 광고성 메시지 수신동의 시간 */
	private Date nightAdAgreementTime;
	
	/** 토큰 등록 시간 */
	private Date createTime;
	
	/** 토큰 수정 시간 */
	private Date updateTime;
	
	/** 디바이스 타입 */
	private List<TokenDeviceVO> devices;

}