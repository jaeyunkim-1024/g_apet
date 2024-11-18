package biz.app.goods.dao;

import biz.app.goods.model.*;
import org.springframework.stereotype.Repository;

import framework.common.dao.MainAbstractDao;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: TwcProductDao.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 		: TWC 성분 정보
* </pre>
*/
@Repository
public class TwcProductDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "twcProduct.";


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductDao.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: 상품 성분 정보
	* </pre>
	*
	* @param so
	* @return
	*/
	public TwcProductVO getTwcProduct(TwcProductSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getTwcProduct", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductDao.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: 상품 성분 영양 정보
	* </pre>
	*
	* @param productId
	* @return
	*/
	public TwcProductNutritionVO getTwcProductNutrition(String productId) {
		return selectOne(BASE_DAO_PACKAGE + "getTwcProductNutrition", productId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: TwcProductDao.java
	 * - 작성일	: 2021. 4. 2.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 성분 영양 정보 sync
	 * </pre>
	 *
	 * @param sync
	 * @return
	 */
	public int replaceTwcProduct(TwcProductPO po) throws Exception {
		HashMap<String, Object> params = new HashMap<>();
		params.put("product", po);
		return insert_batch(BASE_DAO_PACKAGE + "replaceTwcProduct", params);
	}

	public int replaceTwcProducts(List<TwcProductPO> list) throws Exception {
		HashMap<String, Object> params = new HashMap<>();
		params.put("list", list);
		return insert_batch(BASE_DAO_PACKAGE + "replaceTwcProduct", params);
	}

	public int insertTwcSyncFailLog(String tableName, Timestamp batchStrtDtm, String syncResult, String resultMessage, String jsonLog) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("tableName", tableName);
		params.put("batchStrtDtm", batchStrtDtm);
		params.put("syncResult", syncResult);
		params.put("resultMessage", resultMessage);
		params.put("json", jsonLog);
		return insert(BASE_DAO_PACKAGE + "insertTwcSyncFailLog", params);
	}
}
