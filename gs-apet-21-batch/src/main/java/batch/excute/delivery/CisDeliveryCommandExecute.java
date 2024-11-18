package batch.excute.delivery;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.interfaces.CisOrderDeliveryCmdVO;
import biz.app.order.service.interfaces.CisOrderDeliveryService;
import biz.interfaces.cis.model.request.order.OrderInquirySO;
import biz.interfaces.cis.model.request.order.OrderInsertItemPO;
import biz.interfaces.cis.model.request.order.OrderInsertPO;
import biz.interfaces.cis.model.response.order.OrderInquiryItemVO;
import biz.interfaces.cis.model.response.order.OrderInquiryVO;
import biz.interfaces.cis.model.response.order.OrderInsertItemVO;
import biz.interfaces.cis.model.response.order.OrderInsertVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.delivery
* - 파일명		: CisDeliveryCommandExecute.java
* - 작성일		: 2021. 2. 2.
* - 작성자		: kek01
* - 설명			: CIS 배송 지시
 * </pre>
 */
@Slf4j
@Component
@EnableScheduling
public class CisDeliveryCommandExecute {

	@Autowired private BatchService batchService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private CisOrderDeliveryService cisOrderDeliveryService;
	@Autowired private CisOrderService cisOrderService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: CisDeliveryCommandExecute.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: kek01
	 * - 설명		: CIS 배송 지시 - (주문배송, 클레임교환배송) 배송지시를 처리한다
	 *              - 자사 상품일때	CIS 주문등록IF 호출 및 응답성공시 DB변경 실행
	 *              - 위탁 상품일때	CIS 주문등록IF 호출 및 응답성공시 DB변경 실행
	 * </pre>
	 */
//	@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로 로컬테스트시
	public void cronCisDeliveryCommand() throws Exception {
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_DLVR_CIS_DELIVERY_CMD);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		int successCnt = 0;
		int totalCnt = 0;
		
		String prvOrderNo = null;
		OrderInsertPO param = null;
		CisOrderDeliveryCmdVO prvReqVO = null;
		CisOrderDeliveryCmdVO curReqVO = null;
		List<OrderInsertItemPO> items = new ArrayList<OrderInsertItemPO>();
		
		//CIS에 배송요청 대상조회
		List<CisOrderDeliveryCmdVO> sList = cisOrderDeliveryService.listCisDeliveryCmd();

