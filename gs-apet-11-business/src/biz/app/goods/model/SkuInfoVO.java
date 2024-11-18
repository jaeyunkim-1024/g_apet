package biz.app.goods.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : SkuInfoUpdateVO.java
 * - 작성일     : 2021. 02. 03.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Data
public class SkuInfoVO {
	/** 단품 전송 일시 */
	private String cisDtm;
	private String cisMinute;

	/** 단품 코드 GoodsId */
	private String skuCd;
	/** 단품 이름 */
	private String skuNm;
	/** 상태 코드 */
	private String statCd;
	/** 표준 코드 */
	private String strdCd;
	/** 자체 코드 */
	private String compCd;
	/** 대분류 코드 */
	private String cateCdL;
	/** 대분류 이름 */
	private String cateNmL;
	/** 중분류 코드 */
	private String cateCdM;
	/** 중분류 이름 */
	private String cateNmM;
	/** 소분류 코드 */
	private String cateCdS;
	/** 소분류 이름 */
	private String cateNmS;
	/** 세분류 코드 */
	private String cateCdD;
	/** 세분류 이름 */
	private String cateNmD;
	/** 유통기한 관리여부 */
	private String expDdCtrYn;
	/** 유통기간(월) */
	private String expDd;
	/** 단위 */
	private String unitNm;
	/** 규격 */
	private String spcfNm;
	/** 판매 가격 */
	private int price;
	/** 정상 가격 */
	private int consumerPrice;
	/** 공급 가격 */
	private int supplyPrice;
	/** 매입사 코드 */
	private String vndrCd;
	/** 화주 코드  개발 : PB, 운영 : AP */ 
	private String ownrCd;
	/** 물류센터 코드 개발 : WH01, 운영 : AW01 */
	private String wareCd;
	/** 제조사 */
	private String mnftNm;
	/** 수입사 */
	private String imptNm;
	/** 원산지 */
	private String orgnNm;
	/** 모델 */
	private String modlNm;
	/** 배송비 유형 */
	private String dlvChrgTpCd;
	/** 배송비 */
	private int dlvChrg;
	/** 과세 유형 코드 */
	private String taxTpCd;
	/** 반려동물 유형 */
	private String petTpNm;
	/** 이미지 경로 */
	private String imgSrc;
	/** 상세 내용 */
	private String dtlTxt;
	/** 정보고시 분류코드 */
	private String ntfcCd;
	/** 수집처 전송 여부 */
	private String clltSendYn;
	/** TWC 전송 여부 */
	private String twcSendYn;
	/** 상품 구성 유형 - ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음 */
	private String goodsCstrtTpCd;

	/** 정보고시 */
	private ArrayList<Ntfc> ntfcList;
	
	/** SKU 리스트 */
	private ArrayList<Sku> skuList;
	
	/** 상품 코드 */
	private String prdtCd;
	
	/** 상품 이름 */
	private String prdtNm;
	
	/** 브랜드 번호 */
	private Integer brndNo;

	/** 상품 가격 번호 */
	private Long goodsPrcNo;


	/**
	 * 정보고시
	 */
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Ntfc {

		/** 정보고시 번호 */
		private String ntfcNo;
		/** 정보고시 내용 */
		private String ntfcTxt;
	}
	
	/**
	 * SKU 리스트
	 */
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Sku {
		
		/** 단품코드 */
		private String skuCd;
	}
}
