package admin.web.view.display.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.display.model.DisplayTemplatePO;
import biz.app.display.model.DisplayTemplateSO;
import biz.app.display.model.DisplayTemplateVO;
import biz.app.display.service.DisplayService;

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

@Controller
public class DisplayTemplateController {

	@Autowired
	private DisplayService displayService;

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayTemplateController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/display/displayTemplateListView.do")
	public String displayTemplateListView(Model model) {
		return "/display/displayTemplateListView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayTemplateController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/display/displayTemplateListGrid.do", method=RequestMethod.POST)
	public GridResponse displayTemplateListGrid(DisplayTemplateSO so) {
		List<DisplayTemplateVO> list = displayService.listDisplayTemplateGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayTemplateController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/display/displayTemplateDetailView.do")
	public String displayTemplateDetailView(Model model, DisplayTemplateSO so) {
		model.addAttribute("displayTemplate", displayService.getDisplayTemplateDetail(so));

		return "/display/displayTemplateDetailView";
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayTemplateController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/display/displayTemplateInsert.do")
	public String displayTemplateInsert(Model model, DisplayTemplatePO po) {
		displayService.insertDisplayTemplate(po);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayTemplateController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/display/displayTemplateUpdate.do")
	public String displayTemplateUpdate(Model model, DisplayTemplatePO po) {
		displayService.updateDisplayTemplate(po);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DisplayTemplateController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/display/displayTemplateDelete.do")
	public String templateDelete(Model model, DisplayTemplatePO po) {
		displayService.deleteDisplayTemplate(po);

		return View.jsonView();
	}
}