package biz.app.cart.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartVO extends BaseSysVO {

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

	/** 바로 구매 여부 */
	private String nowBuyYn;

	/** 세션 아이디 */
	private String ssnId;

	
	/************************
	 * 상품 관련 속성
	 ************************/

	/** 최소 주문 수량 */
	private Integer minOrdQty;

	/** 최대 주문 수량 */
	private Integer maxOrdQty;

	/** 재고 관리 여부 */
	private String stkMngYn;

	
	/************************
	 * 단품 관련 속성
	 ************************/

	/** 웹 재고 수량 */
	private Integer webStkQty;
	
	/** 묶음 상품 번호 */
	private String pakGoodsId;
	
	/** 제작 상품 여부 */
	private String mkiGoodsYn;
	
	/** 제작 상품 옵션 내용 */
	private String mkiGoodsOptContent;
	
	private String goodsCstrtTpCd;

}