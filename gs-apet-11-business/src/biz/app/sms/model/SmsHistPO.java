package biz.app.sms.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.model
* - 파일명		: SmsHistPO.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: snw
* - 설명		: Sms 전송이력 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SmsHistPO extends BaseSysVO{

	private static final long serialVersionUID = -7985465446021295468L;

	private String	smsHistId;
	
	private String	smsGbCd;
	
	private String 	sndNo;
	
	private String	ttl;
	
	private String	content;
	
	private String 	rsvYn;
	
	private String rsvDtm;
	
	private String usrDfn1;
	
	private String usrDfn2;
	
	private String sndRstStat;
	
	private String RstCd;
	
	private String RstMsg;
	
	private String RstSndCnt;
	
	private String RstRmnCnt;
	
}