package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DayWmsStockTotalSO extends BaseSearchVO<DayWmsStockTotalSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 조회 일시 */
	private String baseDt;

}