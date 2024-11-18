package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsTagMapPO;
import biz.app.goods.model.GoodsTagMapVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsTagMapDao.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 상품 태그 매핑 DAO
* </pre>
*/
@Repository
public class GoodsTagMapDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsTagMap.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapDao.java
	* - 작성일	: 2020. 12. 31.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 등록
	* </pre>
	*
	* @param po
	* @return
	*/
	public int insertGoodsTagMap (GoodsTagMapPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsTagMap", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapDao.java
	* - 작성일	: 2020. 12. 31.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsTagMapVO> listGoodsTagMap (String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsTagMap", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapDao.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsTagMap (String goodsId) {
		return delete(BASE_DAO_PACKAGE + "deleteGoodsTagMap", goodsId);
	}
}
