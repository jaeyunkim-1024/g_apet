package biz.app.cart.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 쿠폰 SO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartCouponSO extends BaseSearchVO<CartCouponSO> {

	private static final long serialVersionUID = 1L;

	private Long stId;
	
	/** 회원 번호 */
	private Long mbrNo;

	/** 장바구니 아이디 [배열] */
	private String[] cartIds;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 상품 총 구매 가격 */
	private Long totGoodsAmt;
	
	private Long dlvrcPlcNo;
	
	private Long dlvrAmt;
	
	private Long cartSelMbrCpNo;
}