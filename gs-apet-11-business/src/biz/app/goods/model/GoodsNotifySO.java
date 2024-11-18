package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsNotifySO extends BaseSearchVO<GoodsNotifySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 고시 항목 아이디 */
	private String ntfItemId;

	/** 항목 값 */
	private String itemVal;

	/** 상품 아이디 */
	private String goodsId;

}