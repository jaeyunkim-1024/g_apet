package biz.interfaces.nicepay.service;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.model.CashReceiptVO;
import biz.app.receipt.service.CashReceiptService;
import biz.interfaces.nicepay.client.NicePayClient;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import framework.common.enums.NicePayApiSpec;
import framework.front.model.Session;
import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.service
 * - 파일명		: NicePayCashReceiptServiceImpl.java
 * - 작성일		: 2021. 01. 13.
 * - 작성자		: JinHong
 * - 설명		: Nice Pay 현금영수증 서비스 구현
 * </pre>
 */
@Slf4j
@Transactional
@Service
public class NicePayCashReceiptServiceImpl implements NicePayCashReceiptService {

	@Autowired Properties webConfig;

	@Autowired Properties bizConfig;
	
	@Autowired CashReceiptService cashReceiptService;

	@Override
	public CashReceiptResVO reqCashReceipt(CashReceiptReqVO vo) {
		
		/*예시 : 현금영수증 요청 시 세팅*/
		//CashReceiptReqVO vo = new CashReceiptReqVO();
		/*vo = new CashReceiptReqVO();
		vo.setMoid("321321");
		vo.setReceiptAmt("100000");
		vo.setGoodsName("고양이 사료");
		vo.setReceiptType(NicePayConstants.RECEIPT_TYPE_1);
		vo.setReceiptTypeNo("01000000000");
		Long receiptAmt = Long.valueOf(vo.getReceiptAmt());
		Long supplyAmt = Math.round(receiptAmt.doubleValue() / 1.1);
		vo.setReceiptSupplyAmt(String.valueOf(supplyAmt));
		vo.setReceiptVAT(String.valueOf(receiptAmt - supplyAmt));
		vo.setReceiptServiceAmt("0");
		vo.setReceiptTaxFreeAmt("0");*/
		/*예시 : 현금영수증 요청 시 세팅 end*/
		
		NicePayClient<CashReceiptReqVO> client = new NicePayClient<CashReceiptReqVO>(vo, NicePayConstants.MID_GB_CERTIFY, NicePayConstants.PAY_MEANS_04, NicePayConstants.MDA_GB_01);
		//SignData builder
		StringBuilder builder = new StringBuilder();
		builder.append(vo.getMID())
				.append(vo.getReceiptAmt())
				.append(vo.getEdiDate())
				.append(vo.getMoid())
				.append(vo.getMerchanKey());
		CashReceiptResVO res =  client.getResponse(NicePayApiSpec.IF_CASH_RECEIPT, vo, builder.toString(), CashReceiptResVO.class);
		
		return res;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: pse
	 * - 설명		: 현금영수증 취소 요청
	 * </pre>
	 * @param vo
	 * @return
	 */
	@Override
	public CancelProcessReqVO setCancelCashReceipt(String ordNo) {
		CashReceiptSO cashReceiptSO = new CashReceiptSO();
		CancelProcessReqVO vo = null;
		
		cashReceiptSO.setOrdNo(ordNo);
		CashReceiptVO reqData = cashReceiptService.getCashReceipt(cashReceiptSO);
		if(reqData != null) {
			vo = new CancelProcessReqVO();
			vo.setTID(reqData.getLnkDealNo());
			vo.setCancelAmt(reqData.getPayAmt().toString());
			
			Long payAmt = reqData.getPayAmt();
			Long staxAmt = Math.round(payAmt.doubleValue() / 1.1 * 0.1);
			Long splAmt = payAmt - staxAmt;
			Long srvcAmt = 0L;
			vo.setSupplyAmt(splAmt.toString());
			vo.setGoodsVat(staxAmt.toString());
			
			vo.setCancelMsg("주문 취소");
			vo.setPartialCancelCode("0"); // 0:전체취소. 부분취소는 사용 안함.
			vo.setPayMeansCd(reqData.getPayMeansCd());
			vo.setMoid(ordNo);
		} 
		
		return vo;
	}
}