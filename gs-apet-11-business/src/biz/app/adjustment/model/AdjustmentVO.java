package biz.app.adjustment.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AdjustmentVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Integer itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Long ordQty;

	/** 결제 금액 */
	private Long payAmt;

	/** 상품 쿠폰 할인 금액 */
	private Long goodsCpDcAmt;

	/** 배송비 쿠폰 할인 금액 */
	private Long dlvrcCpDcAmt;

	/** 조립비 쿠폰 할인 금액 */
	private Long asbcCpDcAmt;

	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;

	/** 적립금 할인 금액 */
	private Long svmnDcAmt;

	private Long realAsbAmt;

	private Long realDlvrAmt;

	/** 결제 수단 코드 */
	private String payMeansCd;

	private Long cmsAmt;

	private Long adjtAmt;

	/** 상품수수료율 */
	private Double cmsRate;

	private Long adjtTax;

	private Long pay10Amt;
	private Long pay20Amt;
	private Long pay30Amt;
	private Long pay40Amt;
	private Long pay50Amt;
	private Long pay90Amt;

	/** 페이지 구분 코드 */
	private String pageGbCd;

}
