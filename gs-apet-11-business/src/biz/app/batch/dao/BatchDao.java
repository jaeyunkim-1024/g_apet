package biz.app.batch.dao;

import org.springframework.stereotype.Repository;

import biz.app.batch.model.BatchLogPO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	    : biz.app.batch.dao
* - 파일명		: BatchDao.java
* - 작성일		: 2017. 3. 31.
* - 작성자		: WilLee
* - 설명			: Batch DAO
 * </pre>
 */
@Repository
public class BatchDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "batch.";

	public int insertBatchLog(BatchLogPO batchLogPO) {
		return update(BASE_DAO_PACKAGE + "insertBatchLog", batchLogPO);
	}
		
	
	public String selectBatchNm(String btchId) {
		return selectOne(BASE_DAO_PACKAGE + "selectBatchName", btchId);
	}
}
