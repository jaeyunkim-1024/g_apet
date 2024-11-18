package biz.app.goods.dao;

import biz.app.goods.model.FiltAttrMapVO;
import org.springframework.stereotype.Repository;

import biz.app.goods.model.FiltAttrMapPO;
import framework.common.dao.MainAbstractDao;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: FiltAttrMapDao.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 필터 속성 매핑
* </pre>
*/
@Repository
public class FiltAttrMapDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "filtAttrMap.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: FiltAttrMapDao.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 필터 속성 매핑 등록
	* </pre>
	*
	* @param po
	* @return
	*/
	public int insertFiltAttrMap (FiltAttrMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertFiltAttrMap", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: FiltAttrMapDao.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 필터 속성 매핑 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteFiltAttrMap(String goodsId) {
		return delete(BASE_DAO_PACKAGE + "deleteFiltAttrMap", goodsId);
	}

	public List<FiltAttrMapVO> listFiltAttrMap(FiltAttrMapPO po) {
		return selectList(BASE_DAO_PACKAGE + "listFiltAttrMap", po);
	}
}
