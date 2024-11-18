package biz.admin.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsMainVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String name;
	private Long cnt10;
	private Long cnt20;
	private Long cnt30;
	private Long cnt40;
	private Long cnt50;
	private Long cnt60;

}