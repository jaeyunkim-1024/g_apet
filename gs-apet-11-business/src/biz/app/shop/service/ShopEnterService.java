package biz.app.shop.service;

import java.util.List;

import biz.app.shop.model.ShopEnterFileSO;
import biz.app.shop.model.ShopEnterFileVO;
import biz.app.shop.model.ShopEnterPO;
import biz.app.shop.model.ShopEnterSO;
import biz.app.shop.model.ShopEnterVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.shop.service
* - 파일명	: ShopEnterService.java
* - 작성일	: 2016. 4. 18.
* - 작성자	: jangjy
* - 설명		: 입점문의 서비스 Interface
* </pre>
*/
public interface ShopEnterService {
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: ShopEnterService.java
	* - 작성일	: 2016. 4. 18.
	* - 작성자	: jangjy
	* - 설명		: 입점문의 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	void insertShopEnter(ShopEnterPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ShopEnterService.java
	* - 작성일		: 2016. 9. 05.
	* - 작성자		: muelKim
	* - 설명			: 입점문의목록 페이지
	* </pre>
	* @param so
	* @return
	*/
	public List<ShopEnterVO> pageContectList(ShopEnterSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ShopEnterService.java
	* - 작성일		: 2016. 9. 05.
	* - 작성자		: muelKim
	* - 설명			: 입점문의목록 상세
	* </pre>
	* @param so
	* @return
	*/
	public List<ShopEnterVO> listShopEnterDetail(ShopEnterSO so);
	
	public List<ShopEnterFileVO> listShopEnterFile(ShopEnterFileSO sefso);
}