package batch.excute.delivery;

import java.util.List;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.delivery.model.DeliveryVO;
import biz.app.delivery.service.DeliveryService;
import biz.app.order.service.OrderService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.ObjectUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.delivery
* - 파일명		: DeliverySendNoticeExecute.java
* - 작성일		: 2021. 9. 2.
* - 작성자		: ksy02
* - 설명			: 배송 알림
 * </pre>
 */
@Slf4j
@Component
@EnableScheduling
public class DeliverySendNoticeExecute {

	@Autowired private BatchService batchService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private OrderService orderService;
	@Autowired private DeliveryService deliveryService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: CisReturnCommandExecute.java
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: ksy02
	 * - 설명		: 위탁업체 배송 안내 알림톡 발송
	 * </pre>
	 */
	public void cronSendConsignDlvrIng() throws Exception {
		sendConsignDlvr(AdminConstants.ORD_DTL_STAT_150, "K_M_ord_0016", CommonConstants.BATCH_DLVR_NOTICE_CONSIGN_ING);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: CisReturnCommandExecute.java
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: ksy02
	 * - 설명		: 위탁업체 배송 완료 알림톡 발송
	 * </pre>
	 */
	public void cronSendConsignDlvrFinal() throws Exception {
		sendConsignDlvr(AdminConstants.ORD_DTL_STAT_160, "K_M_ord_0018", CommonConstants.BATCH_DLVR_NOTICE_CONSIGN_FINAL);
	}
	
	public void sendConsignDlvr(String ordDtlstat, String tmpId, String batchId) {
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(batchId);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int successCnt = 0;
		int totalCnt = 0;
		
		// 위탁업체 배송안내 대상 조회 - 상태:배송중
		DeliveryVO so = new DeliveryVO();
		so.setOrdDtlStatCd(ordDtlstat);
		List<DeliveryVO> sList = deliveryService.listDeliveryConsignComp(so);
		
		for(DeliveryVO deliveryVO : sList) {
			if(ObjectUtil.isNotEmpty(deliveryVO) && ObjectUtil.isNotEmpty(deliveryVO.getOrdDtlSeqs())) {
				String[] ordDtlSeqs = deliveryVO.getOrdDtlSeqs().split(",");
				if(ordDtlSeqs.length > 0) {
					Integer[] arrayOrdDtlSeq = Stream.of(ordDtlSeqs).mapToInt(Integer::parseInt).boxed().toArray(Integer[]::new);
					orderService.sendMessage(deliveryVO.getOrdNo(), "", tmpId , null, arrayOrdDtlSeq, deliveryVO.getInvNo());
					totalCnt++;
					successCnt++;
				}
			}
		}
		
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		blpo.setBatchRstMsg(this.message.getMessage("batch.log.result.msg.order.delivery.command.success", new Object[]{totalCnt, successCnt, totalCnt-successCnt}));
		batchService.insertBatchLog(blpo);
		
	}
}
