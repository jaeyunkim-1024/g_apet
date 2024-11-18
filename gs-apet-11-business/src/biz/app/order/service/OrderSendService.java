package biz.app.order.service;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderSendService.java
* - 작성일		: 2017. 6. 30.
* - 작성자		: Administrator
* - 설명			: 주문 전송 서비스
* </pre>
*/
public interface OrderSendService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderSendService.java
	* - 작성일		: 2017. 6. 30.
	* - 작성자		: Administrator
	* - 설명			: 주문 메일 및 Sms 전송
	* </pre>
	* @param ordNo
	*/
	public void sendOrderInfo(String ordNo);
	
}
