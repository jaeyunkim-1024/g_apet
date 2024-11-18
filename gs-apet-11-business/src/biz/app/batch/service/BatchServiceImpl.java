package biz.app.batch.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.batch.dao.BatchDao;
import biz.app.batch.model.BatchLogPO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("batchService")
public class BatchServiceImpl implements BatchService {

	@Autowired
	private BatchDao batchDao;

	/*
	 * (non-Javadoc)
	 * @see biz.app.batch.service.BatchService#insertBatchLog(biz.app.batch.model.BatchLogPO)
	 */
	@Override
	public int insertBatchLog(BatchLogPO batchLogPO) {
		return batchDao.insertBatchLog(batchLogPO);
	}
		
	
	@Override
	public String selectBatchNm(String btchId)  {
		return batchDao.selectBatchNm(btchId);
		
	}

}