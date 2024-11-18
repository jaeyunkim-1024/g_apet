package biz.app.goods.service;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.service
* - 파일명		: ItemService.java
* - 작성일		: 2016. 4. 14.
* - 작성자		: valueFactory
* - 설명			:  재고
* </pre>
*/
public interface GoodsStockService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsStockService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명			: 상품의 웹재고 증차감
	* 					  상품단위의 웹 재고 관리에 따른 증 차감 처리
	* 					  주문/클레임 시 사용
	* </pre>
	* @param goodsId
	 * @param applyQty	+ / -
	*/
	public void updateStockQty(String goodsId, Integer applyQty);
}
