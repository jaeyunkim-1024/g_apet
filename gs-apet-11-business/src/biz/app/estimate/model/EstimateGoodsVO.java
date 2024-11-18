package biz.app.estimate.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EstimateGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 견적 번호 */
	private Integer estmNo;
	
	/** 상품 순번 */
	private Long goodsSeq;
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 단품 번호 */
	private Integer itemNo;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 단품 명 */
	private String itemNm;
	
	/** 배송 분류 명 */
	private String dlvrClsfNm;
	
	/** 판매 금액 */
	private Long saleAmt;
	
	/** 수량 */
	private Long qty;
	
}
