package biz.interfaces.cis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import biz.interfaces.cis.model.request.order.OrderCancelPO;
import biz.interfaces.cis.model.request.order.OrderExptCreateSO;
import biz.interfaces.cis.model.request.order.OrderInquirySO;
import biz.interfaces.cis.model.request.order.OrderInsertItemPO;
import biz.interfaces.cis.model.request.order.OrderInsertPO;
import biz.interfaces.cis.model.request.order.OrderUpdateItemPO;
import biz.interfaces.cis.model.request.order.OrderUpdatePO;
import biz.interfaces.cis.model.request.order.ReturnCancelPO;
import biz.interfaces.cis.model.request.order.ReturnInquirySO;
import biz.interfaces.cis.model.request.order.ReturnInsertItemPO;
import biz.interfaces.cis.model.request.order.ReturnInsertPO;
import biz.interfaces.cis.model.request.order.ReturnUpdatePO;
import biz.interfaces.cis.model.request.order.RngeInquirySO;
import biz.interfaces.cis.model.request.order.SlotInquirySO;
import biz.interfaces.cis.model.response.order.OrderCancelVO;
import biz.interfaces.cis.model.response.order.OrderExptCreateVO;
import biz.interfaces.cis.model.response.order.OrderInquiryItemVO;
import biz.interfaces.cis.model.response.order.OrderInquiryVO;
import biz.interfaces.cis.model.response.order.OrderInsertVO;
import biz.interfaces.cis.model.response.order.OrderUpdateVO;
import biz.interfaces.cis.model.response.order.ReturnInquiryItemVO;
import biz.interfaces.cis.model.response.order.ReturnInquiryVO;
import biz.interfaces.cis.model.response.order.ReturnInsertVO;
import biz.interfaces.cis.model.response.order.ReturnUpdateVO;
import biz.interfaces.cis.model.response.order.RngeInquiryVO;
import biz.interfaces.cis.model.response.order.SlotInquiryItemVO;
import biz.interfaces.cis.model.response.order.SlotInquiryVO;
import framework.cis.client.ApiClient;
import framework.cis.model.response.ApiResponse;
import framework.cis.model.response.shop.OrderResponse;
import framework.common.constants.CommonConstants;
import framework.common.enums.CisApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.CisCryptoUtil;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("cisOrderService")
public class CisOrderServiceImpl implements CisOrderService{

	@Autowired private MessageSourceAccessor message;
	@Autowired private ApiClient apiClient;
	@Autowired private CisIfLogService cisIfLogService;
	@Autowired private CisCryptoUtil cisCryptoUtil;
	
