package biz.app.order.service;

import biz.app.order.dao.OrderBaseDao;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.service
 * - 파일명		: OrderBaseServiceImpl.java
 * - 작성일		: 2017. 1. 9.
 * - 작성자		: snw
 * - 설명		: 주문기본 서비스 Impl
 * </pre>
 */
@Slf4j
@Service("orderBaseService")
@Transactional
public class OrderBaseServiceImpl implements OrderBaseService {

	@Autowired private OrderBaseDao orderBaseDao;

	/*
	 * 주문 처리 결과 수정
	 * 
	 * @see
	 * biz.app.order.service.OrderBaseService#updateOrderBaseProcessResult(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public void updateOrderBaseProcessResult(String ordNo, String ordPrcsRstCd, String ordPrcsRstMsg, String dataStatCd) {

		try {
			OrderBasePO obpo = new OrderBasePO();
			obpo.setOrdNo(ordNo);
			obpo.setOrdPrcsRstCd(ordPrcsRstCd);
			obpo.setOrdPrcsRstMsg(ordPrcsRstMsg);
			if (dataStatCd != null) {
				obpo.setDataStatCd(dataStatCd);
			}

			this.orderBaseDao.updateOrderBase(obpo);
		} catch (Exception e) {
			log.error("[주문 처리 결과 저장 오류] 주문번호 : " + ordNo);
		}

	}

	/*
	 * 주문 기본 조회
	 * 
	 * @see biz.app.order.service.OrderBaseService#getOrderBase(java.lang.String)
	 */
	@Override
	@Transactional(readOnly = true)
	public OrderBaseVO getOrderBase(String ordNo) {
		OrderBaseSO so = new OrderBaseSO();
		so.setOrdNo(ordNo);
		OrderBaseVO vo = orderBaseDao.getOrderBase(so);
		vo.setExecSql(so.getExecSql());
		return vo;
	}

	/*
	 * 주문 기본 조회
	 * 
	 * @see biz.app.order.service.OrderBaseService#getOrderBase(biz.app.order.model.OrderBaseSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public OrderBaseVO getOrderBase(OrderBaseSO orderBaseSO) {
		return orderBaseDao.getOrderBase(orderBaseSO);
	}

	/*
	 * 주문 기본 수정
	 * 
	 * @see
	 * biz.app.order.service.OrderBaseService#updateOrderBase(biz.app.order.model.OrderBasePO)
	 */
	@Override
	public void updateOrderBase(OrderBasePO orderBasePO) {

		// 주문 기본 변경
		int result = orderBaseDao.updateOrderBase(orderBasePO);
		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/*
	 *
	 * 
	 * @see
	 * biz.app.order.service.OrderBaseService#updateOrderBase(biz.app.order.model.OrderBasePO)
	 */
	@Override
	public void updateOrderBaseStatus(OrderBasePO orderBasePO) {

		// 주문 기본 변경
		int result = orderBaseDao.updateOrderBaseStatus(orderBasePO);
		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

}
