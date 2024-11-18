package biz.app.cart.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 상품 쿠폰 VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartCouponGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	//----------------------------------------
	// 상품 정보

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 판매 금액 */
	private Long saleAmt;

	/** 공급 금액 */
	private Long splAmt;

	
	//----------------------------------------
	// 쿠폰 정보
	private List<Coupon> couponList;

	
	
	/**
	 * 쿠폰 정보
	 */
	@Data
	public static class Coupon {

		/** 쿠폰 번호 */
		private Long cpNo;

		/** 쿠폰 명 */
		private String cpNm;

		/** 쿠폰 적용 코드 */
		private String cpAplCd;

		/** 쿠폰 적용 값 */
		private Long aplVal;

		/** 회원 쿠폰 번호 */
		private Long mbrCpNo;

		/** 최대 할인 금액 */
		private Long maxDcAmt;

		
		// 장바구니 목록
		private List<Cart> cartList;

	}

	
	/**
	 * 쿠폰 정보
	 */
	@Data
	public static class Cart {

		/** 장바구니 아이디 */
		private String cartId;

		/** 구매 수량 */
		private Integer buyQty;

		/** 쿠폰 할인 금액 */
		private Long cpDcAmt;
	}
}