package biz.app.estimate.service;

import java.util.List;

import biz.app.estimate.model.EstimateGoodsVO;
import biz.app.estimate.model.EstimateSO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.estimate.service
* - 파일명		: EstimateGoodsService.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 상품 서비스 Interface
* </pre>
*/
public interface EstimateGoodsService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EstimateGoodsService.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 상품 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<EstimateGoodsVO> listEstimateGoods(EstimateSO so );
	
}
