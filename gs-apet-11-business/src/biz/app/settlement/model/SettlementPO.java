package biz.app.settlement.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SettlementPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 정산 번호 */
	private Long stlNo;	
	
	/** 정산 상태 코드 */
	private String stlStatCd;
	
	/** 업체 정산 번호 */
	private Long[] arrStlNo;	

	/** 지급 상태 코드 */
	private String pvdStatCd;

}
