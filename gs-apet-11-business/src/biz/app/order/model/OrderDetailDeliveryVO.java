package biz.app.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailDeliveryVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 배송지 번호 */
	private Long ordDlvpSn;

	/** 회원 배송지 번호 */
	private Integer mbrDlvraNo;

	/** 주문 번호 */
	private String ordNo;

}