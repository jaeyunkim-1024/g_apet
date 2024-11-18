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

import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsDispExecute.java
 * - 작성일     : 2021. 05. 25.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Slf4j
@Component
public class GoodsDispExecute {

	@Autowired
	private GoodsBulkService goodsBulkService;

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명 : batch
	 * - 패키지명   : batch.excute.goods
	 * - 파일명     : GoodsDispExecute.java
	 * - 작성일     : 2021. 05. 25.
	 * - 작성자     : valfac
	 * - 설명      : 상품 전체 카테고리 전시 순위 집계 배치
	 * 1분
	 * </pre>
	 */
	public void cronGoodsDispRank() {
		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_GOODS_DISPLAY_ALL_CTG);
		String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;
		String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.proc.success");

		String nowDateTime = DateUtil.getNowDateTime();
		Timestamp now = DateUtil.getTimestamp(nowDateTime, "yyyy-MM-dd HH:mm:ss");
		Timestamp compareDateTime = DateUtil.getTimestamp("2021-06-05 21:35:00", "yyyy-MM-dd HH:mm:ss");

		try {

			if(now.after(compareDateTime)) {
				//프로시저 호출 SP_BAT_DISPLAY_GOODS_ALL_CTG 5분
				goodsBulkService.callGoodsDispAllCtgProc();
			} else {
				batchRstCd = "PASS";
			}

		} catch (Exception e) {
			batchRstCd = CommonConstants.BATCH_RST_CD_FAIL;
			batchRstMsg = this.message.getMessage("batch.log.result.msg.goods.proc.fail", new Object[]{e.getMessage()});
			BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
		}

		BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
	}
}
