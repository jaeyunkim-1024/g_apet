package biz.app.company.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyDispTpGoodsSO extends BaseSearchVO<CompanyDispTpGoodsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 업체 번호 */
	private Long compNo;
	
}