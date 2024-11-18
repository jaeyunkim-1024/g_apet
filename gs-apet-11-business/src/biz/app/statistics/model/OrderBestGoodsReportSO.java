package biz.app.statistics.model;



import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderBestGoodsReportSO extends BaseSearchVO<OrderBestGoodsReportSO> {
 
	/** UID */
	private static final long serialVersionUID = 1L;

	/**	집계 일자 Yyyymmdd	*/
	private String totalDt;  
	/**	사이트 id	*/
	private Long   stId;  
	/** 집계 시작 일시 */
	private String totalDtStart;
	/** 집계 종료 일시 */
	private String totalDtEnd;
	
	/** 주문 매체 코드 */
	private String ordMdaCd	;
	
}