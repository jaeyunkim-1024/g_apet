package biz.app.goods.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemSO extends BaseSearchVO<ItemSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 상태 코드 */
	private String itemStatCd;

	/** 재고 관리 여부 */
	private String stkMngYn;


	/** 단품 명 */
	private String itemNm;


	/** 웹 재고 수량 */
	private Long webStkQty;

	/** 판매 여부 */
	private String saleYn;

	/** 추가 판매 금액 */
	private Long addSaleAmt;


	/** 노출 순서 */
	private Long showSeq;
	
	/** 사은품 가능 여부 */
	private String frbPsbYn;


	/** 속성1 번호 */
	private Long attr1No;

	/** 속성1 명 */
	private String attr1Nm;

	/** 속성1 값 번호 */
	private Long attr1ValNo;

	/** 속성1 값 */
	private String attr1Val;

	/** 속성2 번호 */
	private Long attr2No;

	/** 속성2 명 */
	private String attr2Nm;

	/** 속성2 값 번호 */
	private Long attr2ValNo;

	/** 속성2 값 */
	private String attr2Val;

	/** 속성3 번호 */
	private Long attr3No;

	/** 속성3 명 */
	private String attr3Nm;

	/** 속성3 값 번호 */
	private Long attr3ValNo;

	/** 속성3 값 */
	private String attr3Val;

	/** 속성4 번호 */
	private Long attr4No;

	/** 속성4 명 */
	private String attr4Nm;

	/** 속성4 값 번호 */
	private Long attr4ValNo;

	/** 속성4 값 */
	private String attr4Val;

	/** 속성5 번호 */
	private Long attr5No;

	/** 속성5 명 */
	private String attr5Nm;

	/** 속성5 값 번호 */
	private Long attr5ValNo;

	/** 속성5 값 */
	private String attr5Val;

	private String attrValJson;

	/** 속성 값 번호 */
	private Long attrValNo;

	/** 속성 번 */
	private Long attrNo;

	private List<Long> itemNos;

	private String attrNoList;		//속성번호

	private String attrValNoList;	//속성번호값

	/** 배송 정책 번호 */
	private Long dlvrcPlcNo;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Long ordDtlSeq;

	/** 업체 단품 아이디 */
	private String compItemId;
}