package batch.excute.goods;

import batch.config.util.BatchLogUtil;
import biz.app.batch.model.BatchLogPO;
import biz.app.goods.service.GoodsBulkService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsBastExcute.java
 * - 작성일     : 2021. 03. 29.
 * - 작성자     : valfac
 * - 설명       : 매일 아침 베스트 업데이트
 * </pre>
 */

@Slf4j
@Component
public class GoodsBastExecute {

	@Autowired private GoodsBulkService goodsBulkService;

	@Autowired private MessageSourceAccessor message;

	//@Scheduled(cron = "0 0 1 * * ?")
	public void cronGoodsBest() {

		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_GOODS_BEST_INSERT);
		String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;
		String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.proc.success");

		try {
			//배치 실행 일자 세팅
			String argBaseDt = DateUtil.getNowDate();
			//프로시저 호출 SP_SET_BEST_GOODS_TOTAL(일자[Ymd], 기간[숫자]) 1일전
			goodsBulkService.callGoodsBestProc(argBaseDt);

		} catch (Exception e) {
			batchRstCd = CommonConstants.BATCH_RST_CD_FAIL;
			batchRstMsg = this.message.getMessage("batch.log.result.msg.goods.proc.fail", new Object[]{e.getMessage()});
			BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
		}

		//프로시저 안에서 배치 로그 등록, 주석처리 20210407
		//BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
	}
}
