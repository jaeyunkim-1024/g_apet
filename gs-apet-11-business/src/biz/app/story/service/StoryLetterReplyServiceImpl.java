package biz.app.story.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.story.dao.StoryLetterReplyDao;
import biz.app.story.model.StoryLetterReplySO;
import biz.app.story.model.StoryLetterReplyVO;
import biz.common.service.BizService;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.story.service
* - 파일명		: storyBaseService.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: muel
* - 설명		: 스토리 기본항목 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("storyLetterReplyService")
public class StoryLetterReplyServiceImpl implements StoryLetterReplyService {

	@Autowired private StoryLetterReplyDao storyLetterReplyDao;
	
	@Autowired private BizService bizService;


	/* (스토리댓글조회)
	 * @see biz.app.story.service.StoryLetterReplyService#listStoryLetterReply(biz.app.story.model.StoryLetterReplySO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StoryLetterReplyVO> pageStoryLetterReply(StoryLetterReplySO slrso){
		
		return this.storyLetterReplyDao.pageStoryLetterReply(slrso);
	}
	
}