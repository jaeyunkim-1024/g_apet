package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: CardcInstmntInfoPO.java
* - 작성일		:
* - 작성자		: kek01
* - 설명		    : 무이자할부정보보* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CardcInstmntInfoPO extends BaseSysVO implements Serializable {
	/** 카드사 코드 */
	private String cardcCd;
	/** 개월 */
	private String month;
	/** 할부 유형 코드 */
	private String instmntTpCd;
	/** 최소 금액 */
	private int minAmt;

}
