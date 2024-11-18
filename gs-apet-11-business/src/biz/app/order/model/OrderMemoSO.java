package biz.app.order.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderMemoSO.java
* - 작성일		: 2017. 1. 11.
* - 작성자		: snw
* - 설명			:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderMemoSO extends BaseSearchVO<OrderMemoSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 주문 번호 */
	private String ordNo;

	/** 메모 순번 */
	private Integer memoSeq;

}