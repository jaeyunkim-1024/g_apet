package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.FiltAttrMapPO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: FiltAttrMapService.java
* - 작성일	: 2021. 1. 6.
* - 작성자	: valfac
* - 설명 		: 필터 속성 매핑 서비스
* </pre>
*/
public interface FiltAttrMapService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: FiltAttrMapService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 필터 속성 매핑 등록
	* </pre>
	*
	* @param goodsId
	* @param filtAttrMapList
	* @return
	*/
	public void insertFiltAttrMap(String goodsId, List<FiltAttrMapPO> filtAttrMapList);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: FiltAttrMapService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 필터 속성 매핑 수정
	* </pre>
	*
	* @param goodsId
	* @param filtAttrMapList
	*/
	public void updateFiltAttrMap(String goodsId, List<FiltAttrMapPO> filtAttrMapList);
}