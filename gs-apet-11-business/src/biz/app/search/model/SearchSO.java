package biz.app.search.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SearchSO extends BaseSearchVO<SearchSO> {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	private String[] goodsIds;
	
	private String deviceGb;
	
	private Long mbrNo;
}
