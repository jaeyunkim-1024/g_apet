package biz.app.goods.service;

import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsPricePO;
import biz.app.goods.model.GoodsPriceVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsPriceService.java
* - 작성일	: 2021. 1. 7.
* - 작성자	: valfac
* - 설명 		: 상품 가격 서비스
* </pre>
*/
public interface GoodsPriceService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 가격 등록
	* </pre>
	*
	* @param goodsPricePO
	* @param goodsBasePO
	* @return
	*/
	public GoodsPricePO insertGoodsPrice(GoodsPricePO goodsPricePO, GoodsBasePO goodsBasePO);
	

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceService.java
	* - 작성일	: 2021. 1. 12.
	* - 작성자 	: valfac
	* - 설명 		: 상품 가격 정보 수정
	* </pre>
	*
	* @param po
	*/
	public void updateGoodsPrice(GoodsPricePO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 현재 가격 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsPriceVO getCurrentGoodsPrice (String goodsId);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2021. 5. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 가격 정보 cisYn 업데이트
	 * </pre>
	 * @param goodsId
	 * @param cisYn
	 * @return
	 */
	int editGoodsPriceCisYn (Long goodsPrcNo, String cisYn);

}