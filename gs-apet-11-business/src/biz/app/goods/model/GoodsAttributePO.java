package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsAttributePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 속성 번호 */
	private Long attrNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 전시우선순위 */
	private Integer dispPriorRank;

}