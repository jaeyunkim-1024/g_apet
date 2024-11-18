package batch.excute.delivery;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.interfaces.CisOrderReturnCmdVO;
import biz.app.order.service.interfaces.CisOrderReturnService;
import biz.interfaces.cis.model.request.order.ReturnInsertItemPO;
import biz.interfaces.cis.model.request.order.ReturnInsertPO;
import biz.interfaces.cis.model.response.order.ReturnInsertItemVO;
import biz.interfaces.cis.model.response.order.ReturnInsertVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.delivery
* - 파일명		: CisReturnCommandExecute.java
* - 작성일		: 2021. 3. 10.
* - 작성자		: kek01
* - 설명			: CIS 회수 지시
 * </pre>
 */
@Slf4j
@Component
@EnableScheduling
public class CisReturnCommandExecute {

	@Autowired private BatchService batchService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private CisOrderReturnService cisOrderReturnService;
	@Autowired private CisOrderService cisOrderService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: CisReturnCommandExecute.java
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: kek01
	 * - 설명		: CIS 회수 지시 - (반품회수, 교환회수) 회수지시를 처리한다
	 *              - 자사 상품일때	CIS 주문등록IF 호출 및 응답성공시 DB변경 실행
	 *              - 위탁 상품일때	DB 변경만 실행
	 * </pre>
	 */
//	@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로 로컬테스트시
	public void cronCisReturnCommand() throws Exception {

		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_DLVR_CIS_RETURN_CMD);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		int successCnt = 0;
		int totalCnt = 0;
		
		String prvClaimNo = null;
		ReturnInsertPO param = null;
		CisOrderReturnCmdVO prvReqVO = null;
		CisOrderReturnCmdVO curReqVO = null;
		List<ReturnInsertItemPO> items = new ArrayList<ReturnInsertItemPO>();
		List<ReturnInsertItemPO> itemsOut = new ArrayList<ReturnInsertItemPO>();
		
		//CIS에 회수요청 대상조회
		List<CisOrderReturnCmdVO> sList = cisOrderReturnService.listCisReturnCmd();

