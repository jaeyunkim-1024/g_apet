package biz.interfaces.nicepay.model.request.data;

import biz.interfaces.nicepay.model.request.RequestCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CheckBankAccountReqVO extends RequestCommonVO{
	private static final long serialVersionUID = 1L;
/** 필수 항목 start */
	
	/** 은행 코드 */
	private String BankCode;
	
	/** 은행 계좌 번호 */
	private String AccountNo;
	
}
