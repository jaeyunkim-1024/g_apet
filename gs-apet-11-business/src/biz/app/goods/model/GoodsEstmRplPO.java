package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsEstmRplPO extends BaseSysVO{

	private static final long serialVersionUID = 1L;
	
	/** 평가 답변 번호 */
	private Long estmRplNo;
	
	/* 상품평 번호 */
	private Long goodsEstmNo;
	
	/* 평가 문항 번호 */
	private Long estmQstNo;
	
	/*  평가 항목 번호 */
	private Long estmItemNo;
	
	/* 평가 점수 */
	private Integer estmScore;
}
