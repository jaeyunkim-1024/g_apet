package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByCompVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private long rownum;
	private String sumRef;
	private long compNo;
	private String compNm;
	private String compTpCd;
	private long pcQty;
	private long pcAmt;
	private long moQty;
	private long moAmt;
	private long totQty;
	private long totAmt;

}
