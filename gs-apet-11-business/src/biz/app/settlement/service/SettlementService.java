package biz.app.settlement.service;

import java.util.List;

import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderListSO;
import biz.app.settlement.model.GsPntHistSO;
import biz.app.settlement.model.GsPntHistVO;
import biz.app.settlement.model.SettlementListExcelVO;
import biz.app.settlement.model.SettlementListSO;
import biz.app.settlement.model.SettlementListVO;
import biz.app.settlement.model.SettlementPO;
import biz.app.settlement.model.SettlementSO;
import biz.app.settlement.model.SettlementVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app
* - 파일명		: SettlementService.java
* - 작성일		: 2017. 6. 20.
* - 작성자		: schoi
* - 설명			:
* </pre>
*/
public interface SettlementService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlement (SettlementSO settlementSO );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementDtl (SettlementSO settlementSO );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementPO
	* @return
	*/	
	public void updateSettlementListStlStat(SettlementPO settlementPO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementComplete (SettlementSO settlementSO );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementCompleteDtl (SettlementSO settlementSO );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 7. 18.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> listSettlementCompleteTaxInvoice (SettlementSO settlementSO );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementPO
	* @return
	*/	
	public void updateSettlementCompletePvdStat(SettlementPO settlementPO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 7. 7.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementInfo (SettlementSO settlementSO );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2021. 4. 6.
	* - 작성자		: KKB
	* - 설명		: GS&포인트 내역
	* </pre>
	* @param GsPntHistSO
	* @return List<GsPntHistVO> 
	*/
	public List<GsPntHistVO> pageGsPntHist (GsPntHistSO so );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2021. 4. 7.
	* - 작성자		: KKB
	* - 설명		: GS&포인트 총금액 조회
	* </pre>
	* @param GsPntHistSO
	* @return GsPntHistVO
	*/
	public GsPntHistVO getGsPntHistTotal (GsPntHistSO so );

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: snw
	* - 설명			: 정산 목록 페이징 조회
	 * </pre>
	 * 
	 * @param SettlementListSO
	 * @return
	 */
	public List<SettlementListVO> pageOrderOrgStlm(SettlementListSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementService.java
	* - 작성일		: 2020. 12. 18.
	* - 작성자		: valueFactory
	* - 설명			: 정산 상태 일괄 수정
	* </pre>
	* @param orderDetailPoList
	* @return
	*/
	public int batchUpdateStat(List<OrderDetailPO> orderDetailPoList);

	/*
	 * 주문 목록 정산 페이징 조회 - Excel
	 *
	 * @see
	 */
	public List<SettlementListExcelVO> settlementAdjustExcel(SettlementListSO so);
}
