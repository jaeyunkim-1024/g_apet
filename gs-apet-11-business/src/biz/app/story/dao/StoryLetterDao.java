package biz.app.story.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.story.model.StoryLetterSO;
import biz.app.story.model.StoryLetterVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.dao
* - 파일명		: StoryLetterDao.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		:  스토리글항목 DAO
* </pre>
*/
@Repository
public class StoryLetterDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "storyLetter.";
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StoryLetterDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: muel
	* - 설명		: 스토리 글 항목 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<StoryLetterVO> pageStoryLetter(StoryLetterSO slso) {
		return selectListPage(BASE_DAO_PACKAGE + "pageStoryLetter", slso);
	}

	public StoryLetterVO getStoryDetail(StoryLetterSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getStoryDetail", so);
	}
}
