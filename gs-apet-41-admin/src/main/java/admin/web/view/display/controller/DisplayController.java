package admin.web.view.display.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import admin.web.config.grid.GridResponse;
import admin.web.config.util.ServiceUtil;
import admin.web.config.view.View;
import biz.app.banner.model.BannerSO;
import biz.app.display.model.DispCornerItemTagMapSO;
import biz.app.display.model.DispCornerItemTagMapVO;
import biz.app.display.model.DisplayBannerSO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayBrandPO;
import biz.app.display.model.DisplayBrandSO;
import biz.app.display.model.DisplayBrandVO;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayClsfCornerPO;
import biz.app.display.model.DisplayClsfCornerSO;
import biz.app.display.model.DisplayClsfCornerVO;
import biz.app.display.model.DisplayCornerItemPO;
import biz.app.display.model.DisplayCornerItemSO;
import biz.app.display.model.DisplayCornerItemVO;
import biz.app.display.model.DisplayCornerPO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerVO;
import biz.app.display.model.DisplayGoodsPO;
import biz.app.display.model.DisplayGoodsSO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.display.model.DisplayPO;
import biz.app.display.model.DisplayTemplateSO;
import biz.app.display.model.DisplayTreeVO;
import biz.app.display.model.SeoInfoPO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsBulkUploadSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;
import framework.common.util.ExcelUtil;
import framework.common.util.StringUtil;
import framework.common.util.excel.ExcelData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.ObjectUtils;

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

@Slf4j
@Controller
public class DisplayController {

	@Autowired
	private DisplayService displayService;

