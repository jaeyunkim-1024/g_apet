package biz.app.brand.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.model
* - 파일명		: BrandSeriesVO.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 초성단위 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class BrandInitialVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 초성 구분 코드 */
	private String	initCharGbCd;	
	/** 초성 코드 */
	private String	initCharCd;
	/** 초성 명 */
	private String	initCharNm;
	
	
	/** 브랜드 카테고리의 브랜드 목록 */
	private List<BrandVO> brandList;
}