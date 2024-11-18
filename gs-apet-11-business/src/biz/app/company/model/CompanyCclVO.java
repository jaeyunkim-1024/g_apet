package biz.app.company.model;

import java.sql.Timestamp;

import framework.admin.constants.AdminConstants;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyCclVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 정산 번호 */
	private Integer compCclNo;

	/** 업체 번호 */
	private Long compNo;

	/** 사이트  ID */
	private Long stId;

	/** 사이트  명 */
	private String stNm;


	/** 정산 시작 일자 */
	private Timestamp cclStrtDtm;

	/** 정산 종료 일자 */
	private Timestamp cclEndDtm;

	/** 수수료 율 */
	private Double cmsRate;

	public Double getCmsRate() {
		return cmsRate == null ? AdminConstants.CMS_DEFALUT_RATE : cmsRate;
	}

	/**  사용여부 */
	private String useYn;

}