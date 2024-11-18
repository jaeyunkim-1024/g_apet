package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsIconPO;
import biz.app.goods.model.GoodsIconVO;
import biz.app.system.model.CodeDetailVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsIconService.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 상품 아이콘 서비스
* </pre>
*/
public interface GoodsIconService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsIconService.java
	* - 작성일	: 2020. 12. 29.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이콘 조회
	* </pre>
	*
	* @return
	*/
	List<GoodsIconVO> listGoodsIcon(String goodsId);

	List<CodeDetailVO> listGoodsIconByGoodsId(String goodsId);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsIconService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이콘 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsIconList
	* @return
	*/
	void insertGoodsIcon(String goodsId, List<GoodsIconPO> goodsIconList);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsIconService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이콘 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsIconList
	*/
	int saveGoodsIcon(List<String> goodsIds, List<GoodsIconPO> goodsIconList, String usrDfn1Val, String usrDfn2Val);
	//void updateGoodsIcon(String goodsId, List<GoodsIconPO> goodsIconList, String usrDfn1Val, String usrDfn2Val);
}