package front.web.view.customer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.service.DisplayService;
import biz.app.shop.model.ShopEnterPO;
import biz.app.shop.service.ShopEnterService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewCustomer;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.introduce.controller
* - 파일명		: ContectController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 입점문의 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("customer/contect")
public class ContectController {

	@Autowired private CacheService cacheService;
	
	@Autowired private ShopEnterService shopEnterService;
	
	@Autowired private DisplayService displayService;

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: ContectController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 입점문의 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexContect")
	public String indexContect(ModelMap map, Session session, ViewBase view){
		// 입점희망 카테고리 조회
		DisplayCategorySO dispSO = new DisplayCategorySO();
		
		dispSO.setStId(view.getStId());
		dispSO.setDispLvl(1L);
		List<DisplayCategoryVO> dispHopeCate = displayService.listDisplayHopeCategory(dispSO);
		
		map.put("dispHopeCate", dispHopeCate);
		
		map.put("session", session);
		map.put("view", view);
		
		// 상품유형, 판매유형, 물류유형
		map.put("seGoodsTpCdList", this.cacheService.listCodeCache(CommonConstants.SE_GOODS_TP, null, null, null, null, null));
		map.put("seSaleTpCdList", this.cacheService.listCodeCache(CommonConstants.SE_SALE_TP, null, null, null, null, null));
		map.put("seDstbTpCdList", this.cacheService.listCodeCache(CommonConstants.SE_DSTB_TP, null, null, null, null, null));
		map.put(FrontWebConstants.CUSTOMER_MENU_GB, FrontWebConstants.CUSTOMER_MENU_CONTECT);
		
		return TilesView.customer(new String[]{"indexContect"});
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: ContectController.java
	* - 작성일	: 2016. 4. 18.
	* - 작성자	: jangjy
	* - 설명		: 입점문의 등록
	* </pre>
	* @param ShopEnterPO
	* @param Session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="insertShopEnter")
	@ResponseBody
	public ModelMap insertShopEnter(ShopEnterPO po,Session session){

		po.setSysRegrNo(session.getMbrNo());
		
		this.shopEnterService.insertShopEnter(po);
		
		return new ModelMap();
	}
	
	
}