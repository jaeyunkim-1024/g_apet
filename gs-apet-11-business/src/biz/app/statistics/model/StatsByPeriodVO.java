package biz.app.statistics.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByPeriodVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String sumDate;
	private long pcOrdQty;
	private long pcQty;
	private long pcSaleAmt;
	private long moOrdQty;
	private long moQty;
	private long moSaleAmt;
	private long srOrdQty;
	private long srQty;
	private long srSaleAmt;
	private long dodotAmt;
	private long mkOrdQty;
	private long mkQty;
	private long mkSaleAmt;
	private long totAmt;

}
