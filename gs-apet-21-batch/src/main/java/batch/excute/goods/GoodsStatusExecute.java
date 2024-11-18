package batch.excute.goods;

import batch.config.util.BatchLogUtil;
import biz.app.batch.model.BatchLogPO;
import biz.app.goods.service.GoodsBulkService;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsSaleExecute.java
 * - 작성일     : 2021. 04. 05.
 * - 작성자     : valfac
 * - 설명       : 상품 상태값 변경
 * </pre>
 */
@Slf4j
@Component
public class GoodsStatusExecute {

	@Autowired private GoodsBulkService goodsBulkService;

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명 : batch
	 * - 패키지명   : batch.excute.goods
	 * - 파일명     : cronTwcProductSync.java
	 * - 작성일     : 2021. 03. 31.
	 * - 작성자     : valfac
	 * - 설명       : 상품 판매기간 경과 판매중지
	 * 1분
	 * </pre>
	 */
	public void cronGoodsSaleEnd() {

		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_GOODS_STAT_60_UPDATE);
		String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;
		String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.proc.success");

		try {
			//프로시저 호출 SP_SET_GOODS_STAT 1분
			goodsBulkService.callGoodsStatProc();

		} catch (Exception e) {
			batchRstCd = CommonConstants.BATCH_RST_CD_FAIL;
			batchRstMsg = this.message.getMessage("batch.log.result.msg.goods.proc.fail", new Object[]{e.getMessage()});
			BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
		}

		//프로시저 안에서 배치로그 등록함. 주석처리 20210407
		//BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
	}
}
