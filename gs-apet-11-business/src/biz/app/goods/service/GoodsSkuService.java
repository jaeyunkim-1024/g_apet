package biz.app.goods.service;

import biz.app.goods.model.*;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.goods.service
 * - 파일명		: GoodsSkuService.java
 * - 작성일		: 2021. 1. 26.
 * - 작성자		: valueFactory
 * - 설명		: 단품 CIS 연동 관리
 * </pre>
 */
public interface GoodsSkuService {
	
	void insertSkuBase(GoodsBasePO vo, ItemPO itemPO);
	int updateSkuBase(GoodsSkuBasePO po);

	void updateSkuStockQty(String goodsId, long itemNo, String skuCd, Integer applyQty);
	void updateSkuStockQty(GoodsBaseVO goodsBase, long itemNo, String skuCd, Integer applyQty);
}
