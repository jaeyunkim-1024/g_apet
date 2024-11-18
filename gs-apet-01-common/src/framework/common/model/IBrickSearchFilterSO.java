package framework.common.model;

import lombok.Data;

@Data
public class IBrickSearchFilterSO {
	
	/** 필터 유형 */
	private String FILTER_CD;
	/** 필터값 */
	private String FILTER_VAL[];
	
}
