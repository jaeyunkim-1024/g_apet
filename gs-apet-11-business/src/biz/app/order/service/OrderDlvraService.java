package biz.app.order.service;

 
 
import java.util.List;

import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderDlvraService.java
* - 작성일		: 2017. 1. 26.
* - 작성자		: snw
* - 설명			: 주문 배송지 서비스 Interface
* </pre>
*/
public interface OrderDlvraService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDlvraService.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: Administrator
	* - 설명			: 주문 배송 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDlvraVO> listOrderDlvra(OrderDlvraSO so);
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.order.service
	* - 파일명      : OrderDlvraService.java
	* - 작성일      : 2017. 2. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  배송조회 
	* </pre>
	 */
	public OrderDlvraVO getOrderDlvra(OrderDlvraSO so);

	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.order.service
	* - 파일명      : OrderDlvraService.java
	* - 작성일      : 2017. 2. 28.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 	배송지 수정 
	* </pre>
	 */ 
	public String updateDeliveryAddress(OrderDlvraPO po);
	
}
