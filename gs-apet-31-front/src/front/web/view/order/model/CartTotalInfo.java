package front.web.view.order.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.order.model
* - 파일명		: CartTotalInfo.java
* - 작성일		: 2017. 7. 17.
* - 작성자		: Administrator
* - 설명			: 장바구니 선택상품 합계 정보
* </pre>
*/
@Data
public class CartTotalInfo {
	
	/** 총 상품 금액 */
	private Long totalGoodsAmt;

	/** 총 배송비 금액 */
	private Long totalDlvrAmt;

	/** 총 금액 */
	private Long totalAmt;
	
	/** 총 적립 예정 금액 */
	private Long totalSvmnAmt;
}
