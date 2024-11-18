package biz.app.cart.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 상품 SO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartGoodsSO extends BaseSearchVO<CartGoodsSO> {

	private static final long serialVersionUID = 1L;

	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 세션 아이디 */
	private String ssnId;

	/** 바로 구매 여부 */
	private String nowBuyYn;

	/** 장바구니 아이디 [배열] */
	private String[] cartIds;
	
	/** 상품 아이디 [배열] */
	private String[] goodsIds;
	
	/** 제외 상품 아이디 */
	private String[] exGoodsIds;
	
	private String cartId;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;
	
	/** 미니 장바구니 여부 */
	private boolean isMiniCart = false;
	
	private List<Cart> cartList;
	
	/** 장바구니 유효성 체크 */
	private Integer buyQty;
	private String goodsId;
	
	/** 장바구니 세트상품 체크 */
	private String goodsCstrtTpCd;
	
	/** 상품 카테고리 정보 */
	private Long cateCdL;
	
	@Data
	public static class Cart {

		private String cartId;

		private String buyQty;
		
		private Long selMbrCpNo;
		
		/** 쿠폰적용팝업 노출할 상품 여부 */	
		private boolean isSelected = false;
		
		public void setIsSelected(boolean isSelected) {
			this.isSelected = isSelected;
		}
	}
	
	@Data
	public static class CartCoupon {
		private Long mbrCpNo;
	}
	
	@Data
	public static class DlvrcCoupon {
		
		private Long dlvrcPlcNo;
		
		private Long dlvrAmt;
		
		private Long mbrCpNo;
		
		
		//===사용안함=== 
		private String cartId;
		
		private Integer PkgDlvrNo;
		
		private Long PkgDlvrAmt;
	}
}