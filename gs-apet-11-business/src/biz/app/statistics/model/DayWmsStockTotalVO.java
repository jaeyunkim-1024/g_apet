package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DayWmsStockTotalVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계일자 */
	private String baseDt;
	
	/** 업체번호 */
	private String compNo;
	
	/** 업체명 */
	private String compNm;
	
	/** 창고번호 */
	private String whsNo;
	
	/** 창고명 */
	private String whsNm;
	
	/** BOM원산지코드 */
	private String bomCtrOrgCd;
	
	/** BOM원산지명 */
	private String bomCtrOrgNm;
	
	/** BOM업체구분코드 */
	private String bomCompGbCd;
	
	/** BOM업체구분명 */
	private String bomCompGbNm;
	
	/** 재고금액 */
	private String stkAmt;
	
	/** 구성비 */
	private String rate;

	/** 재고금액 */
	private String subStkAmt;
	
	/** 구성비 */
	private String subRate;

}