package biz.app.goods.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemHistSO extends BaseSearchVO<ItemHistSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 이력 번호 */
	private Long itemHistNo;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 웹 재고 수량 */
	private Long webStkQty;

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

	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	private String sysRegrNm;

}