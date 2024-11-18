package biz.app.promotion.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PromotionFreebiePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 프로모션 번호 */
	private Long prmtNo;

	/** 상품 아이디 */
	private String goodsId;
	
	/** 사은품 수량 */
	private Long frbQty;
	
	/** 공급업체 분담율 */
	private Long splCompDvdRate;


}