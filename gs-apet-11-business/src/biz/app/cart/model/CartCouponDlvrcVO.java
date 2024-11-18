package biz.app.cart.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 배송비 쿠폰 VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartCouponDlvrcVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private Long dlvrcPlcNo;
	
	private String compGbCd;
	
	private Long compNo;
	
	private String compNm;
	
	
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
		
		/** 최소 구매 금액 */
		private Long minBuyAmt;
		
		/** 최대 할인 금액 */
		private Long maxDcAmt;
		
		private Long aplDcAmt;
		
		/** 이용안내 */
		private String notice;
		
		private boolean isSelected = false;
		
		private Long leftSeconds;
	}
	
	
	
	
	
	//===================아래 사용안함===================
	
	//----------------------------------------
	// 상품 정보
	
	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	
	//----------------------------------------
	// 배송비 쿠폰 관련 항목

	/** 패키지 배송비 번호 */
	private Integer pkgDlvrNo;

	/** 패키지 배송비 금액 */
	private Long pkgDlvrAmt;

	
	//----------------------------------------
	// 장바구니 정보
	private List<Cart> cartList;

	
	

	
	/**
	 * 장바구니 정보
	 */
	@Data
	public static class Cart {

		/** 장바구니 아이디 */
		private String cartId;
	}

}