package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoReserveResult.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 예약 결과
* </pre>
*/
@Data
public class PaycoReserveResult {


	private String code;
	
	private String message;
	
	private PaycoReserveResultObj result;
	
	@Data
	public class PaycoReserveResultObj{
		private String reserveOrderNo;
		private String orderSheetUrl;
	}

}
