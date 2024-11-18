package biz.app.delivery.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.model
* - 파일명		: DeliveryHistPO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 배송 이력 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class DeliveryHistSO extends BaseSearchVO<DeliveryHistSO> {

	/** 배송 번호 */
	private Long dlvrNo;
	
	/** 배송 번호 배열 */
	private Long[] arrDlvrNo;
	
}