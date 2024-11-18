package biz.app.receipt.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CashReceiptGoodsMapVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 현금 영수증 번호 */
	private Long cashRctNo;

	/** 주문 / 클레임 번호 */
	private String ordClmNo;

	/** 주문 / 클레임 상세 순번 */
	private Integer ordClmDtlSeq;
	
	/** 적용 수량 */
	private Integer aplQty;
	
	/** 상품 명 */
	private String goodsNm;

}