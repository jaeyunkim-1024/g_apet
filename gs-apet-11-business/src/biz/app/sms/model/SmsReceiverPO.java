package biz.app.sms.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.model
* - 파일명		: SmsReceiverPO.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: snw
* - 설명		: Sms 수신자 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SmsReceiverPO extends BaseSysVO{

	private static final long serialVersionUID = -7985465446021295468L;

	private String	smsHistId;
	
	private Integer	rcvSeq;

	private String	rcvrNo;
	
	private String	rcvrNm;
	
}