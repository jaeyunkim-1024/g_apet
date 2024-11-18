package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;

	/** 웹 재고 수량 */
	private Integer webStkQty;

	/** 단품 명 */
	private String itemNm;

	/** 판매 여부 */
	private String saleYn;

	/** 추가 판매 금액 */
	private Long addSaleAmt;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 상태 코드 */
	private String itemStatCd;

	/** 노출 순서 */
	private Long showSeq;

	/** plusYn */
	private String plusYn;

	/** 업체 단품 아이디 */
	private String compItemId;
	
	/** 사은품 가능 여부 */
	private String frbPsbYn;

	/** SKU 코드 */
	private String skuCd;
	
	/** 상품구성유형코드 */
	private String goodsCstrtTpCd;
}