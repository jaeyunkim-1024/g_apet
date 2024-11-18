package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoResultDTO.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 결제 완료 DTO
* </pre>
*/
@Data
public class PaycoResultDTO {

	private String reserveOrderNo;	//주문예약번호
	
	private String sellerOrderReferenceKey;	//가맹점주문연동키
	
	private String paymentCertifyToken;	//결제인증토큰(결제승인시필요)
	
	private String totalPaymentAmt; //총 결제금액
	
	private String cart_no;	////주문예약시 전달한 returnUrlParam ({"cart_no" : "A1234"}을 전송했었음.)
	
	private String code; //결과코드(성공 : 0)
	
	private String message;	//결과 메시지
}
