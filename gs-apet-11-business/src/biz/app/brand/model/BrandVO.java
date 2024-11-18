package biz.app.brand.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.model
* - 파일명		: BrandVO.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class BrandVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Integer bndNo;
	/** 브랜드 명 국문 */
	private String	bndNmKo;
	/** 국문 초성 코드 */
	private String	koInitCharCd;
	/** 브랜드 명 영문 */
	private String	bndNmEn;
	/** 영문 초성 코드 */
	private String	enInitCharCd;
	/** 브랜드 구분 코드 */
	private String 	bndGbCd;
	/** 브랜드 소개 */
	private String	bndItrdc;
	/** 브랜드 소개 이미지 경로*/
	private String	bndItrdcImgPath;
	/** 정렬 순번 */
	private Integer	sortSeq;
	/** 사용 여부 */
	private String	useYn;
	/** 초성 코드 */
	private String	dtlCd;
	/** 초성 명 */
	private String	dtlNm;
	/** 브랜드 분류 */
	private String	dispClsfNo;	
	
	private String	bndNm;
}