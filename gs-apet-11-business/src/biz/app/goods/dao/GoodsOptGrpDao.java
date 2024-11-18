package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsOptGrpPO;
import biz.app.goods.model.GoodsOptGrpVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsOptGrpDao.java
* - 작성일	: 2021. 1. 22.
* - 작성자	: valfac
* - 설명 		: 상품 옵션 그룹 구성 dao
* </pre>
*/
@Repository
public class GoodsOptGrpDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsOptGrp.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpDao.java
	* - 작성일	: 2021. 1. 22.
	* - 작성자 	: valfac
	* - 설명 		: 상품 옵션 그룹 구성 등록
	* </pre>
	*
	* @param goodsOptGrpPO
	*/
	public int insertGoodsOptGrp(GoodsOptGrpPO goodsOptGrpPO) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsOptGrp", goodsOptGrpPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpDao.java
	* - 작성일	: 2021. 1. 22.
	* - 작성자 	: valfac
	* - 설명 		: 상품 옵션 그룹 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsOptGrpVO> listGoodsOptGrp(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsOptGrp", goodsId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpDao.java
	* - 작성일	: 2021. 2. 25.
	* - 작성자 	: valfac
	* - 설명 		: 상품 옵션 그룹 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsOptGrp(String goodsId) {
		return delete(BASE_DAO_PACKAGE + "deleteGoodsOptGrp", goodsId);
	}	
}
