package biz.app.estimate.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.estimate.model.EstimateGoodsVO;
import biz.app.estimate.model.EstimateSO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.estimate.dao
* - 파일명		: EstimateGoodsDao.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 상품 DAO
* </pre>
*/
@Repository
public class EstimateGoodsDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "estimateGoods.";


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EstimateGoodsDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 상품 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<EstimateGoodsVO> listEstimateGoods(EstimateSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listEstimateGoods", so );
	}

}
