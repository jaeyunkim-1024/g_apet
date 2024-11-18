package biz.app.goods.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsListSO.java
* - 작성일		: 2017. 06. 16.
* - 작성자		: wyjeong
* - 설명		: FO 상품 리스트 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsListSO extends BaseSearchVO<GoodsListSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 업체 번호 */
	private Long compNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 전시분류번호 */
	private Long dispClsfNo;	
	private List<Long> dispClsfNos;	
	
	/** 전시 코너 번호 */
	private Long dispCornNo;
	
	/** 전시 분류 번호 */
	private Long upDispClsfNo;
	
	/** 웹/모바일 구분코드 */
	private String webMobileGbCd;
	private List<String> webMobileGbCds;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 베스트 상품 전시코너 번호 */
	private Long dispCornNoBest;
	
	/** 정렬 타입 */
	private String sortType;
	
	/** 카테고리 유형 구분 (BEST/일반) */
	private String ctgGb;
	
	private Integer limitCount;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	
	/** 딜상품 여부 */
	private String dealYn;
	
	/** 무료 배송 여부 */
	private String freeDlvrYn;
	
	/** 쿠폰 여부 */
	private String couponYn;
	
	/** 기기구분 [PC, MO, APP]*/
	private String deviceGb;
}