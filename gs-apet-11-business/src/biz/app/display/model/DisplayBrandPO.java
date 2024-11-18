package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayBrandPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 브랜드 구분 코드 */
	private String bndGbCd;

}