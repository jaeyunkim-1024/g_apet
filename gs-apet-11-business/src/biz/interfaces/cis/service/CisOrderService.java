package biz.interfaces.cis.service;

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
import framework.cis.model.response.shop.OrderResponse;

public interface CisOrderService {

	/**
	 * 주문등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderInsertVO insertOrder(OrderInsertPO param) throws Exception;
	
	/**
	 * 주문조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderInquiryVO listOrder(OrderInquirySO param) throws Exception;
	
	/**
	 * 주문취소
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderCancelVO cancelOrder(OrderCancelPO param) throws Exception;
	
	/**
	 * 반품등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ReturnInsertVO insertReturn(ReturnInsertPO param) throws Exception;
	
	/**
	 * 반품조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ReturnInquiryVO listReturn(ReturnInquirySO param) throws Exception;

	/**
	 * 반품취소
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderResponse<Void> cancelReturn(ReturnCancelPO param) throws Exception;
	
	/**
	 * 슬롯조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public SlotInquiryVO listSlot(SlotInquirySO param) throws Exception;
	
	/**
	 * 권역조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public RngeInquiryVO listRnge(RngeInquirySO param) throws Exception;
	
	/**
	 * 주문수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderUpdateVO updateOrder(OrderUpdatePO param) throws Exception;
	
	/**
	 * 반품수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ReturnUpdateVO updateReturn(ReturnUpdatePO param) throws Exception;
	
	/**
	 * 출고차수생성여부 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public OrderExptCreateVO getExptCreate(OrderExptCreateSO param) throws Exception;
	
}
