package biz.app.story.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.story.model.StoryLetterReplySO;
import biz.app.story.model.StoryLetterReplyVO;
import framework.common.dao.MainAbstractDao;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.dao
* - 파일명		: StoryLetterReplyDao.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: Administrator
* - 설명		:
* </pre>
*/
@Repository
public class StoryLetterReplyDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "storyLetterReply.";
	


	public List<StoryLetterReplyVO> pageStoryLetterReply(StoryLetterReplySO slrso) {
		return selectListPage(BASE_DAO_PACKAGE + "pageStoryLetterReply", slrso);
	}
}
