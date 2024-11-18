package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsAttributeSO extends BaseSearchVO<GoodsAttributeSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 전시우선순위 */
	private Integer dispPriorRank;

	/** 유효 단품 여부  : 단품에 사용된 속성만 가져올 경우 true */
	private Boolean validItem;













	/** 속성 번호 */
	private Integer attrNo;

}