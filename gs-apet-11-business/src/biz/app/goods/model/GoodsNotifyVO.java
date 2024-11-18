package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsNotifyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 고시 항목 아이디 */
	private String ntfItemId;

	/** 항목 값 */
	private String itemVal;

	/** 상품 아이디 */
	private String goodsId;
	
	/** 항목 명 */
	private String	itemNm;
	/** 항목 설명 */
	private String	dscrt;
	/** 비고 */
	private String	bigo;

	private String goodsNm;
}