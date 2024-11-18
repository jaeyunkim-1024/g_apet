package biz.app.statistics.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderCategoryReportSO extends BaseSearchVO<OrderCategoryReportSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String totalDtStart;
	private String totalDtEnd;
	private String ordMdaCd;
	private Long dispClsfNo;	//전시분류번호
  	private Long stId;
}