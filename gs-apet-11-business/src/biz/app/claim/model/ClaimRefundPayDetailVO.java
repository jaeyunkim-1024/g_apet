package biz.app.claim.model;

import framework.common.model.BaseSysVO;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimRefundPayDetailVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Long payNo;

	/** 결제수단코드 */
	private String payMeansCd;
	private String payMeansNm;
	
	/** 결제 금액 */
	private Long payAmt;

	/** 은행 코드 */
	private String 	bankCd;

	/** 계좌 번호 */
	private String 	acctNo;

	/** 예금주 명 */
	private String 	ooaNm;
	
	/** 결제 구분 코드 */
	private String 	payGbCd;
	
	public String getMaskedAcctNo() {
		return (StringUtil.isNotBlank(this.acctNo))? MaskingUtil.getBankNo(this.acctNo) : null;
	}

}