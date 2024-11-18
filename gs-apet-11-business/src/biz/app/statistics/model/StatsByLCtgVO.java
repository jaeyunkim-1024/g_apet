package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByLCtgVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;

	private String sumRef;
	private String dispClsfNm;
	private long saleAmt;
	private long totAmt;
	private double saleRate;
}
