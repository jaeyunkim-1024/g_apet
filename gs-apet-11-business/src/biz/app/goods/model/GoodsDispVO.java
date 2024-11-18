package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.brand.model.BrandBaseVO;
import framework.common.constants.CommonConstants;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.apache.commons.lang.StringUtils;


/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsDispVO.java
 * - 작성일     : 2021. 02. 15.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class GoodsDispVO extends GoodsListVO {

	/** 타임딜 타입 NOW : 타임딜 진행중, SOON : 타임딜 예고 */
	/** 폭풍할인 타입 40 : 재고임박, 50 : 유통기한 임박  */
	/** 베스트20 AUTO : 자동, MANUAL : 수동  */
	private int webStkQty;
	private String dispType;
	private Integer dispTypeCount;
	private int goodsCount;

	/** 상품 카테고리 정보 */
	private Long cateCdL;
	private String cateNmL;
	private Long cateCdM;
	private String cateCdMStr;
	private String cateNmM;
	private Long cateCdS;
	private String cateCdSStr;
	private String cateNmS;

	/** 아이콘 */
	private String icons;
	
	/** 딜날짜 */
	private Timestamp dealDate;

	/** 판매 종료 날짜 */
	private Timestamp saleEndDtm;

	/** 증감수 */
	private int rasing;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 전시 카테고리 순번 */
	private Long cateSeq;
	
	/** 주문 수량 */
	private Integer ordQty;
	
	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;
	
	@Builder
	public GoodsDispVO(Long cateSeq, Long cateCdM, String cateNmM) {
		this.cateSeq = cateSeq;
		this.cateCdM = cateCdM;
		this.cateNmM = cateNmM;
	}

	/** 기획전 테마번호 */
	private Integer thmNo;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 품절 상품 노출 여부 */
	private String ostkGoodsShowYn;
	
	/** 단품 번호 */
	private Long itemNo;
	
	/** 주문제작여부 */
	private String ordmkiYn;
	
	/** 표시 유통 기한 */
	private Timestamp expDt;
	
	/** 상품필저 조회 */
	List<FiltAttrMapVO> getFilter;
	List<BrandBaseVO> getBrand;
	
	/** 브랜드 위시리스트 여부*/
	private String	brandInterestYn;
	
	/*펫 이름*/
	private String petNm;
	
	/*펫 번호*/
    private Long petNo;
    
	/*펫 구분 코드*/
	private String petGbCd;
	
	/** 매칭률 int*/
	private int intRate;

	private Long bndNo;

	/** 베스트 20 자동 - 카테고리 필터 */
	private String filterInfo;
	
	/** 재고 관리 여부 */
	private String stkMngYn;
	
	/** 재고 수량 노출 여부 */
	private String stkQtyShowYn;
	
	/** 유통기한 관리 여부 */
	private String expMngYn;

	/** 가격 정보 */
	private String[] goodsPriceInfo;

	public void setGoodsPriceInfo(String goodsPriceInfo) {
		if(StringUtils.isNotEmpty(goodsPriceInfo)) {
			this.goodsPriceInfo = goodsPriceInfo.split("\\|");
			settingAmt();
		}
	}

	/**
	 * goodsPriceInfo
	 * 상품판매가(핫딜세일적용가)|프로모션번호|프로모션할인가|쿠폰번호|쿠폰할인가|상품금액유형코드|상품원판매가|공급금액|상품가격번호
	 */
	public void settingAmt() {

		//상품판매가
		Long saleAmt = Long.parseUnsignedLong(goodsPriceInfo[0]);
		this.setSaleAmt(saleAmt);

		//상품원판매가
		Long orgSaleAmt = Long.parseUnsignedLong(goodsPriceInfo[6]);
		this.setOrgSaleAmt(orgSaleAmt);

		//프로모션할인가
		Long dscountAmt = Long.parseUnsignedLong(goodsPriceInfo[2]);
		Long dcAmt = 0L;
		Long foSaleAmt = 0L;

		if(dscountAmt > 0) {
			dcAmt = saleAmt - dscountAmt;
			foSaleAmt = saleAmt - dscountAmt;
		} else {
			dcAmt = dscountAmt;
			foSaleAmt = saleAmt;
		}
		//할인가
		this.setDcAmt(dcAmt);
		//최종판매가
		this.setFoSaleAmt(foSaleAmt);

		//딜여부
		String goodsAmtTpCd = goodsPriceInfo[5];
		String dealYn = null;
		if(StringUtils.equals(goodsAmtTpCd, CommonConstants.GOODS_AMT_TP_20)) {
			dealYn = CommonConstants.COMM_YN_Y;
		} else {
			dealYn = CommonConstants.COMM_YN_N;
		}
		this.setDealYn(dealYn);

		//쿠폰 여부
		Long cpNo = Long.parseUnsignedLong(goodsPriceInfo[3]);
		String couponYn = null;
		if(cpNo == null || cpNo == 0) {
			couponYn = CommonConstants.COMM_YN_N;
		} else {
			couponYn = CommonConstants.COMM_YN_Y;
		}
		this.setCouponYn(couponYn);
	}
}
