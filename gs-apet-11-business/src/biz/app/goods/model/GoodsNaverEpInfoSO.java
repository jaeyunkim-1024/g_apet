package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsNaverEpInfoSO.java
* - 작성일	: 2021. 1. 18.
* - 작성자	: valfac
* - 설명 		:
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsNaverEpInfoSO extends BaseSearchVO<GoodsNaverEpInfoSO> {
	
	/** 상품 아이디 */
	private String goodsId;
}
