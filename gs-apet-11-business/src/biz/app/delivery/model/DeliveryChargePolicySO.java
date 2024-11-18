package biz.app.delivery.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.model
* - 파일명		: DeliveryChargePolicySO.java
* - 작성일		: 2017. 3. 14.
* - 작성자		: snw
* - 설명			: 배송비 정책 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryChargePolicySO extends BaseSearchVO<DeliveryChargePolicySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;
	
	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 업체 번호 */
	private Long 	compNo;
}