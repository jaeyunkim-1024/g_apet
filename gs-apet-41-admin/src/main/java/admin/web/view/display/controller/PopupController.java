package admin.web.view.display.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.display.model.PopupPO;
import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupShowDispClsfPO;
import biz.app.display.model.PopupShowDispClsfVO;
import biz.app.display.model.PopupTargetPO;
import biz.app.display.model.PopupTargetVO;
import biz.app.display.model.PopupVO;
import biz.app.display.service.PopupService;
import framework.admin.util.JsonUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PopupController {

	@Autowired
	private PopupService popupService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PopupController.java
	* - 작성일		: 2016. 6. 24.
	* - 작성자		: eojo
	* - 설명		:
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/display/popupListView.do")
	public String popupListView(Model model){


		return "/display/popupListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PopupController.java
	* - 작성일		: 2016. 6. 24.
	* - 작성자		: eojo
	* - 설명		:
	* </pre>
	* @param model
	* @param popupSO
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/display/popupListGrid.do", method=RequestMethod.POST)
	public GridResponse popupListGrid(Model model, PopupSO so) {
		List<PopupVO> list = popupService.pagePopupList(so);
		return new GridResponse(list, so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PopupController.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 등록
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/display/popupInsertView.do")
	public String popupInsertView (Model model ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "POPUP 등록");
			log.debug("==================================================");
		}

		return "/display/popupInsertView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PopupController.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 등록
	* </pre>
	* @param model
	* @param goodsBaseStr
	* @param attributeStr
	* @return
	*/
	@RequestMapping(value = "/display/popupInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String popupInsert (Model model,
			@RequestParam("popupPO") String popupPOStr,
			@RequestParam(value = "popupShowDispClsfPO", required = false) String popupShowDispClsfPOStr,
			@RequestParam(value = "popupTargetPO", required = false) String popupTargetPOStrStr
			) {

		JsonUtil jsonUt = new JsonUtil();
		Integer popupNo = null;
 
		// 팝업 기본
		PopupPO popupPO = null;
		if(StringUtil.isNotEmpty(popupPOStr) ) {
			popupPO = (PopupPO) jsonUt.toBean(PopupPO.class, popupPOStr );
		}

		// 팝업 Display
		List<PopupShowDispClsfPO> popupShowDispClsfPOList = null;
		if(StringUtil.isNotEmpty(popupShowDispClsfPOStr) ) {
			popupShowDispClsfPOList = jsonUt.toArray(PopupShowDispClsfPO.class, popupShowDispClsfPOStr );
		}
		// 팝업 상품
		List<PopupTargetPO> popupTargetPOList = null;
		if(StringUtil.isNotEmpty(popupTargetPOStrStr) ) {
			popupTargetPOList = jsonUt.toArray(PopupTargetPO.class, popupTargetPOStrStr );
		}

		popupNo = popupService.insertPopup(popupPO, popupShowDispClsfPOList ,popupTargetPOList  );

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("POPUP 등록 : {}", popupNo);
			log.debug("==================================================");
		}

		model.addAttribute("popupNo", popupNo );

		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PopupController.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @return
	*/
	@RequestMapping(value = "/display/popupUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String popupUpdate (Model model,
			@RequestParam("popupPO") String popupPOStr,
			@RequestParam(value = "popupShowDispClsfPO", required = false) String popupShowDispClsfPOStr,
			@RequestParam(value = "popupTargetPO", required = false) String popupTargetPOStrStr   ) {

		JsonUtil jsonUt = new JsonUtil();
		Integer popupNo = null;

		// 팝업 기본
		PopupPO popupPO = null;
		if(StringUtil.isNotEmpty(popupPOStr) ) {
			popupPO = (PopupPO) jsonUt.toBean(PopupPO.class, popupPOStr );
		}
 
		// 팝업 Display
		List<PopupShowDispClsfPO> popupShowDispClsfPOList = null;
		if(StringUtil.isNotEmpty(popupShowDispClsfPOStr) ) {
			popupShowDispClsfPOList = jsonUt.toArray(PopupShowDispClsfPO.class, popupShowDispClsfPOStr );
		}
		// 팝업 상품 
		List<PopupTargetPO> popupTargetPOList = null;
		if(StringUtil.isNotEmpty(popupTargetPOStrStr) ) {
			popupTargetPOList = jsonUt.toArray(PopupTargetPO.class, popupTargetPOStrStr );
		}
		popupNo = popupService.updatePopup(popupPO, popupShowDispClsfPOList ,popupTargetPOList );

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("POPUP 수정 : {}", popupNo);
			log.debug("==================================================");
		}

		model.addAttribute("popupNo", popupNo );

		return View.jsonView();
	}


	@RequestMapping("/display/popupDetailView.do")
	public String popupDetailView (Model model, PopupSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		Long popupNo = null;
		popupNo = so.getPopupNo();

		PopupVO popupVO = popupService.getPopup(popupNo );

		model.addAttribute("popup", popupVO );
		return "/display/popupDetailView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PopupController.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 전시번호 조회
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/display/popupShowDispClsfGrid.do", method=RequestMethod.POST)
	public GridResponse popupShowDispClsfGrid (Model model, PopupSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		Long popupNo = so.getPopupNo();
		List<PopupShowDispClsfVO> list = popupService.listPopupShowDispClsf(popupNo );

		return new GridResponse(list, so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.display.controller
	* - 파일명      : PopupController.java
	* - 작성일      : 2017. 6. 5.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 팝업상품 그리드 
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/popup/popupGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse popupGoodsListGrid(PopupSO so) { 
		List<PopupTargetVO> list = popupService.listpopupGoods(so);
		return new GridResponse(list, so);
	}


}
