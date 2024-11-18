package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsOptGrpSO.java
* - 작성일	: 2021. 1. 22.
* - 작성자	: valfac
* - 설명 		: 상품 옵션 그룹 SO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsOptGrpSO extends BaseSearchVO<GoodsOptGrpSO> {

	/** 상품 아이디  */
	private String goodsId;
	
}