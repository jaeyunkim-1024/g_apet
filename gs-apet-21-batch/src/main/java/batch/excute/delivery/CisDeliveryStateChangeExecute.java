package batch.excute.delivery;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.interfaces.CisOrderDeliveryStateChgVO;
import biz.app.order.service.interfaces.CisOrderDeliveryService;
import biz.interfaces.cis.model.request.order.OrderInquirySO;
import biz.interfaces.cis.model.response.order.OrderInquiryItemVO;
import biz.interfaces.cis.model.response.order.OrderInquiryVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.delivery
* - 파일명		: CisDeliveryStateChangeExecute.java
* - 작성일		: 2021. 2. 17.
* - 작성자		: kek01
* - 설명			: CIS 배송 상태 변경
 * </pre>
 */
@Slf4j
@Component
@EnableScheduling
public class CisDeliveryStateChangeExecute {

	@Autowired private BatchService batchService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private CisOrderDeliveryService cisOrderDeliveryService;
	@Autowired private CisOrderService cisOrderService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: CisDeliveryStateChangeExecute.java
	 * - 작성일		: 2021. 2. 17.
	 * - 작성자		: kek01
	 * - 설명		: CIS 배송 상태 변경 - 주문, 클레임 상태 변경 처리한다
	 * 				  - 자사 상품일때만	CIS 주문조회IF 호출 및 응답성공시 DB변경 실행  (위탁상품은 상태변경 X)
	 *                - 새벽,당일 배송일때 배송완료까지 UPDATE
	 *                  택배      배송일때 배송중  까지 UPDATE   (배송완료는 굿스플로를 통해서 UPDATE 해야된다고 함)
	 * </pre>
	 */
//	@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로 로컬테스트시
	public void cronCisDeliveryStateChange() throws Exception {

		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_DLVR_CIS_DELIVERY_STATE_CHG);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		int successCnt = 0;
		int totalCnt = 0;
		
		String prvOrderNo = "";
		OrderInquirySO param = null;
		OrderInquiryVO resVO = null;
		CisOrderDeliveryStateChgVO cdscvo = new CisOrderDeliveryStateChgVO();
		List<OrderInquiryItemVO> sendMsgCisItems = new ArrayList<OrderInquiryItemVO>(); // 알림톡 발송용 cisItem 리스트
		
		//------------------------------------------------
		//CIS에 배송 상태 변경 대상조회 (주문상세구성 TBL 기준)
		//------------------------------------------------
		List<CisOrderDeliveryStateChgVO> ordDtlCstrtList = cisOrderDeliveryService.listCisDeliveryStateChg();
		int ordDtlCstrtListCnt = 0;

		for(CisOrderDeliveryStateChgVO vo : ordDtlCstrtList) {
			try {
				//-------------------------------------------------
				//주문번호(클레임번호)기준으로 CIS 호출 및 배송정보를 조회
				//-------------------------------------------------
				if(!prvOrderNo.equals(vo.getOrdNo())) {
					log.info("### 배송중,배송완료 알림톡 발송 리스트 확인  - cdscvo:"+cdscvo.getOrdNo()+", sendMsgCisItems:"+sendMsgCisItems.size()+", prvOrderNo:"+prvOrderNo+", ordNo:"+vo.getOrdNo());
					// 후처리 된 주문 알림톡 발송
					// 주문 당 상품들의 송장번호 중복 체크 후 송장번호 group별 cisItem 리스트 알림톡 발송 20210715
					if (CollectionUtils.isNotEmpty(sendMsgCisItems)) { 
						log.info("### 배송중,배송완료 알림톡 발송  - ordNo:"+cdscvo.getOrdNo()+", sendMsgCisItems:"+sendMsgCisItems.size());
						cisOrderDeliveryService.allInvcNoGoodsSendMessage(cdscvo, sendMsgCisItems);
						sendMsgCisItems.clear();
						cdscvo = new CisOrderDeliveryStateChgVO();
					}
					
					//CIS API 호출
					param = new OrderInquirySO();
					param.setShopOrdrNo(vo.getOrdNo());
					resVO = cisOrderService.listOrder(param);
				}
				if(resVO == null) { resVO = new OrderInquiryVO(); }
				
				//후처리 (응답 Success)
				if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) {
					OrderInquiryItemVO oiivo = cisOrderDeliveryService.updateCisDeliveryStateChgAfter(vo, resVO.getItemList());
					if (StringUtil.isNotEmpty(oiivo)) {
						log.info("### 알림톡 발송 대상 정보 - statCd:"+oiivo.getStatCd()+", shopSortNo[0]:"+StringUtil.split(oiivo.getShopSortNo(), "_")[0]);
						sendMsgCisItems.add(oiivo);
					}
					successCnt++;
					log.info("### 배송상태변경_SUCCESS - ordNo:"+vo.getOrdNo()+", ordDtlSeq:"+vo.getOrdDtlSeq()+", ordDtlCstrtNo:"+vo.getOrdDtlCstrtNo()+", 클레임배송여부:"+vo.getClmDlvrYn());
				}
			}catch(Exception ex) {
				log.error("### 배송상태변경_EXCEPTION - ordNo:"+vo.getOrdNo()+", ordDtlSeq:"+vo.getOrdDtlSeq()+", ordDtlCstrtNo:"+vo.getOrdDtlCstrtNo()+", 클레임배송여부:"+vo.getClmDlvrYn());
				ex.printStackTrace();
			}
			totalCnt++;

			prvOrderNo = vo.getOrdNo();
			cdscvo = vo;
			ordDtlCstrtListCnt++;
			
			log.info("### 주문상세구성 리스트 COUNT - ordDtlCstrtListCnt:"+ordDtlCstrtListCnt+", ordDtlCstrtList:"+ordDtlCstrtList.size()+", sendMsgCisItems:"+sendMsgCisItems.size());
			// 반복문 마지막 vo일 경우 cisItems 알림톡 발송
			if (ordDtlCstrtListCnt == ordDtlCstrtList.size()) {
				if (CollectionUtils.isNotEmpty(sendMsgCisItems)) {
					cisOrderDeliveryService.allInvcNoGoodsSendMessage(cdscvo, sendMsgCisItems);
					sendMsgCisItems.clear();
					cdscvo = new CisOrderDeliveryStateChgVO();
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
