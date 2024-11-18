package front.web.view.order.model;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-31-front
 * - 패키지명	: front.web.view.order.model
 * - 파일명		: CartDeliveryPrice.java
 * - 작성일		: 2021. 02. 03.
 * - 작성자		: JinHong
 * - 설명		: 장바구니 배송비정책 별 배송비
 * </pre>
 */
@Data
public class CartDeliveryTotalInfo {
	
	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;
	
	/** 총 상품 금액 */
	private Long totalGoodsAmt;
	
	/** 총 쿠폰 할인 금액 */
	private Long totalCpDcAmt;

	/** 총 배송비 금액 */
	private Long totalDlvrAmt;
	
	/** 업체 구분 코드 */
	private String compGbCd;
	
}
