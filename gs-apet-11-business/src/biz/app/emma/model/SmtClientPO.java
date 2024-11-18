package biz.app.emma.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.emma.model
* - 파일명		: SmtClientPO.java
* - 작성일		: 2017. 2. 2.
* - 작성자		: WilLee
* - 설명			: SMS 수신자 번호 리스트
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SmtClientPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	private Integer mtPr;

	// 순번
	private Integer mtSeq;

	// 메시지 상태 (1-전송대기, 2-결과대기, 3-완료)
	private String msgStatus;

	// 수신자 전화 번호
	private String recipientNum;

}