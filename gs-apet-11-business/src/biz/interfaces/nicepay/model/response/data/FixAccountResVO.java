package biz.interfaces.nicepay.model.response.data;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class FixAccountResVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;
	
	/** ResultCode : 결과 코드 (4100 : 성공)*/
	
	/** 거래번호, 거래를 구분하는 transaction ID */
	private String TID;
	
	/** 주문번호 */
	private String Moid;
	
	/** 결제금액 */
	private String Amt;
	
	/** 처리일자(YYMMDDHHMISS) */
	private String AuthDate;
}
