package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DayGoodsPplrtTotalPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계 일자 */
	private String sumDt;

	/** 집계 구분 코드 */
	private String sumGbCd;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 판매 금액 */
	private Integer saleAmt;

	/** 판매 수량 */
	private Integer saleQty;

	/** 판매 금액 순위 */
	private Integer saleAmtRank;

	/** 판매 수량 순위 */
	private Integer saleQtyRank;

	/** 상품 평가 수 */
	private Integer goodsEstmCnt;

	/** 누적 판매 금액 */
	private Integer accmSaleAmt;

	/** 누적 판매 수량 */
	private Integer accmSaleQty;

	/** 누적 상품 평가 수 */
	private Integer accmGoodsEstmCnt;

}