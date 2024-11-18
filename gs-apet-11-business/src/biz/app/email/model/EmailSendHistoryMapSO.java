package biz.app.email.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.model
* - 파일명		: EmailSendHistoryMapSO.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 이력 Map SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class EmailSendHistoryMapSO extends BaseSearchVO<EmailSendHistoryMapSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 이력 번호 */
	private Long 	histNo;

}