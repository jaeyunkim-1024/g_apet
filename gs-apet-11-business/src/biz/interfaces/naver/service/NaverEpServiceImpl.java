package biz.interfaces.naver.service;

import biz.interfaces.naver.dao.NaverEpDao;
import biz.interfaces.naver.model.NaverEpVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.interfaces.naver.service
 * - 파일명     : NaverEpServiceImpl.java
 * - 작성일     : 2021. 03. 02.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Slf4j
@Transactional
@Service("naverEpService")
public class NaverEpServiceImpl implements NaverEpService {
	@Autowired
	NaverEpDao naverEpDao;

	@Override
	public List<NaverEpVO> getNaverEpInfo() {
		return naverEpDao.selectNaverEpInfo();
	}
}
