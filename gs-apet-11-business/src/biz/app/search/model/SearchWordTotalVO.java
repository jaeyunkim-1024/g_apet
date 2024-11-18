package biz.app.search.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SearchWordTotalVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String totalDtm;
	
	private String srchWord;
	
	private String srchCnt;

}