package biz.app.order.service.interfaces;

import java.util.List;

import biz.app.delivery.model.DeliveryVO;
import biz.app.order.model.interfaces.CisOrderDeliveryCmdVO;
import biz.app.order.model.interfaces.CisOrderDeliveryStateChgVO;
import biz.interfaces.cis.model.request.order.OrderInsertItemPO;
import biz.interfaces.cis.model.response.order.OrderInquiryItemVO;
import biz.interfaces.cis.model.response.order.OrderInsertItemVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service.interfaces
* - 파일명		: CisOrderDeliveryService.java
* - 작성일		: 2021. 2. 2.
* - 작성자		: kek01
* - 설명			: CIS 배송 서비스
* </pre>
*/
public interface CisOrderDeliveryService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CisOrderDeliveryService.java
	* - 작성일		: 2021. 2. 2.
	* - 작성자		: kek01
	* - 설명			: CIS 배송지시 대상 주문 조회
	* </pre>
	* @return
	*/
	public List<CisOrderDeliveryCmdVO> listCisDeliveryCmd();
		
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CisOrderDeliveryService.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: kek01
	 * - 설명		: CIS 배송지시 후처리
	 * </pre>
	 * @return
	 */
	public int updateCisDeliveryCmdAfter(List<OrderInsertItemVO> resItems, String dlvrPrcsTpCd, Long ordDlvraNo, String clmDlvrYn, List<OrderInsertItemPO> paramItems);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CisOrderDeliveryService.java
	* - 작성일		: 2021. 2. 17.
	* - 작성자		: kek01
	* - 설명			: CIS 배송 상태 변경 대상 주문 조회
	* </pre>
	* @return
	*/
	public List<CisOrderDeliveryStateChgVO> listCisDeliveryStateChg();
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CisOrderDeliveryService.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: kek01
	 * - 설명		: CIS 배송 상태 변경 후처리
	 * </pre>
	 * @return
	 */
	public OrderInquiryItemVO updateCisDeliveryStateChgAfter(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CisOrderDeliveryService.java
	 * - 작성일		: 2021. 2. 18.
	 * - 작성자		: kek01
	 * - 설명		: 배송정보 조회
	 * </pre>
	 * @return
	 */
	public List<DeliveryVO> listDelivery(String ordNo, int ordDtlSeq, String clmNo, int clmDtlSeq);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CisOrderDeliveryService.java
	 * - 작성일		: 2021. 7. 20.
	 * - 작성자		: hjh01
	 * - 설명		: 주문 상품 송장번호 별 알림톡 발송
	 * </pre>
	 * @return
	 */
	public void allInvcNoGoodsSendMessage(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems);
}
