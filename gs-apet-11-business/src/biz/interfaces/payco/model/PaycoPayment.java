package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoApproveResult.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 승인 결과
* </pre>
*/
@Data
public class PaycoPayment {
	
	private String paymentTradeNo;
	private String paymentMethodCode;	//결제 수단
	private String paymentMethodName;
	private String tradeYmdt;
	
	private String cardCompanyName;
	private String cardCompanyCode;
	private String cardNo;
}