		for(CisOrderReturnCmdVO cisOrderReturnCmdVO : sList) {
			curReqVO = cisOrderReturnCmdVO;
			//보안 진단. 널 포인터 역참조
			if(prvClaimNo == null || (prvClaimNo != null && !prvClaimNo.equals(curReqVO.getClmNo()))) {
				if(prvClaimNo != null) {
					
					//----------------------
					//<START> CIS API 호출
					//----------------------
					try {
						ReturnInsertVO resVO = null;
	
						//자사 상품일때만 CIS 반품지시를 내린다
						if(items.size() > 0) {
							param.setItemList(items);
							param.setRmkTxt(StringUtil.removeEmoji(param.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
							resVO = cisOrderService.insertReturn(param);
						}
						//위탁 상품일때는 aboutPet BO 에서 처리를 위해 응답을 성공으로 조작하여 프로세스를 태운다 - CIS 미호출이나 후처리를 위해 응답값 수동 SET
						resVO = makeResponseDataExistOutGoods(items, param, resVO, itemsOut);
						
//						//------------------------------------------------------------------------	
//						//CIS 미호출시 테스트를 위해서 응답값 수동 SET
//						param.setItemList(items);
//						
//						List<ReturnInsertItemPO> paramItemsTemp = param.getItemList();
//						for (ReturnInsertItemPO itemout : itemsOut) {
//							ReturnInsertItemVO rivo = new ReturnInsertItemVO();
//							rivo.setShopOrdrNo(itemout.getShopOrdrNo());
//							rivo.setShopSortNo(itemout.getShopSortNo());
//							paramItemsTemp.add(itemout);
//						}					
//						param.setItemList(paramItemsTemp);
//						
//						resVO = new ReturnInsertVO();
//						resVO.setResCd(CommonConstants.CIS_API_SUCCESS_CD);
//						List<ReturnInsertItemVO> itemList = new ArrayList<ReturnInsertItemVO>();
//						for (ReturnInsertItemPO item : items) {
//							ReturnInsertItemVO rivo = new ReturnInsertItemVO();
//							rivo.setShopOrdrNo(item.getShopOrdrNo());
//							rivo.setShopSortNo(item.getShopSortNo());
//							itemList.add(rivo);
//						}
//						resVO.setItemList(itemList);
//						//------------------------------------------------------------------------
						
						//후처리 DB변경 (응답 Success)
						if(prvReqVO != null) {//보안 진단. 널 포인터 역참조
							if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) { 
								cisOrderReturnService.updateCisReturnCmdAfter(resVO.getItemList(), prvReqVO.getDlvrPrcsTpCd(), prvReqVO.getOrdDlvraNo(), prvReqVO.getExchgRtnYn(), param.getItemList());
								successCnt++;
								log.info("### 회수지시_SUCCESS - clmNo:"+prvReqVO.getClmNo()+", clmDtlSeq:"+prvReqVO.getClmDtlSeq()+", ClmDtlCstrtNo:"+prvReqVO.getClmDtlCstrtNo()+", 교환회수여부:"+prvReqVO.getExchgRtnYn());
							}
						}						
					}catch(Exception ex) {
						log.error("### 회수지시_EXCEPTION - clmNo:"+prvReqVO.getClmNo()+", clmDtlSeq:"+prvReqVO.getClmDtlSeq()+", ClmDtlCstrtNo:"+prvReqVO.getClmDtlCstrtNo()+", 교환회수여부:"+prvReqVO.getExchgRtnYn());
						ex.printStackTrace();
					}
					totalCnt++;
					//----------------------
					//< END > CIS API 호출
					//----------------------
					
					//초기화
					items = new ArrayList<ReturnInsertItemPO>();
					itemsOut = new ArrayList<ReturnInsertItemPO>();
				}
				param = null;
				param = curReqVO.getReturnInsertPO();
				
				ReturnInsertItemPO tmpPO = curReqVO.getReturnInsertPO().getItemList().get(0);
				tmpPO.setRmkTxt(StringUtil.removeEmoji(tmpPO.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
				
				if(CommonConstants.COMP_GB_10.equals(curReqVO.getCompGbCd())) { //자사상품만 회수지시를 내린다
					items.add(tmpPO);
				}else {
					itemsOut.add(tmpPO);
				}
				
			}else{
				ReturnInsertItemPO tmpPO = curReqVO.getReturnInsertPO().getItemList().get(0);
				tmpPO.setRmkTxt(StringUtil.removeEmoji(tmpPO.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
				
				if(CommonConstants.COMP_GB_10.equals(curReqVO.getCompGbCd())) { //자사상품만 회수지시를 내린다
					items.add(tmpPO);
				}else {
					itemsOut.add(tmpPO);
				}
			}
			
			prvReqVO = curReqVO;
			prvClaimNo = curReqVO.getClmNo();
			
		}

		if(sList.size() > 0) {
			//----------------------
			//<START> CIS API 호출
			//----------------------
			try {
				ReturnInsertVO resVO = null;
	
				//자사 상품일때만 CIS 반품지시를 내린다
				if(items.size() > 0) {
					param.setItemList(items);
					param.setRmkTxt(StringUtil.removeEmoji(param.getRmkTxt())); //이모티콘제거 - 2021.05.14 by kek01
					resVO = cisOrderService.insertReturn(param);
				}
				//위탁 상품일때는 aboutPet BO 에서 처리를 위해 응답을 성공으로 조작하여 프로세스를 태운다 - CIS 미호출이나 후처리를 위해 응답값 수동 SET
				resVO = makeResponseDataExistOutGoods(items, param, resVO, itemsOut);
							
//				//------------------------------------------------------------------------	
//				//CIS 미호출시 테스트를 위해서 응답값 수동 SET
//				param.setItemList(items);
//				
//				List<ReturnInsertItemPO> paramItemsTemp = param.getItemList();
//				for (ReturnInsertItemPO itemout : itemsOut) {
//					ReturnInsertItemVO rivo = new ReturnInsertItemVO();
//					rivo.setShopOrdrNo(itemout.getShopOrdrNo());
//					rivo.setShopSortNo(itemout.getShopSortNo());
//					paramItemsTemp.add(itemout);
//				}					
//				param.setItemList(paramItemsTemp);
//	
//				resVO = new ReturnInsertVO();
//				resVO.setResCd(CommonConstants.CIS_API_SUCCESS_CD);
//				List<ReturnInsertItemVO> itemList = new ArrayList<ReturnInsertItemVO>();
//				for (ReturnInsertItemPO item : items) {
//					ReturnInsertItemVO rivo = new ReturnInsertItemVO();
//					rivo.setShopOrdrNo(item.getShopOrdrNo());
//					rivo.setShopSortNo(item.getShopSortNo());
//					itemList.add(rivo);
//				}
//				resVO.setItemList(itemList);
//				//------------------------------------------------------------------------
				
				//후처리 DB변경 (응답 Success)
				if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) { 
					cisOrderReturnService.updateCisReturnCmdAfter(resVO.getItemList(), curReqVO.getDlvrPrcsTpCd(), curReqVO.getOrdDlvraNo(), curReqVO.getExchgRtnYn(), param.getItemList());
					successCnt++;
					log.info("### 회수지시_SUCCESS - clmNo:"+curReqVO.getClmNo()+", clmDtlSeq:"+curReqVO.getClmDtlSeq()+", ClmDtlCstrtNo:"+curReqVO.getClmDtlCstrtNo()+", 교환회수여부="+curReqVO.getExchgRtnYn());
				}
			}catch(Exception ex) {
				log.error("### 회수지시_EXCEPTION - clmNo:"+curReqVO.getClmNo()+", clmDtlSeq:"+curReqVO.getClmDtlSeq()+", ClmDtlCstrtNo:"+curReqVO.getClmDtlCstrtNo()+", 교환회수여부="+curReqVO.getExchgRtnYn());
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
	 * 위탁 상품일때는 aboutPet BO 에서 처리를 위해 응답을 성공으로 조작하여 프로세스를 태운다 - CIS 미호출이나 후처리를 위해 응답값 수동 SET
	 * @param items
	 * @param param
	 * @param resVO
	 * @param itemsOut
	 */
	public ReturnInsertVO makeResponseDataExistOutGoods(List<ReturnInsertItemPO> items, ReturnInsertPO param, ReturnInsertVO resVO, List<ReturnInsertItemPO> itemsOut) {
		try {
			if(itemsOut.size() > 0) {
				if(resVO == null) { 					//자사상품이 없는 경우 (위탁상품만으로 회수지시된 경우)
					resVO = new ReturnInsertVO();
					resVO.setResCd(CommonConstants.CIS_API_SUCCESS_CD);
					List<ReturnInsertItemVO> itemList = new ArrayList<ReturnInsertItemVO>();
					for (ReturnInsertItemPO itemout : itemsOut) {
						ReturnInsertItemVO rivo = new ReturnInsertItemVO();
						rivo.setShopOrdrNo(itemout.getShopOrdrNo());
						rivo.setShopSortNo(itemout.getShopSortNo());
						itemList.add(rivo);
					}
					resVO.setItemList(itemList);
					param.setItemList(itemsOut);
	
				}else {									//자사상품+위탁상품 섞여서 회수지시된 경우
					if(CommonConstants.CIS_API_SUCCESS_CD.equals(resVO.getResCd())) { //성공일때만 위탁상품 정보를 넣어준다
						List<ReturnInsertItemVO> itemsTemp = resVO.getItemList();
						List<ReturnInsertItemPO> paramItemsTemp = param.getItemList();
						
						if(itemsTemp == null) { itemsTemp = new ArrayList<ReturnInsertItemVO>(); }
						
						for (ReturnInsertItemPO itemout : itemsOut) {
							ReturnInsertItemVO rivo = new ReturnInsertItemVO();
							rivo.setShopOrdrNo(itemout.getShopOrdrNo());
							rivo.setShopSortNo(itemout.getShopSortNo());
							itemsTemp.add(rivo);
							
							paramItemsTemp.add(itemout);
						}
						
						resVO.setItemList(itemsTemp);
						param.setItemList(paramItemsTemp);
					}
				}
			}
		}catch(Exception ex) {
			throw ex;
		}
		return resVO;
	}
}
