package biz.app.company.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompAcctVO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 계좌 번호 */
	private String compAcctIsuNo;

	/** 업체 번호 */
	public Long compNo;

	/** 계좌 번호 */
	public String acctNo;

	/** 은행 구분 코드 */
	public String bankGbCd;

	/** 계좌 예금주 */
	public String acctOoa;

	/** 계좌 이미지 경로 */
	public String acctImgPath;

	/** 계좌 메모 */
	public String acctMemo;
}
