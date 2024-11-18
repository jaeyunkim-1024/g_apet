package biz.app.market.service;

import java.util.List;

import biz.app.market.model.MarketOrderConfirmPO;
import biz.app.market.model.MarketOrderListSO;
import biz.app.market.model.MarketOrderListVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.market.service
 * - 파일명		: MarketOrderService.java
 * - 작성일		: 2017. 9. 21.
 * - 작성자		: kimdp
 * - 설명			: 오픈마켓 주문 서비스
 * </pre>
 */

public interface MarketOrderService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명		: biz.app.market.service
	 * - 파일명		: MarketOrderService.java
	 * - 작성일		: 2017. 9. 21.
	 * - 작성자		: kimdp
	 * - 설명			: 오픈마켓 주문 서비스
	 * </pre>
	* @param orderSO
	* @return
	*/
	public List<MarketOrderListVO> pageMarketOrderOrg( MarketOrderListSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderServiceImpl.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public void insertMarketOrderConfirm(MarketOrderConfirmPO marketOrderConfirmPO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderServiceImpl.java
	* - 작성일	: 2017. 10. 23.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 수집
	* </pre>
	* @param String startDtm, String endDtm
	* @return
	*/
	public void marketGetOrder(String startDtm, String endDtm);

}
