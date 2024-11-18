package biz.common.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.email.model
* - 파일명		: EmailSend.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: 이메일 전송 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class NaverEmailSendPO{
	
	/** 발신자 주소 */
	private String senderAddress;
	
	/** tile */
	private String title;
		
	/** body */
	private String body;
	
	/** 예약 발송 일시 **/
	private String reservationDateTime;
	
	/** 이메일 정보 */
	private List<EmailRecivePO> recipients;

}