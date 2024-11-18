package biz.interfaces.payco.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.payco.model
* - 파일명		: PaycoCancelDTO.java
* - 작성일		: 2016. 5. 17.
* - 작성자		: snw
* - 설명		: Payco 승인 DTO
* </pre>
*/
@Data
public class PaycoCancelDTO {

	private String cancelType;						//취소 Type 받기 - ALL 또는 PART  CommonConstants : PAYCO_CANCEL_TYPE_ALL, PAYCO_CANCEL_TYPE_PART
	private String orderNo;							//PAYCO에서 발급받은 주문번호
	private String orderCertifyKey;					//PAYCO에서 발급받은 주문인증 key
	private String cancelTotalAmt;					//총 취소 금액
	private String totalCancelPossibleAmt;			//총 취소가능금액
	private String sellerOrderProductReferenceKey;	//가맹점 주문 상품 연동 키(PART 취소 시)
	private String cancelDetailContent;				//취소 상세 사유
	private String cancelAmt;						//취소 상품 금액(PART 취소 시)
	private String requestMemo;						//취소처리 요청메모

}
