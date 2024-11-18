package biz.app.estimate.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class EstimateSO extends BaseSearchVO<EstimateSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 견적 일자 */
	private String estmDt;
	
	/** 대상명 */
	private String tgNm;
	
	/** 견적번호 */
	private Integer estmNo;
	
	/** 등록일시 시작 */
	private String strtDtm;

	/** 등록일시 종료 */
	private String endDtm;
}