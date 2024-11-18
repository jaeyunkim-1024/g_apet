package biz.app.attribute.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.attribute.model
* - 파일명		: AttributeValueVO.java
* - 작성일		: 2017. 2. 6.
* - 작성자		: snw
* - 설명			: 속성 값 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class AttributeValueVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 속성 번호 */
	private Long attrNo;

	/** 속성 값 번호 */
	private Integer attrValNo;

	/** 속성 값 */
	private String attrVal;

	/** 사용 여부 */
	private String useYn;

	/** 속성 명 */
	private String attrNm;
	
	/** 상품 번호 */
	private Long itemNo;
	
	/** 상품 가격 */
	private Long saleAmt;
	
	/** 상품id */
	private String goodsId;
	
	/** 상품판매여부 */
	private String salePsbCd;
	
	/** 품절여부 */
	private String soldOutYn;
	
	/** 입고알림여부 */
	private String ioAlmYn;
}