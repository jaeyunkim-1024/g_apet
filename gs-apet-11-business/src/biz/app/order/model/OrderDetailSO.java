package biz.app.order.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderDetailSO.java
* - 작성일		: 2017. 1. 11.
* - 작성자		: snw
* - 설명			: 주문 상세 조회용 Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailSO extends BaseSearchVO<OrderDetailSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 번호 */
	private Integer ordDtlSeq;

	/** 주문 상세 번호 : 배열 */
	private Integer[] arrOrdDtlSeq;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 단품 번호 */
	private Long itemNo;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 상위 업체 번호 */
	private Long upCompNo;
	
	/** 상품평 등록 여부 */
	private String goodsEstmRegYn;
	
	/** 잔여주문수량이 0 보다 큰가  */
	private Boolean rmnOrdQty0Over = Boolean.FALSE ;	
	
	/** 검색 월- 3개월,6개월, 12개월(전시 요청) */
	private Long searchMonth;
}