package biz.app.pay.service;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.service
* - 파일명		: PaySendService.java
* - 작성일		: 2017. 7. 10.
* - 작성자		: Administrator
* - 설명			: 결제 전송 서비스
* </pre>
*/
public interface PaySendService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PaySendService.java
	* - 작성일		: 2017. 7. 10.
	* - 작성자		: Administrator
	* - 설명			: 결제 환불 완료 메일 및 LMS전송
	* </pre>
	* @param clmNo
	*/
	public void sendRefundComplete(String clmNo);
	
}
