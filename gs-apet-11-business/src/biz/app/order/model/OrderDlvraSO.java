package biz.app.order.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderDlvraSO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 배송지 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvraSO extends BaseSearchVO<OrderDlvraSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문번호 */
	private String	ordNo;
	
	/** 주문 배송지 번호 */
	private Long ordDlvraNo;
	
	/** 주문 배송지 번호 배열 */
	private Object[] arrOrdDlvraNo;
	
	/** 클레임 번호 */
	private String 	clmNo;


}