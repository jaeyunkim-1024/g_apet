package biz.app.settlement.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderDetailPO;
import biz.app.settlement.model.GsPntHistSO;
import biz.app.settlement.model.GsPntHistVO;
import biz.app.settlement.model.SettlementListExcelVO;
import biz.app.settlement.model.SettlementListSO;
import biz.app.settlement.model.SettlementListVO;
import biz.app.settlement.model.SettlementPO;
import biz.app.settlement.model.SettlementSO;
import biz.app.settlement.model.SettlementVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app
* - 파일명		: SettlementDao.java
* - 작성일		: 2017. 6. 20.
* - 작성자		: schoi
* - 설명			:
* </pre>
*/
@Repository
public class SettlementDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "settlement.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlement (SettlementSO settlementSO ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageListSettlement", settlementSO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementDtl (SettlementSO settlementSO ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageListSettlementDtl", settlementSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementPO
	* @return
	*/
	public int updateSettlementListStlStat(SettlementPO settlementPO) {
		return update(BASE_DAO_PACKAGE + "updateSettlementListStlStatUpdate", settlementPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementComplete (SettlementSO settlementSO ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageListSettlementComplete", settlementSO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementCompleteDtl (SettlementSO settlementSO ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageListSettlementCompleteDtl", settlementSO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 7. 18.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> listSettlementCompleteTaxInvoice (SettlementSO settlementSO ) {
		return selectList(BASE_DAO_PACKAGE + "listSettlementCompleteTaxInvoice", settlementSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementPO
	* @return
	*/
	public int updateSettlementCompletePvdStat(SettlementPO settlementPO) {
		return update(BASE_DAO_PACKAGE + "updateSettlementCompletePvdStatUpdate", settlementPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 7. 7.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param settlementSO
	* @return
	*/
	public List<SettlementVO> pageListSettlementInfo (SettlementSO settlementSO ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageListSettlementInfo", settlementSO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2021. 4. 6.
	* - 작성자		: KKB
	* - 설명		: GS&포인트 내역
	* </pre>
	* @param GsPntHistSO
	* @return List<GsPntHistVO> 
	*/
	public List<GsPntHistVO> pageGsPntHist (GsPntHistSO so ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageGsPntHist", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2021. 4. 7.
	* - 작성자		: KKB
	* - 설명		: GS&포인트 총금액 조회
	* </pre>
	* @param GsPntHistSO
	* @return GsPntHistVO 
	*/
	public GsPntHistVO getGsPntHistTotal (GsPntHistSO so ) {
		return selectOne(BASE_DAO_PACKAGE + "getGsPntHistTotal", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SettlementDao.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: snw
	* - 설명			: 정산 목록 페이징 조회
	* </pre>
	* @param SettlementListSO
	* @return
	*/
	public List<SettlementListVO> pageOrderOrgStlm(SettlementListSO so) {
		if(!StringUtil.isBlank(so.getOrdrTel())){
			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getOrdrMobile())){
			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
		}
		return selectListPage( BASE_DAO_PACKAGE + "pageOrderOrgStlm", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: settlementDao.java
	* - 작성일		: 2020. 12. 18.
	* - 작성자		: valueFactory
	* - 설명			: 정산상태 일괄 수정
	* </pre>
	* @param OrderDetailPO
	* @return
	*/
	public int batchUpdateStat(OrderDetailPO po) {
		return update(BASE_DAO_PACKAGE + "batchUpdateStat", po );
	}

	public List<SettlementListExcelVO> settlementAdjustExcel(SettlementListSO so) {
		if(!StringUtil.isBlank(so.getOrdrTel())){
			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getOrdrMobile())){
			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
		}

		return selectListPage( BASE_DAO_PACKAGE + "settlementAdjustExcel", so );
	}
}
