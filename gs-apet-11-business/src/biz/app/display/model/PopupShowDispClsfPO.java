package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopupShowDispClsfPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 팝업 번호 */
	private Integer popupNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

}