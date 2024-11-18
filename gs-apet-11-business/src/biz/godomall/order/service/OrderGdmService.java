package biz.godomall.order.service;

import biz.app.order.model.*;
import biz.app.receipt.model.CashReceiptSO;

import java.util.List;

public interface OrderGdmService {
    // 주문 정보
    public OrderStatusVO listOrderCdCountList(OrderSO orderSO);

    public List<OrderBaseVO> pageOrderDeliveryList2ndE(OrderSO orderSO );

    public OrderBaseVO listOrderDetail2ndE(OrderDetailSO so);

    //배송지 정보
    public OrderDlvraVO getOrderDlvra(OrderDlvraSO so);

    public List<OrderPayVO> getOrderPayInfo(String ordNo);

    public OrderPayVO getFrontPayInfo(String ordNo);

    public Integer getCashReceiptExistsCheck(CashReceiptSO so);

}
