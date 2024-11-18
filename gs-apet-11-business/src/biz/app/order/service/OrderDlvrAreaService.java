package biz.app.order.service;

import java.util.List;

import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: OrderDlvrAreaService.java
 * - 작성일		: 2021. 03. 01.
 * - 작성자		: JinHong
 * - 설명		: 주문 배송 권역 서비스
 * </pre>
 */
public interface OrderDlvrAreaService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 01.
	 * - 작성자		: JinHong
	 * - 설명		: 배송권역 정보 조회
	 * </pre>
	 * @param postNo
	 * @return
	 */
	public List<OrderDlvrAreaVO> getDlvrPrcsListFromTime(String postNo);

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 07.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 정보 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDlvrAreaVO> listDlvrAreaInfo(OrderDlvrAreaSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 04. 08.
	 * - 작성자		: JinHong
	 * - 설명		: 주문서 배송 valid
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderDlvrAreaVO validOrderDlvr(OrderDlvrAreaSO so);
	
	/**
	 * 
	 * <pre>
	 * - Method 명	: getDlvrPrcsListForGoodsDetail
	 * - 작성일		: 2021. 4. 21.
	 * - 작성자		: SungHyun
	 * - 설 명			: 
	 * </pre>
	 *
	 * @return
	 */
	public List<OrderDlvrAreaVO> getDlvrPrcsListForGoodsDetail();
}
