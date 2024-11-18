package biz.app.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.order.dao.OrderMemoDao;
import biz.app.order.dao.OrderMemoHistDao;
import biz.app.order.model.OrderMemoHistPO;
import biz.app.order.model.OrderMemoPO;
import biz.app.order.model.OrderMemoSO;
import biz.app.order.model.OrderMemoVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderMemoServiceImpl.java
* - 작성일		: 2017. 1. 11.
* - 작성자		: snw
* - 설명			: 주문 메모 서비스 Impl
* </pre>
*/
@Slf4j
@Service("orderMemoService")
@Transactional
public class OrderMemoServiceImpl implements OrderMemoService {

	@Autowired
	private OrderMemoDao orderMemoDao;

	@Autowired
	private OrderMemoHistDao orderMemoHistDao;

	/*
	 * 주문 메모 목록 조회
	 * @see biz.app.order.service.OrderMemoService#listOrderMemo(biz.app.order.model.OrderMemoSO)
	 */
	@Override
	public List<OrderMemoVO> listOrderMemo(OrderMemoSO so) {
		return this.orderMemoDao.listOrderMemo(so);
	}

	/* 
	 * 주문 메모 등록
	 * @see biz.app.order.service.OrderMemoService#insertOrderMemo(biz.app.order.model.OrderMemoPO)
	 */
	@Override
	public void insertOrderMemo( OrderMemoPO orderMemoPO ) {

		int result = orderMemoDao.insertOrderMemo( orderMemoPO );

		if ( result != 1 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}

	/*
	 * 주문 메모 수정
	 * @see biz.app.order.service.OrderMemoService#updateOrderMemo(biz.app.order.model.OrderMemoPO)
	 */
	@Override
	public void updateOrderMemo(OrderMemoPO po) {

		// 메모 이력 등록
		OrderMemoHistPO omhPO = new OrderMemoHistPO();

		omhPO.setOrdNo(po.getOrdNo());
		omhPO.setMemoSeq(po.getMemoSeq());
		omhPO.setSysRegrNo(po.getSysUpdrNo());
		int result = this.orderMemoHistDao.insertOrderMemoHist(omhPO);

		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}		

		result = this.orderMemoDao.updateOrderMemo( po );
		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}		
		
	}
	
}

