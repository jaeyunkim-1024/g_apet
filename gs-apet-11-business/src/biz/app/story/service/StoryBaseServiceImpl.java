package biz.app.story.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.story.dao.StoryBaseDao;
import biz.app.story.model.StoryBaseSO;
import biz.app.story.model.StoryBaseVO;
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
@Service("storyBaseService")
public class StoryBaseServiceImpl implements StoryBaseService {

	@Autowired private StoryBaseDao storyBaseDao;
	
	@Autowired private BizService bizService;

	/*
	 * 스토리 기본항목 목록 조회
	 * @see biz.app.story.service.StoryBaseService#listStoryBase(biz.app.story.model.StoryBaseSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StoryBaseVO> listStoryBase(StoryBaseSO so){
		
		return this.storyBaseDao.listStoryBase(so);
	}

	@Override
	@Transactional(readOnly=true)
	public StoryBaseVO getStory(Integer stryNo){

		return this.storyBaseDao.getStory(stryNo);
	}


}