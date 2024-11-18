package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByClassVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String sumRef;

	private long stpOQty;
	private long stpOAmt;
	private long stpAQty;
	private long stpAAmt;
	private long stpIQty;
	private long stpIAmt;
	private long dodotAmt;
	private long sttOQty;
	private long sttOAmt;
	private long sttAQty;
	private long sttAAmt;
	private long outAmt;
	private long totOQty;
	private long totOAmt;
	private long totAQty;
	private long totAAmt;
	private long totIQty;
	private long totIAmt;
	private long totAmt;

}
