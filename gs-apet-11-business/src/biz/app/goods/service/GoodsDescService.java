package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsDescPO;
import biz.app.goods.model.GoodsDescSO;
import biz.app.goods.model.GoodsDescVO;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsDescService.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 설명 서비스 Interface
* </pre>
*/
public interface GoodsDescService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDescService.java
	* - 작성일		: 2016. 3. 3.
	* - 작성자		: snw
	* - 설명		: 상품 설명 상세 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	GoodsDescVO getGoodsDesc(GoodsDescSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsDescPOList
	* @return
	*/
	public void insertGoodsDesc(String goodsId, List<GoodsDescPO> goodsDescPOList);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsDescPOList
	*/
	public void updateGoodsDesc(String goodsId, List<GoodsDescPO> goodsDescPOList);
	
}