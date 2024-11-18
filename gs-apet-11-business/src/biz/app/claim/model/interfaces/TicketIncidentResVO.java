package biz.app.claim.model.interfaces;

import biz.app.cart.model.CartGoodsVO;
import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.claim.model.interfaces
 * - 파일명		: TicketIncidentResVO.java
 * - 작성일		: 2021. 03. 22.
 * - 작성자		: JinHong
 * - 설명		: 티켓 사건 추가 응답 VO
 * </pre>
 */
@Data
public class TicketIncidentResVO{
	
	private String code;
	
	private String message;
	
	private ResData data;
	
	@Data
	public class ResData {
		private String ticketDispId;
		
		private String eventDescription;
		
		private String wirteAgentLoginId;
		
	}

}