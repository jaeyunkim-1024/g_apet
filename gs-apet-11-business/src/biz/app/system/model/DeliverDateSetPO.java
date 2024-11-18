package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverDateSetPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 직배송아이디 */
	private Integer dsId;

	/** 직배지역코드 */
	private Integer areaId;

	/** 구분(1:기간,2:이후) */
	private String deliverGubunCd;

	/** 배송일자 */
	private String deliverDate;

	/** 일일배송량한계 */
	private Integer daysDeliveryLimit;

	/** 일일배송수량한계 */
	private Integer daysDeliveryCntLimit;

	/** 배송량가중치 */
	private Integer deliveryIncrease;

	/** 시작 배송일자 */
	private String strtDeliverDate;

	/** 종료 배송일자 */
	private String endDeliverDate;

}