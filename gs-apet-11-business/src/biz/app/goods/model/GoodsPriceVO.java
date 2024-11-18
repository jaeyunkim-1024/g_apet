package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsPriceVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 가격 번호 */
	private Long goodsPrcNo;

	/** 미래 상품 가격번호 */
	private Long futrGoodsPrcNo;

	/** 원가 금액 */
	private Long costAmt;

	private String goodsAmtTpCd;

	private Long orgSaleAmt;

	/** 판매 금액 */
	private Long saleAmt;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 구성 유형 - ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음 */
	private String goodsCstrtTpCd;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 수수료 율 */
	private Double cmsRate;

	/** 혜택 적용 방식 코드 */
	private String fvrAplMethCd;

	/** 혜택 값 */
	private Double fvrVal;

	private String delYn;
	
	/** 표시 유통 기한 */
	private Timestamp expDt;
	
	/** 예약구매수량 */
	private Integer rsvBuyQty;

	/** 추가 */
	private String saleYn;	// 세일여부
	private Long saleCostAmt;
	private String saleGoodsAmtTpCd;
	private Long saleOrgSaleAmt;
	private Long saleSaleAmt;
	private Long saleSplAmt;
	private Timestamp saleSaleStrtDtm;
	private Timestamp saleSaleEndDtm;
	private Long saleCmsRate;
	private String saleFvrAplMethCd;
	private Long saleFvrVal;
	private String saleDelYn;
	private Long futrCostAmt;
	private String futrGoodsAmtTpCd;
	private Long futrOrgSaleAmt;
	private Long futrSaleAmt;
	private Long futrSplAmt;
	private Timestamp futrSaleStrtDtm;
	private Timestamp futrSaleEndDtm;
	private Long futrCmsRate;
	private String futrFvrAplMethCd;
	private Long futrFvrVal;
	private String futrDelYn;

	/** 할인가격 표시 */
	// 사이트 아이디
	private Long stId;
	// 사이트 이름
	private String stNm;
	// 프로모션 번호
	private Long prmtNo;
	// 프로모션 등록자
	private String prmtSysRegrNm;
	// PC
	private String webMobileGbPc;
	// PC 판매가격(핫딜적용가)
	private Long webMobileGbPcPrc;
	// PC 프로모션 적용가격
	private Long webMobileGbPcPrmtPrc;
	// MOBILE
	private String webMobileGbMo;
	// MOBILE 판매가격(핫딜적용가)
	private Long webMobileGbMoPrc;
	// MOBILE 프로모션 적용가격
	private Long webMobileGbMoPrmtPrc;

	private String webStkQty;
	private String dealType;
}