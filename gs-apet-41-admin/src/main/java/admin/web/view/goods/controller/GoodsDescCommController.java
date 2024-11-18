package admin.web.view.goods.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.goods.model.GoodsDescCommPO;
import biz.app.goods.model.GoodsDescCommSO;
import biz.app.goods.model.GoodsDescCommVO;
import biz.app.goods.service.GoodsDescCommService;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: gs-apet-41-admin
* - 패키지명 	: admin.web.view.goods.controller
* - 파일명 	: GoodsDescCommController.java
* - 작성일	: 2021. 1. 4.
* - 작성자	: valfac
* - 설명 		: 상품 설명 공통 컨트롤러
* </pre>
*/
@Slf4j
@Controller
public class GoodsDescCommController {

	@Autowired
	private GoodsDescCommService goodsDescCommService;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsDescCommController.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 
	* </pre>
	*
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/goods/goodsDescCommGrid.do", method=RequestMethod.POST)
	public GridResponse goodsDescCommGrid(Model model , GoodsDescCommSO so) {

		List<GoodsDescCommVO> list = goodsDescCommService.pageGoodsDescComm(so);

		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsDescCommController.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 리스트
	* </pre>
	*
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping(value="/goods/goodsDescCommListView.do")
	public String goodsDescCommListView(Model model, GoodsDescCommSO so) {
		
		return "/goods/goodsDescCommListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명	: goodsDescCommInsertView.java
	 * - 작성일	: 2021. 1. 4.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 설명 공통 등록 화면
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value="/goods/goodsDescCommInsertView.do")
	public String goodsDescCommInsertView(Model model, GoodsDescCommPO po) {
		
		return "/goods/goodsDescCommInsertView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsDescCommController.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 상세
	* </pre>
	*
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping(value="/goods/goodsDescCommDeatilView.do")
	public String goodsDescCommDeatilView(Model model, GoodsDescCommPO po) {
		
		GoodsDescCommVO goodsDescComm = goodsDescCommService.getGoodsDescComm(po);
		
		model.addAttribute("goodsDescComm", goodsDescComm);
		
		return "/goods/goodsDescCommInsertView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsDescCommController.java
	* - 작성일	: 2021. 1. 5.
	* - 작성자 	: valfac
	* - 설명 		: 상품 내용 공통 등록
	* </pre>
	*
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping(value = "/goods/goodsDescCommInsert.do", method = RequestMethod.POST)
	public String insertGoodsDescComm(Model model, GoodsDescCommPO po) {
		
		goodsDescCommService.insertGoodsDescComm(po);
		
		model.addAttribute("goodsDescCommPO", po);
		
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsDescCommController.java
	* - 작성일	: 2021. 1. 5.
	* - 작성자 	: valfac
	* - 설명 		: 상품 내용 공통 수정
	* </pre>
	*
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping(value = "/goods/goodsDescCommUpdate.do", method = RequestMethod.POST)
	public String updateGoodsDescComm(Model model, GoodsDescCommPO po) {
		
		goodsDescCommService.updateGoodsDescComm(po);
		
		model.addAttribute("goodsDescCommPO", po);
		
		return View.jsonView();
	}
}
