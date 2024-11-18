package biz.app.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderClaimDetailVO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문/클래임 상세 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderClaimDetailVO extends OrderDetailVO {

	private static final long serialVersionUID = 1L;

	/** 클래임 접수한 수량 */
	private Integer clmQty;
	
	/** 클래임 요청 가능한 수량 */
	private Integer clmReqQty;

}
