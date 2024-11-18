package biz.app.order.service;

import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.service
 * - 파일명		: OrderBaseService.java
 * - 작성일		: 2017. 1. 9.
 * - 작성자		: snw
 * - 설명		: 주문 기본 서비스
 * </pre>
 */
public interface OrderBaseService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseService.java
	 * - 작성일		: 2017. 2. 15.
	 * - 작성자		: snw
	 * - 설명		: 주문 처리 결과 수정
	 * </pre>
	 * 
	 * @param ordNo
	 * @param ordPrcsRstCd
	 * @param ordPrcsRstMsg
	 */
	public void updateOrderBaseProcessResult(String ordNo, String ordPrcsRstCd, String ordPrcsRstMsg, String dataStatCd);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseService.java
	 * - 작성일		: 2017. 1. 11.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 조회
	 * </pre>
	 * 
	 * @param ordNo
	 * @return
	 */
	public OrderBaseVO getOrderBase(String ordNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseService.java
	 * - 작성일		: 2017. 1. 11.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 조회
	 * </pre>
	 * 
	 * @param ordNo
	 * @return
	 */
	public OrderBaseVO getOrderBase(OrderBaseSO orderBaseSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseService.java
	 * - 작성일		: 2017. 1. 11.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 수정
	 *					주문 기본 이력 저장 포함
	 * </pre>
	 * 
	 * @param orderBasePO
	 * @return
	 */
	public void updateOrderBase(OrderBasePO orderBasePO);
	

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseService.java
	 * - 작성일		: 2021. 3. 14.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 삭제---수정 ORDR_SHOW_YN = 'N'
	 *			
	 * </pre>
	 * 
	 * @param orderBasePO
	 * @return
	 */
	public void updateOrderBaseStatus(OrderBasePO orderBasePO);

}
