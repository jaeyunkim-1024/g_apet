package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverDateStatusPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 배송일자 */
	private String deliverDate;

	/** 일일배송량한계 */
	private Integer daysDeliveryStatus;

	/** 일일배송수량한계 */
	private Integer daysDeliveryCntStatus;

	/** 지역 코드 */
	private Integer areaId;

}