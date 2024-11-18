package batch.excute.order;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.service.OrdSavePntService;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@EnableScheduling
public class OrderPurchaseConfirmExcute {

	@Autowired	private OrderService orderService;
	@Autowired	private OrderDetailService orderDetailService;
	@Autowired	private OrdSavePntService ordSavePntService;
	@Autowired	private BatchService batchService;
	@Autowired private MessageSourceAccessor message;

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: OrderPurchaseConfirmExcute.java
	* - 작성일		: 2021. 3. 16.
	* - 작성자		: kek01
	* - 설명			: 구매 확정
	*               - 배송완료인 주문건을 조회해서 2주가 지났으면 구매확정 처리
	*               - 하위 모든 클레임이 종료되었때 구매확정 처리
	*               - 구매확정 처리시 계산된 포인트를 고객에게 지급처리 
	*               - 최초~세번째 구매 감사 쿠폰 지급 처리 추가 - 2021.05.03
	* </pre>
	*/
//	@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로
	public void cronOrderPurchaseConfirm() {
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_PURCHASE_CONFIRM);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		int successCnt = 0;
		int totalCnt = 0;
		
		//구매확정을 위한 배송완료된 주문상세 목록 조회
		OrderDetailSO so = new OrderDetailSO();
		List<OrderDetailVO> list = orderDetailService.listOrderDetailDlvrCpltForPurchaseConfirm(so);

		if (CollectionUtils.isNotEmpty(list)) {
			for (OrderDetailVO ordDtlVO : list) {
				
				totalCnt++;
				try {
					//=======================
					//주문상세 구매확정 처리
					//=======================
					Integer[] arrOrdDtlSeq = new Integer[1];
					arrOrdDtlSeq[0] = ordDtlVO.getOrdDtlSeq();
					orderDetailService.updateOrderDetailPurchase(ordDtlVO.getOrdNo(), arrOrdDtlSeq);
					
					successCnt++;
				}catch(Exception ex) {
					ex.getMessage();
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
