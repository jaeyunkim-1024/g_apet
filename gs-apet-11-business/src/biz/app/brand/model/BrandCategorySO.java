package biz.app.brand.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.model
* - 파일명		: BrandCategorySO.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 카테고리 Search Object
* </pre>
*/
@Data
public class BrandCategorySO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/** 브랜드 번호 */
	private Long bndNo;
	
	/** 웹 모바일 구분 코드 */
	private List<String> webMobileGbCds;
	
	/** 사이트 ID */
	private Long stId;
}