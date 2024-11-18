package biz.app.story.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;

@Data
public class StoryLetterReplySO extends BaseSearchVO<StoryLetterReplySO>{

	private static final long serialVersionUID = 1L;
	
	private String sysDelYn;
	
	private Integer stryLettNo;
}