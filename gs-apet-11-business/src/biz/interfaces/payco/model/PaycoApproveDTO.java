package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoReserveDTO.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 승인 DTO
* </pre>
*/
@Data
public class PaycoApproveDTO {
		
	private String reserveOrderNo;	//주문예약번호
	
	private String sellerOrderReferenceKey;	//가맹점주문연동키
	
	private String paymentCertifyToken;	//결제인증토큰(결제승인시필요)
	
	private Long totalPaymentAmt;	//총 결제금액
	
	private String cart_no;
	
	private String code;
	
	private String message;
	
	

}
