package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopupTargetPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 팝업 번호 */
	private Integer popupNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;
	
	/** 상품 아이디 */
	private String goodsId;
	 
}