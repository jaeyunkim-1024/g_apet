package biz.app.system.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.model
 * - 파일명		: DepositAcctInfoSO.java
 * - 작성일		: 2017. 2. 9.
 * - 작성자		: snw
 * - 설명		: 무통장 계좌 정보 SO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DepositAcctInfoSO extends BaseSearchVO<DepositAcctInfoSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 계좌 정보 번호 */
	private Long acctInfoNo;

	/** 사이트 아이디 */
	private Long stId;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

}