package biz.app.search.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RecommendTagVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 태그 명*/
	private String tagNm;
}