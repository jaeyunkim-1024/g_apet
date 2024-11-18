package biz.app.market.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.market.model.MarketClaimConfirmPO;
import biz.app.market.model.MarketClaimConfirmVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.dao
* - 파일명	: MarketClaimDao.java
* - 작성일	: 2017. 10. 17.
* - 작성자	: schoi
* - 설명		:
* </pre>
*/
@Repository

public class MarketClaimDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "obclaim.";	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 번호 확인
	* </pre>
	* @param	marketClaimConfirmPO
	* @return
	*/
	public Integer checkClmNoCnt (MarketClaimConfirmPO marketClaimConfirmPO) {
		return (Integer) selectOne(BASE_DAO_PACKAGE + "checkClmNoCnt", marketClaimConfirmPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 번호 확인
	* </pre>
	* @param 	marketClaimConfirmPO
	* @return
	*/
	public String getOrdNo (MarketClaimConfirmPO marketClaimConfirmPO) {
		return (String) selectOne(BASE_DAO_PACKAGE + "getOrdNo", marketClaimConfirmPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 번호 확인
	* </pre>
	* @param 	marketClaimConfirmPO
	* @return
	*/
	public String checkClmNo (MarketClaimConfirmPO marketClaimConfirmPO) {
		return (String) selectOne(BASE_DAO_PACKAGE + "checkClmNo", marketClaimConfirmPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소 기본 정보 등록
	* </pre>
	* @param 	marketClaimConfirmPO
	* @return
	*/
	public int insertMarketClaimCancelBase( MarketClaimConfirmPO marketClaimConfirmPO ) {
		return insert( BASE_DAO_PACKAGE + "insertMarketClaimCancelBase", marketClaimConfirmPO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소 상세 정보 등록
	* </pre>
	* @param 	marketClaimConfirmPO
	* @return
	*/
	public int insertMarketClaimCancelDetail( MarketClaimConfirmPO marketClaimConfirmPO ) {
		return insert( BASE_DAO_PACKAGE + "insertMarketClaimCancelDetail", marketClaimConfirmPO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		:
	* </pre>
	* @param 	marketClaimConfirmPO
	* @return
	*/
	public List<MarketClaimConfirmVO> selectClaimConfirmGoodsInfo (MarketClaimConfirmPO marketClaimConfirmPO ) {
		return selectList (BASE_DAO_PACKAGE + "selectClaimConfirmGoodsInfo", marketClaimConfirmPO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimDao.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소 내역 처리 상태 변경
	* </pre>
	* @param 	marketClaimConfirmPO
	* @return
	*/
	public int updateObClaimCancelProcCd(MarketClaimConfirmPO marketClaimConfirmPO) {
		return update(BASE_DAO_PACKAGE + "updateObClaimCancelProcCd", marketClaimConfirmPO);
	}

}