	@Autowired
	private SeoService seoService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private StService stService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시목록 검색 Layer
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displaySearchLayerView.do")
	public String displaySearchLayerView(Model model) {
		return "/display/displaySearchLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품평) 검색 Layer
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayGoodsCommentSearchLayerView.do")
	public String displayGoodsCommentSearchLayerView(Model model) {
		return "/display/displayGoodsCommentSearchLayerView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 관리 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayView.do")
	public String displayView(Model model) {
		// 쇼룸 카테고리 리스트
		model.addAttribute("listShowRoom", displayService.listDisplayShowRoomCategory());

		return "/display/displayView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 관리 트리 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayListTree.do", method=RequestMethod.POST)
	public List<DisplayTreeVO> displayListTree(DisplayCategorySO so) {
		List<DisplayTreeVO> list = new ArrayList<>();
		List<CodeDetailVO> codeList = displayService.getDistinctDispClsfCds(so.getStId()); // 해당 사이트에서 사용 중으로 마킹된 전시 분류 코드 모두 가져옴. (udf2 필드에 ,로 구분)
		List<String> validCdList = new ArrayList<>();
		
		for(CodeDetailVO code : codeList) {
			DisplayTreeVO vo = new DisplayTreeVO();
			vo.setId(code.getDtlCd());
			vo.setText(code.getDtlNm());
			vo.setParent("#");
			vo.setDispLvl(0L);
			vo.setDispClsfCd(code.getDtlCd());

			list.add(vo);
			validCdList.add(code.getDtlCd());
		}
		
		String[] arrDispClsfCd = validCdList.toArray(new String[validCdList.size()]);
		so.setArrDispClsfCd(arrDispClsfCd);
		list.addAll(displayService.listDisplayTree(so));
		return list;
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayBaseView.do")
	public String displayBaseView(Model model, @ModelAttribute("displayResult") DisplayCategorySO displayCategorySO, DisplayTemplateSO dispTemplateSO) {
		// 템플릿 리스트
		model.addAttribute("dispTemplateList", displayService.listDisplayTemplate(dispTemplateSO));
		// 기본정보
		model.addAttribute("displayBase", displayService.getDisplayBase(displayCategorySO));

		if (displayCategorySO.getDispLvl() > 1) {
			// 카테고리 필터
			model.addAttribute("categoryFilters", displayService.getCategoryFilters(displayCategorySO));
		}

		return "/display/displayBaseView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 등록 및 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping(value="/display/displayBaseSave.do", method = RequestMethod.POST)
	public String displayBaseSave(Model model, DisplayCategoryPO po) {
		displayService.saveDisplayBase(po);
		return View.jsonView();
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/display/displayBaseDelete.do")
	public String displayBaseDelete(Model model, DisplayCategoryPO po) {
		displayService.deleteDisplayBase(po);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayCornerListView.do")
	public String displayCornerListView(Model model) {
		return "/display/displayCornerListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerListGrid(DisplayCornerSO so) {
		if(!StringUtil.isEmpty(so.getDispCornNoArea())) {
			so.setDispCornNos(StringUtil.splitEnter(so.getDispCornNoArea()) );
		}
		if(!StringUtil.isEmpty(so.getDispCornNmArea())) {
			so.setDispCornNms(StringUtil.splitEnter(so.getDispCornNmArea()) );
		}

		List<DisplayCornerVO> list = displayService.listDisplayCornerGrid(so);

		return new GridResponse(list, so);
	}

	@RequestMapping(value="/display/displayCornerListSave.do", method = RequestMethod.POST)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String displayCornerListSave(Model model, DisplayCornerPO displayCornerPO, 
			@RequestParam(value = "dispCornerListPO", required = false) String dispCornerListStr) {
		
		JsonUtil jsonUt = new JsonUtil();
		
		List<DisplayCornerPO> list = null;
		if(!StringUtil.isEmpty(dispCornerListStr)) {
			list = jsonUt.toArray(DisplayCornerPO.class, dispCornerListStr);
			displayCornerPO.setDisplayCornerPOlist(list);
		}
		
		displayService.saveDisplayCorner(displayCornerPO);
		
		return View.jsonView();
	}
	

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 추가/수정 팝업
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayCornerViewPop.do")
	public String displayCornerViewPop(Model model, @ModelAttribute("displayCornerResult") DisplayCornerPO po, DisplayCornerSO so) {
		model.addAttribute("displayCorner",  displayService.listDisplayCornerGrid(so));
		
		if(CommonConstants.DISP_CORN_TP_130.equals(so.getDispCornTpCd()) ||
		   CommonConstants.DISP_CORN_TP_131.equals(so.getDispCornTpCd()) ||
		   CommonConstants.DISP_CORN_TP_132.equals(so.getDispCornTpCd()) ||
		   CommonConstants.DISP_CORN_TP_133.equals(so.getDispCornTpCd())) {
			DisplayClsfCornerSO dccSo = new DisplayClsfCornerSO();
			dccSo.setDispClsfNo(so.getDispClsfNo());
			dccSo.setDispCornNo(so.getDispCornNo());
			dccSo.setPreviewDt(DateUtil.getNowDate());
			
			List<DisplayClsfCornerVO> list = displayService.listDisplayClsfCornerGrid(dccSo);
			if(list.size() > 0 ) {
				model.addAttribute("displayClsfCorner", list);
			}
		}
		return "/display/displayCornerViewPop";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 등록 및 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/display/displayCornerSave.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String displayCornerSave(Model model, DisplayCornerPO po, 
			@RequestParam(value = "dispCornerListPO", required = false) String dispCornerListStr) {
		
		JsonUtil jsonUt = new JsonUtil();
		
		List<DisplayCornerPO> list = null;
		if(!StringUtil.isEmpty(dispCornerListStr)) {
			list = jsonUt.toArray(DisplayCornerPO.class, dispCornerListStr);
			po.setDisplayCornerPOlist(list);
		}
		
		displayService.saveDisplayCorner(po);
		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021.06.09
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너, 전시분류 코너 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/display/displayCornerAndDisplayClsfCornSave.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String displayCornerAndDisplayClsfCornSave(Model model, DisplayCornerPO po) {
		displayService.SaveDisplayCornerAndDisplayClsfCorner(po);
		return View.jsonView();
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 삭제
	 * </pre>
	 * @param model
	 * @param displayCornerItemListStr
	 * @return
	 */
	@RequestMapping("/display/displayCornerDelete.do")
	public String displayCornerDelete(Model model, DisplayCornerPO po) {
		displayService.deleteDisplayCorner(po);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayCornerItemListView.do")
	public String displayCornerItemListView(Model model, @ModelAttribute("displayCornerItemResult") DisplayCornerItemPO po) {
		return "/display/displayCornerItemListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerGoodsListGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerGoodsGrid(so);
		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품평)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerGoodsEstmListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerGoodsEstmListGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerGoodsEstmGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 화면 및 리스트(배너 HTML)
	 * </pre>
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayCornerBnrHtmlView.do")
	public String displayCornerBnrHtmlView(Model model, @ModelAttribute("displayCornerItemResult") DisplayCornerItemPO po, DisplayCornerItemSO so) {
		model.addAttribute("displayCornerBnrItem", displayService.listDisplayCornerBnrItemGrid(so));

		return "/display/displayCornerBnrHtmlView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템(배너 이미지 / 배너 복합) 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/display/displayCornerBnrItemView.do")
	public String displayCornerBnrItemView(Model model, @ModelAttribute("displayCornerItemResult") DisplayCornerItemPO po) {
		return "/display/displayCornerBnrItemView";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템(영상 + 배너) 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/display/displayCornerVdBnrItemView.do")
	public String displayCornerVdBnrItemView(Model model, @ModelAttribute("displayCornerItemResult") DisplayCornerItemPO po) {
		return "/display/displayCornerVdBnrItemView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(영상 + 배너)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerVdBnrListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerVdBnrListGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerBnrVdBnrGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(영상 + 배너)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerBannerListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerBannerListGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerBannerGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템(배너) 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/display/displayCornerBannerItemView.do")
	public String displayCornerBnnerItemView(Model model, @ModelAttribute("displayCornerItemResult") DisplayCornerItemPO po) {
		return "/display/displayCornerBannerItemView";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(배너 TEXT / 배너 이미지 / 배너 복합)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerBnrItemListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerBnrItemListGrid(DisplayCornerItemSO so) {
		List<DisplayBannerVO> list = displayService.listDisplayCornerBnrItemGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시코너 아이템 추가 팝업(배너 이미지 / 배너 복합 / 배너 이미지 큐브 / 10 동영상)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayCornerItemViewPop.do")
	public String displayCornerItemViewPop(Model model, DisplayCornerItemSO so) {
		model.addAttribute("displayCornerItem", so);

		if(so.getDispBnrNo() != null) {
			model.addAttribute("displayCornerBnrItem", displayService.listDisplayCornerBnrItemGrid(so));
		}

		return "/display/displayCornerBnrItemViewPop";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2017. 1. 25.
	 * - 작성자		: hongjun
	 * - 설명		: 전시코너 아이템 추가 팝업(브랜드 콘텐츠)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayCornerBrandCntsItemViewPop.do")
	public String displayCornerBrandCntsItemViewPop(Model model, DisplayCornerItemSO so) {
		model.addAttribute("displayCornerItem", so);

		if(so.getDispBnrNo() != null) {
			model.addAttribute("displayCornerBnrItem", displayService.listDisplayCornerBnrItemGrid(so));
		}

		return "/display/displayCornerBrandCntsItemViewPop";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayCornerItemDelete.do")
	public String displayCornerItemDelete(Model model, @RequestParam("displayCornerItemPOList") String displayCornerItemListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayCornerItemListStr)) {
			List<DisplayCornerItemPO> displayCornerItemPOList = jsonUt.toArray(DisplayCornerItemPO.class, displayCornerItemListStr);
			displayPO.setDisplayCornerItemPOList(displayCornerItemPOList );
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.deleteDisplayCornerItem(displayPO);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 저장
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/display/displayCornerItemSave.do", method = RequestMethod.POST)
	public String displayCornerItemSave(Model model,
			@RequestParam(value="displayCornerItemPOList", required=false) String displayCornerItemListStr, 
			DisplayCornerItemPO displayCornerItemPO, String[] tagNos) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		// 전시 코너 아이템(팝업 - 배너 TEXT / 배너 HTML / 배너 이미지 / 배너 복합 / 배너 이미지 큐브 / 10초 동영상 / 브랜드 콘텐츠 / 메뉴 리스트)
		if(CommonConstants.DISP_CORN_TP_10.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_20.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_30.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_72.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_73.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_75.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_130.equals(displayCornerItemPO.getDispCornTpCd())
			|| CommonConstants.DISP_CORN_TP_131.equals(displayCornerItemPO.getDispCornTpCd())
			//|| CommonConstants.DISP_CORN_TP_40.equals(displayCornerItemPO.getDispCornTpCd())
			) {
			displayService.saveDisplayCornerItem(displayPO, displayCornerItemPO, tagNos);
		} else {
			if(StringUtil.isNotEmpty(displayCornerItemListStr)) {
				List<DisplayCornerItemPO> displayCornerItemPOList = jsonUt.toArray(DisplayCornerItemPO.class, displayCornerItemListStr);
				displayPO.setDisplayCornerItemPOList(displayCornerItemPOList);
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			// 전시 코너 아이템(리스트(그리드) - 상품 / 상품평 / 배너 TEXT)
			displayService.saveDisplayCornerItem(displayPO, displayCornerItemPO, tagNos);
		}

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayGoodsListView.do")
	public String displayGoodsListView(Model model, @ModelAttribute("displayGoodsResult") DisplayGoodsPO po) {
		return "/display/displayGoodsListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse displayGoodsListGrid(DisplayGoodsSO so) {

		List<DisplayGoodsVO> list = displayService.listDisplayGoodsGrid(so);
		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayShowRoomGoodsListView.do")
	public String displayShowRoomGoodsListView(Model model, @ModelAttribute("displayGoodsResult") DisplayGoodsPO po) {
		return "/display/displayShowRoomGoodsListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayShowRoomGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse displayShowRoomGoodsListGrid(DisplayGoodsSO so) {
		List<DisplayGoodsVO> list = displayService.listDisplayShowRoomGoodsGrid(so);
		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 삭제
	 * </pre>
	 * @param model
	 * @param displayGoodsPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayGoodsDelete.do")
	public String displayGoodsDelete(Model model, @RequestParam("displayGoodsPOList") String displayGoodsPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayGoodsPOListStr)) {
			List<DisplayGoodsPO> displayGoodsPOList = jsonUt.toArray(DisplayGoodsPO.class, displayGoodsPOListStr);
			displayPO.setDisplayGoodsPOList(displayGoodsPOList );
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.deleteDisplayGoods(displayPO);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 삭제
	 * </pre>
	 * @param model
	 * @param displayGoodsPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayShowRoomGoodsDelete.do")
	public String displayShowRoomGoodsDelete(Model model, @RequestParam("displayGoodsPOList") String displayGoodsPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayGoodsPOListStr)) {

			List<DisplayGoodsPO> displayGoodsPOList = jsonUt.toArray(DisplayGoodsPO.class, displayGoodsPOListStr);

			displayPO.setDisplayGoodsPOList(displayGoodsPOList );
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.deleteDisplayShowRoomGoods(displayPO);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 저장
	 * </pre>
	 * @param model
	 * @param displayGoodsPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayGoodsSave.do")
	public String displayGoodsSave(Model model, @RequestParam("displayGoodsPOList") String displayGoodsPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayGoodsPOListStr)) {
			List<DisplayGoodsPO> displayGoodsPOList = jsonUt.toArray(DisplayGoodsPO.class, displayGoodsPOListStr);
			displayPO.setDisplayGoodsPOList(displayGoodsPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.saveDisplayGoods(displayPO);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 추가
	 * </pre>
	 * @param model
	 * @param displayGoodsStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayGoodsInsert.do")
	public String displayGoodsInsert(Model model, @RequestParam("displayGoodsStr") String displayGoodsStr) {
		JsonUtil jsonUt = new JsonUtil();

		if(StringUtil.isNotEmpty(displayGoodsStr)) {
			List<DisplayGoodsPO> displayGoodsPOList = jsonUt.toArray(DisplayGoodsPO.class, displayGoodsStr);
			displayService.insertDisplayGoods(displayGoodsPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 추가
	 * </pre>
	 * @param model
	 * @param displayGoodsStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayShowRoomGoodsInsert.do")
	public String displayShowRoomGoodsInsert(Model model, @RequestParam("displayGoodsStr") String displayGoodsStr) {
		JsonUtil jsonUt = new JsonUtil();

		if(StringUtil.isNotEmpty(displayGoodsStr)) {

			List<DisplayGoodsPO> displayGoodsPOList = jsonUt.toArray(DisplayGoodsPO.class, displayGoodsStr);

			displayService.insertDisplayShowRoomGoods(displayGoodsPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}



		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/display/displayBrandListView.do")
	public String displayBrandListView(Model model, @ModelAttribute("displayBrandResult") DisplayBrandPO po) {
		return "/display/displayBrandListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayBrandListGrid.do", method=RequestMethod.POST)
	public GridResponse displayBrandListGrid(DisplayBrandSO so) {
		List<DisplayBrandVO> list = displayService.listDisplayBrandGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 추가
	 * </pre>
	 * @param model
	 * @param displayBrandPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayBrandInsert.do")
	public String displayBrandInsert(Model model, @RequestParam("displayBrandPOList") String displayBrandPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayBrandPOListStr)) {
			List<DisplayBrandPO> displayBrandPOList = jsonUt.toArray(DisplayBrandPO.class, displayBrandPOListStr);
			displayPO.setDisplayBrandPOList(displayBrandPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.insertDisplayBrand(displayPO);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 저장
	 * </pre>
	 * @param model
	 * @param displayBrandPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayBrandSave.do")
	public String displayBrandSave(Model model, @RequestParam("displayBrandPOList") String displayBrandPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayBrandPOListStr)) {
			List<DisplayBrandPO> displayBrandPOList = jsonUt.toArray(DisplayBrandPO.class, displayBrandPOListStr);
			displayPO.setDisplayBrandPOList(displayBrandPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.saveDisplayBrand(displayPO);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 삭제
	 * </pre>
	 * @param model
	 * @param displayGoodsPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayBrandDelete.do")
	public String displayBrandDelete(Model model, @RequestParam("displayBrandPOList") String displayBrandPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(displayBrandPOListStr)) {
			List<DisplayBrandPO> displayBrandPOList = jsonUt.toArray(DisplayBrandPO.class, displayBrandPOListStr);
			displayPO.setDisplayBrandPOList(displayBrandPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.deleteDisplayBrand(displayPO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 6. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 일괄등록 템플릿 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayGoodsTemplateDownload.do")
	public String displayGoodsTemplateDownload(Model model) {
		log.info( "==============================================" );
		log.info( "기획전 상품 일괄등록 템플릿 다운로드" );
		log.info( "==============================================" );

		String[] headerName = null;
		String[] fieldName = null;
		String sheetName = null;
		String fileName = null;

		sheetName = "DisplayGoodsBulkUpload";
		fileName = sheetName;

		headerName = new String[] {
			messageSourceAccessor.getMessage("column.disp_clsf_no" )
			, messageSourceAccessor.getMessage("column.display_view.disp_prior_rank" )
			, messageSourceAccessor.getMessage("column.goods_id" )
//			, messageSourceAccessor.getMessage("column.display_view.goods_nm" )
//			, messageSourceAccessor.getMessage("column.display_view.sr_disp_clsf_gb" )
//			, messageSourceAccessor.getMessage("column.dlgt_disp_yn" )
//			, messageSourceAccessor.getMessage("column.goods_stat_cd" )
//			, messageSourceAccessor.getMessage("column.goods_tp_cd" )
//			, messageSourceAccessor.getMessage("column.sale_prc" )
//			, messageSourceAccessor.getMessage("column.goods.comp_nm" )
//			, messageSourceAccessor.getMessage("column.bnd_nm" )
//			, messageSourceAccessor.getMessage("column.mmft" )
//			, messageSourceAccessor.getMessage("column.show_yn" )
//			, messageSourceAccessor.getMessage("column.display_view.disp_strtdt" )
//			, messageSourceAccessor.getMessage("column.display_view.disp_enddt" )
		};

		fieldName = new String[] {
			"dispClsfNo"		// 전시분류번호
			, "dispPriorRank"	// 우선순위
			, "goodsId"			// 상품아이디
//			, "goodsNm"
//			, "showRoomGb"
//			, "dlgtDispYn"
//			, "goodsStatCd"
//			, "goodsTpCd"
//			, "saleAmt"
//			, "compNm"
//			, "bndNmKo"
//			, "bomNm"
//			, "mmft"
//			, "showYn"
//			, "saleStrtDtm"
//			, "saleEndDtm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(sheetName, headerName, fieldName, null) );
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, fileName );

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 6. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 일괄 업로드 팝업
	 * </pre>
	 * @param model
	 * @param po
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayGoodsUploadPop.do")
	public String displayGoodsUploadPop(Model model, DisplayGoodsSO so) {
		model.addAttribute("displayGoods", so);

		return "/display/displayGoodsUploadPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 6. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 업로드 그리드 리스트
	 * </pre>
	 * @param model
	 * @param so
	 * @param filePath
	 * @param fileName
	 * @param colNames
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/display/displayGoodsUploadGrid.do", method=RequestMethod.POST)
	public GridResponse displayGoodsUploadGrid (Model model, DisplayGoodsSO so, @RequestParam("filePath") String filePath, @RequestParam("fileName") String fileName, @RequestParam("colName") String[] colNames) {
		log.info( "==============================================" );
		log.info( "기획전 상품 업로드 그리드 리스트" );
		log.info( "==============================================" );

		// 가지고온 Grid의 헤더와 엑셀을 맵핑
		// 그리드 순서와 엑셀순서
		String[][] headerMap = null;
		ExcelData excelData = new ExcelData(null, null);

		if(StringUtil.isNotEmpty(filePath)) {
			// 파싱할 Excel File
			File excelFile = new File(filePath);

			if(colNames != null && colNames.length > 0) {
				headerMap = new String[colNames.length][2];

				for(int i = 0; i < colNames.length; i++) {
					headerMap[i][0] = String.valueOf(i + 1);
					headerMap[i][1] = colNames[i];
				}
			}

			// 상품 업로드
			try {
				excelData = ExcelUtil.parse(excelFile, DisplayGoodsPO.class, headerMap);
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}

			List<DisplayGoodsPO> dipslayGoodsUploadPOList = excelData.getData();
			if(CollectionUtils.isNotEmpty(dipslayGoodsUploadPOList)) {
				// 기획전 상품 엑셀 데이터 유효성 검사
				dipslayGoodsUploadPOList = displayService.validateBulkUpladGoods(dipslayGoodsUploadPOList);
				excelData.setData(dipslayGoodsUploadPOList);
			}

			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("Fail to delete of file. DisplayController.displayGoodsUploadGrid::excelFile.delete {}");
			}
		}

		return new GridResponse(excelData.getData(), so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 6. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 일괄업로드
	 * </pre>
	 * @param model
	 * @param dipslayGoodsUploadPOListStr
	 * @return
	 */
	@RequestMapping(value="/display/displayGoodsUpload.do")
	@SuppressWarnings({"rawtypes", "unchecked"})
	public String displayGoodsUpload(Model model , GoodsBulkUploadSO so, @RequestParam("dipslayGoodsUploadPOList") String dipslayGoodsUploadPOListStr ) {
		log.info( "==============================================" );
		log.info( "기획전 상품 일괄등록" );
		log.info( "==============================================" );

		JsonUtil jsonUt = new JsonUtil();
		DisplayPO displayPO = new DisplayPO();

		if(StringUtil.isNotEmpty(dipslayGoodsUploadPOListStr)) {
			List<DisplayGoodsPO> dipslayGoodsUploadPOList = jsonUt.toArray(DisplayGoodsPO.class, dipslayGoodsUploadPOListStr);
			displayPO.setDipslayGoodsUploadPOList(dipslayGoodsUploadPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.displayGoodsUpload(displayPO);

		return View.jsonView();
	}

	/*
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: DisplayController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hjko
	* - 설명		: 상품상세에서 전시 카테고리 추가시 레이어 팝업
	* </pre>
	* @param so
	* @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayListTreeFilter.do", method=RequestMethod.POST)
	public List<DisplayTreeVO> displayListTreeFilter(DisplayCategorySO so) {

		// 사이트별 전시카테고리 트리  몽땅 가져오기. (filterGb가 G가 아닌 경우)
		List<DisplayTreeVO> resultlist10 = new ArrayList<>();
		log.debug("so >>"+so);
		//팝업에서 레이어 띄울때
		if(so.getArrDispClsfCd() != null){
			so.setDispClsfCd(null);
		}

		// 전시카테고리, 업체카테고리 트리 (filterGb가 G인 경우)
		List<DisplayTreeVO> resultlist60 = new ArrayList<>();

		if( (so.getFilterGb() == null ) && (so.getFilterGb() != "G")){
			resultlist10 = this.displayService.listDisplayTree(so);
		}else{
			List<DisplayCategoryVO> resultlist = this.displayService.displayListTreeFilter(so);
			log.debug("resultlist ====>"+resultlist);

			for(DisplayCategoryVO cate : resultlist){
				DisplayTreeVO vos = new DisplayTreeVO();
				vos.setId(cate.getDispClsfNo().toString());
				vos.setDispClsfCd(cate.getDispClsfCd());
				vos.setDispLvl(cate.getDispLvl());
				vos.setText(cate.getDispClsfNm());
				vos.setParent(cate.getUpDispClsfNo().toString());
				vos.setDispPath(cate.getDispClsfNm());
				vos.setStId(cate.getStId().toString());
				vos.setStNm(cate.getStNm());
				vos.setCompNo(cate.getCompNo().toString());

				resultlist60.add(vos);
			}
		}

		List<CodeDetailVO> codeList = ServiceUtil.listCode(AdminConstants.DISP_CLSF);

		List<DisplayTreeVO> list = new ArrayList<>();


		// 전시 목록 트리 셋팅
		if(CollectionUtils.isNotEmpty(codeList)) {
			for(CodeDetailVO code : codeList) {
				if(so.getArrDispClsfCd() != null && so.getArrDispClsfCd().length > 0) {
					for(String dispClsfCd : so.getArrDispClsfCd()) {
						if(dispClsfCd.equals(code.getDtlCd())){
							DisplayTreeVO vo = new DisplayTreeVO();
							vo.setId(code.getDtlCd());
							vo.setText(code.getDtlNm());
							vo.setParent("#");
							vo.setDispLvl(0L);
							vo.setDispClsfCd(code.getDtlCd());
							if (so.getStId() != null) {
								vo.setStId(so.getStId().toString());
							}
							if (so.getCompNo() != null) {
								vo.setCompNo(so.getCompNo().toString());
							}
							list.add(vo);
						}
					}
				}else if(StringUtil.isNotBlank(so.getDispClsfCd()) && so.getDispClsfCd().equals(code.getDtlCd())){
					// 해당되는 전시목록 가져오기(전시카테고리, 기획전, 비정형페이지, 쇼륨)
					DisplayTreeVO vo = new DisplayTreeVO();
					vo.setId(code.getDtlCd());
					vo.setText(code.getDtlNm());
					vo.setParent("#");
					vo.setDispLvl(0L);
					vo.setDispClsfCd(code.getDtlCd());
					if (so.getStId() != null) {
						vo.setStId(so.getStId().toString());
					}
					if (so.getCompNo() != null) {
						vo.setCompNo(so.getCompNo().toString());
					}

					list.add(vo);
				}
			}
		}

		if( (so.getFilterGb() == null ) && (so.getFilterGb() != "G")){
			list.addAll(resultlist10);
		}else{
			list.addAll(resultlist60);
		}
		log.debug("=================================================");
		log.debug(" == 상품에서 카테고리 추가 가능한 목록 list", list);
		log.debug("list >>>"+list);
		log.debug("=================================================");
		return list;

	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2017. 1. 23
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayClsfCornerListView.do")
	public String displayClsfCornerListView(Model model, @ModelAttribute("displayClsfCornerResult") DisplayClsfCornerPO po) {
		return "/display/displayClsfCornerListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2017. 1. 23
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayClsfCornerGrid.do", method=RequestMethod.POST)
	public GridResponse displayClsfCornerGrid(DisplayClsfCornerSO so) {
		List<DisplayClsfCornerVO> list = displayService.listDisplayClsfCornerGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2017. 1. 23
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 추가 팝업
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayClsfCornerViewPop.do")
	public String displayClsfCornerViewPop(Model model, DisplayClsfCornerSO so) {
		model.addAttribute("displayClsfCorner", so);

		if(so.getDispClsfCornNo() != null) {
			model.addAttribute("displayClsfCornerList", displayService.listDisplayClsfCornerGrid(so));
		}

		return "/display/displayClsfCornerViewPop";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2017. 1. 23
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 등록 및 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/display/displayClsfCornerSave.do")
	public String displayClsfCornerSave(Model model, DisplayClsfCornerPO po) {
		displayService.saveDisplayClsfCorner(po);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2017. 1. 24
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/display/displayClsfCornerDelete.do")
	public String displayClsfCornerDelete(Model model, @RequestParam("displayClsfCornerPOList") String displayClsfCornerListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DisplayPO po = new DisplayPO();

		if(StringUtil.isNotEmpty(displayClsfCornerListStr)) {
			List<DisplayClsfCornerPO> displayClsfCornerPOList = jsonUt.toArray(DisplayClsfCornerPO.class, displayClsfCornerListStr);
			po.setDisplayClsfCornerPOList(displayClsfCornerPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		displayService.deleteDisplayClsfCorner(po);

		return View.jsonView();
	}

	/*
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: DisplayController.java
	* - 작성일		: 2017. 5. 24.
	* - 작성자		: hongjun
	* - 설명		: 카테고리 목록리스팅
	* </pre>
	* @param so
	* @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/listDisplayCategory.do", method=RequestMethod.POST)
	public List<DisplayCategoryVO> listDisplayCategory(DisplayCategorySO so) {
		return displayService.listDisplayCategory(so);
	}

	@RequestMapping(value="/display/seoInfoPop.do")
	public String popupSeoInfo(SeoInfoSO so, Model model, @RequestParam(value="seoExhibiCd",required=false) String seoExhibiCd) {
		SeoInfoVO vo = new SeoInfoVO();
		vo.setDispClsfNo(so.getDispClsfNo());
		vo.setDispClsfCd(so.getDispClsfCd());
		
		model.addAttribute("seoParam", so);
		
		if (!ObjectUtils.isEmpty(so) && so.getSeoInfoNo() != null) {
			vo = seoService.getSeoInfo(so);
		}
		model.addAttribute("seoInfo", vo);
		model.addAttribute("seoExhibiCd", seoExhibiCd);
		return "/display/popupSeoInfoView";
	}

	@RequestMapping(value="/display/saveSeoInfo.do", method=RequestMethod.POST)
	public String saveSeoInfo(Model model, SeoInfoPO po) {
		if (ObjectUtils.isEmpty(po)) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		seoService.saveSeoInfo(po);
		model.addAttribute("seoInfoNo", po.getSeoInfoNo());

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2020. 12. 23.
	 * - 작성자		: CJA
	 * - 설명			: 펫로그 배너 등록/수정 팝업
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/petlog/petTvContentViewPop.do", method = RequestMethod.POST)
	public String petLogContentViewPop(BannerSO so) {

		return "/contents/petTvContentViewPop";
	}
	
	// cja
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템(영상)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerVdListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerVdListGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerVdGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템(영상) 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/display/displayCornerVdItemView.do")
	public String displayCornerVdItemView(Model model, @ModelAttribute("displayCornerItemResult") DisplayCornerItemPO po) {
		return "/display/displayCornerVdItemView";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(시리즈 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerSeriesListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerSeriesListGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerSeriesGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(배너 이미지/영상/태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/listDisplayCornerBnrVodTagGrid.do", method=RequestMethod.POST)
	public GridResponse listDisplayCornerBnrVodTagGrid(DisplayCornerItemSO so) {
		List<DisplayBannerVO> list = displayService.listDisplayCornerBnrVodTagGrid(so);
		
		DisplayCornerItemSO dso = new DisplayCornerItemSO();
		
		for(int i = 0; i < list.size(); i++) {
			
			dso.setDispBnrNo(list.get(i).getDispBnrNo());
			
			List<DisplayCornerItemVO> tagList =  displayService.getTagList(dso);
			list.get(i).setTagList(tagList);
		}
		
		return new GridResponse(list, so);
	}
	
	
	/**
	 * <pre>
	 * - Method 명	: bannerSearchLayerView
	 * - 작성일		: 2020. 12. 22
	 * - 작성자		: CJA
	 * - 설 명		: 시리즈 조회 팝업
	 * </pre>
	 *
	 * @param  model
	 * @param  so
	 * @return
	 */
	@RequestMapping(value="/display/seriesSearchLayerView.do", method = RequestMethod.POST)
	public String seriesSearchLayerView(Model model, DisplayCornerItemSO so) {
		if(so.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_132)) {
					model.addAttribute("so", so);
		}
		return "/display/seriesSearchLayerView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2020. 12. 23.
	 * - 작성자		: CJA
	 * - 설명			: 배너 이미지/영상/태그 팝업
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/dispaly/dispBnrVodTagViewPop.do", method = RequestMethod.POST)
	public String dispBnrVodTagViewPop(Model model, DisplayCornerItemSO so) {
		model.addAttribute("so", so);
		if(so.getDispCnrItemNo() != null && so.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_71) ||
		   so.getDispCnrItemNo() != null && so.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_133)) {
			model.addAttribute("listDisplayCornerVdGrid", displayService.listDisplayCornerVdGrid(so));
		} else if(so.getDispCnrItemNo() != null && so.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_75)) {
			model.addAttribute("listDisplayCornerBannerGrid", displayService.listDisplayCornerBannerGrid(so));
		} else if(so.getDispCnrItemNo() != null && so.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_72)) {
			DisplayCornerItemSO dso = new DisplayCornerItemSO();
			
			List<DisplayBannerVO> list = displayService.listDisplayCornerBnrVodTagGrid(so);
			
				dso.setDispBnrNo(list.get(0).getDispBnrNo());
				
				List<DisplayCornerItemVO> tagList =  displayService.getTagList(dso);
				
			
				model.addAttribute("tagList", tagList);
			model.addAttribute("listDisplayCornerBnrVodTagGrid", list);
		}
		
		return "/display/displayCornerBnrVodTagLayerView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2020. 12. 23.
	 * - 작성자		: CJA
	 * - 설명			: 미리보기
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/display/previewPage.do", method = RequestMethod.POST)
	public String previewPage(Model model) {
		
		return "/display/displayPreview";
	}
	
	/**
	 * <pre>
	 * - Method 명	: cerificationEventPreView
	 * - 작성일		: 2020. 10. 6.
	 * - 작성자		: Administrator
	 * - 설 명		: BO - 미리보기 
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/homePreView.do" , method=RequestMethod.GET)
	public ModelMap homePreView(Model model, DisplayClsfCornerSO so) {
		StStdInfoVO vo = stService.getStStdInfo(1L);
		ModelMap result = new ModelMap();
		String dispType = "";
		if(so.getDispClsfNo().toString().equals(bizConfig.getProperty("disp.clsf.no.pettv"))) {
			dispType = "tv";
		}else if(so.getDispClsfNo().toString().equals(bizConfig.getProperty("disp.clsf.no.petlog"))) {
			dispType = "log";
		}else {
			dispType = "shop";
			result.addAttribute("lnbDispClsfNo",so.getDispClsfNo());
		}
		String domain = AdminConstants.ENVIRONMENT_GB_LOCAL.equals(bizConfig.getProperty("envmt.gb")) ? vo.getStUrl().replace("https", "http") : vo.getStUrl();

        if(AdminConstants.ENVIRONMENT_GB_LOCAL.equals(bizConfig.getProperty("envmt.gb"))) {
        	domain = "http://localhost:8180/"+dispType+"/home";
        } else if(AdminConstants.ENVIRONMENT_GB_DEV.equals(bizConfig.getProperty("envmt.gb"))){
        	domain = "https://dev.aboutpet.co.kr/"+dispType+"/home";
        } else if(AdminConstants.ENVIRONMENT_GB_STG.equals(bizConfig.getProperty("envmt.gb"))){
        	domain = "https://stg.aboutpet.co.kr/"+dispType+"/home";
        } else {
        	domain = "https://aboutpet.co.kr/"+dispType+"/home";
        }
		result.addAttribute("domain",domain);
		result.addAttribute("previewDt",so.getPreviewDt());
		return result;
	}
	
	// cja
	
	// yjy
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerTagsListGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerTagsListGrid(DisplayCornerItemSO so) {
		List<DisplayBannerVO> list = displayService.listDisplayCornerTagsGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021. 1. 13. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(펫로그 회원)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerPetLogMemberGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerPetLogMemberGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerPetLogMemberGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: DisplayController.java
	 * - 작성일		: 2021. 1. 13. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(로그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayCornerLogsGrid.do", method=RequestMethod.POST)
	public GridResponse displayCornerLogsGrid(DisplayCornerItemSO so) {
		List<DisplayCornerItemVO> list = displayService.listDisplayCornerLogsGrid(so);
		return new GridResponse(list, so);
	}
	// yjy
}