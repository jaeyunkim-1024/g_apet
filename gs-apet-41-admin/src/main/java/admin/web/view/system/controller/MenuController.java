package admin.web.view.system.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.system.model.*;
import biz.app.system.service.MenuService;
import biz.app.system.service.UserService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

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
public class MenuController {

	@Autowired
	private MenuService menuService;

	@Autowired
	private UserService userService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/system/menuView.do")
	public String menuView(Model model,UserBaseSO so) {
		so.setUsrNo(AdminSessionUtil.getSession().getUsrNo());
		UserBaseVO vo = userService.getUser(so);
		model.addAttribute("usrGrpCd",vo.getUsrGrpCd());
		return "/system/menuView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 트리 리스트
	 * </pre>
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/menuTree.do", method=RequestMethod.POST)
	public List<MenuTreeVO> menuTree(MenuSO so) {
		so.setAuthNos(AdminSessionUtil.getSession().getAuthNos());
		return menuService.listMenuTree(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: PO 메뉴 트리 리스트
	 * </pre>
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/poMenuTree.do", method=RequestMethod.POST)
	public List<MenuTreeVO> poMenuTree(MenuSO so) {
		List<Long> authNos = new ArrayList<Long>();
		authNos.add(Long.parseLong(AdminConstants.PO_AUTH_NO));
		so.setAuthNos(authNos);
		return menuService.listMenuTree(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 상세 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/menuBaseView.do")
	public String menuBaseView(Model model, @ModelAttribute("menuResult") MenuSO so) {
		model.addAttribute("menuBase", menuService.getMenuBase(so));
		return "/system/menuBaseView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 저장
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/menuBaseSave.do")
	public String menuBaseSave(Model model, MenuBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		menuService.saveMenuBase(po);
		model.addAttribute("menuBase", po);
		return View.jsonView();
	}

	@RequestMapping("/system/menuBaseDelete.do")
	public String menuBaseDelete(Model model, MenuBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		menuService.deleteMenuBase(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/menuActionListGrid.do", method=RequestMethod.POST)
	public GridResponse menuActionListGrid(MenuActionSO so) {
		List<MenuActionVO> list = menuService.listMenuAction(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/menuActionView.do")
	public String menuActionView(Model model, @ModelAttribute("menuActionResult") MenuActionSO so ){
		model.addAttribute("menuAction", menuService.getMenuAction(so));
		return "/system/menuActionView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴기능 저장
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/menuActionSave.do")
	public String menuActionSave(Model model, @ModelAttribute("menuAction") MenuActionPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		menuService.saveMenuAction(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MenuController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/menuActionDelete.do")
	public String menuActionDelete(Model model, @ModelAttribute("menuAction") MenuActionPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		menuService.deleteMenuAction(po);
		return View.jsonView();
	}


}