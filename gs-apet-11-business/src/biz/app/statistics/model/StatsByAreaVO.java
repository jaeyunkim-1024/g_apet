package biz.app.statistics.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByAreaVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String orderArea;
	private long pcMemAmt;
	private long pcNomemAmt;
	private long pcTotAmt;
	private long mobileMemAmt;
	private long mobileNomemAmt;
	private long mobileTotAmt;
	private long totAmt;
	private long pcMemQty;
	private long pcNomemQty;
	private long pcTotQty;
	private long mobileMemQty;
	private long mobileNomemQty;
	private long mobileTotQty;
	private long totQty;

}
