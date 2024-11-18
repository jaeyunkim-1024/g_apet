package biz.godomall.order.dao;

import biz.app.order.model.*;
import biz.app.receipt.model.CashReceiptSO;
import framework.common.dao.GodoMallAbstractDao;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Lazy
public class OrderGdmDao extends GodoMallAbstractDao {
    private static final String BASE_DAO_PACKAGE = "order.";

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: OrderDao.java
     * - 작성일		: 2016. 5. 30.
     * - 작성자		: phy
     * - 설명		: 나의 최근 주문현황
     * </pre>
     * @param orderSO
     * @return
     */
    public OrderStatusVO listOrderCdCountList(OrderSO orderSO) {
        return selectOne(BASE_DAO_PACKAGE + "listOrderCdCountList", orderSO);
    }

    /*
        주문 목록
     */
    public List<OrderBaseVO> pageOrderDeliveryList2ndE(OrderSO orderSO ) {
        return this.selectListPage(BASE_DAO_PACKAGE + "pageOrderDeliveryList2ndE", orderSO );
    }

    public OrderBaseVO listOrderDetail2ndE(OrderDetailSO so){
        return selectOne( BASE_DAO_PACKAGE + "listOrderDetail2ndE", so );
    }

    public OrderDlvraVO getOrderDlvra(OrderDlvraSO so){
        return selectOne(BASE_DAO_PACKAGE + "getOrderDlvra", so);
    }

    public List getOrderPayInfo(String ordNo){
        return selectList (BASE_DAO_PACKAGE + "getOrderPayInfo", ordNo);
    }
    public OrderPayVO getFrontPayInfo(String ordNo){
        return selectOne (BASE_DAO_PACKAGE + "getFrontPayInfo", ordNo);
    }

    public int getCashReceiptExistsCheck( CashReceiptSO cashReceiptSO ) {
        return (int) selectOne( BASE_DAO_PACKAGE + "getCashReceiptExistsCheck", cashReceiptSO );
    }
}
