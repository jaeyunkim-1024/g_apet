package biz.app.cart.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 쿠폰 VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartCouponVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

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
	
	private String notice;
	
	private boolean isSelected = false;
	
}