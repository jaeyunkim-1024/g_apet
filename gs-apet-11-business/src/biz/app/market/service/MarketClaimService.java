package biz.app.market.service;

import java.util.List;

import biz.app.market.model.MarketClaimListSO;
import biz.app.market.model.MarketClaimListVO;
import biz.app.market.model.MarketClaimConfirmPO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.market.service
 * - 파일명		: MarketClaimService.java
 * - 작성일		: 2017. 9. 21.
 * - 작성자		: kimdp
 * - 설명			: 오픈마켓 클레임 서비스
 * </pre>
 */

public interface MarketClaimService {
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명		: biz.app.market.service
	 * - 파일명		: MarketClaimService.java
	 * - 작성일		: 2017. 9. 21.
	 * - 작성자		: kimdp
	 * - 설명			: 오픈마켓 클레임 서비스
	 * </pre>
	* @param orderSO
	* @return
	*/
	public List<MarketClaimListVO> pageMarketClaimOrg( MarketClaimListSO so );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimService.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 취소
	* </pre>
	* @param marketClaimConfirmPO
	* @return
	*/
	public void insertMarketClaimCancelConfirm(MarketClaimConfirmPO marketClaimConfirmPO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimService.java
	* - 작성일	: 2017. 10. 23.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소 수집
	* </pre>
	* @param String startDtm, String endDtm
	* @return
	*/
	public void marketGetClaimCancel(String startDtm, String endDtm);
}
