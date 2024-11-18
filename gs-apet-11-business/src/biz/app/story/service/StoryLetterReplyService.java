package biz.app.story.service;

import java.util.List;

import biz.app.story.model.StoryLetterReplySO;
import biz.app.story.model.StoryLetterReplyVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.service
* - 파일명		: StoryLetterReplyService.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: Administrator
* - 설명		:
* </pre>
*/
public interface StoryLetterReplyService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명	: biz.app.story.service
	* - 파일명		: StoryLetterService.java
	* - 작성일		: 2016. 4. 22.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	*/
	List<StoryLetterReplyVO> pageStoryLetterReply(StoryLetterReplySO slrso);
}