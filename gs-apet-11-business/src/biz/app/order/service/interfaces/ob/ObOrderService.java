package biz.app.order.service.interfaces.ob;

import biz.app.order.model.interfaces.ob.ObApiBasePO;
import biz.app.order.model.interfaces.ob.ObOrderBasePO;
import biz.app.order.model.interfaces.ob.ObOrderHistoryPO;
import biz.app.order.model.interfaces.ob.ObOrderResponsePO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.order.service.interfaces.ob
* - 파일명	: ObOrderService.java
* - 작성일	: 2017. 9. 18.
* - 작성자	: schoi
* - 설명		: Outbound API 주문 서비스
* </pre>
*/

public interface ObOrderService {

	/****************************
	 * Outbound API 이력 정보
	 ****************************/
	public void insertObApiBase(ObApiBasePO obApiBasePO);
	
	/****************************
	 * Outbound API 주문 이력 정보
	 ****************************/
	public void insertObOrderBase(ObOrderBasePO obOrderBasePO);	
	
	/****************************
	 * Outbound API 이력 상세 정보
	 ****************************/
	public void insertObOrderHistory(ObOrderHistoryPO obOrderHistPO);
	
	/****************************
	 * Outbound API Response 이력 상세 정보
	 ****************************/
	public void insertObOrderResponse(ObOrderResponsePO obOrderResponsePO);
	
}
