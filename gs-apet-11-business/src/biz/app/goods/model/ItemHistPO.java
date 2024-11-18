package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 이력 번호 */
	private Long itemHistNo;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 웹 재고 수량 */
	private Integer webStkQty;

	/** 판매 여부 */
	private String saleYn;

	/** 추가 판매 금액 */
	private Long addSaleAmt;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 상태 코드 */
	private String itemStatCd;

	/** 노출 순서 */
	private Integer showSeq;

}