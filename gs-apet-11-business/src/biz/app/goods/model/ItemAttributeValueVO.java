package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.model
* - 파일명		: ItemAttributeValueVO.java
* - 작성일		: 2017. 2. 6.
* - 작성자		: snw
* - 설명			: 단품 속성 값 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ItemAttributeValueVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;

	/** 속성 번호 */
	private Long attrNo;

	/** 속성 값 */
	private String attrNm;

	/** 속성 값 번호 */
	private Long attrValNo;

	/** 속성 값 */
	private String attrVal;

	/** 전시우선순위 */
	private Integer dispPriorRank;

}