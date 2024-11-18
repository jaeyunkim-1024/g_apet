package biz.interfaces.nicepay.service;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import biz.interfaces.nicepay.client.NicePayClient;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.enums.NicePayCodeMapping;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CheckBankAccountReqVO;
import biz.interfaces.nicepay.model.request.data.FixAccountReqVO;
import biz.interfaces.nicepay.model.request.data.VirtualAccountReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CheckBankAccountResVO;
import biz.interfaces.nicepay.model.response.data.FixAccountResVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountResVO;
import framework.common.constants.CommonConstants;
import framework.common.enums.NicePayApiSpec;
import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.service
 * - 파일명		: NicePayCommonServiceImpl.java
 * - 작성일		: 2021. 02. 22.
 * - 작성자		: JinHong
 * - 설명		: Nice pay 공통 서비스 구현
 * </pre>
 */
@Slf4j
@Transactional
@Service
public class NicePayCommonServiceImpl implements NicePayCommonService {

	@Autowired Properties webConfig;

	@Autowired Properties bizConfig;

	@Override
	public CancelProcessResVO reqCancelProcess(CancelProcessReqVO vo, String midGb, String payMeans, String mdaGb) {
		/*CancelProcessReqVO req = new CancelProcessReqVO();
		req.setTID("nictest04m04012101130910155757");	// 현금영수증 승인 return TID 기준으로 취소
		req.setMoid("C1234444444444");
		req.setCancelAmt("100000");
		req.setSupplyAmt("90909");
		req.setGoodsVat("9091");
		req.setServiceAmt("0");
		req.setTaxFreeAmt("0");
		req.setCancelMsg(NicePayConstants.CANCEL_MSG_CS);
		req.setPartialCancelCode(NicePayConstants.PART_CANCEL_CODE_0);
		*/
		
		NicePayClient<CancelProcessReqVO> client = new NicePayClient<CancelProcessReqVO>(vo, midGb, payMeans, mdaGb);

		StringBuilder builder = new StringBuilder();
		builder.append(vo.getMID())
				.append(vo.getCancelAmt())
				.append(vo.getEdiDate())
				.append(vo.getMerchanKey());
		
		CancelProcessResVO res =  client.getResponse(NicePayApiSpec.IF_CANCEL_PROCESS, vo, builder.toString(), CancelProcessResVO.class);
		
		return res;
	}
	
	@Override
	public CheckBankAccountResVO reqCheckBankAccount(CheckBankAccountReqVO vo) {
		NicePayClient<CheckBankAccountReqVO> client = new NicePayClient<CheckBankAccountReqVO>(vo, NicePayConstants.MID_GB_CERTIFY);

		StringBuilder builder = new StringBuilder();
		builder.append(vo.getMID())
				.append(vo.getEdiDate())
				.append(vo.getAccountNo())
				.append(vo.getMerchanKey());
		
		CheckBankAccountResVO res =  client.getResponse(NicePayApiSpec.IF_CHECK_BANK_ACCOUNT, vo, builder.toString(), CheckBankAccountResVO.class);
		
		return res;
	}
	
	@Override
	public VirtualAccountResVO reqGetVirtualAccount(VirtualAccountReqVO vo) {
		
		NicePayClient<VirtualAccountReqVO> client = new NicePayClient<VirtualAccountReqVO>(vo, NicePayConstants.MID_GB_SIMPLE, NicePayConstants.PAY_MEANS_03, NicePayConstants.MDA_GB_01);

		StringBuilder signData = new StringBuilder();
		signData.append(vo.getMID())
				.append(vo.getAmt())
				.append(vo.getEdiDate())
				.append(vo.getMoid())
				.append(vo.getMerchanKey());
		
		VirtualAccountResVO res =  client.getResponse(NicePayApiSpec.IF_GET_VIRTUAL_ACCOUNT, vo, signData.toString(), VirtualAccountResVO.class);
		
		return res;
	}

	@Override
	public FixAccountResVO reqRegistFixAccount(FixAccountReqVO vo) {
		NicePayClient<FixAccountReqVO> client = new NicePayClient<FixAccountReqVO>(vo, NicePayConstants.MID_GB_FIX_ACCOUNT, NicePayConstants.PAY_MEANS_03, NicePayConstants.MDA_GB_01);

		StringBuilder signData = new StringBuilder();
		signData.append(vo.getMID())
				.append(vo.getAmt())
				.append(vo.getEdiDate())
				.append(vo.getMoid())
				.append(vo.getMerchanKey());
		
		//To niceCode
		vo.setVbankBankCode(NicePayCodeMapping.getMappingToNiceCode(CommonConstants.BANK, vo.getVbankBankCode()));
		
		FixAccountResVO res =  client.getResponse(NicePayApiSpec.IF_REGIST_FIX_ACCOUNT, vo, signData.toString(), FixAccountResVO.class);
		
		return res;
	}
}