package biz.app.promotion.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionThemeGoodsVO.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionThemeGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 테마 번호 */
	private Long thmNo;

	/** 테마 이름 */
	private String thmNm;
	
	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 모델 명 */
	private String mdlNm;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;
	
	/** 업체상품 아이디 */
	private String compGoodsId;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 제조사 */
	private String mmft;

	/** 노출 여부 */
	private String showYn;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 브랜드 명 영문 */
	private String bndNmEn;
	
	/** 노출 브랜드 명 */
	private String bndNm;

	/** 판매 금액 */
	private Long saleAmt;

	/** 원 판매 금액 */
	private Long orgSaleAmt;
	
	/** 할인 금액 */
	private Long dcAmt;
	
	/** 최종판매가 */
	private Long foSaleAmt;
	
	/** 이미지 경로 */
	private String imgPath;
	
	/** 상품 대표이미지 순번 */
	private Integer imgSeq;
	
	/** 반전 이미지 경로 */
	private String rvsImgPath;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 비고 */
	private String bigo;
	
	/** 홍보 문구 노출 여부 */
	private String prWdsShowYn;
	
	/** 홍보 문구 */
	private String prWds;
	
	/** 무료 배송 여부 */
	private String freeDlvrYn;
	
	/** 쿠폰 여부 */
	private String couponYn;
	
	/** 신규 여부 */
	private String newYn;
	
	/** 베스트 여부 */
	private String bestYn;
	
	/** 품절 여부 */
	private String soldOutYn;
	
	/** 핫딜 상품 여부 */
	private String dealYn;
	
	/** 찜 여부 */
	private String interestYn;
	
	/** 공동구매 상품 여부 */
	private String groupYn;
	
	/* 공동구매 강제 종료 여부 */
	private String groupEndYn;
}