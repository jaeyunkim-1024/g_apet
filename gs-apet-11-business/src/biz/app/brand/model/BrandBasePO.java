package biz.app.brand.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 브랜드 유형 구분 */
	private String bndTpCd;

	/** 대표 브랜드 번호 */
	private Long dlgtBndNo;

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

	/** 브랜드 소개 이미지 */
	private String bndItrdcImgPath;

	/** 노출 상태 */
	private String bndShowYn;

	/** 사이트 명 */
	private Long[] stId;

	/** 브랜드 모바일 소개 */
	private String bndMoItrdc;

	/** 브랜드 모바일 소개 이미지 */
	private String bndItrdcMoImgPath;

	/** 브랜드 콘텐츠 유형 */
	private String bndCntsTpCd;

	/** 카테고리 번호 */
	private Long[] arrDispClsfNo;

	/** 브랜드 신규상품 */
	private String[] arrNewGoodsId;
	/** 브랜드 베스트상품 */
	private String[] arrBestGoodsId;

	/** 브랜드 스토리 */
	private String bndStry;

	/** 썸네일 이미지 */
	private String tnImgPath;

	/** 썸네일 모바일 이미지 */
	private String tnMoImgPath;


	/** 오리진 브랜드  소개 이미지  */
	private String orgBndItrdcImgPath;
	/** 오리진 브랜드 모바일 소개 이미지  */
	private String orgBndItrdcMoImgPath;
	/** 오리진 썸네일 이미지 */
	private String orgTnImgPath;
	/** 오리진 썸네일 모바일 이미지 */
	private String orgTnMoImgPath;



}