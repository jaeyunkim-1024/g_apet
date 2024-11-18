package biz.interfaces.payco.model;

import java.util.ArrayList;
import java.util.List;

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
public class PaycoApproveResult {

	private String code;

	private String message;
	
	private String ordNo;
	
	private String orderCertifyKey;
	
	private String sellerOrderReferenceKey;
	
	private List<PaycoPayment> payList;

}
