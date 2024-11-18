package biz.app.cart.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 SO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartSO extends BaseSearchVO<CartSO> {

	private static final long serialVersionUID = 1L;

	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 세션 아이디 */
	private String ssnId;

	/** 장바구니 아이디 */
	private String cartId;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 번호 */
	private Long itemNo;

	/** 바로 구매 여부 */
	private String nowBuyYn;
	
	/** 묶음 상품 번호 */
	private String pakGoodsId;
	
	/** 장바구니 아이디 [배열] */
	private String[] cartIds;

}