package biz.app.member.model;

import java.util.List;

import biz.app.goods.model.GoodsBaseVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: MemberInterestGoodsVO.java
* - 작성일		: 2016. 4. 29.
* - 작성자		: snw
* - 설명		: 회원 관심상품 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberInterestGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 상품 아이디 */
	private String	goodsId;

	/** 상품명 */
	private String goodsNm;

	/** 상품 상태 */
	private String goodsStatCd;

	/** 이미지 순번 */
	private Integer imgSeq;

	/** 이미지 경로 */
	private String imgPath;

	/** 반전 이미지 경로 */
	private String rvsImgPath;

	/** 판매 금액 */
	private Long saleAmt;

	/** 원 판매 금액 */
	private Long orgSaleAmt;
	
	/** 할인 금액 */
	private Long dcAmt;
	
	/** 최종판매가 */
	private Long foSaleAmt;
	
	/** 할인율 */
	private Long dcRate;

	/** 적립금 */
	private Long saveAmt;

	/** 상품 품절 여부 */
	private String goodsSoldoutYn;

	/** 브랜드 명 */
	private String bndNmKo;
	private String bndNm;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 웹 재고 수량 */
	private Long webStkQty;

	/** 프로모션 번호 */
	private Long 	prmtNo;

	/** 프로모션 할인 금액 */
	private Long	prmtDcAmt;

	/** 가격정보 */
	private String goodsPriceInfo;

	/** 연관상품 */
	private List<GoodsBaseVO> relatedGoodsList;

	/** 찜여부 */
	private String interestYn;
	
	/** 품절 여부*/
	private String soldOutYn;
	
	/** 핫딜 상품 여부 */
	private String dealYn;
	
	/** 공동구매 상품 여부 */
	private String groupYn;
	
	/* 공동구매 강제 종료 여부 */
	private String groupEndYn;
}