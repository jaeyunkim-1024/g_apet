package biz.app.brand.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.brand.model
* - 파일명 	: BrandCisVO.java
* - 작성일	: 2021. 4. 7.
* - 작성자	: valfac
* - 설명 		: 브랜드 cis vo
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCisVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Integer brndNo;
	/** 브랜드 이름 */
	private String brndNm;
	/** 사용여부 */
	private String useYn;
	
}