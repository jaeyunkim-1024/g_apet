package biz.app.statistics.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDailyReportSO extends BaseSearchVO<OrderDailyReportSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String totalDt;
	private String ordMdaCd;
	private Long dispClsfNo;	//전시분류번호
  	private Long stId;
}