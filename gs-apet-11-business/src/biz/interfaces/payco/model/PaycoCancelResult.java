package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoCancelResult.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 취소 결과
* </pre>
*/
@Data
public class PaycoCancelResult {


	private String code;
	
	private String message;
	
	private String cancelTradeSeq;	//주문취소번호
	
//	private PaycoCancelResultObj result;
	
	private String totalCancelPaymentAmt;	//취소상품금액
	
//	@Data
//	public class PaycoCancelResultObj{
//		private String cancelTradeSeq;	//주문취소번호
//		private String totalCancelPaymentAmt;	//취소상품금액
//	}


}