		for(CisOrderDeliveryCmdVO cisOrderDeliveryCmdVO : sList) {
			curReqVO = cisOrderDeliveryCmdVO;
			//보안 진단. 널 포인터 역참조
			if(prvOrderNo == null || (prvOrderNo != null && !prvOrderNo.equals(curReqVO.getOrdNo()))) {
				if(prvOrderNo != null) {
					
					//----------------------
					//<START> CIS API 호출
					//----------------------
					try {
						//호출
						if(param != null) {//보안 진단. 널 포인터 역참조
							param.setItemList(items);
							param.setRmkTxt(StringUtil.removeEmoji(param.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
							OrderInsertVO resVO = cisOrderService.insertOrder(param);
							
							//-----------------------------------------------------------------------------------------------------
							//CIS 연동결과 - 오류코드:0028, 오류내용:{0}번째 품목의 경우 이미 등록된 내역이 존재합니다. 발생시 처리 - 2021.04.29 kek01
							if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_FAIL_CD_0028)) {
								resVO = makeResVOWhenCisExist(resVO, prvReqVO.getOrdNo(), param);
							}
							//-----------------------------------------------------------------------------------------------------
							
							//후처리 DB변경 (응답 Success)
							if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) { 
								if(prvReqVO != null) {//보안 진단. 널 포인터 역참조
									cisOrderDeliveryService.updateCisDeliveryCmdAfter(resVO.getItemList(), prvReqVO.getDlvrPrcsTpCd(), prvReqVO.getOrdDlvraNo(), prvReqVO.getClmDlvrYn(), param.getItemList());
									successCnt++;
									log.info("### 배송지시_SUCCESS - ordNo:"+prvReqVO.getOrdNo()+", ordDtlSeq:"+prvReqVO.getOrdDtlSeq()+", ordDtlCstrtNo:"+prvReqVO.getOrdDtlCstrtNo()+", 클레임배송여부:"+prvReqVO.getClmDlvrYn());
								}								
							}
						}						
					}catch(Exception ex) {
						log.error("### 배송지시_EXCEPTION - ordNo:"+prvReqVO.getOrdNo()+", ordDtlSeq:"+prvReqVO.getOrdDtlSeq()+", ordDtlCstrtNo:"+prvReqVO.getOrdDtlCstrtNo()+", 클레임배송여부:"+prvReqVO.getClmDlvrYn());
						ex.printStackTrace();
//						StringWriter sw = new StringWriter();
//						ex.printStackTrace(new PrintWriter(sw)); 
//						log.error("### 배송지시_StackTrace: " + sw.toString());
					}
					totalCnt++;
					//----------------------
					//< END > CIS API 호출
					//----------------------
					
					//초기화
					items = new ArrayList<OrderInsertItemPO>();
				}
				param = null;
				param = curReqVO.getOrderInsertPO();
				
				OrderInsertItemPO tmpPO = curReqVO.getOrderInsertPO().getItemList().get(0);
				tmpPO.setRmkTxt(StringUtil.removeEmoji(tmpPO.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
				items.add(tmpPO);

			}else{
				OrderInsertItemPO tmpPO = curReqVO.getOrderInsertPO().getItemList().get(0);
				tmpPO.setRmkTxt(StringUtil.removeEmoji(tmpPO.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
				items.add(tmpPO);
			}
			
			prvReqVO = curReqVO;
			prvOrderNo = curReqVO.getOrdNo();
			
		}

		if(sList.size() > 0) {
			//----------------------
			//<START> CIS API 호출
			//----------------------
			try {
				//호출
				if(param != null) {//보안 진단. 널 포인트 역참조
					param.setItemList(items);
					param.setRmkTxt(StringUtil.removeEmoji(param.getRmkTxt())); //이모티콘제거
					OrderInsertVO resVO = cisOrderService.insertOrder(param);
					
					//-----------------------------------------------------------------------------------------------------
					//CIS 연동결과 - 오류코드:0028, 오류내용:{0}번째 품목의 경우 이미 등록된 내역이 존재합니다. 발생시 처리 - 2021.04.29 kek01
					if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_FAIL_CD_0028)) {
						resVO = makeResVOWhenCisExist(resVO, curReqVO.getOrdNo(), param);
					}
					//-----------------------------------------------------------------------------------------------------
					
					//후처리 DB변경 (응답 Success)
					if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) { 
						cisOrderDeliveryService.updateCisDeliveryCmdAfter(resVO.getItemList(), curReqVO.getDlvrPrcsTpCd(), curReqVO.getOrdDlvraNo(), curReqVO.getClmDlvrYn(), param.getItemList());
						successCnt++;
						log.info("### 배송지시_SUCCESS - ordNo:"+curReqVO.getOrdNo()+", ordDtlSeq:"+curReqVO.getOrdDtlSeq()+", ordDtlCstrtNo:"+curReqVO.getOrdDtlCstrtNo()+", 클레임배송여부="+curReqVO.getClmDlvrYn());
					}
				}				
			}catch(Exception ex) {
				log.error("### 배송지시_EXCEPTION - ordNo:"+curReqVO.getOrdNo()+", ordDtlSeq:"+curReqVO.getOrdDtlSeq()+", ordDtlCstrtNo:"+curReqVO.getOrdDtlCstrtNo()+", 클레임배송여부="+curReqVO.getClmDlvrYn());
				ex.printStackTrace();
			}				
			totalCnt++;
			//----------------------
			//< END > CIS API 호출
			//----------------------
		}

		
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		blpo.setBatchRstMsg(this.message.getMessage("batch.log.result.msg.order.delivery.command.success", new Object[]{totalCnt, successCnt, totalCnt-successCnt}));
		batchService.insertBatchLog(blpo);
	}
	
	/**
	 * CIS에 이미 주문등록이 성공한 경우인데 aboutPet는 주문완료인 경우, 수동으로 CIS 응답을 성공으로 만들어 리턴
	 * @param resVO
	 * @param ordNo
	 * @param param
	 * @return
	 */
	public OrderInsertVO makeResVOWhenCisExist(OrderInsertVO resVO, String ordNo, OrderInsertPO param) {
		try {
			if(resVO == null) { resVO = new OrderInsertVO(); }
			if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_FAIL_CD_0028)) {
				//-----------------------
				//CIS 주문조회 I/F 호출
				//-----------------------
				OrderInquirySO sovo = new OrderInquirySO();
				sovo.setShopOrdrNo(ordNo);
				OrderInquiryVO selResVO = cisOrderService.listOrder(sovo);
				
				if(StringUtil.nvl(selResVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) {
					if(selResVO.getItemList() != null) {
						List<OrderInquiryItemVO> selItemList = selResVO.getItemList();	//주문조회 ItemList
						if(selItemList.size() == param.getItemList().size()) {			//주문등록할 ItemList 와 주문조회 ItemList 갯수가 동일 하다면,
							resVO.setResCd(CommonConstants.CIS_API_SUCCESS_CD);
							resVO.setResMsg("");
							
							List<OrderInsertItemVO> makeItemList = new ArrayList<OrderInsertItemVO>();
							String ordrNo = "";
							for(OrderInquiryItemVO selItem : selItemList) {
								OrderInsertItemVO makeItem = new OrderInsertItemVO();
								makeItem.setSkuCd(selItem.getSkuCd());
								makeItem.setOrdrNo(selItem.getOrdrNo());
								makeItem.setSortNo(selItem.getSortNo());
								makeItem.setShopOrdrNo(selItem.getShopOrdrNo());
								makeItem.setShopSortNo(selItem.getShopSortNo());
								ordrNo = selItem.getOrdrNo();
								
								makeItemList.add(makeItem);
							}
							resVO.setItemList(makeItemList);
							resVO.setOrdrNo(ordrNo);
						}
					}
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return resVO;
	}
	
}
