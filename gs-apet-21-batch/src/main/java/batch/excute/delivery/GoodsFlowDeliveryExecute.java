package batch.excute.delivery;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;

import biz.app.batch.model.BatchCountLogPO;
import biz.app.batch.service.BatchService;
import biz.common.service.SlackService;
import biz.interfaces.goodsflow.model.TraceResult;
import biz.interfaces.goodsflow.service.GoodsFlowService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.delivery
* - 파일명		: GoodsFlowDeliveryExcute.java
* - 작성일		: 2017. 6. 20.
* - 작성자		: WilLee
* - 설명			: 굿스플로 배송 연동 관련 배치
 * </pre>
 */
@Slf4j
@Component
@EnableScheduling
public class GoodsFlowDeliveryExecute {

	@Autowired private GoodsFlowService goodsFlowService;
	@Autowired private BatchService batchService;
	@Autowired private SlackService slackService;
	@Autowired private MessageSourceAccessor message;	
	
	/**
	 * <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: GoodsFlowDeliveryExcute.java
	* - 작성일		: 2019. 6. 28.
	* - 작성자		: siete
	* - 설명		: 배송 추적 등록 요청
	 * </pre>
	 */
	//@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로
	public void cronOrdRequestTrace() {

		BatchCountLogPO blpo = new BatchCountLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_REQUEST_TRACE);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		Long total 	= Long.valueOf(0);		
		Long success= Long.valueOf(0);		
		Long fail 	= Long.valueOf(0);
		String resultCd =null;
		String resultMsg=null;
		try {
			TraceResult result = goodsFlowService.requestTraceV3New();	// 3.0
			total 	= (Long)ObjectUtils.defaultIfNull(result.getTotal(), Long.valueOf(0));
			success	= (Long)ObjectUtils.defaultIfNull(result.getSuccess(), Long.valueOf(0));
			fail 	= (Long)ObjectUtils.defaultIfNull(result.getFail(), Long.valueOf(0));
			
			resultCd = CommonConstants.BATCH_RST_CD_SUCCESS;
			
		} catch(RestClientException rce) {
			
			resultCd = CommonConstants.BATCH_RST_CD_FAIL;
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, rce);
		}
		resultMsg = message.getMessage("batch.log.result.msg.delivery", new Object[] { total, success, fail });
		
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(resultCd);
		blpo.setBatchRstMsg(resultMsg);
		blpo.setExecTgCnt(total);
		blpo.setExecSuccCnt(success);
		blpo.setExecFailCnt(fail);
		
		// slack 전송 (실패시)
		/*
		if(CommonConstants.BATCH_RST_CD_FAIL.equals(resultCd) || ((Long)ObjectUtils.defaultIfNull(fail, Long.valueOf(0L))).compareTo(Long.valueOf(0L)) == 1) {
			slackService.batchSlackMessage(blpo.getBatchId(), blpo.getExecTgCnt(), blpo.getExecFailCnt(), resultMsg);
		}
		*/
		
		batchService.insertBatchLog(blpo);
		
	}	
	
	/**
	 * <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: GoodsFlowDeliveryExcute.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: WilLee
	* - 설명		: 배송 결과 수신 및 응답처리
	 * </pre>
	 */
	//@Scheduled(fixedDelay=1)		//배치실행시 즉시실행 및 5분 단위로
	public void cronOrdReceiveTrace() {

		BatchCountLogPO blpo = new BatchCountLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_RECEIVE_TRACE);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		//TraceResult result = goodsFlowService.receiveTraceResult();	// 2.0
		TraceResult result = goodsFlowService.receiveTraceResultV3();	// 3.0
		String resultCd = (StringUtils.equals(result.getStatus(), CommonConstants.GOODS_FLOW_STATUS_SUCCESS) || StringUtils.equals(result.getStatus(), CommonConstants.GOODS_FLOW_STATUS_NO_DATA))
				? CommonConstants.BATCH_RST_CD_SUCCESS : CommonConstants.BATCH_RST_CD_FAIL;

		String resultMsg = (StringUtils.equals(result.getStatus(), CommonConstants.GOODS_FLOW_STATUS_SUCCESS) || StringUtils.equals(result.getStatus(), CommonConstants.GOODS_FLOW_STATUS_NO_DATA))
				? message.getMessage("batch.log.result.msg.delivery.success", new Object[] { result.getItems().size() })
				: message.getMessage("batch.log.result.msg.delivery.fail", new Object[] { result.getStatus() });
		log.debug("GoodsFlow result message :: {}", resultMsg);

		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(resultCd);
		blpo.setBatchRstMsg(resultMsg);
		blpo.setExecTgCnt((Long)ObjectUtils.defaultIfNull(result.getTotal(), Long.valueOf(0)));
		blpo.setExecSuccCnt((Long)ObjectUtils.defaultIfNull(result.getSuccess(), Long.valueOf(0)));
		blpo.setExecFailCnt((Long)ObjectUtils.defaultIfNull(result.getFail(), Long.valueOf(0)));
		
//		if(blpo.getBatchRstCd().equals(CommonConstants.BATCH_RST_CD_FAIL)) {
//			slackService.batchSlackMessage(blpo.getBatchId(), 0, 0);
//		}else if(blpo.getExecFailCnt()>0) {
//			slackService.batchSlackMessage(blpo.getBatchId(), blpo.getExecTgCnt(), blpo.getExecFailCnt());
//		}
		
		// slack 전송 (실패시)
		/*
		if(((Long)ObjectUtils.defaultIfNull(result.getFail(), Long.valueOf(0L))).compareTo(Long.valueOf(0L)) == 1) {
			slackService.batchSlackMessage(blpo.getBatchId(), blpo.getExecTgCnt(), blpo.getExecFailCnt(), resultMsg);
		}
		*/
		
		// 저장
		batchService.insertBatchLog(blpo);

	}
}
