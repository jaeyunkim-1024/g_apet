package biz.app.estimate.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.estimate.model.EstimateSO;
import biz.app.estimate.model.EstimateVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.estimate.dao
* - 파일명		: EsitmateDao.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 DAO
* </pre>
*/
@Repository
public class EstimateDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "estimate.";


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EstimateDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<EstimateVO> pageEstimate(EstimateSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageEstimate", so );
	}
}
