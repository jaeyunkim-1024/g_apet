package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsNotifyPO;
import biz.app.goods.model.GoodsNotifyVO;
import biz.app.goods.model.NotifyInfoVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsNotifyService.java
* - 작성일		: 2016. 4. 12.
* - 작성자		: snw
* - 설명		: 상품 고시 서비스 Interface
* </pre>
*/
public interface GoodsNotifyService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsNotifyService.java
	* - 작성일		: 2016. 4. 12.
	* - 작성자		: snw
	* - 설명		: 상품고시 목록 조회 (상품의 고시정보 및 값정보)
	* </pre>
	* @param goodsId
	* @return
	* @throws Exception
	*/
	List<GoodsNotifyVO> listGoodsNotifyUsed(String goodsId);

	/**
		* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsNotifyService.java
	* - 작성일		: 2017. 6. 01.
	* - 작성자		: snw
	* - 설명		: 상품고시 조회 (상품의 고시정보)
	* </pre>
	* @param goodsId
	* @return
	* @throws Exception
	 */
	NotifyInfoVO getCheckGoodsNotify(String ntfId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNotifyService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품고시 정보 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsNotifyPOList
	* @return
	*/
	public void insertGoodsNotify(String goodsId, List<GoodsNotifyPO> goodsNotifyPOList);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNotifyService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품고시 정보 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsNotifyPOList
	*/
	public void updateGoodsNotify(String goodsId, List<GoodsNotifyPO> goodsNotifyPOList);


}