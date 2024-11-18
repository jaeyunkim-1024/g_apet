package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoReserveDTO.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 예약 DTO
* </pre>
*/
@Data
public class PaycoReserveDTO {

	/* Result URL */
	private String returnUrl;
	
	/* 주문 번호 */
	private String ordNo;
	
	/* 상품 명 */
	private String goodsNm;
	
	/* 상품 금액 */
	private String goodsAmt;
	
	/* 주문 채널 */
	private String channel;	//PC or MOBILE	CommonConstants.PAYCO_CHANNLE_ 참조

}
