package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentScoreVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;
	
	/*상품 평가 점수 */
	private Integer estmScore;
	
	/* 상품 평가 수 */
	private Integer scoreTotal;

	/* 상품 평가 평균 */
	private Double estmAvg;
	
	/* 최고점 여부 */
	private String maxYn;
}
