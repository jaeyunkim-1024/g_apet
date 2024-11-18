package biz.app.order.model;

import lombok.Data;

import java.io.Serializable;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: CardcInstmntInfoVO.java
* - 작성일		:
* - 작성자		: valfac
* - 설명		: 무이자할부정보보* </pre>
*/
@Data
public class CardcInstmntInfoSO implements Serializable{

	private static final long serialVersionUID = 1L;

	private String cardcCd;

	/** 기준 금액 */
	private Long minAmt;
	
}
