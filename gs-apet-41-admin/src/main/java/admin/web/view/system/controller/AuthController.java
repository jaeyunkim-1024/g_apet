package admin.web.view.system.controller;

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
import biz.app.system.model.AuthorityPO;
import biz.app.system.model.AuthoritySO;
import biz.app.system.model.AuthorityVO;
import biz.app.system.service.AuthService;
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

@Controller
public class AuthController {

	@Autowired
	private AuthService authService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: AuthController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/system/authListView.do")
	public String authListView() {
		return "/system/authListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: AuthController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/authListGrid.do", method=RequestMethod.POST)
	public GridResponse authListGrid(AuthoritySO so) {
		List<AuthorityVO> list = authService.pageAuth(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: AuthController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/authView.do")
	public String userView(Model model, AuthoritySO so, BindingResult br) {
		if(br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("auth", authService.getAuth(so));
		return "/system/authView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: AuthController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 리스트
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/authMenuList.do")
	public String authMenuList(Model model, AuthoritySO so, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("authMenu", authService.listAuthMenu(so));
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: AuthController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 저장
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/authSave.do")
	public String authSave(Model model, AuthorityPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		authService.saveAuth(po);
		model.addAttribute("auth", po);
		return View.jsonView();
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: AuthController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/authDelete.do")
	public String authDelete(Model model, AuthorityPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		authService.deleteAuth(po);
		return View.jsonView();
	}

}