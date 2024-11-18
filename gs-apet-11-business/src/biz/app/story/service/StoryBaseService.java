package biz.app.story.service;

import java.util.List;

import biz.app.story.model.StoryBaseSO;
import biz.app.story.model.StoryBaseVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.service
* - 파일명		: storyBaseService.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: muel
* - 설명		: 스토리 서비스 구조
* </pre>
*/
public interface StoryBaseService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: storyBaseService.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: muel
	* - 설명		: 스토리 기본항목 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<StoryBaseVO> listStoryBase(StoryBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: storyBaseService.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: muel
	* - 설명		: 스토리 기본항목 조회(스토리번호)
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	StoryBaseVO getStory(Integer stryNo);
}