package biz.app.goods.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.model
* - 파일명		: ItemAttributeValueSO.java
* - 작성일		: 2017. 2. 6.
* - 작성자		: snw
* - 설명			: 단품 속성 값 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ItemAttributeValueSO extends BaseSearchVO<ItemAttributeValueSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/** 속성 번호 */
	private Long attrNo;
	
	/** 속성 값 번호 */
	private Long attrValNo;
	
	/** 상품 아이디 */
	private String goodsId;


	
	private List<Long> itemNos;
	

}