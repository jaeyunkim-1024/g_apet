package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsCstrtSetPO;
import biz.app.goods.model.GoodsCstrtSetVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsCstrtSetService.java
* - 작성일	: 2021. 1. 8.
* - 작성자	: valfac
* - 설명 		: 상품 세트 구성 서비스
* </pre>
*/
public interface GoodsCstrtSetService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetService.java
	* - 작성일	: 2021. 1. 8.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 등록
	* </pre>
	*
	* @param goodsCstrtSetPOList
	* @param goodsId
	*/
	public void insertGoodsCstrtSet(List<GoodsCstrtSetPO> goodsCstrtSetPOList, String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetService.java
	* - 작성일	: 2021. 1. 14.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 리스트
	* </pre>
	*
	* @param goodsId
	*/
	public List<GoodsCstrtSetVO> listGoodsCstrtSet(String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetService.java
	* - 작성일	: 2021. 2. 24.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsCstrtSet(String goodsId);
}