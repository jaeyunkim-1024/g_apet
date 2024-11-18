package biz.app.goods.service;

import biz.app.goods.model.*;

import java.sql.Timestamp;
import java.util.List;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: TwcProductService.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 		: TWC 성분 정보
* </pre>
*/
public interface TwcProductService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductService.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: 성분 정보
	* </pre>
	*
	* @param productCode
	* @param petsbeId
	* @return
	*/
	TwcProductVO getTwcProduct(String productCode, String petsbeId);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductService.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: 성분 영양 정보
	* </pre>
	*
	* @param productId
	* @return
	*/
	TwcProductNutritionVO getTwcProductNutrition(Integer productId);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductService.java
	* - 작성일	: 2021. 2. 19.
	* - 작성자 	: valfac
	* - 설명 		: 성분 영양 정보
	* </pre>
	*
	* @param twcProductVO
	* @return
	*/
	List<GoodsNotifyVO> getTwcProductValidationFO(TwcProductVO twcProductVO);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: TwcProductService.java
	 * - 작성일	: 2021. 4. 2.
	 * - 작성자 	: valfac
	 * - 설명 	: 성분 정보 sync
	 * </pre>
	 *
	 * @param list
	 * @return
	 */
	int syncTwcProduct(TwcProductPO po) throws Exception ;
	int syncTwcProducts(List<TwcProductPO> list) throws Exception ;

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: TwcProductService.java
	 * - 작성일	: 2021. 4. 2.
	 * - 작성자 	: valfac
	 * - 설명 	: 성분 영양 정보 sync
	 * </pre>
	 *
	 * @param list
	 * @return
	 */
	int syncTwcProductNutrition(TwcProductNutritionPO po) throws Exception ;
	int syncTwcProductNutritions(List<TwcProductNutritionPO> list) throws Exception ;

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: TwcProductService.java
	 * - 작성일	: 2021. 4. 20.
	 * - 작성자 	: valfac
	 * - 설명 	: sync 연동 로그 등록
	 * </pre>
	 *
	 * @param list
	 * @return
	 */
	int addTwcSyncLog(String twcTableName, Timestamp batchStrtDtm, String restCd, String resultMessage, String json);
}