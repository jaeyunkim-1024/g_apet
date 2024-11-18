package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsAttributeSO;
import biz.app.goods.model.GoodsAttributeVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.attribute.dao
* - 파일명		: GoodsAttributeDao.java
* - 작성일		: 2017. 2. 6.
* - 작성자		: snw
* - 설명			: 상품 속성 DAO
* </pre>
*/
@Repository
public class GoodsAttributeDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsAttribute.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsAttributeDao.java
	* - 작성일		: 2017. 2. 6.
	* - 작성자		: snw
	* - 설명			: 상품 속성&값 목록 조회
	*                   
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsAttributeVO> listGoodsAttribute(GoodsAttributeSO so){
		return selectList(BASE_DAO_PACKAGE + "listGoodsAttribute", so);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}