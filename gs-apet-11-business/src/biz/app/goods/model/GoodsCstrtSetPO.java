package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsCstrtSetPO.java
* - 작성일	: 2021. 1. 8.
* - 작성자	: valfac
* - 설명 		: 상품 세트 구성 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtSetPO extends BaseSysVO {

	/** 상품 아이디 */
	private String goodsId;

	/** 세트 상품 번호 */
	private String subGoodsId;

	/** 구성 수량 */
	private Integer cstrtQty;
	
	/** 전시 순서  */
	private Integer dispPriorRank;

}