package biz.app.statistics.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class WmsOutOrdTotalSO extends BaseSearchVO<WmsOutOrdTotalSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 조회 일시 */
	private String fromBaseDt;

	private String toBaseDt;

	private String searchTextType;

	private String searchText;

	private String bomCompGbCd;

}