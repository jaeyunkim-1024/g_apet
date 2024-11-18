package batch.excute.goods;

import batch.config.util.BatchLogUtil;
import biz.app.batch.model.BatchLogPO;
import biz.app.goods.model.TwcProductNutritionPO;
import biz.app.goods.model.TwcProductPO;
import biz.app.goods.service.TwcProductService;
import biz.twc.dao.TwcSyncProductDao;
import com.google.gson.Gson;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.collections4.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsTwcSyncExecute.java
 * - 작성일     : 2021. 03. 31.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */
@Slf4j
@Component
public class GoodsTwcSyncExecute {

	@Autowired private MessageSourceAccessor message;

	//TWC DB 조회
	@Autowired TwcSyncProductDao twcSyncProductDao;

	//ABOUTPET DB REPLACE
	@Autowired TwcProductService twcProductService;

	/**
	 * <pre>
	 * - 프로젝트명 : batch
	 * - 패키지명   : batch.excute.goods
	 * - 파일명     : cronTwcProductSync.java
	 * - 작성일     : 2021. 03. 31.
	 * - 작성자     : valfac
	 * - 설명       : 새벽4시 동기화 작업
	 * 20210430 - 1시간 배치로 변경 임시
	 * </pre>
	 */
	@Scheduled(cron = "0 0 4 * * ?")
	public void cronTwcProductSync() {

		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_TWC_SYNC_PRODUCT_REPLACE);
		String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;

		List<TwcProductPO> products = twcSyncProductDao.listTwcProduct();
		List<List<TwcProductPO>> batchProductList = ListUtils.partition(products, 500);

		int productTotal = products.size();
		int productSuccess = 0;
		int productFail = 0;

		String twcTableName = CommonConstants.BATCH_TWC_SYNC_PRODUCT_TABLE;
		Gson gson = new Gson();
		// Bean 복사를 위한 처리
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		try {

			TwcProductPO po = null;
			for(List<TwcProductPO> list : batchProductList) {
				try {
					twcProductService.syncTwcProducts(list);

					productSuccess = productSuccess + list.size();

				} catch (Exception pe1) {

					for(Object vo : list) {
						po = new TwcProductPO();
						try {
							BeanUtils.copyProperties(po, vo);
							twcProductService.syncTwcProduct(po);

							productSuccess++;

						} catch (Exception pe2) {
							productFail ++;
							//실패 데이터 로그 남기기
							String jsonLog = gson.toJson(vo);

							twcProductService.addTwcSyncLog(twcTableName, blpo.getBatchStrtDtm(), CommonConstants.BATCH_RST_CD_FAIL, pe2.getMessage(), jsonLog);
						}
					}
				}
			}

		} catch (Exception e) {

			batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;

		}

		String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.success", new Object[] { productTotal, productSuccess, productFail});

		BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);


		blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_TWC_SYNC_NUTRITION_REPLACE);

		List<TwcProductNutritionPO> productNutritions = twcSyncProductDao.listTwcProductNutrition();
		List<List<TwcProductNutritionPO>> batchProductNutritions = ListUtils.partition(productNutritions, 1000);

		int nutritionTotal = productNutritions.size();
		int nutritionSuccess = 0;
		int nutritionFail = 0;

		twcTableName = CommonConstants.BATCH_TWC_SYNC_NUTRITION_TABLE;

		try {
			TwcProductNutritionPO npo = null;
			for(List<TwcProductNutritionPO> list : batchProductNutritions) {
				// 1000개씩 등록
				try {
					twcProductService.syncTwcProductNutritions(list);
					nutritionSuccess = nutritionSuccess + list.size();

				} catch (Exception ne1) {

					for(Object vo : list) {
						try {
							npo = new TwcProductNutritionPO();
							BeanUtils.copyProperties(npo, vo);

							twcProductService.syncTwcProductNutrition(npo);

							nutritionSuccess ++;

						} catch (Exception ne2) {
							nutritionFail ++;
							//실패 데이터 로그 남기기
							String jsonLog = gson.toJson(npo);

							twcProductService.addTwcSyncLog(twcTableName, blpo.getBatchStrtDtm(), CommonConstants.BATCH_RST_CD_FAIL, ne2.getMessage(), jsonLog);
						}
					}
				}
			}

		batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;

		} catch (Exception e) {

			batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;

		}

		batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.success", new Object[] { nutritionTotal, nutritionSuccess, nutritionFail});

		BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);

	}
}
