package biz.twc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.twc.dao.TwcSampleDao;
import biz.twc.model.TwcSampleVO;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.twc.service
* - 파일명		: TwcSampleServiceImpl.java
* - 작성일		: 2021.01.08
* - 작성자		: KKB
* - 설명		: TWC 샘픔 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional(value="TwcTransactionManager")
public class TwcSampleServiceImpl implements TwcSampleService {

	@Autowired	private TwcSampleDao twcSampleDao;

	@Override
	public List<TwcSampleVO> getHelpKeyword() {
		return twcSampleDao.getHelpKeyword();
	}
}

