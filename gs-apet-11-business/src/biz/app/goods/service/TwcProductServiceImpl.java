package biz.app.goods.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import biz.app.goods.model.*;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.TwcProductDao;
import biz.app.goods.dao.TwcProductNutritionDao;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: TwcProductServiceImpl.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 		: TWC 성분 정보 
* </pre>
*/
@Transactional
@Service("twcProductService")
public class TwcProductServiceImpl implements TwcProductService {

	@Autowired private TwcProductDao twcProductDao;

	@Autowired private TwcProductNutritionDao twcProductNutritionDao;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductServiceImpl.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: TWC 성분 정보
	* </pre>
	*
	* @param productCode
	* @param petsbeId
	* @return
	*/
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public TwcProductVO getTwcProduct(String productCode, String petsbeId) {
		TwcProductSO so = new TwcProductSO();
		so.setProductCode(productCode);
		so.setPetsbeId(petsbeId);
		return twcProductDao.getTwcProduct(so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: TwcProductServiceImpl.java
	* - 작성일	: 2021. 1. 29.
	* - 작성자 	: valfac
	* - 설명 		: TWC 성분 영양 정보
	* </pre>
	*
	* @param productId
	* @return
	*/
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public TwcProductNutritionVO getTwcProductNutrition(Integer productId) {
		return twcProductNutritionDao.getTwcProductNutrition(productId);
	}

	@Override
	public List<GoodsNotifyVO> getTwcProductValidationFO(TwcProductVO twc) {

		Map<String, String> twcMap = null;
		List<GoodsNotifyVO> twcList = new ArrayList<>();
		try {
			twcMap = BeanUtils.describe(twc);
			for(Map.Entry<String, String> header : twcMap.entrySet()) {
				if(header.getKey().equals("material") ||
						header.getKey().equals("packagingType") ||
						header.getKey().equals("innerPacking") ||
						header.getKey().equals("feedGrade") ||
						header.getKey().equals("recommendAge")){
					GoodsNotifyVO entryMap = new GoodsNotifyVO();
					entryMap.setItemVal(header.getValue());
					entryMap.setItemNm(header.getKey());
					twcList.add(entryMap);
				}
			}
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return twcList;
	}

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
	public int syncTwcProduct(TwcProductPO po) throws Exception {
		return twcProductDao.replaceTwcProduct(po);
	}

	@Transactional
	public int syncTwcProducts(List<TwcProductPO> list) throws Exception {
		return twcProductDao.replaceTwcProducts(list);
	}

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
	public int syncTwcProductNutrition(TwcProductNutritionPO po) throws Exception {
		return twcProductNutritionDao.replaceTwcProductNutrition(po);
	}

	@Transactional
	public int syncTwcProductNutritions(List<TwcProductNutritionPO> list) throws Exception {
		return twcProductNutritionDao.replaceTwcProductNutritions(list);
	}

	public int addTwcSyncLog(String twcTableName, Timestamp batchStrtDtm, String restCd, String resultMessage, String json) {
		return twcProductDao.insertTwcSyncFailLog(twcTableName, batchStrtDtm, restCd, resultMessage, json);
	}
}