package biz.app.display.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DispCornerItemTagMapPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 전시 코너 아이템 번호*/
	private Long dispCnrItemNo;
	
	/** 태그 번호*/
	private String tagNo;
}
