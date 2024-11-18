package biz.app.goods.dao;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsNaverEpInfoPO;
import biz.app.goods.model.GoodsNaverEpInfoVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsNaverEpInfoDao.java
* - 작성일	: 2021. 1. 18.
* - 작성자	: valfac
* - 설명 		: 상품 네이버 EP 정보 Dao
* </pre>
*/
@Repository
public class GoodsNaverEpInfoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsNaverEpInfo.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoDao.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 등록
	* </pre>
	*
	* @param goodsNaverEpInfoPO
	* @return
	*/
	public int insertGoodsNaverEpInfo (GoodsNaverEpInfoPO goodsNaverEpInfoPO) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsNaverEpInfo", goodsNaverEpInfoPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoDao.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 수정
	* </pre>
	*
	* @param goodsNaverEpInfoPO
	* @return
	*/
	public int updateGoodsNaverEpInfo (GoodsNaverEpInfoPO goodsNaverEpInfoPO) {
		return update(BASE_DAO_PACKAGE + "updateGoodsNaverEpInfo", goodsNaverEpInfoPO);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoDao.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public GoodsNaverEpInfoVO getGoodsNaverEpInfo(String goodsId) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsNaverEpInfo", goodsId);
	}

}
