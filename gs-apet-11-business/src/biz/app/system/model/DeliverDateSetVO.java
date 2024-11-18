package biz.app.system.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverDateSetVO extends BaseSysVO {

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

	/** 현재배송예정량 */
	private Integer daysDeliveryStatus;

	/** 현재배송수량한계 */
	private Integer daysDeliveryCntStatus;

	private String areaName;
	
	/**  날짜 */
	private String calDay;
	
	/**  요일 */
	private String calWeek;
	
	/** 휴일여부 */
	private String holidayYn;
	
	/** 현재배송량한계여부 */
	private String deliveryYn;
	
	/** 현재배송수량한계여부 */
	private String deliveryCntYn;
	
	
}