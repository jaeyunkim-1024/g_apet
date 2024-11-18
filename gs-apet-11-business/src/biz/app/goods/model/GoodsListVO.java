package biz.app.goods.model;

import java.util.List;

import biz.app.tag.model.TagBaseVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.goods.model
 * - 파일명		: GoodsListVO.java
 * - 작성자		: ValueFactory
 * - 설명		: FO 상품 리스트 VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsListVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String	goodsId;

	/** 상품 명 */
	private String	goodsNm;

	/** 홍보 문구 노출 여부 */
	private String	prWdsShowYn;
	
	/** 홍보 문구 */
	private String	prWds;

	/** 노출 브랜드 명 */
	private String	bndNm;
	
	/** 판매 금액 */
	private Long	saleAmt;

	/** 원 판매 금액 */
	private Long	orgSaleAmt;
	
	/** 할인 금액 */
	private Long	dcAmt;
	
	/** 최종판매가 */
	private Long	foSaleAmt;
	
	/** 상품 대표이미지 순번 */
	private Integer	imgSeq;
	
	/** 이미지 경로 */
	private String	imgPath;

	/** 배너 경로 */
	private String	bannerPath;
	
	/** 무료 배송 여부 */
	private String	freeDlvrYn;

	/** 쿠폰 여부 */
	private String	couponYn;
	
	/** 신규 여부 */
	private String	newYn;
	
	/** 베스트 여부 */
	private String	bestYn;
	
	/** 품절 여부 */
	private String	soldOutYn;
	
	/** 위시리스트 여부*/
	private String	interestYn; 
	
	/** 상품평 수 */
	private Long	commentCnt;
	
	/** 업체 번호 */
	private Long	compNo;
	
	/** 업체 명 */
	private String	compNm;
	
	/** 쿠폰 명 */
	private String	couponNm;
	
	/** 핫딜 상품 여부 */
	private String	dealYn;
	
	/** 매칭률*/
	private String rate;
	
	/** 태그 리스트 */
	private List<TagBaseVO> goodsTagList;
	
	/** 태그 */
	private String[] tags;
	
	/** 태그 */
	private String tag;
	
	/** MD 추천 문구 */
	private String mdRcomWds;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo2;
	
	/** 전시 분류 번호 */
	private Long upDispClsfNo;

	/** 전시 분류 명 */
	private String dispClsfNm;
	
	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 판매 가능 상태 코드 */
	private String salePsbCd;
}