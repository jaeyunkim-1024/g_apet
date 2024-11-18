package admin.web.view.goods.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.web.config.view.View;
import biz.app.goods.model.GoodsPricePO;
import biz.app.goods.model.GoodsPriceSO;
import biz.app.goods.model.GoodsPriceVO;
import biz.app.goods.service.GoodsPriceService;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: gs-apet-41-admin
* - 패키지명 	: admin.web.view.goods.controller
* - 파일명 	: GoodsPriceController.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 가격 컨트롤러
* </pre>
*/
@Slf4j
@Controller
public class GoodsPriceController {

	@Autowired private GoodsPriceService goodsPriceService;
	

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 가격 정보 수정 / 등록
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsPriceUpdate.do")
	public String goodsPriceUpdate(Model model, GoodsPricePO po) {

		po.setValidCheck(true);
		
		goodsPriceService.updateGoodsPrice(po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 가격 수정 정보 Layer
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsPriceLayerView.do")
	public String goodsPriceLayerView(Model model, GoodsPriceSO so) {

		// 상품 현재 가격 정보 조회
		GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(so.getGoodsId());
		goodsPriceVO.setGoodsId(so.getGoodsId());

		model.addAttribute("goodsPrice", goodsPriceVO);
		
		return "/goods/goodsPriceLayerView";
	}

}
