package biz.common.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.model
* - 파일명		: LmsSendDTO.java
* - 작성일		: 2019. 7. 12.
* - 작성자		: SIG
* - 설명		: Slack
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SlackSO {

	private static final long serialVersionUID = 1L;

	/** 채널 이름 */
	private String chlNm;
	
	/** 메세지 이름 */
	private String msgNm;
	
	/** 메세지 내용 */
	private String msgCont;
	
	
}