package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsTagMapPO.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 상품 태그 맵 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class GoodsTagMapPO extends BaseSysVO {

	/** 상품 아이디 */
	private String goodsId;
	
	/** 태그 번호 */
	private String tagNo;

}
