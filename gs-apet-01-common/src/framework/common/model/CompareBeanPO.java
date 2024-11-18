package framework.common.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CompareBeanPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String	columnId;
	private String	columnNm;
	private Object	value1;
	private Object	value2;

}
