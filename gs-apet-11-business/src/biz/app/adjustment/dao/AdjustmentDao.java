package biz.app.adjustment.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.adjustment.model.AdjustmentSO;
import biz.app.adjustment.model.AdjustmentVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app
* - 파일명		: AdjustmentDao.java
* - 작성일		: 2016. 8. 31.
* - 작성자		: valueFactory
* - 설명			:
* </pre>
*/
@Repository
public class AdjustmentDao extends MainAbstractDao {

	//private static final String BASE_DAO_PACKAGE = "adjustment.";


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentDao.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listCompAdjustmentDtl (AdjustmentSO adjustmentSO ) {
		return selectList("adjustment.listCompAdjustmentDtl", adjustmentSO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentDao.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listCompAdjustment (AdjustmentSO adjustmentSO ) {
		return selectList("adjustment.listCompAdjustment", adjustmentSO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentDao.java
	* - 작성일		: 2016. 9. 3.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listPageAdjustment (AdjustmentSO adjustmentSO ) {
		return selectList("adjustment.listPageAdjustment", adjustmentSO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentDao.java
	* - 작성일		: 2016. 9. 3.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listPageAdjustmentDtl (AdjustmentSO adjustmentSO ) {
		return selectList("adjustment.listPageAdjustmentDtl", adjustmentSO );
	}


}
