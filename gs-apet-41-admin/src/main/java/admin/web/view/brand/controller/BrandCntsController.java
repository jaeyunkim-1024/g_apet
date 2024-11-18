package admin.web.view.brand.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.brand.model.BrandCntsItemPO;
import biz.app.brand.model.BrandCntsItemSO;
import biz.app.brand.model.BrandCntsItemVO;
import biz.app.brand.model.BrandCntsPO;
import biz.app.brand.model.BrandCntsSO;
import biz.app.brand.model.BrandCntsVO;
import biz.app.brand.service.BrandCntsService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BrandCntsController {

	@Autowired
	private BrandCntsService brandCntsService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsListView.do")
	public String brandCntsListView() {
		return "/brand/brandCntsListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/brandCnts/brandCntsGrid.do", method=RequestMethod.POST)
	public GridResponse brandCntsGrid(BrandCntsSO so) {

		// 업체사용자일 때 업체번호를 항상 등록조건에 사용하도록.
		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(session.getCompNo());
		}

		List<BrandCntsVO> list = brandCntsService.pageBrandCnts(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 상세 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsView.do")
	public String brandCntsView(Model model, BrandCntsSO so) {
		if(so.getBndCntsNo() != null) {
			model.addAttribute("brandCnts", brandCntsService.pageBrandCnts(so).get(0));
		}

		return "/brand/brandCntsView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsInsert.do")
	public String brandCntsInsert(Model model, BrandCntsPO po) {
		brandCntsService.insertBrandCnts(po);
		model.addAttribute("brandCnts", po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsUpdate.do")
	public String brandCntsUpdate(Model model, BrandCntsPO po) {
		brandCntsService.updateBrandCnts(po);
		model.addAttribute("brandCnts", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsDelete.do")
	public String brandCntsDelete(Model model, BrandCntsPO po) {
		brandCntsService.deleteBrandCnts(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/brandCnts/brandCntsItemListGrid.do", method=RequestMethod.POST)
	public GridResponse brandCntsItemListGrid(BrandCntsItemSO so) {
		List<BrandCntsItemVO> list = brandCntsService.pageBrandCntsItem(so);
		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 추가 팝업
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsItemViewPop.do")
	public String displayCornerBrandCntsItemViewPop(Model model, BrandCntsItemSO so) {
		model.addAttribute("brandCnts", so);

		if(so.getItemNo() != null) {
			model.addAttribute("brandCntsItem", brandCntsService.pageBrandCntsItem(so));
		}

		return "/brand/brandCntsItemViewPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 등록/수정
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsItemSave.do")
	public String brandCntsItemSave(Model model, BrandCntsItemPO po) {
		brandCntsService.brandCntsItemSave(po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/brandCnts/brandCntsItemDelete.do")
	public String brandCntsItemDelete(Model model, BrandCntsItemSO so) {
		Long[] itemNos = so.getItemNos();
		int delCnt = 0;
		if(itemNos != null && itemNos.length > 0 ) {
			delCnt = brandCntsService.deleteBrandCntsItem(itemNos );
		}

		model.addAttribute("delCnt", delCnt );
		return View.jsonView();
	}
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	 * - 파일명		: BrandCntsController.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 검색 Layer
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/brandCnts/brandCntsSearchLayerView.do")
	public String brandCntsSearchLayerView (Model model, BrandCntsSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "Brand Contents Search");
			log.debug("==================================================");
		}

		return "/brand/brandCntsSearchLayerView";
	}
}
