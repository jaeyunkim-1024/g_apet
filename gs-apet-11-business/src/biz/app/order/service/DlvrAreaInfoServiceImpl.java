package biz.app.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.order.dao.DlvrAreaInfoDao;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: DlvrAreaInfoServiceImpl.java
 * - 작성일		: 2021. 04. 20.
 * - 작성자		: JinHong
 * - 설명		: 배송 권역 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class DlvrAreaInfoServiceImpl implements DlvrAreaInfoService {

	@Autowired private DlvrAreaInfoDao dlvrAreaInfoDao;
	@Override
	public OrderDlvrAreaVO getDlvrAreaInfo(OrderDlvrAreaSO so) {
		return dlvrAreaInfoDao.getDlvrAreaInfo(so);
	}
}
