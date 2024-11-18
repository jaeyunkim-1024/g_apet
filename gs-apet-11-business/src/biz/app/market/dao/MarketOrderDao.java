package biz.app.market.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.market.model.MarketOrderConfirmPO;
import biz.app.market.model.MarketOrderConfirmVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.dao
* - 파일명	: MarketOrderDao.java
* - 작성일	: 2017. 9. 25.
* - 작성자	: schoi
* - 설명		:
* </pre>
*/
@Repository

public class MarketOrderDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "oborder.";	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 번호 확인
	* </pre>
	* @param	marketOrderConfirmPO
	* @return
	*/
	public Integer checkOrdNoCnt (MarketOrderConfirmPO marketOrderConfirmPO) {
		return (Integer) selectOne(BASE_DAO_PACKAGE + "checkOrdNoCnt", marketOrderConfirmPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 번호 확인
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public String checkOrdNo (MarketOrderConfirmPO marketOrderConfirmPO) {
		return (String) selectOne(BASE_DAO_PACKAGE + "checkOrdNo", marketOrderConfirmPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 배송지 번호 확인
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public Long checkOrdDlvraNo (MarketOrderConfirmPO marketOrderConfirmPO) {
		return (Long) selectOne(BASE_DAO_PACKAGE + "checkOrdDlvraNo", marketOrderConfirmPO);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 배송비 번호 확인
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public Long checkDlvrcNo (MarketOrderConfirmPO marketOrderConfirmPO) {
		return (Long) selectOne(BASE_DAO_PACKAGE + "checkDlvrcNo", marketOrderConfirmPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 기본 정보 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public int insertMarketOrderBase( MarketOrderConfirmPO marketOrderConfirmPO ) {
		return insert( BASE_DAO_PACKAGE + "insertMarketOrderBase", marketOrderConfirmPO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 상세 정보 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public int insertMarketOrderDetail( MarketOrderConfirmPO marketOrderConfirmPO ) {
		return insert( BASE_DAO_PACKAGE + "insertMarketOrderDetail", marketOrderConfirmPO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 배송지 정보 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public int insertMarketOrderDelivery( MarketOrderConfirmPO marketOrderConfirmPO ) {
		return insert( BASE_DAO_PACKAGE + "insertMarketOrderDelivery", marketOrderConfirmPO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 배송비 정보 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public int insertMarketDeliveryCharge( MarketOrderConfirmPO marketOrderConfirmPO ) {
		return insert( BASE_DAO_PACKAGE + "insertMarketDeliveryCharge", marketOrderConfirmPO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		:
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public List<MarketOrderConfirmVO> selectOrderConfirmGoodsInfo (MarketOrderConfirmPO marketOrderConfirmPO ) {
		return selectList (BASE_DAO_PACKAGE + "selectOrderConfirmGoodsInfo", marketOrderConfirmPO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderDao.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 처리 상태 변경
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	public int updateObOrderProcCd(MarketOrderConfirmPO marketOrderConfirmPO) {
		return update(BASE_DAO_PACKAGE + "updateObOrderProcCd", marketOrderConfirmPO);
	}

}
