package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CodeGroupSO extends BaseSearchVO<CodeGroupSO> {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/** 그룹 코드 */
	private String grpCd;

	/** 그룹 명 */
	private String grpNm;

}