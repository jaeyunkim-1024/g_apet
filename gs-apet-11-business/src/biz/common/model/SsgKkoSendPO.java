package biz.common.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: SsgKkoSendPO.java
* - 작성일		: 2021. 1. 27.
* - 작성자		: snw
* - 설명		: KKO 전송 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SsgKkoSendPO extends SsgMmsSendPO{

	private static final long serialVersionUID = 1L;

	/** KKO발신프로필키 (카카오 전송을 위해 승인받은 프로필키) */
	private String	fyellowid;

	/** KKO 친구톡전용 제목 */
	private String fkkosubject;

	/* KKO 템플릿키 */
	private String ftemplatekey;

	/** KKO 버튼(링크기능, JSON 이용) */
	private String fkkobutton;

	/** KKO/KKF 재발송 메시지 타입(SMS/LMS) */
	private String fkkoresendtype;

	/** KKO/KKF SMS재발송 메시지 내용 */
	private String fkkoresendmsg;

	/** KKO/KKF 재발송 횟수 재발송 최대 1회 */
	private Long fretry;
	
	/** 메세지 구분 코드 */
	private String deviceTypeCd;
}