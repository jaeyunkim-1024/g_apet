package biz.app.story.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;

@Data
public class StoryLetterSO extends BaseSearchVO<StoryLetterSO>{

	private static final long serialVersionUID = 1L;
	
	private String sysDelYn;
	
	private Integer stryNo;
	
	private String searchWord;
	
	private String searchType;
	
	private Integer stryLettNo;
}