package biz.common.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.model
* - 파일명		: SmsSendPO.java
* - 작성일		: 2016. 4. 21.
* - 작성자		: snw
* - 설명		: SMS 전송 PO
* </pre>
*/
@Data
public class SmsSendPO  implements Serializable{

	private static final long serialVersionUID = 1L;

	/** 예약시간 (yyyyMMddHHmmss) */
	private String	reserveTime; 
	
	/** 수신번호(멀티일 경우 , 로 구분) */
	private String	receivePhone;
	
	/** 수신자명(멀티일 경우 , 로 구분) */
	private String 	receiveName;
	
	/** 전송내용  sms:90Byte lms:2,000Byte 이내 */
	private String	msg;
	
	/** 전송번호 : 미입력 시 기본 번호로 전송 */
	private String sendPhone;
	
	/** 시스템 등록자 번호 */
	private Long sysRegrNo;
	
}