package biz.app.system.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CodeDetailSO extends BaseSearchVO<CodeDetailSO> {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/** 그룹 코드 */
	private String grpCd;

	/** 상세 코드 */
	private String dtlCd;

	/** 사용자 정의1 값 */
	private String usrDfn1Val;

	/** 사용자 정의2 값 */
	private String usrDfn2Val;

	/** 사용자 정의3 값 */
	private String usrDfn3Val;

	/** 사용자 정의4 값 */
	private String usrDfn4Val;

	/** 사용자 정의5 값 */
	private String usrDfn5Val;

	private String selectKey;

	private String defaultName;

	private String showValue;

	private int usrDfnValIdx;

}