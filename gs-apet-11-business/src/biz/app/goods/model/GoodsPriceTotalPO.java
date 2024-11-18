package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsPriceTotalPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 판매 금액 */
	private Long saleAmt;

	/** 할인 금액 */
	private Long dcAmt;

	/** 쿠폰 금액 */
	private Long cpAmt;

	/** 상품 아이디 */
	private String goodsId;

}