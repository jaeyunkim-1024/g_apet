package biz.app.order.service;

import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: DlvrAreaInfoService.java
 * - 작성일		: 2021. 04. 20.
 * - 작성자		: JinHong
 * - 설명		: 배송 권역 서비스
 * </pre>
 */
public interface DlvrAreaInfoService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 04. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderDlvrAreaVO getDlvrAreaInfo(OrderDlvrAreaSO so);
}
