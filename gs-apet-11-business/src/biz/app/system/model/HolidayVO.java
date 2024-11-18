package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class HolidayVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 제목 */
	private String title;

	/** 내용 */
	private String contents;

	/** 휴일 시작일시 */
	private String holidayDate;

}