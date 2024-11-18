package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsEstmQstCtgMapSO.java
* - 작성일	: 2021. 2. 15.
* - 작성자	: valfac
* - 설명 		: 상품 평가 문항 카테고리 매핑 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@SuppressWarnings("serial")
public class GoodsEstmQstCtgMapSO extends BaseSearchVO<GoodsEstmQstCtgMapSO>{

	/** 전시 분류 번호 */
	private Integer dispClsfNo;
	
}
