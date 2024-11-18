package biz.app.delivery.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryChargeDetailExcptProcessVO extends BaseSysVO {
	
	private Long 	fstDlvrcNo;
	private Long 	regDlvrcNo;
	private Long 	delDlvrcNo;
	
	private Long 	realDlvrAmt;
	private Long 	realDlvrAddAmt;
	
	
}