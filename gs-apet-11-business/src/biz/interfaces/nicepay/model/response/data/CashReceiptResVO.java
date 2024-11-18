package biz.interfaces.nicepay.model.response.data;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class CashReceiptResVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;
	
	/** ResultCode : 결제 결과 코드 (7001 : 성공)*/
	/** 거래번호, 거래를 구분하는 transaction ID */
	private String TID;
	
	/** 주문번호 */
	private String Moid;
	
	/** 승인번호 */
	private String AuthCode;
	
	/** 승인일자 */
	private String AuthDate;
}
