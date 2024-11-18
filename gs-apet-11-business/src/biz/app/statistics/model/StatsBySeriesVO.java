package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsBySeriesVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;

	private long rownum;
	private String sumRef;
	private long seriesNo;
	private String seriesNm;
	private long pcQty;
	private long pcAmt;
	private long moQty;
	private long moAmt;
	private long totQty;
	private long totAmt;
	private double saleRate;
}
