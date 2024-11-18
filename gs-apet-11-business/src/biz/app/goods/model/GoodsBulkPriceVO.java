package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
 * FIXME[상품, 이하정, 20210113] 개별 작업용
 */
/**
 * <pre>
 * - 프로젝트명 : 11.admin
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsBulkPriceVO.java
 * - 작성일     : 2021. 01. 11.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBulkPriceVO extends GoodsBaseVO {

	/** 공급사 유형  */
	private String compTpCd;
	
	/** 상품 금액 유형 코드 */
	private String goodsAmtTpCd;

	/** 원 판매 금액(정상가) */
	private Long orgSaleAmt;

	/** 판매 금액(판매가) */
	private Long saleAmt;

	/** 공급 금액(매입가) */
	private Long splAmt;

	/** 수수료 율 */
	private Double cmsRate;
}
