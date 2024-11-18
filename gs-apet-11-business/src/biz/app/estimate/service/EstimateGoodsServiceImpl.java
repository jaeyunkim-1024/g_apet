package biz.app.estimate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.estimate.dao.EstimateGoodsDao;
import biz.app.estimate.model.EstimateGoodsVO;
import biz.app.estimate.model.EstimateSO;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.estimate.service
* - 파일명		: EstimateGoodsServiceImpl.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 상품 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class EstimateGoodsServiceImpl implements EstimateGoodsService {

	@Autowired	private EstimateGoodsDao estimateGoodsDao;

	/*
	 * 견적서 상품 목록
	 * @see biz.app.estimate.service.EstimateGoodsService#listEstimateGoods(biz.app.estimate.model.EstimateSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<EstimateGoodsVO> listEstimateGoods(EstimateSO so) {
		return this.estimateGoodsDao.listEstimateGoods(so);
	}
}

