package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class NotifyItemSO extends BaseSearchVO<NotifyItemSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 고시 아이디 */
	private String ntfId;

	/** 고시 항목 아이디 */
	private String ntfItemId;

	/** 항목 명 */
	private String itemNm;

	/** 설명 */
	private String dscrt;

	/** 비고 */
	private String bigo;

	/** 상품 ID */
	private String goodsId;

}