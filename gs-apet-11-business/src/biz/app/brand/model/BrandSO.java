package biz.app.brand.model;

import java.io.Serializable;
import java.util.List;

import biz.app.st.model.StStdInfoVO;
import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: BrandSO.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 브랜드 Search Object
* </pre>
*/
@Data
public class BrandSO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 브랜드 명 */
	private String	bndNm;
	/** 브랜드 초성 문자 구분 코드 */
	private String 	initCharGbCd;
	/** 브랜드 초성 문자 코드 */
	private String 	initCharCd;
	/** 브랜드 카테고리 코드 */
	private String	bndCtgCd;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 대표 브랜드 번호 */
	private Long DlgtBndNo;

	/** 전시분류번호 */
	private Long dispClsfNo;

	/** 전시분류번호리스트 */
	private List<Long> dispClsfNos;

	/** 전시 분류 코드 */
	private String dispClsfCd;
	
	/** 브랜드 상품 전시 구분 10 new , 20 best */
	private String bndGoodsDispGb;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 사이트 정보 목록 */
	private List<StStdInfoVO> stStdList;
	
}