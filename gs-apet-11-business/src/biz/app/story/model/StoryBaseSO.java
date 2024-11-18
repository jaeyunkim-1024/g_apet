package biz.app.story.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;

@Data
public class StoryBaseSO extends BaseSearchVO<StoryBaseSO>{

	private static final long serialVersionUID = 1L;
	
	private String	stId;

	private String dispYn;
	
	private Integer stryNo;
}