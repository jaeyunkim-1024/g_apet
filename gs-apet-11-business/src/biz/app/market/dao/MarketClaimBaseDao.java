package biz.app.market.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.market.model.MarketClaimListSO;
import biz.app.market.model.MarketClaimListVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.dao
* - 파일명	: MarketClaimBaseDao.java
* - 작성일	: 2017. 9. 21.
* - 작성자	: kimdp
* - 설명		:
* </pre>
*/
@Repository

public class MarketClaimBaseDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "obclaimbase.";	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimBaseDao.java
	* - 작성일	: 2017. 9. 21.
	* - 작성자	: kimdp
	* - 설명		: 오픈마켓 원 주문 목록 페이징 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<MarketClaimListVO> pageMarketClaimOrg( MarketClaimListSO so ) {
//		if(!StringUtil.isBlank(so.getOrdrTel())){
//			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
//		}
//		if(!StringUtil.isBlank(so.getOrdrMobile())){
//			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
//		}

		return selectListPage( BASE_DAO_PACKAGE + "pageMarketClaimOrg", so );
	}

}