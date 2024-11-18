package batch.excute.goods;

import batch.config.util.BatchLogUtil;
import biz.app.batch.model.BatchLogPO;
import biz.app.goods.model.GoodsSkuBasePO;
import biz.app.goods.service.GoodsSkuService;
import biz.interfaces.cis.model.response.goods.StockUpdateVO;
import biz.interfaces.cis.service.CisGoodsService;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;
import org.apache.commons.lang.StringUtils;
import framework.common.util.DateUtil;
import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.groupingBy;
import static java.util.stream.Collectors.summingInt;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsStkQtyExecute.java
 * - 작성일     : 2021. 01. 25.
 * - 작성자     : lhj01
 * - 설명       : CIS 상품 재고배치
 * </pre>
 */
@Slf4j
@Component
public class GoodsStkQtyExecute {

	@Autowired private CisGoodsService cisGoodsService;

	@Autowired private GoodsSkuService goodsSkuService;

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: GoodsStkQtyExecute.java
	 * - 작성일		: 2021. 01. 25.
	 * - 작성자		:
	 * - 설명		: CIS 상품 재고배치
	 *
	 * 20210324 기존 재고가 0 이상일 때 새로 들어온 재고가 있을 경우, 재입고 알림 대상 상품 테이블에 등록
	 * 5분 간격 -> 20210514 -> 20분 간격
	 * </pre>
	 */
	public void cronGoodsStockQty() {

		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_GOODS_STK_QTY_UPDATE);
		log.error("============== 재고 배치 시작 ==============[" + DateUtil.getTimestampToString(blpo.getBatchStrtDtm(),  "yyyy-MM-dd HH:mm:ss") + "]" );

		try{
			StockUpdateVO vo = cisGoodsService.getGoodsStockList(CommonConstants.COMM_YN_Y);
			//버그 테스트
			//List<StockUpdateVO.Stock> itemList = cisGoodsService.getGoodsStockListTest();
			String resCd = vo.getResCd();

			int total = 0;
			int[] success = {0};
			int[] fail = {0};

			if(CommonConstants.BATCH_RST_CD_SUCCESS.equals(resCd)) {
				try {
					List<StockUpdateVO.Stock> list = vo.getItemList();
					//버그 테스트
					//list = itemList;
					total = list.size();

					// skuCd = goodsId 별로 합산하여 수량 계산
					Map<String, Integer> stockMap =
							list.stream().collect(groupingBy(StockUpdateVO.Stock::getSkuCd, summingInt(StockUpdateVO.Stock::getStockAbl)));

					//for(StockUpdateVO.Stock stockVO : list ) {
					stockMap.forEach((goodsId, stkQty)->{

						log.debug("상품 GOODS_ID={} : 수량={}", goodsId, stkQty);

						try {
							GoodsSkuBasePO po = new GoodsSkuBasePO();
							po.setGoodsId(goodsId);
							po.setStkQty(stkQty);
							po.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
							po.setSysRegDtm(blpo.getBatchStrtDtm());

							if(StringUtils.isNotEmpty(goodsId)) {
								int result = goodsSkuService.updateSkuBase(po);

								if(result > 0) {
									success[0] ++;
									log.debug("배치 GOODS_ID={} : 수량={}", goodsId, stkQty);
								} else {
									fail[0] ++;
									log.debug("재고 배치 실패 GOODS_ID={} : 수량={}", goodsId, stkQty);
								}
							}

						} catch (Exception e) {
							fail[0] ++;
							log.debug("재고 배치 실패 GOODS_ID={} : 수량={}", goodsId, stkQty);
						}
					});

					String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;
					String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.success", new Object[] { total, success[0], fail[0]});

					BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
					log.error("============== 재고 배치 종료 ==============[" + DateUtil.getTimestampToString(blpo.getBatchEndDtm(),
							"yyyy-MM-dd HH:mm:ss") + "]" );

				} catch (Exception e) {

					String batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;
					String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.fail", new Object[] { total, success[0], fail[0]});

					BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
				}
			}

		} catch (Exception e) {
			String batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;
			String batchRstMsg= e.getMessage();

			BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
		}
	}
}