package biz.app.goods.service;

import biz.app.goods.model.GoodsCisPO;
import biz.app.goods.model.GoodsCisSO;
import biz.app.goods.model.GoodsCisVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsCisService.java
* - 작성일	: 2021. 1. 12.
* - 작성자	: YJS01
* - 설명 		: 단품 상품 CRUD
* </pre>
*/
public interface GoodsCisService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCisService.java
	* - 작성일		: 2021. 1. 12.
	* - 작성자 		: YJS01
	* - 설명 		: 단품 상품 조회
	* </pre>
	*
	* @param so
	* @return GoodsSkuVO
	*/
	public GoodsCisVO getGoodsCisInfo(GoodsCisSO so) throws Exception;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCisService.java
	* - 작성일		: 2021. 1. 14.
	* - 작성자 		: YJS01
	* - 설명 		: 단품 상품 등록
	* </pre>
	*
	* @param po
	* @return GoodsSkuVO
	*/
	public GoodsCisVO.GoodsCisRes insertGoodsCis(GoodsCisPO po) throws Exception;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCisService.java
	* - 작성일		: 2021. 1. 14.
	* - 작성자 		: YJS01
	* - 설명 		: 단품 상품 수정
	* </pre>
	*
	* @param po
	* @return GoodsSkuVO
	*/
	public GoodsCisVO.GoodsCisRes updateGoodsCis(GoodsCisPO po) throws Exception;
}