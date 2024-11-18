package biz.app.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtSetVO;
import biz.app.goods.model.GoodsPriceVO;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("goodsStockService")
public class GoodsStockServiceImpl implements GoodsStockService {

	@Autowired private GoodsBaseDao goodsBaseDao;
	@Autowired private GoodsCstrtSetService goodsCstrtSetService;
	@Autowired private ItemService itemService;
	@Autowired private GoodsSkuService goodsSkuService;
	@Autowired private GoodsPriceService goodsPriceService;

	/*
	 * 상품의 업체 유형 예약 여부에 따른 재고 증 차감
	 * @see biz.app.goods.service.GoodsStockService#updateStockQty(java.lang.String, java.lang.Long, java.lang.Integer)
	 */
	@Override
	public void updateStockQty(String goodsId, Integer applyQty) {
		GoodsBaseSO gbso = new GoodsBaseSO();
		gbso.setGoodsId(goodsId);
		GoodsBaseVO goodsBase = this.goodsBaseDao.getGoodsBase(gbso);

		/*
		 * 주문 상세 구성 별로 재고 증차감.
		 * 주문 상세 구성은 단품만 insert
		 * 단품일 가능성만 있음. 혹시 몰라 SET 체크.
		 * */
		if(CommonConstants.GOODS_CSTRT_TP_SET.contentEquals(goodsBase.getGoodsCstrtTpCd())) {
			List<GoodsCstrtSetVO> listGoodsCstrtSet = this.goodsCstrtSetService.listGoodsCstrtSet(goodsId);
			if(!listGoodsCstrtSet.isEmpty() && listGoodsCstrtSet.size()>0) {
				for(GoodsCstrtSetVO goodsCstrtSetVO : listGoodsCstrtSet) {
					this.updateStockQty(goodsCstrtSetVO.getSubGoodsId(), goodsCstrtSetVO.getCstrtQty().intValue() * applyQty);
				}
			}
		}else if( CommonConstants.GOODS_CSTRT_TP_ITEM.contentEquals(goodsBase.getGoodsCstrtTpCd()) ) {
			//단품
			GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(goodsBase.getGoodsId());
			
			if(!CommonConstants.GOODS_AMT_TP_60.contentEquals(goodsPriceVO.getGoodsAmtTpCd()) 
					&& CommonConstants.COMP_GB_10.contentEquals(goodsBase.getCompGbCd())) {
				// 예약 상품 X and 자사
				this.goodsSkuService.updateSkuStockQty(goodsBase, goodsBase.getItemNo(), "", applyQty);
			}else {
				this.itemService.updateItemWebStockQty(goodsBase, goodsBase.getItemNo(), applyQty);
			}
		}
	}
}
