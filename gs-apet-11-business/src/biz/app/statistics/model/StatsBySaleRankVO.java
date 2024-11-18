package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsBySaleRankVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private long rownum;
	private String sumRef;
	private String goodsId;
	private String goodsNm;
	private long ordQty;
	private long saleAmt;
}
