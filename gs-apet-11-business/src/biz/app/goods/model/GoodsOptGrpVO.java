package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsOptGrpVO.java
* - 작성일	: 2021. 1. 22.
* - 작성자	: valfac
* - 설명 		: 상품 옵션 그룹  VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsOptGrpVO extends BaseSysVO {

	/** 상품 옵션 그룹 번호  */
	private Long goodsOptGrpNo;
	
	/** 상품 아이디  */
	private String goodsId;
	
	/** 속성 번호  */
	private Long attrNo;
	
	/** 노출명  */
	private String showNm;
	
	/** 전시우선순위  */
	private Integer dispPriorRank;
	
}