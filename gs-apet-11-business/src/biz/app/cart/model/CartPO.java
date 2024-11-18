package biz.app.cart.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 PO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 장바구니 아이디 */
	private String cartId;

	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 번호 */
	private Long itemNo;

	/** 구매 수량 */
	private Integer buyQty;

	/** 세션 아이디 */
	private String ssnId;

	/** 바로 구매 여부 */
	private String nowBuyYn;

	/** 세션 아이디 */
	private String oldSsnId;

	/** 회원 여부 */
	private String mbrYn;

	/** 보관기간 */
	private Integer strgPeriod;
	
	/** 묶음 상품 번호 */
	private String pakGoodsId;
	
	/** 상품 선택 여부 */
	private String goodsPickYn;
	
	/** 제작 상품 옵션 내용 */
	private String mkiGoodsOptContent;
	
	/** 제작 상품 여부 */
	private String mkiGoodsYn;
}