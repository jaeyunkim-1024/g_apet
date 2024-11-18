package biz.interfaces.nicepay.model.response.data;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class CheckBankAccountResVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;
	
	/** ResultCode : 결과 코드 (0000 : 성공)*/
	
	/** 예금주 이름 - 성공일 경우에 응답 */
	private String AccountName;
}
