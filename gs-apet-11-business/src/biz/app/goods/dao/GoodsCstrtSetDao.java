package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsCstrtSetPO;
import biz.app.goods.model.GoodsCstrtSetVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsCstrtSetDao.java
* - 작성일	: 2021. 1. 8.
* - 작성자	: valfac
* - 설명 		: 상품 세트 구성 dao
* </pre>
*/
@Repository
public class GoodsCstrtSetDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsCstrtSet.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetDao.java
	* - 작성일	: 2021. 1. 8.
	* - 작성자 	: valfac
	* - 설명 		: 상품 세트 구성 등록
	* </pre>
	*
	* @param goodsCstrtSetPO
	*/
	public int insertGoodsCstrtSet(GoodsCstrtSetPO goodsCstrtSetPO) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsCstrtSet", goodsCstrtSetPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetDao.java
	* - 작성일	: 2021. 1. 14.
	* - 작성자 	: valfac
	* - 설명 		: 상품 세트 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsCstrtSetVO> listGoodsCstrtSet(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsCstrtSet", goodsId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetDao.java
	* - 작성일	: 2021. 2. 25.
	* - 작성자 	: valfac
	* - 설명 		: 상품 세트 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsCstrtSet(String goodsId) {
		return insert(BASE_DAO_PACKAGE + "deleteGoodsCstrtSet", goodsId);
	}
}
