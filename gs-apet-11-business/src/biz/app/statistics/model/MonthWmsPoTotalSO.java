package biz.app.statistics.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MonthWmsPoTotalSO extends BaseSearchVO<MonthWmsPoTotalSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 조회 일시 */
	private String baseYm;

	private String sumGbCd;

	private String compNo;

	private String seriesNo;

}