package biz.admin.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SalesStateMainVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String name;
	private Long ordCnt;
	private Long ordAmt;
	private Long payCnt;
	private Long payAmt;
	private Long cancelCnt;
	private Long cancelAmt;

}