package biz.app.cart.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 사은품 재고 체크 VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartFreebieRtnVO  {

	/** 장바구니 아이디 */
	private String cartId;
	
	/** 재고 체크 성공 여부 */
	private Boolean isOk = false;
	
	/** 재고 체크 실패 코드 : 
	 * 10 : 사은품 품절
	 * 20 : 사은품 재고 부족
	 * 30 : 사은품 품절과 재고부족
	 * */
	private String rtnCode;
	
	/** 재고 품절 사은품 */
	private CartGoodsVO.Freebie freebie;
	
	/** 주문 사은품 목록 */
	private List<CartGoodsVO.Freebie> freebieList;
}