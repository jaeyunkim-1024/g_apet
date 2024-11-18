package biz.app.estimate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.estimate.dao.EstimateDao;
import biz.app.estimate.model.EstimateSO;
import biz.app.estimate.model.EstimateVO;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.estimate.service
* - 파일명		: EstimateServiceImpl.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class EstimateServiceImpl implements EstimateService {

	@Autowired	private EstimateDao estimateDao;

	/* 
	 * 견적서 목록 조회(페이징)
	 * @see biz.app.estimate.service.EstimateService#pageEstimate(biz.app.estimate.model.EstimateSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<EstimateVO> pageEstimate(EstimateSO so) {
		so.setSord("DESC");
		so.setSidx("ESTM_NO");
		return estimateDao.pageEstimate(so);
	}
}

