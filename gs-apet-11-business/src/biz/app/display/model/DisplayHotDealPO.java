package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayHotDealPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트  ID */
	private Long stId;		

}