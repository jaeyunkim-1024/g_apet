package biz.app.brand.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyBrandSO extends BaseSearchVO<CompanyBrandSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 브랜드 번호 */
	private Long bndNo;

}