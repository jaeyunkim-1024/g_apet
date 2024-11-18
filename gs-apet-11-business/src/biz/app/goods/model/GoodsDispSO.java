package biz.app.goods.model;

import lombok.*;

import java.util.List;

import biz.app.brand.model.BrandBaseVO;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsDispSO.java
 * - 작성일     : 2021. 02. 15.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GoodsDispSO {

	/** 상품 아이디 */
	private String	goodsId;
	
	/** 전시 타입 **/
	private String dispType;
	private String timeDeal;

	/** 전시 분류 타입 */
	private String dispCornType;

	/** 판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체 ) */
	private String salePeriodYn;

	/** 품절상품 조회 여부  (Y : 품절상품 조회 , N : 품절상품 제외 ) */
	private String saleOutYn;

	/** 조회 기간 ( 일간 : DAY, 주간 : WEEK, 월간 : MONTH ) */
	private String period;

	/** 사이트 아이디 **/
	private Long stId;
	
	/** 전시분류번호 */
	private Long dispClsfNo;
	/** 전시분류번호 - LNB에서 넘긴 값 */
	private Long dispClsfNo2;
	private Long lnbDispClsfNo;
	private Long petGbDispClsfNo;
	/** 상위전시분류번호 */
	private Long upDispClsfNo;
	
	/** 전시 코너 번호 */
	private Long dispCornNo;

	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 조회용 - 베스트 여부 */
	private Long dispCornNoBest;

	/** 조회용 - 회원 번호 */
	private Long mbrNo;

	/*펫 번호*/
    private Long petNo;
    
	/*펫 리스트*/
    private String petNos;
    
	/** 정렬 */
	private String order;
	
	/** 현재 페이지 */
	private int page = 0;

	/** 한페이지당 보여줄 리스트 수 */
	private Integer	rows;

	/** 총 카운트 */
	private Integer totalCount = 0;
	
	/** 기기구분 [PC, MO, APP]*/
	private String deviceGb;

	/**
	 * 검색 필터 리스트
	 * 카테고리 : 필터관리의 필터 그룹_seq
	 * 패키지 상품 목록 : 1PLUS1, 2PLUS1, GIFT, ETC
	 */
	private List<String> filters;
	private int filterCount;
	/**
	 * 패키지 상품의 기본 필터 조건
	 */
	private List<String> filterCondition;
	private List<String> filterNm;
	private List<Integer> bndNos;
	
	private String filter;
	
	/** 브랜드 번호 */
	private Long bndNo;
	
	/** 미리보기 날짜 */
    private String previewDt;
    
    /** 상품금액유형코드 */
	private String goodsAmtTpCd;
	
	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;
	
	/** 사전예약 상품 조회 여부 */
	private String reservedYn;
	
	/** 상품 카테고리 정보 */
	private Long cateCdL;
	private Long cateCdM;
	private Long cateCdS;

	/** 기획전 정보 */
	private Long thmNo;
	private Long exhbtNo;
	private String exhbtGbCd;
	
	/** 검색 월- 3개월,6개월, 12개월 */
	private Integer searchMonth;

	private String[] icons;
	private String[] tags;
	private String tagNm;

	/** 패키지 상품 필터 검색시 상품 구성 유형 조건 : Y : 묶음상품, 세트상품 조회 , N : X */
	private String goodsCstrtYn;

	/** 상품 필터 속성 목록  */
	private List<GoodsFiltAttrVO> goodsFiltAttrList;
	private List<GoodsFiltAttrVO> getFilter;
	private List<BrandBaseVO> getBrand;
	
	/** call 구분 */
	private String callGb;
	
	/** 초기 호출 Cnt */
	private Long dvsnCornerCnt;
}
