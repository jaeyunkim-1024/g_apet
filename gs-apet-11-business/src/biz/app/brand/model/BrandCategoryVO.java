package biz.app.brand.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.model
* - 파일명		: BrandCategoryVO.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 카테고리 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCategoryVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Long	bndNo;

	/** 전시분류 코드 */
	private Long	dispClsfNo;

}