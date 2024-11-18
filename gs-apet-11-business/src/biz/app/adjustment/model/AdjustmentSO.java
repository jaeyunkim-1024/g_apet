package biz.app.adjustment.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class AdjustmentSO extends BaseSearchVO<AdjustmentSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 페이지 구분 코드 */
	private String pageGbCd;

	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;

	/** 하위 업체 번호 */
	private Long lowCompNo;

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;

}
