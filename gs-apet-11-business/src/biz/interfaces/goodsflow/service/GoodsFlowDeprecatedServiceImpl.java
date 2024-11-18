package biz.interfaces.goodsflow.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import biz.interfaces.goodsflow.model.TraceResult;
import biz.interfaces.goodsflow.model.request.data.InvoiceVO;
import biz.interfaces.goodsflow.model.response.data.TraceVO;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GoodsFlowDeprecatedServiceImpl extends GoodsFlowServiceImpl {

	@Override
	public List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> checkInvoiceNo(List<InvoiceVO> invoices) {
		// 2017.9.29, 굿스플로우 연동 중단 처리, 항상 true 를 리턴함.

		try {
			List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> result = new ArrayList<>();
			biz.interfaces.goodsflow.model.response.data.InvoiceVO invoice = new biz.interfaces.goodsflow.model.response.data.InvoiceVO();

			invoice.setIsOk(true);
			result.add(invoice);

			return result;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return null;
		}
	}

	@Override
	public boolean sendTraceRequest(Long dlvrNo) {
		// 2017.9.29, 굿스플로우 연동 중단 처리, 항상 true 를 리턴함.
		return true;
	}

	@Override
	public TraceResult receiveTraceResult() {
		// 2017.9.29, 굿스플로우 연동 중단 처리, 항상 true 를 리턴함.

		TraceResult result = new TraceResult();
		List<TraceVO> items = new ArrayList<>();

		try {
			result.setStatus(CommonConstants.GOODS_FLOW_STATUS_NO_DATA);
			result.setItems(items);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			result.setStatus(CommonConstants.GOODS_FLOW_STATUS_UNKOWN);
		}

		return result;
	}
}