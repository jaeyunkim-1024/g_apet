package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsTagMapPO;
import biz.app.goods.model.GoodsTagMapVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsTagMapService.java
* - 작성일	: 2020. 12. 31.
* - 작성자	: valfac
* - 설명 		: 상품 태그 서비스
* </pre>
*/
public interface GoodsTagMapService {


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsTagMapVO> listGoodsTagMap(String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsTagMapList
	* @return
	*/
	public void insertGoodsTagMap(String goodsId, List<GoodsTagMapPO> goodsTagMapList);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsTagMapList
	*/
	public void updateGoodsTagMap(String goodsId, List<GoodsTagMapPO> goodsTagMapList);
	
}