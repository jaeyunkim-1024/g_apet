package biz.app.story.service;

import java.util.List;

import biz.app.story.model.StoryLetterSO;
import biz.app.story.model.StoryLetterVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.service
* - 파일명		: storyLetterService.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: muel
* - 설명		: 스토리글 서비스 구조
* </pre>
*/

public interface StoryLetterService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: storyLetterService.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: muel
	* - 설명		: 스토리 글 목록 조회
	* </pre>
	* @param slso
	* @return
	* @throws Exception
	*/
	List<StoryLetterVO> pageStoryLetter(StoryLetterSO slso);
	
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
	StoryLetterVO getStoryDetail(StoryLetterSO so);
}