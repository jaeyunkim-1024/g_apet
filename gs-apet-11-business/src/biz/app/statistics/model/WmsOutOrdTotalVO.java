package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class WmsOutOrdTotalVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계년월 */
	private String baseDt;

	/** 지역10 */
	private String A10;

	/** 지역20 */
	private String A20;

	/** 지역30 */
	private String A30;

	/** 지역40 */
	private String A40;

	/** 지역50 */
	private String A50;

	/** 지역60 */
	private String A60;

	/** 지역70 */
	private String A70;

	/** 지역80 */
	private String A80;

	/** 총 주문건수 */
	private int ordCnt;

	/** 총 상품수 */
	private int ordQty;

	/** 총 출고금액 */
	private int saleAmt;

	/** 총 매출액 */
	private int costAmt;

}