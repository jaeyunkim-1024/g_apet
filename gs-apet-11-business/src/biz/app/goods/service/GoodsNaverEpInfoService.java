package biz.app.goods.service;

import biz.app.goods.model.GoodsNaverEpInfoPO;
import biz.app.goods.model.GoodsNaverEpInfoVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsNaverEpInfoService.java
* - 작성일	: 2021. 1. 18.
* - 작성자	: valfac
* - 설명 		: 상품 네이버 EP 정보 서비스
* </pre>
*/
public interface GoodsNaverEpInfoService {


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoService.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 등록
	* </pre>
	*
	* @param goodsNaverEpInfoPO
	* @param goodsId
	* @return
	*/
	public int insertGoodsNaverEpInfo(GoodsNaverEpInfoPO goodsNaverEpInfoPO, String goodsId);
	

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoService.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 수정
	* </pre>
	*
	* @param goodsNaverEpInfoPO
	* @return
	*/
	public int updateGoodsNaverEpInfo(GoodsNaverEpInfoPO goodsNaverEpInfoPO);
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoService.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public GoodsNaverEpInfoVO getGoodsNaverEpInfo(String goodsId);


	
}