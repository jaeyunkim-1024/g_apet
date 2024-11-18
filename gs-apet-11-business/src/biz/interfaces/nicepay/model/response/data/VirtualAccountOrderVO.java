package biz.interfaces.nicepay.model.response.data;

import java.util.Date;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class VirtualAccountOrderVO extends BaseSysVO {
	
	private static final long serialVersionUID = 1L;
	
	private String ordNo; // 주문번호
	private String ordStatCd; // 주문 상태 코드
	private Date ordCpltDtm; // 주문완료 일시
	
	/**
	 * order_detail
	 */
	private String ordDtlStatCd; // 주문상세 코드

}
