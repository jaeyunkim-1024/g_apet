package biz.app.brand.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.model
* - 파일명		: BrandCategoryPO.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 카테고리 Param Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCategoryPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Integer	bndNo;
	/** 브랜드 카테고리 코드 */
	private String	bndCtgCd;

}