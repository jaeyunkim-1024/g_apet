package biz.app.order.service.interfaces;

import java.util.List;

import biz.app.delivery.model.DeliveryVO;
import biz.app.order.model.interfaces.CisOrderReturnCmdVO;
import biz.app.order.model.interfaces.CisOrderReturnStateChgVO;
import biz.interfaces.cis.model.request.order.ReturnInsertItemPO;
import biz.interfaces.cis.model.response.order.ReturnInquiryItemVO;
import biz.interfaces.cis.model.response.order.ReturnInsertItemVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service.interfaces
* - 파일명		: CisOrderReturnService.java
* - 작성일		: 2021. 3. 10.
* - 작성자		: kek01
* - 설명			: CIS 회수 서비스
* </pre>
*/
public interface CisOrderReturnService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CisOrderReturnService.java
	* - 작성일		: 2021. 2. 2.
	* - 작성자		: kek01
	* - 설명			: CIS 회수지시 대상 조회
	* </pre>
	* @return
	*/
	public List<CisOrderReturnCmdVO> listCisReturnCmd();
		
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CisOrderReturnService.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: kek01
	 * - 설명		: CIS 회수지시 후처리
	 * </pre>
	 * @return
	 */
	public int updateCisReturnCmdAfter(List<ReturnInsertItemVO> resItems, String dlvrPrcsTpCd, Long ordDlvraNo, String exchgRtnYn, List<ReturnInsertItemPO> paramItems);
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CisOrderDeliveryService.java
	* - 작성일		: 2021. 2. 17.
	* - 작성자		: kek01
	* - 설명			: CIS 회수 상태 변경 대상 주문 조회
	* </pre>
	* @return
	*/
	public List<CisOrderReturnStateChgVO> listCisReturnStateChg();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CisOrderDeliveryService.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: kek01
	 * - 설명		: CIS 회수 상태 변경 후처리
	 * </pre>
	 * @return
	 */
	public int updateCisReturnStateChgAfter(CisOrderReturnStateChgVO vo, List<ReturnInquiryItemVO> cisItems);
	
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
	public List<DeliveryVO> listDelivery(String clmNo, int clmDtlSeq);
	
}
