package biz.app.order.model;

import java.util.Iterator;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderClaimBaseVO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문/클래임 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderClaimVO extends OrderDeliveryVO {

	private static final long serialVersionUID = 1L;
	
	/** 클래임 번호 */
	private String clmNo;
	
	/** 클래임 유형 */
	private String clmTpCd;
	
	/** 클래임 상태 */
	private String clmStatCd;
	
	/** 주문/클래임 상세 목록 */
	List<OrderClaimDetailVO> orderClaimDetailList;

	/** 주문 취소 가능 여부 */
	private String ordCancelPsbYn;
	
}
