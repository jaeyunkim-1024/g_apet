package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class HolidaySO extends BaseSearchVO<HolidaySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 휴일 시작일시 */
	private String holidayDate;

	/** 시작일시 */
	private String strtDate;

	/** 종료일시 */
	private String endDate;
}