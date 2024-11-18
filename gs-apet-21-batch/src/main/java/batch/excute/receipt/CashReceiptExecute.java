package batch.excute.receipt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptVO;
import biz.app.receipt.service.CashReceiptService;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.enums.NicePayCodeMapping;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import biz.interfaces.nicepay.service.NicePayCashReceiptService;
import biz.interfaces.nicepay.service.NicePayCommonService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.receipt
* - 파일명		: CashReceiptExcute.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 현금영수증 관련 Excute
* </pre>
*/
@Slf4j
@Component
public class CashReceiptExecute {

	@Autowired
	private CashReceiptService cashReceiptService;

	@Autowired
	private BatchService batchService;
	
	@Autowired
	private NicePayCommonService nicePayCommonService;
	
	@Autowired
	private NicePayCashReceiptService nicePayCashReceiptService;

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: OrderExcute.java
	 * - 작성일		: 2017. 3. 29.
	 * - 작성자		: WilLee
	 * - 설명		: 현금 영수증 발행/재발행/취소
	 * </pre>
	 */
//	@Scheduled(fixedDelay=10000)
//	@Scheduled(cron = "0 0 * * * *")
	public void cronCashReceipt() {
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_CASH_RECEIPT);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		CashReceiptResVO receiptRes = null;
		CancelProcessResVO cancelRes = null; 
		CashReceiptPO crp = null;
		int apprSuccessCnt = 0;
		int apprFailCnt = 0;
		int cnclSuccessCnt = 0;
		int cnclFailCnt=0 ;

		try {
			
			/**************************************
			 * 발행 취소
			 **************************************/
			List<CashReceiptVO> listCashReceiptCncl = cashReceiptService.listBatchCashReceiptCncl();

			for (CashReceiptVO crv : listCashReceiptCncl) {
				CancelProcessReqVO req = new CancelProcessReqVO();
				req.setTID(crv.getLnkDealNo());	// 현금영수증 승인 return TID 기준으로 취소
				req.setMoid(crv.getClmNo());
				req.setCancelAmt(ObjectUtils.isEmpty(crv.getPayAmt()) ? null : crv.getPayAmt().toString());
				req.setSupplyAmt(ObjectUtils.isEmpty(crv.getSplAmt()) ? null : crv.getSplAmt().toString());
				req.setGoodsVat(ObjectUtils.isEmpty(crv.getStaxAmt()) ? null : crv.getStaxAmt().toString());
				req.setServiceAmt(ObjectUtils.isEmpty(crv.getSrvcAmt()) ? null : crv.getSrvcAmt().toString());
				req.setTaxFreeAmt("0");
				req.setCancelMsg(NicePayConstants.CANCEL_MSG_CS);
				/** TODO : 배치는 전체취소로 고정, 이후에 검토 사항
				 * */
				req.setPartialCancelCode(NicePayConstants.PART_CANCEL_CODE_0);
				
				cancelRes = nicePayCommonService.reqCancelProcess(req, NicePayConstants.MID_GB_SIMPLE, NicePayConstants.PAY_MEANS_04, NicePayConstants.MDA_GB_01);
				
				crp = new CashReceiptPO();
				crp.setCashRctNo(crv.getCashRctNo());
				if(NicePayConstants.CANCEL_PROCESS_SUCCESS_CODE.equals(cancelRes.getResultCode())){ // 성공
					crp.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_20);
					cnclSuccessCnt++;
				}else{ // 실패
					cnclFailCnt++;
					crp.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_90);
				}
				crp.setLnkDtm(DateUtil.getTimestamp(cancelRes.getCancelDate() + cancelRes.getCancelTime(), "yyyyMMddHHmmss"));
				crp.setLnkRstMsg(cancelRes.getResponseBody());
				crp.setSysUpdrNo(blpo.getSysRegrNo());
				cashReceiptService.updateCashReceipt(crp);
			}

			/********************************
			 * 발행 승인
			 ********************************/
			List<CashReceiptVO> listCashReceiptAppr = cashReceiptService.listBatchCashReceiptAppr();

			for (CashReceiptVO crv : listCashReceiptAppr) {
				String goodsNm = this.cashReceiptService.getCashReceiptGoodsNm(crv.getCashRctNo());
				CashReceiptReqVO req = new CashReceiptReqVO();
				req.setMoid(crv.getOrdNo());
				req.setReceiptAmt(ObjectUtils.isEmpty(crv.getPayAmt()) ? null : crv.getPayAmt().toString());
				req.setGoodsName(goodsNm);
				req.setReceiptType(NicePayCodeMapping.getMappingToNiceCode(CommonConstants.USE_GB, crv.getUseGbCd()));
				req.setReceiptTypeNo(crv.getIsuMeansNo());
				req.setReceiptSupplyAmt(ObjectUtils.isEmpty(crv.getSplAmt()) ? null : crv.getSplAmt().toString());
				req.setReceiptVAT(ObjectUtils.isEmpty(crv.getStaxAmt()) ? null : crv.getStaxAmt().toString());
				req.setReceiptServiceAmt(ObjectUtils.isEmpty(crv.getSrvcAmt()) ? null : crv.getSrvcAmt().toString());
				req.setReceiptTaxFreeAmt("0");
				req.setBuyerName(crv.getOrdNm());
				req.setBuyerEmail(crv.getOrdrEmail());
				req.setBuyerTel(crv.getOrdrMobile());
				
				receiptRes = nicePayCashReceiptService.reqCashReceipt(req);

				log.debug(">>>>>>>>>>>>현금영수증 승인 결과="+receiptRes.toString());
				crp = new CashReceiptPO();
				crp.setCashRctNo(crv.getCashRctNo());
				if(NicePayConstants.CASH_RECEIPT_SUCCESS_CODE.equals(receiptRes.getResultCode())){
					crp.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_20);
					apprSuccessCnt++;
				}else{
					apprFailCnt++;
					crp.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_90);
				}
				crp.setLnkDealNo(receiptRes.getTID());
				crp.setLnkDtm(StringUtil.isEmpty(receiptRes.getAuthDate()) ? null : DateUtil.getTimestamp(receiptRes.getAuthDate(), "yyMMddHHmmss"));
				crp.setLnkRstMsg(receiptRes.getResponseBody());
				crp.setSysUpdrNo(blpo.getSysRegrNo());
				cashReceiptService.updateCashReceipt(crp);
			}

			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
			
			String rstMsg = this.message.getMessage("batch.log.result.msg.cash_receipt", new Integer[]{apprSuccessCnt, apprFailCnt, cnclSuccessCnt, cnclFailCnt});
					
			blpo.setBatchRstMsg(rstMsg);

			batchService.insertBatchLog(blpo);

			log.debug(String.valueOf(blpo.getResult()));

		} catch (Exception e) {

			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
			blpo.setBatchRstMsg(e.getMessage());

			batchService.insertBatchLog(blpo);

			log.debug(String.valueOf(blpo.getResult()));
		}

	}
}
