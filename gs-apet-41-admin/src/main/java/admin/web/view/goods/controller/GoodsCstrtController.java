package admin.web.view.goods.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import biz.app.goods.model.GoodsCstrtPakSO;
import biz.app.goods.model.GoodsCstrtPakVO;
import biz.app.goods.model.GoodsCstrtSetSO;
import biz.app.goods.model.GoodsCstrtSetVO;
import biz.app.goods.model.GoodsOptGrpVO;
import biz.app.goods.service.GoodsCstrtPakService;
import biz.app.goods.service.GoodsCstrtSetService;
import biz.app.goods.service.GoodsOptGrpService;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: gs-apet-41-admin
* - 패키지명 	: admin.web.view.goods.controller
* - 파일명 	: GoodsCstrtController.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 구성 유형 컨트롤러 (단품, 옵션, 세트, 묶음 )
* </pre>
*/
@Slf4j
@Controller
public class GoodsCstrtController {

	@Autowired private GoodsCstrtPakService goodsCstrtPakService;

	@Autowired	private GoodsCstrtSetService goodsCstrtSetService;
	
	@Autowired	private GoodsOptGrpService goodsOptGrpService;

	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsController.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 그리드
	* </pre>
	*
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/goodsCstrtSetGrid.do", method = RequestMethod.POST)
	public GridResponse goodsCstrtSetGrid(Model model, GoodsCstrtSetSO so) {
		List<GoodsCstrtSetVO> list = goodsCstrtSetService.listGoodsCstrtSet(so.getGoodsId());
		return new GridResponse(list, so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsCstrtController.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 그리드
	* </pre>
	*
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/goodsCstrtPakGrid.do", method = RequestMethod.POST)
	public GridResponse goodsCstrtPakGrid(Model model, GoodsCstrtPakSO so) {
		List<GoodsCstrtPakVO> list = goodsCstrtPakService.listGoodsCstrtPak(so.getGoodsId());
		return new GridResponse(list, so);
	}
	
	// '대표상품'의 배송정책번호 조회. 대표상품 재고 없을경우, 다음 상품으로 조회함. 상품모두가 재고가 없을때는 0을 리턴
	@ResponseBody
	@RequestMapping(value = "/goods/getMainDlvrcPlcNo.do", method = RequestMethod.POST)
	public Map<String, String> getMainDlvrcPlcNo(String goodsId) {
		
		Map<String, String> result = new HashMap<>();
			
		int mainDlvrcPlcNo = goodsCstrtPakService.getMainDlvrcPlcNo(goodsId);
		
		result.put("mainDlvrcPlcNo", Integer.toString(mainDlvrcPlcNo));
		
		return result;
	}
	
	// 상품ID로 배송정책 코드 가져오기
	@ResponseBody
	@RequestMapping(value = "/goods/getDlvrcPlcNo.do", method = RequestMethod.POST)
	public Map<String, String> getDlvrcPlcNo(String goodsId) {
		
		Map<String, String> result = new HashMap<>();
			
		int mainDlvrcPlcNo = goodsCstrtPakService.getDlvrcPlcNo(goodsId);
		
		result.put("dlvrcPlcNo", Integer.toString(mainDlvrcPlcNo));
		
		return result;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명	: GoodsCstrtController.java
	 * - 작성일	: 2021. 1. 26.
	 * - 작성자 	: valfac
	 * - 설명 	: 옵션 묶음 상품 그리드
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsOptGrpGrid.do", method = RequestMethod.POST)
	public GridResponse goodsOptGrpGrid(Model model, GoodsCstrtPakSO so) {
		List<GoodsOptGrpVO> list = goodsOptGrpService.listGoodsOptGrp(so.getGoodsId());
		return new GridResponse(list, so);
	}
	
}