	/**
	 * 주문등록
	 */
	@Override
	public OrderInsertVO insertOrder(OrderInsertPO param) throws Exception{
		OrderInsertVO res = new OrderInsertVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) { param = new OrderInsertPO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();

		//Validation check
		checkValidationInsertOrder(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) { 
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_INSERT_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}

		//암호화
		if(!StringUtil.isEmpty(param.getOrdrNm()))		{param.setOrdrNm(cisCryptoUtil.encrypt(param.getOrdrNm()));}
		if(!StringUtil.isEmpty(param.getOrdrTelNo()))	{param.setOrdrTelNo(cisCryptoUtil.encrypt(param.getOrdrTelNo()));}
		if(!StringUtil.isEmpty(param.getOrdrCelNo()))	{param.setOrdrCelNo(cisCryptoUtil.encrypt(param.getOrdrCelNo()));}
		if(!StringUtil.isEmpty(param.getOrdrEmail()))	{param.setOrdrEmail(cisCryptoUtil.encrypt(param.getOrdrEmail()));}
		if(!StringUtil.isEmpty(param.getRecvNm()))		{param.setRecvNm(cisCryptoUtil.encrypt(param.getRecvNm()));}
		if(!StringUtil.isEmpty(param.getRecvTelNo()))	{param.setRecvTelNo(cisCryptoUtil.encrypt(param.getRecvTelNo()));}
		if(!StringUtil.isEmpty(param.getRecvCelNo()))	{param.setRecvCelNo(cisCryptoUtil.encrypt(param.getRecvCelNo()));}
		if(!StringUtil.isEmpty(param.getRecvZipcode()))	{param.setRecvZipcode(cisCryptoUtil.encrypt(param.getRecvZipcode()));}
		if(!StringUtil.isEmpty(param.getRecvAddr()))	{param.setRecvAddr(cisCryptoUtil.encrypt(param.getRecvAddr()));}
		if(!StringUtil.isEmpty(param.getRecvAddrDtl()))	{param.setRecvAddrDtl(cisCryptoUtil.encrypt(param.getRecvAddrDtl()));}
		if(!StringUtil.isEmpty(param.getGateNo()))		{param.setGateNo(cisCryptoUtil.encrypt(param.getGateNo()));}

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_INSERT_ORDR_INFO, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), OrderInsertVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_INSERT_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
                null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;
	}
	
	/**
	 * 주문조회
	 */
	@Override
	public OrderInquiryVO listOrder(OrderInquirySO param) throws Exception{
		OrderInquiryVO res = new OrderInquiryVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) {	param = new OrderInquirySO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationInquiryOrder(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_ORDR_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}
		
		//암호화
		if(!StringUtil.isEmpty(param.getRtlrCd   ()))		{param.setRtlrCd   (cisCryptoUtil.encrypt(param.getRtlrCd   ()));}
		if(!StringUtil.isEmpty(param.getRtlrCdNm ()))		{param.setRtlrCdNm (cisCryptoUtil.encrypt(param.getRtlrCdNm ()));}
		if(!StringUtil.isEmpty(param.getSkuCd    ()))		{param.setSkuCd    (cisCryptoUtil.encrypt(param.getSkuCd    ()));}
		if(!StringUtil.isEmpty(param.getOrdrDd   ()))		{param.setOrdrDd   (cisCryptoUtil.encrypt(param.getOrdrDd   ()));}
		if(!StringUtil.isEmpty(param.getOrdrCelNo()))		{param.setOrdrCelNo(cisCryptoUtil.encrypt(param.getOrdrCelNo()));}
		if(!StringUtil.isEmpty(param.getRecvNm   ()))		{param.setRecvNm   (cisCryptoUtil.encrypt(param.getRecvNm   ()));}
		if(!StringUtil.isEmpty(param.getRecvCelNo()))		{param.setRecvCelNo(cisCryptoUtil.encrypt(param.getRecvCelNo()));}
		if(!StringUtil.isEmpty(param.getInvcNo   ()))		{param.setInvcNo   (cisCryptoUtil.encrypt(param.getInvcNo   ()));}
		if(!StringUtil.isEmpty(param.getDlvCmpyCd()))		{param.setDlvCmpyCd(cisCryptoUtil.encrypt(param.getDlvCmpyCd()));}
		if(!StringUtil.isEmpty(param.getStatCd   ()))		{param.setStatCd   (cisCryptoUtil.encrypt(param.getStatCd   ()));}
		
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_ORDR_LIST, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), OrderInquiryVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_ORDR_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				                          null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		//복호화
		List<OrderInquiryItemVO> items = res.getItemList();
		if(!StringUtil.isEmpty(items)) {
			for(OrderInquiryItemVO item : items) {
				if(!StringUtil.isEmpty(item.getOrdrNm()))		{item.setOrdrNm(cisCryptoUtil.decrypt(item.getOrdrNm()));}
				if(!StringUtil.isEmpty(item.getOrdrTelNo()))	{item.setOrdrTelNo(cisCryptoUtil.decrypt(item.getOrdrTelNo()));}
				if(!StringUtil.isEmpty(item.getOrdrCelNo()))	{item.setOrdrCelNo(cisCryptoUtil.decrypt(item.getOrdrCelNo()));}
				if(!StringUtil.isEmpty(item.getOrdrEmail()))	{item.setOrdrEmail(cisCryptoUtil.decrypt(item.getOrdrEmail()));}
				if(!StringUtil.isEmpty(item.getRecvNm()))		{item.setRecvNm(cisCryptoUtil.decrypt(item.getRecvNm()));}
				if(!StringUtil.isEmpty(item.getRecvTelNo()))	{item.setRecvTelNo(cisCryptoUtil.decrypt(item.getRecvTelNo()));}
				if(!StringUtil.isEmpty(item.getRecvCelNo()))	{item.setRecvCelNo(cisCryptoUtil.decrypt(item.getRecvCelNo()));}
				if(!StringUtil.isEmpty(item.getRecvZipcode()))	{item.setRecvZipcode(cisCryptoUtil.decrypt(item.getRecvZipcode()));}
				if(!StringUtil.isEmpty(item.getRecvAddr()))		{item.setRecvAddr(cisCryptoUtil.decrypt(item.getRecvAddr()));}
				if(!StringUtil.isEmpty(item.getRecvAddrDtl()))	{item.setRecvAddrDtl(cisCryptoUtil.decrypt(item.getRecvAddrDtl()));}
				if(!StringUtil.isEmpty(item.getGateNo()))		{item.setGateNo(cisCryptoUtil.decrypt(item.getGateNo()));}
				
				//주문상세순번, 주문구성순번 분리 SET
				item.setShopOrdrDtlSeq( Integer.parseInt(StringUtil.split(item.getShopSortNo(), "_")[0]) );
				item.setShopOrdrCstrtSeq( Integer.parseInt(StringUtil.split(item.getShopSortNo(), "_")[1]) );
			}
		}
		
		return res;
	}
	
	/**
	 * 주문취소
	 */
	@Override
	public OrderCancelVO cancelOrder(OrderCancelPO param) throws Exception{
		OrderCancelVO res = new OrderCancelVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) {	param = new OrderCancelPO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationCancelOrder(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_CANCEL_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}
		
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_CANCEL_ORDR_INFO, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
				
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), OrderCancelVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_CANCEL_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
                null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;
	}
	
	/**
	 * 반품등록
	 */
	@Override
	public ReturnInsertVO insertReturn(ReturnInsertPO param) throws Exception{
		ReturnInsertVO res = new ReturnInsertVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) { param = new ReturnInsertPO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationInsertReturn(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_RETURN_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			
			return res;
		}

		//암호화
		if(!StringUtil.isEmpty(param.getRqstNm       ()))		{param.setRqstNm        (cisCryptoUtil.encrypt(param.getRqstNm      ()));}
		if(!StringUtil.isEmpty(param.getRqstTelNo	 ()))		{param.setRqstTelNo  	(cisCryptoUtil.encrypt(param.getRqstTelNo   ()));}
		if(!StringUtil.isEmpty(param.getRqstCelNo	 ()))		{param.setRqstCelNo  	(cisCryptoUtil.encrypt(param.getRqstCelNo   ()));}
		if(!StringUtil.isEmpty(param.getRqstZipcode	 ()))		{param.setRqstZipcode	(cisCryptoUtil.encrypt(param.getRqstZipcode ()));}
		if(!StringUtil.isEmpty(param.getRqstAddr	 ()))		{param.setRqstAddr   	(cisCryptoUtil.encrypt(param.getRqstAddr    ()));}
		if(!StringUtil.isEmpty(param.getRqstAddrDtl	 ()))		{param.setRqstAddrDtl	(cisCryptoUtil.encrypt(param.getRqstAddrDtl ()));}

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_RETURN_ORDR_INFO, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}

		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), ReturnInsertVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_RETURN_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				                          null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;
	}
	
	/**
	 * 반품조회
	 */
	@Override
	public ReturnInquiryVO listReturn(ReturnInquirySO param) throws Exception{
		ReturnInquiryVO res = new ReturnInquiryVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) {	param = new ReturnInquirySO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationInquiryReturn(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_RTNS_LIST, 
											  objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}
		
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_RTNS_LIST, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), ReturnInquiryVO.class);
		}

		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_RTNS_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				                          null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		//복호화
		List<ReturnInquiryItemVO> items = res.getItemList();
		if(!StringUtil.isEmpty(items)) {
			for(ReturnInquiryItemVO item : items) {
				if(!StringUtil.isEmpty(item.getRqstNm	  ()))		{item.setRqstNm	      (cisCryptoUtil.decrypt(item.getRqstNm	     ()));}
				if(!StringUtil.isEmpty(item.getRqstTelNo  ()))		{item.setRqstTelNo    (cisCryptoUtil.decrypt(item.getRqstTelNo   ()));}
				if(!StringUtil.isEmpty(item.getRqstCelNo  ()))		{item.setRqstCelNo    (cisCryptoUtil.decrypt(item.getRqstCelNo   ()));}
				if(!StringUtil.isEmpty(item.getRqstZipcode()))		{item.setRqstZipcode  (cisCryptoUtil.decrypt(item.getRqstZipcode ()));}
				if(!StringUtil.isEmpty(item.getRqstAddr	  ()))		{item.setRqstAddr	  (cisCryptoUtil.decrypt(item.getRqstAddr	 ()));}
				if(!StringUtil.isEmpty(item.getRqstAddrDtl()))		{item.setRqstAddrDtl  (cisCryptoUtil.decrypt(item.getRqstAddrDtl ()));}
			}
		}
		
		return res;
	}
	
	/**
	 * 반품취소
	 */
	@Override
	public OrderResponse<Void> cancelReturn(ReturnCancelPO param) throws Exception{
		OrderResponse<Void> res = new OrderResponse<Void>();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) {	param = new ReturnCancelPO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationCancelReturn(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_CANCEL_RTNS_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}
		
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_CANCEL_RTNS_INFO, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
				
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), OrderResponse.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_CANCEL_RTNS_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				                          null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;
	}
	
	/**
	 * 슬롯조회
	 */
	@Override
	public SlotInquiryVO listSlot(SlotInquirySO param) throws Exception{
		SlotInquiryVO res = new SlotInquiryVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) {	param = new SlotInquirySO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationInquirySlot(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_SLOT_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}
		
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_SLOT_LIST, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), SlotInquiryVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_SLOT_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				                          null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
				
		return res;
	}
	
	/**
	 * 권역조회
	 */
	@Override
	public RngeInquiryVO listRnge(RngeInquirySO param) throws Exception{
		RngeInquiryVO res = new RngeInquiryVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) {	param = new RngeInquirySO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationInquiryRnge(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_RNGE_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}
		
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_RNGE_LIST, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), RngeInquiryVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_S_SELECT_RNGE_LIST, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;
	}	

	
	/**
	 * 주문수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderUpdateVO updateOrder(OrderUpdatePO param) throws Exception{
		OrderUpdateVO res = new OrderUpdateVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) { param = new OrderUpdatePO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();

		//Validation check
		checkValidationUpdateOrder(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) { 
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_UPDATE_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}

		//암호화
		if(!StringUtil.isEmpty(param.getRecvNm()))		{param.setRecvNm(cisCryptoUtil.encrypt(param.getRecvNm()));}
		if(!StringUtil.isEmpty(param.getRecvTelNo()))	{param.setRecvTelNo(cisCryptoUtil.encrypt(param.getRecvTelNo()));}
		if(!StringUtil.isEmpty(param.getRecvCelNo()))	{param.setRecvCelNo(cisCryptoUtil.encrypt(param.getRecvCelNo()));}
		if(!StringUtil.isEmpty(param.getRecvZipcode()))	{param.setRecvZipcode(cisCryptoUtil.encrypt(param.getRecvZipcode()));}
		if(!StringUtil.isEmpty(param.getRecvAddr()))	{param.setRecvAddr(cisCryptoUtil.encrypt(param.getRecvAddr()));}
		if(!StringUtil.isEmpty(param.getRecvAddrDtl()))	{param.setRecvAddrDtl(cisCryptoUtil.encrypt(param.getRecvAddrDtl()));}
		if(!StringUtil.isEmpty(param.getGateNo()))		{param.setGateNo(cisCryptoUtil.encrypt(param.getGateNo()));}

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_UPDATE_ORDR_INFO, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), OrderUpdateVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_UPDATE_ORDR_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
                null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;		
	}
	
	/**
	 * 반품수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ReturnUpdateVO updateReturn(ReturnUpdatePO param) throws Exception{
		ReturnUpdateVO res = new ReturnUpdateVO();
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) { param = new ReturnUpdatePO(); }
		String sysReqStartDtm = DateUtil.getNowDateTime();
		
		//Validation check
		checkValidationUpdateReturn(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) {
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_UPDATE_RTNS_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			
			return res;
		}

		//암호화
		if(!StringUtil.isEmpty(param.getRqstNm       ()))		{param.setRqstNm        (cisCryptoUtil.encrypt(param.getRqstNm      ()));}
		if(!StringUtil.isEmpty(param.getRqstTelNo	 ()))		{param.setRqstTelNo  	(cisCryptoUtil.encrypt(param.getRqstTelNo   ()));}
		if(!StringUtil.isEmpty(param.getRqstCelNo	 ()))		{param.setRqstCelNo  	(cisCryptoUtil.encrypt(param.getRqstCelNo   ()));}
		if(!StringUtil.isEmpty(param.getRqstZipcode	 ()))		{param.setRqstZipcode	(cisCryptoUtil.encrypt(param.getRqstZipcode ()));}
		if(!StringUtil.isEmpty(param.getRqstAddr	 ()))		{param.setRqstAddr   	(cisCryptoUtil.encrypt(param.getRqstAddr    ()));}
		if(!StringUtil.isEmpty(param.getRqstAddrDtl	 ()))		{param.setRqstAddrDtl	(cisCryptoUtil.encrypt(param.getRqstAddrDtl ()));}

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_UPDATE_RTNS_INFO, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}

		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), ReturnUpdateVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_UPDATE_RTNS_INFO, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
				                          null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;		
	}
	
	/**
	 * 출고 차수 생성 여부 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public OrderExptCreateVO getExptCreate(OrderExptCreateSO param) throws Exception {
		OrderExptCreateVO res = new OrderExptCreateVO();
		
		ObjectMapper objectMapper = new ObjectMapper();
		if(param == null) { param = new OrderExptCreateSO(); }

		String sysReqStartDtm = DateUtil.getNowDateTime();
		//Validation check
		checkValidationExptCreate(res, param);
		if(StringUtil.nvl(res.getResCd(),"").equals(CommonConstants.CIS_API_EXCEPT)) { 
			//API call log write
			cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_CHECK_SHP_SEQ, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
					                          null, res.getResCd(), res.getResMsg(), "", sysReqStartDtm);
			return res;
		}

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_CHECK_SHP_SEQ, param);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}
		
		//Response set
		if(ar != null) {
			res = objectMapper.readValue(ar.getResponseBody(), OrderExptCreateVO.class);
		}
		
		//API call log write
		cisIfLogService.insertCisIfLogOne(CommonConstants.CIS_API_ID_IF_R_CHECK_SHP_SEQ, objectMapper.writeValueAsString(param), objectMapper.writeValueAsString(res), 
                null, res.getResCd(), res.getResMsg(), httpStatusCd, sysReqStartDtm);
		
		return res;
	}	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 주문등록 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationInsertOrder(OrderInsertVO res, OrderInsertPO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getOrdrNm()))		{args[0]="ordrNm";		isError=true;}
		if(StringUtil.isEmpty(param.getRecvNm()))		{args[0]="recvNm";		isError=true;}
		if(StringUtil.isEmpty(param.getRecvCelNo()))	{args[0]="recvCelNo";	isError=true;}
		if(StringUtil.isEmpty(param.getRecvZipcode()))	{args[0]="recvZipcode";	isError=true;}
		if(StringUtil.isEmpty(param.getRecvAddr()))		{args[0]="recvAddr";	isError=true;}
		if(StringUtil.isEmpty(param.getOrdrDd()))		{args[0]="ordrDd";		isError=true;}

		List<OrderInsertItemPO> items = param.getItemList();
		if(StringUtil.isEmpty(items)) {
			args[0]="itemList";
			isError=true;
		}else{
			for(OrderInsertItemPO item : items) {
				if(StringUtil.isEmpty(item.getSkuCd()))		{args[0]="skuCd";     	isError=true;}
				if(StringUtil.isEmpty(item.getSkuNm()))		{args[0]="skuNm";     	isError=true;}
				if(StringUtil.isEmpty(item.getUnitNm()))	{args[0]="unitNm";    	isError=true;}
				if(StringUtil.isEmpty(item.getCstrtGbCd()))	{args[0]="cstrtGbCd";   isError=true;}
				if(StringUtil.isEmpty(item.getOwnrCd()))	{args[0]="ownrCd";    	isError=true;}
				if(StringUtil.isEmpty(item.getWareCd()))	{args[0]="wareCd";    	isError=true;}
				if(StringUtil.isEmpty(item.getDrelTpCd()))	{args[0]="drelTpCd";  	isError=true;}
				if(StringUtil.isEmpty(item.getDlvtTpCd()))	{args[0]="dlvtTpCd";  	isError=true;}
				if(StringUtil.isEmpty(item.getArrvCd()))	{args[0]="arrvCd";    	isError=true;}
				if(StringUtil.isEmpty(item.getShopOrdrNo())){args[0]="shopOrdrNo";	isError=true;}
				if(StringUtil.isEmpty(item.getShopSortNo()))	{args[0]="shopSortNo";	isError=true;}
				if(isError) break;
			}
		}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_INSERT_ORDR_INFO);
		}
	}
	
	/**
	 * 주문조회 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationInquiryOrder(OrderInquiryVO res, OrderInquirySO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getShopOrdrNo()) && StringUtil.isEmpty(param.getClltOrdrNo()) && StringUtil.isEmpty(param.getRtlrOrdrNo())) {
			if(StringUtil.isEmpty(param.getSrcStaDd())) {args[0]="srcStaDd";		isError=true;}
			if(StringUtil.isEmpty(param.getSrcEndDd())) {args[0]="srcEndDd";		isError=true;}
		}
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_S_SELECT_ORDR_LIST);
		}
	}
	
	/**
	 * 주문취소 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationCancelOrder(OrderCancelVO res, OrderCancelPO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getShopOrdrNo()))	{args[0]="shopOrdrNo";		isError=true;}
		if(StringUtil.isEmpty(param.getShopSortNo()))	{args[0]="shopSortNo";		isError=true;}

		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_CANCEL_ORDR_INFO);
		}
	}

	/**
	 * 반품등록 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationInsertReturn(ReturnInsertVO res, ReturnInsertPO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getRtnTpCd		()))	{args[0]="rtnTpCd";			isError=true;}
		if(StringUtil.isEmpty(param.getRtnDueDd		()))	{args[0]="rtnDueDd";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstNm		()))	{args[0]="rqstNm";			isError=true;}
		if(StringUtil.isEmpty(param.getRqstCelNo	()))	{args[0]="rqstCelNo";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstZipcode	()))	{args[0]="rqstZipcode";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstAddr		()))	{args[0]="rqstAddr";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstAddrDtl	()))	{args[0]="rqstAddrDtl";		isError=true;}

		List<ReturnInsertItemPO> items = param.getItemList();
		if(StringUtil.isEmpty(items)) {
			args[0]="itemList";
			isError=true;
		}else{
			for(ReturnInsertItemPO item : items) {
				if(StringUtil.isEmpty(item.getShopOrdrNo())){args[0]="shopOrdrNo";     	isError=true;}
				if(StringUtil.isEmpty(item.getShopSortNo())){args[0]="shopSortNo";     	isError=true;}
				if(StringUtil.isEmpty(item.getDlvCmpyCd	())){args[0]="dlvCmpyCd";     	isError=true;}
				if(isError) break;
			}
		}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_RETURN_ORDR_INFO);
		}
	}
	
	/**
	 * 반품조회 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationInquiryReturn(ReturnInquiryVO res, ReturnInquirySO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getShopOrdrNo()) && StringUtil.isEmpty(param.getClltOrdrNo())) {
			if(StringUtil.isEmpty(param.getSrcStaDd())) {args[0]="srcStaDd";		isError=true;}
			if(StringUtil.isEmpty(param.getSrcEndDd())) {args[0]="srcEndDd";		isError=true;}
		}
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_S_SELECT_RTNS_LIST);
		}
	}

	/**
	 * 반품취소 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationCancelReturn(OrderResponse<Void> res, ReturnCancelPO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getRtnsNo()))	{args[0]="rtnsNo";		isError=true;}
		if(StringUtil.isEmpty(param.getItemNo()))	{args[0]="itemNo";		isError=true;}
		if(StringUtil.isEmpty(param.getStatCd()))	{args[0]="statCd";		isError=true;}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_CANCEL_RTNS_INFO);
		}
	}
	
	/**
	 * 슬롯조회 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationInquirySlot(SlotInquiryVO res, SlotInquirySO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getDlvtTpCd()))	{args[0]="dlvtTpCd";	isError=true;}
		if(StringUtil.isEmpty(param.getYmd()))		{args[0]="ymd";			isError=true;}

		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_S_SELECT_SLOT_LIST);
		}
	}
	
	/**
	 * 권역조회 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationInquiryRnge(RngeInquiryVO res, RngeInquirySO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getDlvtTpCd()))	{args[0]="dlvtTpCd";	isError=true;}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_S_SELECT_RNGE_LIST);
		}
	}
	
	/**
	 * 주문수정 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationUpdateOrder(OrderUpdateVO res, OrderUpdatePO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getShopOrdrNo()))	{args[0]="shopOrdrNo";	isError=true;}
		if(StringUtil.isEmpty(param.getRecvNm()))		{args[0]="recvNm";		isError=true;}
		if(StringUtil.isEmpty(param.getRecvCelNo()))	{args[0]="recvCelNo";	isError=true;}
		if(StringUtil.isEmpty(param.getRecvZipcode()))	{args[0]="recvZipcode";	isError=true;}
		if(StringUtil.isEmpty(param.getRecvAddr()))		{args[0]="recvAddr";	isError=true;}

		List<OrderUpdateItemPO> items = param.getItemList();
		if(StringUtil.isEmpty(items)) {
			args[0]="itemList";
			isError=true;
		}else{
			for(OrderUpdateItemPO item : items) {
				if(StringUtil.isEmpty(item.getShopOrdrNo()))	{args[0]="shopOrdrNo";     	isError=true;}
				if(StringUtil.isEmpty(item.getShopSortNo()))	{args[0]="shopSortNo";     	isError=true;}
				if(StringUtil.isEmpty(item.getDlvtTpCd()))		{args[0]="dlvtTpCd";    	isError=true;}
				if(isError) break;
			}
		}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_UPDATE_ORDR_INFO);
		}
	}
	
	/**
	 * 반품수정 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationUpdateReturn(OrderResponse<Void> res, ReturnUpdatePO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getRtnsNo		()))	{args[0]="rtnsNo";			isError=true;}
		if(StringUtil.isEmpty(param.getRqstNm		()))	{args[0]="rqstNm";			isError=true;}
		if(StringUtil.isEmpty(param.getRqstCelNo	()))	{args[0]="rqstCelNo";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstZipcode	()))	{args[0]="rqstZipcode";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstAddr		()))	{args[0]="rqstAddr";		isError=true;}
		if(StringUtil.isEmpty(param.getRqstAddrDtl	()))	{args[0]="rqstAddrDtl";		isError=true;}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_UPDATE_RTNS_INFO);
		}
	}
	
	/**
	 * 출고차수생성여부 validation check
	 * @param res
	 * @param param
	 */
	public void checkValidationExptCreate(OrderExptCreateVO res, OrderExptCreateSO param) {
		boolean isError = false;
		String[] args = new String[1];
		
		if(StringUtil.isEmpty(param.getShopOrdrNo()))	{args[0]="shopOrdrNo";		isError=true;}
		if(StringUtil.isEmpty(param.getShopSortNo()))	{args[0]="shopSortNo";		isError=true;}
		
		if(isError) {
			res.setResCd(CommonConstants.CIS_API_EXCEPT);
			res.setResMsg(message.getMessage("business.cis.check.msg.001", args ));	
			res.setCallId(CommonConstants.CIS_API_ID_IF_R_CHECK_SHP_SEQ);
		}
	}
}
