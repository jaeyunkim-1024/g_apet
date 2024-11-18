package batch.config.util;

import biz.app.batch.dao.BatchDao;
import biz.app.batch.model.BatchLogPO;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.config.util
 * - 파일명     : BatchLogUtil.java
 * - 작성일     : 2021. 04. 05.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Slf4j
@Component
public class BatchLogUtil {

	private static BatchDao batchDao;

	/**
	 * 배치 시작 시간 세팅
	 * @param batchId
	 */
	public static BatchLogPO initBatchLogStrtDtm(String batchId) {
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(batchId);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		return blpo;
	}

	/**
	 * 배치 로그 저장
	 * @param batchRstCd
	 * @param batchRstMsg
	 */
	public static void addBatchLog(BatchLogPO blpo, String batchRstCd, String batchRstMsg) {
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(batchRstCd);
		blpo.setBatchRstMsg(batchRstMsg);

		batchDao.insertBatchLog(blpo);

		log.debug(String.valueOf(blpo.getResult()));
	}

	@Autowired BatchDao dao;

	@PostConstruct
	private void init() {
		batchDao = this.dao;
	}
}
