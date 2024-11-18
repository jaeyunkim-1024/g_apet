package biz.app.order.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderBaseSO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 기본 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderBaseSO extends BaseSearchVO<OrderBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	private String ordrEmail;

	/** 회원 번호 */
	private Long mbrNo;

	/** 사이트 아이디 */
	private Long stId;
	
	/** 외부 주문 번호 */
	private String outsideOrdNo;
}