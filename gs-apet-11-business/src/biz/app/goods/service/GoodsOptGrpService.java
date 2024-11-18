package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsOptGrpPO;
import biz.app.goods.model.GoodsOptGrpVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsOptGrpService.java
* - 작성일	: 2021. 1. 22.
* - 작성자	: valfac
* - 설명 		: 상품 옵션 그룹 서비스
* </pre>
*/
public interface GoodsOptGrpService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpService.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 그룹 상품 등록
	* </pre>
	*
	* @param GoodsOptGrpPOList
	* @param goodsId
	*/
	public void insertGoodsOptGrp(List<GoodsOptGrpPO> GoodsOptGrpPOList, String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpService.java
	* - 작성일	: 2021. 1. 14.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 그룹 상품 리스트
	* </pre>
	*
	* @param goodsId
	*/
	public List<GoodsOptGrpVO> listGoodsOptGrp(String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpService.java
	* - 작성일	: 2021. 2. 24.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 그룹 상품 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsOptGrp(String goodsId);
}