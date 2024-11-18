package admin.web.view.promotion.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.util.ServiceUtil;
import admin.web.config.view.View;
import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.promotion.model.DisplayPromotionTreeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.model.PromotionBasePO;
import biz.app.promotion.model.PromotionBaseVO;
import biz.app.promotion.model.PromotionSO;
import biz.app.promotion.model.PromotionTargetVO;
import biz.app.promotion.service.PromotionService;
import biz.app.system.model.CodeDetailVO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

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
 * - 파일명		: PromotionController.java
 * - 작성일		: 2016. 3. 10.
 * - 작성자		: 	sjkwon01
 * - 설명		: 쿠폰 리스트
 * </pre>
 */
@Slf4j
@Controller
public class PromotionController {

	/**
	 * 프로모션 서비스
	 */
	@Autowired
	private PromotionService promotionService;


	/**
	 * 가격할인 프로모션 목록화면
	 * @return
	 */
	@RequestMapping("/promotion/promotionListView.do")
	public String promotionListView() {
		return "/promotion/promotionListView";
	}


	/**
	 * 가격할인 프로모션 목록 그리드
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionListGrid(PromotionSO so) {
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		List<PromotionBaseVO> list = promotionService.pagePromotionBase(so);
		return new GridResponse(list, so);
	}

	/**
	 * 가격할인 프로모션 상세화면
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/promotionView.do")
	public String promotionView(Model model, PromotionSO so) {

		if(Objects.isNull(so.getPrmtNo())) {
			return promotionInsertView(model, so);
		}

		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		model.addAttribute("promotionBase", promotionService.getPromotionBase(so));

		return "/promotion/promotionView";
	}

	/**
	 * 가격할인 프로모션 등록 화면
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/promotionInsertView.do")
	public String promotionInsertView(Model model, PromotionSO so) {

		return "/promotion/promotionInsertView";
	}

	/**
	 * 가격할인 프로모션 등록
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/promotionInsert.do")
	public String promotionInsert(Model model, PromotionBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		promotionService.insertPromotion(po);
		model.addAttribute("promotionBase", po);

		return View.jsonView();
	}

	/**
	 * 가격할인프로모션 수정
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/promotionUpdate.do")
	public String promotionUpdate(Model model, PromotionBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		promotionService.updatePromotion(po);
		model.addAttribute("promotionBase", po);

		return View.jsonView();
	}
	/**
	 * 가격할인프로모션 삭제
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/promotionDelete.do")
	public String couponDelete(Model model, PromotionBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		promotionService.deletePromotion(po);
		return View.jsonView();
	}

	/**
	 * 가격할인 프로모션 트리
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionDisplayTree.do", method=RequestMethod.POST)
	public List<DisplayPromotionTreeVO> promotionDisplayTree(PromotionSO so) {
		List<DisplayPromotionTreeVO> result = new ArrayList<>();
		List<CodeDetailVO> codeList = ServiceUtil.listCode(AdminConstants.DISP_CLSF);

		// 전시 목록 셋팅
		String dispClsfCd = StringUtils.isNotEmpty(so.getDispClsfCd()) ? so.getDispClsfCd() : AdminConstants.DISP_CLSF_10;
		if(CollectionUtils.isNotEmpty(codeList)) {
			for(CodeDetailVO code : codeList) {
				if(dispClsfCd.equals(code.getDtlCd())) {
					DisplayPromotionTreeVO vo = new DisplayPromotionTreeVO();
					vo.setId(code.getDtlCd());
					vo.setText(code.getDtlNm());
					vo.setParent("#");
					result.add(vo);
				}
			}
		}

		result.addAll(promotionService.listPromotionDisplayTree(so) );

		return result;
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : PromotionController.java
	* - 작성일      : 2017. 2. 17.
	* - 작성자      : valuefctory 권성중
	* - 설명      :  가격할인  전시분류 리스트
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionShowDispClsfGrid.do", method=RequestMethod.POST)
	public GridResponse promotionShowDispClsfGrid (Model model, PromotionSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		Long prmtNo = so.getPrmtNo();
		List<DisplayPromotionTreeVO> list = promotionService.listPromotionShowDispClsf(prmtNo );

		return new GridResponse(list, so);
	}
	/**
	 * 가격할인 프로모션 상품 리스트
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionGoodsListGrid(PromotionSO so) {
		List<PromotionTargetVO> list = promotionService.listPromotionGoods(so);
		return new GridResponse(list, so);
	}
	/**
	 * 가격할인 프로모션 제외 상품 리스트
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/promotionGoodsExListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionGoodsExListGrid(PromotionSO so) {
		List<PromotionTargetVO> list = promotionService.listPromotionGoodsEx(so);

		return new GridResponse(list, so);
	}


	@ResponseBody
	@RequestMapping(value="/promotion/promotionTargetCompNoListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionTargetCompNoListGrid (Model model, PromotionSO so ) {
		List<CompanyBaseVO> list = promotionService.listPromotionTargetCompNo(so);
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/promotion/promotionTargetBndNoListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionTargetBndNoListGrid (Model model, PromotionSO so ) {
		List<BrandBaseVO> list = promotionService.listPromotionTargetBndNo(so);
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/promotion/promotionTargetExhbtNoListGrid.do", method=RequestMethod.POST)
	public GridResponse promotionTargetExhbtNoListGrid (Model model, PromotionSO so ) {
		List<ExhibitionVO> list = promotionService.listPromotionTargetExhbtNo(so);
		return new GridResponse(list, so);
	}



}