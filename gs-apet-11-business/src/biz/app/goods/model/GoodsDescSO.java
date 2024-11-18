package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsDescSO.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 설명 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsDescSO extends BaseSearchVO<GoodsDescSO>{

	private static final long serialVersionUID = 1L;
	
	/* 상품 아이디 */
	private String	goodsId;	
	/* 전시 여부 */
	private String	svcGbCd;	
}