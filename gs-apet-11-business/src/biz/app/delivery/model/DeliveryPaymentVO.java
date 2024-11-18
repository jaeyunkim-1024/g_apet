package biz.app.delivery.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryPaymentVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;
	
	/** 배송 번호 */
	private Long dlvrNo;

	/** 클레임 번호 */
	private String clmNo;

	/** 배송비 **/
	private Long orgDlvrcAmt;
	
	/** 추가 배송비 **/
	private Long clmDlvrcAmt;
	
	/** 초도 결제 배송비 **/
	private Long firstDlvrcAmt;
	
}