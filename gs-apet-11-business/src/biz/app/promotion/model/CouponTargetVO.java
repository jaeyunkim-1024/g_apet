package biz.app.promotion.model;

import biz.app.goods.model.GoodsBaseVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponTargetVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 적용 순번 */
	private Long aplSeq;
	
	/** 기획전 번호 */
	private Long exhbtNo;

}