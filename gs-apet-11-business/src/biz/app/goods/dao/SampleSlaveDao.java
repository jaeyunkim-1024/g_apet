package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import framework.common.dao.SlaveAbstractDao;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: SampleSlaveDao.java
* - 작성일	: 2021. 5. 27.
* - 작성자	: valfac
* - 설명 		: SampleSlaveDao
* </pre>	
*/
@Repository
public class SampleSlaveDao extends SlaveAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsDetail.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 03. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 상세 카테고리 lnb
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List<DisplayCategoryVO> listShopCategories() {
		return selectList(BASE_DAO_PACKAGE + "listShopCategories");
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: shkim
	 * - 설명		: 상품상세 상품정보 조회
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public GoodsBaseVO getGoodsDetail(GoodsBaseSO so){
		return selectOne(BASE_DAO_PACKAGE+"getGoodsDetail", so);
	}
	
}
