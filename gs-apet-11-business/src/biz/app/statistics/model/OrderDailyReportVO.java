package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDailyReportVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	private long dispClsfNo1st;
	private String dispClsfNm1st;
  	private long dispClsfNo2nd;
  	private String dispClsfNm2nd;
  	private long dispClsfNo;
  	private String dispClsfNm;
  	private long saleAmtTot;
  	private long saleAmt02;
  	private long saleAmt04;
  	private long saleAmt06;
  	private long saleAmt08;
  	private long saleAmt10;
  	private long saleAmt12;
  	private long saleAmt14;
  	private long saleAmt16;
  	private long saleAmt18;
  	private long saleAmt20;
  	private long saleAmt22;
  	private long saleAmt24;
}
