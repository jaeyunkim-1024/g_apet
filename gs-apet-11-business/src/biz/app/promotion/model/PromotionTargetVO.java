package biz.app.promotion.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import biz.app.goods.model.GoodsBaseVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PromotionTargetVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 프로모션 번호 */
	private Long prmtNo;

	/** 적용 순번 */
	private Long aplSeq;

	/** 공급업체 분담율 */
	private Long splCompDvdRate;
}