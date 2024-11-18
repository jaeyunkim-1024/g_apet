package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderDetailStatusHistPO.java
* - 작성일		: 2017. 1. 13.
* - 작성자		: snw
* - 설명			: 주문 상세 상태 이력 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailStatusHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

}