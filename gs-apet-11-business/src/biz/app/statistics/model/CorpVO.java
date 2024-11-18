package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CorpVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 순위 */
	private String corpRank;

	/** 업체번호 */
	private String compNo;

	/** 업체명 */
	private String compNm;

	/** 비율 */
	private Double corpRate;

	/** 주문수 */
	private Long ordQty;

	/** 주문상품수 */
	private Long ordGoodsQty;

	/** 총판매금액 */
	private Long saleAmt;

	/** 상품코드 */
	private String goodsId;

	/** 상품명 */
	private String goodsNm;


	/** 옵션판매개수 */
	private String attrSales;

	/** 일자/월/년 */
	private String dmY;
}