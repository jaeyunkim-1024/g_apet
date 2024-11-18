package framework.common.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class HistorySO extends BaseSearchVO<HistorySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String	histGb;

	private String	goodsId;
}
