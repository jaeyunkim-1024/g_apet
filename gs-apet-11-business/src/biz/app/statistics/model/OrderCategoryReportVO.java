package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderCategoryReportVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	private long dispClsfNo1st;
	private String dispClsfNm1st;
  	private long dispClsfNo2nd;
  	private String dispClsfNm2nd;
  	private long dispClsfNo;
  	private String dispClsfNm;
  	private long ordQty;
  	private long ordAmt;
  	private long cncQty;
  	private long cncAmt;
  	private long rtnQty;
  	private long rtnAmt;
	/** 주문 금액 - 취소 금액 - 반품 금액 */
  	private long totAmt;
}
