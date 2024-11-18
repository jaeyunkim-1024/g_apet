package biz.godomall.order.service;

import biz.app.order.model.*;
import biz.app.receipt.model.CashReceiptSO;
import biz.godomall.order.dao.OrderGdmDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@Transactional
@Lazy
public class OrderGdmServiceImpl implements OrderGdmService{
    @Autowired
    private OrderGdmDao orderGdmDao;

    @Override
    public OrderStatusVO listOrderCdCountList(OrderSO orderSO) {
        return orderGdmDao.listOrderCdCountList(orderSO);
    }

    @Override
    public List<OrderBaseVO> pageOrderDeliveryList2ndE(OrderSO orderSO) {
        return orderGdmDao.pageOrderDeliveryList2ndE(orderSO);
    }

    @Override
    public OrderBaseVO listOrderDetail2ndE(OrderDetailSO so) {
        return orderGdmDao.listOrderDetail2ndE(so);
    }

    @Override
    public OrderDlvraVO getOrderDlvra(OrderDlvraSO so) {
        return orderGdmDao.getOrderDlvra(so);

    }

    @Override
    public List<OrderPayVO> getOrderPayInfo(String ordNo) {
        return orderGdmDao.getOrderPayInfo(ordNo);
    }

    @Override
    public OrderPayVO getFrontPayInfo(String ordNo) {
        return orderGdmDao.getFrontPayInfo(ordNo);
    }

    @Override
    public Integer getCashReceiptExistsCheck(CashReceiptSO so) {
        return orderGdmDao.getCashReceiptExistsCheck(so);
    }
}
