package biz.common.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.model
* - 파일명		: LmsSendDTO.java
* - 작성일		: 2016. 4. 21.
* - 작성자		: snw
* - 설명		: Lms 전송 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class LmsSendPO extends SmsSendPO{

	private static final long serialVersionUID = 1L;

	/** 제목 */
	private String	subject;
	
}