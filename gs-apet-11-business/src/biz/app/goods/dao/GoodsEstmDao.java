package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsEstmQstCtgMapSO;
import biz.app.goods.model.GoodsEstmQstVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsEstmDao.java
* - 작성일	: 2020. 12. 21.
* - 작성자	: valfac
* - 설명 		: 상품평가
* </pre>
*/
@Repository
public class GoodsEstmDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsEstm.";
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsEstmDao.java
	* - 작성일	: 2021. 2. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 평가 문항 카테고리 매핑 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<GoodsEstmQstVO> listGoodsEstmQstCtgMap(GoodsEstmQstCtgMapSO so) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsEstmQstCtgMap", so);
	}
	
}