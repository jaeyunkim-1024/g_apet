package admin.web.view.sample.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.interfaces.cis.model.request.order.OrderCancelPO;
import biz.interfaces.cis.model.request.order.OrderExptCreateSO;
import biz.interfaces.cis.model.request.order.OrderInquirySO;
import biz.interfaces.cis.model.request.order.OrderInsertPO;
import biz.interfaces.cis.model.request.order.OrderUpdatePO;
import biz.interfaces.cis.model.request.order.ReturnCancelPO;
import biz.interfaces.cis.model.request.order.ReturnInquirySO;
import biz.interfaces.cis.model.request.order.ReturnInsertPO;
import biz.interfaces.cis.model.request.order.ReturnUpdatePO;
import biz.interfaces.cis.model.request.order.RngeInquirySO;
import biz.interfaces.cis.model.request.order.SlotInquirySO;
import biz.interfaces.cis.model.response.order.OrderCancelVO;
import biz.interfaces.cis.model.response.order.OrderExptCreateVO;
import biz.interfaces.cis.model.response.order.OrderInquiryVO;
import biz.interfaces.cis.model.response.order.OrderInsertVO;
import biz.interfaces.cis.model.response.order.OrderUpdateVO;
import biz.interfaces.cis.model.response.order.ReturnInquiryVO;
import biz.interfaces.cis.model.response.order.ReturnInsertVO;
import biz.interfaces.cis.model.response.order.ReturnUpdateVO;
import biz.interfaces.cis.model.response.order.RngeInquiryVO;
import biz.interfaces.cis.model.response.order.SlotInquiryVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.cis.model.response.shop.OrderResponse;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class SampleCisApiCallController {

	@Autowired
	private CisOrderService cisOrderService;
	
	
	/**
	 * 주문등록 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopOrderInsert.do", method = RequestMethod.POST)
	public @ResponseBody OrderInsertVO shopOrderInsert(@RequestBody OrderInsertPO param) throws Exception{
		if(param == null) {param = new OrderInsertPO();}
		OrderInsertVO res = cisOrderService.insertOrder(param);
		return res;
	}
	
	/**
	 * 주문조회 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopOrderInquiry.do", method = RequestMethod.POST)
	public @ResponseBody OrderInquiryVO shopOrderInquiry(OrderInquirySO param) throws Exception{
		if(param == null) {param = new OrderInquirySO();}
		OrderInquiryVO res = cisOrderService.listOrder(param);
		return res;
	}

	/**
	 * 주문취소 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopOrderCancel.do", method = RequestMethod.POST)
	public @ResponseBody OrderCancelVO shopOrderCancel(OrderCancelPO param) throws Exception{
		if(param == null) {param = new OrderCancelPO();}
		OrderCancelVO res = cisOrderService.cancelOrder(param);
		return res;
	}
	
	/**
	 * 반품등록 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopReturnInsert.do", method = RequestMethod.POST)
	public @ResponseBody ReturnInsertVO shopReturnInsert(@RequestBody ReturnInsertPO param) throws Exception{
		if(param == null) {param = new ReturnInsertPO();}
		ReturnInsertVO res = cisOrderService.insertReturn(param);
		return res;
	}
	
	/**
	 * 반품조회 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopReturnInquiry.do", method = RequestMethod.POST)
	public @ResponseBody ReturnInquiryVO shopReturnInquiry(ReturnInquirySO param) throws Exception{
		if(param == null) {param = new ReturnInquirySO();}
		ReturnInquiryVO res = cisOrderService.listReturn(param);
		return res;
	}

	/**
	 * 반품취소 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopReturnCancel.do", method = RequestMethod.POST)
	public @ResponseBody OrderResponse<Void> shopReturnCancel(ReturnCancelPO param) throws Exception{
		if(param == null) {param = new ReturnCancelPO();}
		OrderResponse<Void> res = cisOrderService.cancelReturn(param);
		return res;
	}
	
	/**
	 * 슬롯조회 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopSlotInquiry.do", method = RequestMethod.POST)
	public @ResponseBody SlotInquiryVO shopSlotInquiry(SlotInquirySO param) throws Exception{
		if(param == null) {param = new SlotInquirySO();}
		SlotInquiryVO res = cisOrderService.listSlot(param);
		return res;
	}
	
	/**
	 * 권역조회 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopRngeInquiry.do", method = RequestMethod.POST)
	public @ResponseBody RngeInquiryVO shopRngeInquiry(RngeInquirySO param) throws Exception{
		if(param == null) {param = new RngeInquirySO();}
		RngeInquiryVO res = cisOrderService.listRnge(param);
		return res;
	}
	
	/**
	 * 주문수정 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopOrderUpdate.do", method = RequestMethod.POST)
	public @ResponseBody OrderUpdateVO shopOrderUpdate(@RequestBody OrderUpdatePO param) throws Exception{
		if(param == null) {param = new OrderUpdatePO();}
		OrderUpdateVO res = cisOrderService.updateOrder(param);
		return res;
	}
	
	/**
	 * 반품수정 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopReturnUpdate.do", method = RequestMethod.POST)
	public @ResponseBody ReturnUpdateVO shopReturnUpdate(@RequestBody ReturnUpdatePO param) throws Exception{
		if(param == null) {param = new ReturnUpdatePO();}
		ReturnUpdateVO res = cisOrderService.updateReturn(param);
		return res;
	}
	
	/**
	 * 차수생성 API 호출
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/samplecisapi/shopDlvrSearch.do", method = RequestMethod.POST)
	public @ResponseBody OrderExptCreateVO shopDlvrSearch(@RequestBody OrderExptCreateSO param) throws Exception{
		if(param == null) {param = new OrderExptCreateSO();}
		OrderExptCreateVO res = cisOrderService.getExptCreate(param);
		return res;
	}
		
}