package biz.app.goods.service;

import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBulkPriceVO;

import java.util.HashMap;
import java.util.List;

public interface GoodsBulkService {

	List<GoodsBulkPriceVO> pageGoodsBulkPrice(GoodsBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 수정 [배치]
	 * </pre>
	 * @param goodsBasePOList
	 * @return
	 */
	boolean updateGoods(String goodsUpdateGb, GoodsBasePO po);

	int callGoodsBestProc(String argBaseDt);

	int callGoodsStatProc();

	int callGoodsDispAllCtgProc();

	HashMap sendGoodsCis();
}
