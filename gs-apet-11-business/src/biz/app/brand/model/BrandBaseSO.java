package biz.app.brand.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class BrandBaseSO extends BaseSearchVO<BrandBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 브랜드 유형 구분 */
	private String bndTpCd;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 브랜드 구분 코드 */
	private String bndGbCd;

	/** 사용 여부 */
	private String useYn;

	/** 브랜드 명 영문 */
	private String bndNmEn;

	/** 정렬 순서 */
	private Long sortSeq;

	/** 국문 초성 코드 */
	private String koInitCharCd;

	/** 영문 초성 코드 */
	private String enInitCharCd;

	/** 브랜드 소개 */
	private String bndItrdc;

	/** 브랜드 소개 이미지 경로 */
	private String bndItrdcImgPath;

	/** 업체 상태 */
	private String compStatCd;

	/** 추가 */
	private String bndNm;
	private Long compNo;
	private String compNm;

	private String bndNoArea;
	private Long[] bndNos;
	private String bndNmArea;
	private String[] bndNms;

	/** 노출 상태 */
	private String bndShowYn;

	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/* 브랜드 초성 */
	private String charCdKo;
	private String charNmKo;
	private String charCdEn;
	private String charNmEn;
	/* 브랜드 검색어 */
	private String brandSrchWord;
	/* 브랜드 검색 카테고리 코드 */
	private Long dispClsfNo;
	/** 전시분류번호 - LNB에서 넘긴 값 */
	private Long lnbDispClsfNo;
	/** 상품 카테고리 정보 */
	private Long cateCdL;
	private Long cateCdM;
	
	/* 브랜드 초성 구분 */
	private String initCharGb;
	/* 브랜드 초성 검색 */
	private String initCharCd;
	
	private Long DispPriorRank;
	/** 기획전 정보 */
	private Long exhbtNo;
	
	/** 브랜드 번호 */
	private List<Integer> brandNos;
	private String[] tags;

	public BrandBaseSO(Long bndNo, String bndNm) {
		this.bndNo = bndNo;
		this.bndNm = bndNm;
	}
	
	private String saleOutYn;
}