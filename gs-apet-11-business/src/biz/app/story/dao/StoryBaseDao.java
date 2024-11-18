package biz.app.story.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.story.model.StoryBaseSO;
import biz.app.story.model.StoryBaseVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.dao
* - 파일명		: StoryBaseDao.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		:  스토리기본항목 DAO
* </pre>
*/
@Repository
public class StoryBaseDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "storyBase.";
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StoryBaseDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: muel
	* - 설명		: 스토리 기본항목 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<StoryBaseVO> listStoryBase(StoryBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "listStoryBase", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StoryBaseDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: muel
	* - 설명		: 스토리 기본항목 목록(스토리번호)조회
	* </pre>
	* @param so
	* @return
	*/
	public StoryBaseVO getStory(Integer stryNo) {

		return selectOne(BASE_DAO_PACKAGE + "getStory", stryNo);
	}

}
