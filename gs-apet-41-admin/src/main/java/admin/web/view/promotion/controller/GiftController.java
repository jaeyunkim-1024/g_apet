package admin.web.view.promotion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.promotion.model.PromotionBasePO;
import biz.app.promotion.model.PromotionBaseVO;
import biz.app.promotion.model.PromotionFreebieVO;
import biz.app.promotion.model.PromotionSO;
import biz.app.promotion.model.PromotionTargetVO;
import biz.app.promotion.service.PromotionService;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * 네이밍 룰
 * 업무명View		:	화면
 * 업무명Grid		:	그리드
 * 업무명Tree		:	트리
 * 업무명Insert		:	입력
 * 업무명Update		:	수정
 * 업무명Delete		:	삭제
 * 업무명Save		:	입력 / 수정
 * 업무명ViewPop		:	화면팝업
 */

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.promotion.controller
 * - 파일명		: GiftController.java
 * - 작성일		: 2016. 3. 18.
 * - 작성자		: valueFactory
 * - 설명		: 사은품 시작 페이지
 * </pre>
 */
@Controller
public class GiftController {

	/**
	 * 프로모션 서비스
	 */
	@Autowired
	private PromotionService promotionService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/promotion/giftListView.do")
	public String giftListView() {
		return "/promotion/giftListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/giftListGrid.do", method=RequestMethod.POST)
	public GridResponse giftListGrid(PromotionSO so) {
		List<PromotionBaseVO> list = promotionService.pagePromotionGift(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/giftView.do")
	public String giftView(Model model, PromotionSO so) {
		model.addAttribute("promotion", promotionService.getPromotionGift(so));
		return "/promotion/giftView";
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/giftInsert.do")
	public String giftInsert(Model model, PromotionBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		promotionService.insertPromotionGift(po);
		model.addAttribute("promotion", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/giftUpdate.do")
	public String giftUpdate(Model model, PromotionBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		promotionService.updatePromotionGift(po);
		model.addAttribute("promotion", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 상세 사은품 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionFreebieListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionFreebieListGrid(PromotionSO so) {
		List<PromotionFreebieVO> list = promotionService.listPromotionFreebie(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GiftController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 상세 적용대상 상품 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionTargetListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionTargetListGrid(PromotionSO so) {
		List<PromotionTargetVO> list = promotionService.listPromotionTarget(so);
		return new GridResponse(list, so);
	}

}