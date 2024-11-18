package biz.interfaces.nicepay.model.response.data;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class VirtualAccountResVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;
	
	/** ResultCode : 결과 코드 (4100 : 성공)*/
	
	/** 거래번호, 거래를 구분하는 transaction ID */
	private String TID;
	
	/** 주문번호 */
	private String Moid;
	
	/** 결제금액 */
	private String Amt;
	
	/** 처리일자 (YYYYMMDD) */
	private String AuthDate;
	
	/** 가상계좌 은행코드  */
	private String VbankBankCode;
	
	/** 가상계좌 은행명 */
	private String VbankBankName;
	
	/** 가상계좌 번호 */
	private String VbankNum;
	
	/** 가상게좌 입금만료일 (YYYYMMDD) */
	private String VbankExpDate;
	
	/** 가상게좌 입금만료시간 (HHMISS) */
	private String VbankExpTime;
	
}
