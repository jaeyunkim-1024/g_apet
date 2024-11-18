package biz.app.story.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.story.dao.StoryLetterDao;
import biz.app.story.model.StoryLetterSO;
import biz.app.story.model.StoryLetterVO;
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
@Service("storyLetterService")
public class StoryLetterServiceImpl implements StoryLetterService {

	@Autowired private StoryLetterDao storyLetterDao;
	
	@Autowired private BizService bizService;

	/*
	 * 스토리 글 목록 조회
	 * @see biz.app.story.service.StoryLetterService#pageStoryLetter(biz.app.story.model.StoryLetterSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StoryLetterVO> pageStoryLetter(StoryLetterSO slso){
		
		return this.storyLetterDao.pageStoryLetter(slso);
	}
	
	
	/* (스토리상세조회)
	 * @see biz.app.story.service.StoryLetterService#getStoryDetail(biz.app.story.model.StoryLetterSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public StoryLetterVO getStoryDetail(StoryLetterSO so){
		
		return this.storyLetterDao.getStoryDetail(so);
	}
}