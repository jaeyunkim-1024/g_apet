package biz.app.promotion.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import biz.app.goods.model.GoodsBaseVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PromotionFreebieVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사은품 번호 */
	private Integer frbNo;

	/** 프로모션 번호 */
	private Long prmtNo;
	
	/** 사은품 수량 */
	private Long frbQty;
	
	/** 공급업체 분담율 */
	private Long splCompDvdRate;

}