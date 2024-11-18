package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByMCtgVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private long dispClsfNoDepth1;
	private String dispClsfNmDepth1;
	private long dispClsfNoDepth2;
	private String dispClsfNmDepth2;
	private long ordQty;
	private long saleAmt;
	private long totAmt;
	private double saleRate;


}
