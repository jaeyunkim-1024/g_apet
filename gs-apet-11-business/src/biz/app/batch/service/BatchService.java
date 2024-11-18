package biz.app.batch.service;

import biz.app.batch.model.BatchLogPO;

public interface BatchService {
	/**
	 * 배치 성공여부만 기록
	 * @param batchLogPO
	 * @return
	 */
	int insertBatchLog(BatchLogPO batchLogPO);
		

	/** 
	 * 배치 명 조회
	 * @param batchId
	 * @return String
	 */
	String selectBatchNm(String btchId);
}