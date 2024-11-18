package biz.app.goods.dao;

import biz.app.goods.model.TwcProductNutritionPO;
import org.springframework.stereotype.Repository;

import biz.app.goods.model.TwcProductNutritionVO;
import framework.common.dao.MainAbstractDao;

import java.util.HashMap;
import java.util.List;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: TwcProductNutritionDao.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 		: TWC 성분 영양 정보
* </pre>
*/
@Repository
public class TwcProductNutritionDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "TwcProductNutrition.";


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductNutritionDao.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: TWC 성분 영양 정보
	* </pre>
	*
	* @param productId
	* @return
	*/
	public TwcProductNutritionVO getTwcProductNutrition(Integer productId) {
		return selectOne(BASE_DAO_PACKAGE + "getTwcProductNutrition", productId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: TwcProductDao.java
	 * - 작성일	: 2021. 4. 2.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 성분 정보 sync
	 * </pre>
	 *
	 * @param sync
	 * @return
	 */
	public int replaceTwcProductNutrition(TwcProductNutritionPO po) throws Exception {
		HashMap<String, Object> params = new HashMap<>();
		params.put("nutrition", po);
		return insert_batch(BASE_DAO_PACKAGE + "replaceTwcProductNutrition", params);
	}

	public int replaceTwcProductNutritions(List<TwcProductNutritionPO> list) throws Exception {
		HashMap<String, Object> params = new HashMap<>();
		params.put("list", list);
		return insert_batch(BASE_DAO_PACKAGE + "replaceTwcProductNutrition", params);
	}
}
