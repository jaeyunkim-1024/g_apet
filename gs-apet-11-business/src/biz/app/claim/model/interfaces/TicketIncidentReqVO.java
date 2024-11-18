package biz.app.claim.model.interfaces;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.claim.model.interfaces
 * - 파일명		: TicketIncidentVO.java
 * - 작성일		: 2021. 03. 22.
 * - 작성자		: JinHong
 * - 설명		: 티켓 사건 추가 VO
 * </pre>
 */
@Data
public class TicketIncidentReqVO{
	
	/** API KEY */
	private String apiKey;
	
	/** 이벤트 코드 */
	private String eventCode;
	
	/** 티켓 사건의 추가 입력사항 */
	private String content;
	
	/** 상담사 로그인 아이디 */
	private String agentLoginId;
	
	/** 티켓 번호 */
	private String ticketDispId;

}