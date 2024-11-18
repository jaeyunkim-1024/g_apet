package biz.app.cart.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 장바구니 상품 VO
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CartGoodsVO extends DeliveryChargeCalcVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 장바구니 아이디 */
	private String cartId;

	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 번호 */
	private Long itemNo;
	
	/** 단품 번호 */
	private String pakGoodsId;
	
	/** 상품 구성 유형 코드 */
	private String goodsCstrtTpCd;
	
	/** 구매 수량 */
	private Integer buyQty;

	/** 구매 금액 */
	private Long buyAmt;

	/** 바로 구매 여부 */
	private String nowBuyYn;

	/** 세션 아이디 */
	private String ssnId;
	
	/** 찜 여부 */
	private String interestYn;

	
	/************************
	 * 상품 관련 속성
	 ************************/
	/** 상품 명 */
	private String goodsNm;
	
	/** 묶음상품 옵션 명 */
	private String optGoodsNm;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 이미지 순번 */
	private Integer imgSeq;

	/** 이미지 경로 */
	private String imgPath;

	/** 최소 주문 수량 */
	private Integer minOrdQty;

	/** 최대 주문 수량 */
	private Integer maxOrdQty;

	/** 재고 관리 여부 */
	private String stkMngYn;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 무료배송 여부 */
	private String freeDlvrYn;

	/** 과세 구분 코드 */
	private String taxGbCd;

	/** MD 사용자 번호 */
	private Long mdUsrNo;
	
	/** 재입고 알람여부 */
	private String ioAlmYn;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 브랜드 명 */
	private String bndNmKo;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;
	
	/** 업체 구분 코드 */
	private String compGbCd;
	
	/** 업체 유형 코드 */
	private String compTpCd;
	
	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 업체상품 아이디 */
	private String compGoodsId;

	/** 업체단품 아이디 */
	private String compItemId;

	/** 판매 금액 */
	private Long salePrc;
	
	/** 원 판매 금액 */
	private Long orgSalePrc;
	
	/** 프로모션 할인 금액 */
	private Long prmtDcAmt;
	
	/** 프로모션 할인가 */
	private Long prmtDcPrc;

	/** 프로모션 번호 */
	private Long prmtNo;

	/** 상품 금액 유형 코드 */
	private String goodsAmtTpCd;

	/** 공동구매 종료 여부 */
	@Deprecated
	private String bulkOrdEndYn;

	/** 프로모션 업체 분담 비율 */
	private Double prmtCompDvdRate;

	/** 판매가능코드 : 사용자 변수 */
	private String salePsbCd;
	
	private String totalSalePsbCd;

	/** 단품 수 */
	@Deprecated
	private Integer itemCnt;

	/** 상품 수수료 율 */
	private Double goodsCmsRate;

	
	/************************
	 * 단품 관련 속성
	 ************************/
	/** 단품 명 */
	private String itemNm;

	/** 추가 판매 금액 */
	private Long addSaleAmt;

	/** 웹 재고 수량 */
	private Integer webStkQty;
	
	/** 재고 수량 */
	private Integer stkQty;
	
	/************************
	 * 배송 정책 관련 속성
	 ************************/

	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;

	/** 배송비 조건 코드 */
	private String dlvrcCdtCd;

	/** 배송비 결제 방법 코드 */
	private String dlvrcPayMtdCd;

	/** 배송비 기준 코드 */
	private String dlvrcStdCd;

	/** 배송비 조건 기준 코드 */
	private String dlvrcCdtStdCd;

	/** 배송 금액 */
	private Long dlvrcDlvrAmt;

	/** 배송 추가 금액 */
	private Long dlvrcAddDlvrAmt;

	/** 배송비 구매 수량 기준 */
	private Integer dlvrcBuyQty;

	/** 배송비 구매 금액 기준 */
	private Long dlvrcBuyPrc;

	
	/************************
	 * 배송비
	 ************************/

	/** 묶음 배송 그룹 번호 */
	private Integer pkgDlvrNo;

	/** 묶음 배송 leaf 여부 */
	private String pkgLeafYn;

	/** 묶음 배송 여부 */
	private String pkgDlvrYn;

	/** 묶음 원 배송비 */
	private Long pkgOrgDlvrAmt;

	/** 묶음 배송비 */
	private Long pkgDlvrAmt;

	/** 묶음 추가 배송비 */
	private Long pkgAddDlvrAmt;

	/** 상품 가격 번호 */
	private Long goodsPrcNo;
	
	/** 상품 선택 여부 */
	private String goodsPickYn;
	
	/** 제작 상품 옵션 내용 */
	private String mkiGoodsOptContent;

	/** 제작 상품 여부 */
	private String mkiGoodsYn;
	
	/** 최적 회원 쿠폰 번호 */
	private Long selMbrCpNo;
	
	/** 최적 쿠폰 번호 */
	private Long selCpNo;
	
	/** 최적 쿠폰 할인금액 */
	private Long selCpDcAmt;

	/** 최적 쿠폰 총 할인금액 */
	private Long selTotCpDcAmt;
	
	private int sortOrder;
	
	private Boolean isCpExist = true;
	
	/** 최적 쿠폰 번호 */
	private Long optimalMbrCpNo;
	
	/** 카테고리 */
	private String dispCtgPath;
	
	/** 쿠폰 목록 */
	private List<Coupon> couponList;
	
	/************************
	 * 사은품 목록
	 ************************/
	private List<Freebie> freebieList;
	
	/** 세트상품 리스트 */
	private List<CartGoodsVO> totalSalePsbCdList;

	/**
	 * 사은품
	 */
	@Data
	public static class Freebie {

		/** 사은품 상품 아이디 */
		private String goodsId;

		/** 사은품 상품 명 */
		private String goodsNm;

		/** 사은품 프로모션 번호 */
		private Long prmtNo;

		/** 사은픔 수량 */
		private Integer qty;

		/** 사은품 상품 이미지 순번 */
		private Integer imgSeq;

		/** 사은푼 상품 이미지 경로 */
		private String imgPath;
		
		/** 원 판매 금액 */
		private Integer   orgSaleAmt;
		
		/** 판매 금액 */
		private Integer   saleAmt;
		
		/** SKU 코드 */
		private String skuCd;
		
		/** 사은품 주문 수량 */
		private Integer ordQty = 0;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 패키지명	: biz.app.cart.model
	 * - 파일명		: CartGoodsVO.java
	 * - 작성일		: 2021. 01. 29.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니- 쿠폰
	 * </pre>
	 */
	@Data
	public static class Coupon {

		/** 쿠폰 번호 */
		private Long cpNo;
		
		/** 쿠폰 설명 */
		private String cpDscrt;
		
		/** 쿠폰 명 */
		private String cpNm;

		/** 쿠폰 종류 코드 */
		private String cpKindCd;

		/** 쿠폰 상태 코드 */
		private String cpStatCd;
		
		/** 쿠폰적용코드 */
		private String cpAplCd;
		
		/** 적용 값 */
		private Long aplVal;

		/** 쿠폰 지급 방식 코드 */
		private String cpPvdMthCd;

		/** 웹모바일구분코드 */
		private String webMobileGbCd;
		
		/** 상품 아이디 */
		private String goodsId;

		/** 최소구매금액 */
		private Long minBuyAmt;

		/** 최대할인금액 */
		private Long maxDcAmt;

		/** 복수적용여부 */
		private String multiAplYn;

		/** 회원쿠폰번호 */
		private Long mbrCpNo;
		
		/** 유의사항 */
		private String notice;

		/** 외부 쿠폰 여부 */
		private String outsideCpYn;
		
		/** 외부 쿠폰 코드 */
		private String outsideCpCd;
		
		/** 총 할인금액 */
		private Long totDcAmt;
		
		/** 할인금액 */
		private Long dcAmt;
		
		private String cartId;
		
		private Long leftSeconds;
		
		private Timestamp sysRegDtm;
	}
	
	/** 상품 옵션 리스트 */
	private List<GoodsOpt> goodsOptList;
	
	@Data
	public static class GoodsOpt {
		
		private String showNm;
		
		private String attrVal;
	}
	
}
