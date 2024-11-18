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
import biz.app.system.model.PntInfoPO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.app.system.service.PntInfoService;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-41-admin
 * - 패키지명	: admin.web.view.system.controller
 * - 파일명		: PntInfoController.java
 * - 작성일		: 2021. 07. 20.
 * - 작성자		: JinHong
 * - 설명		: 포인트 관리
 * </pre>
 */
@Slf4j
@Controller
public class PntInfoController {

	@Autowired
	private PntInfoService pntInfoService;

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 관리 목록
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/pntInfoListView.do")
	public String pntInfoListView() {
		return "/system/pntInfoListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 관리 그리드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/system/pntInfoListGrid.do", method = RequestMethod.POST)
	public GridResponse pntInfoListGrid(PntInfoSO so) {
		List<PntInfoVO> list = pntInfoService.pagePntInfo(so);
		return new GridResponse(list, so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 관리 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/pntInfoView.do")
	public String pntInfoView(Model model, PntInfoSO so) {
		if(so.getPntNo() != null) {
			model.addAttribute("pntInfo", pntInfoService.getPntInfo(so));
		}
		return "/system/pntInfoView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 등록 처리
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/system/insertPntInfo.do")
	public String insertPntInfo(Model model, PntInfoPO po, BindingResult br) throws Exception {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		pntInfoService.insertPntInfo(po);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 수정 처리
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/system/updatePntInfo.do")
	public String updatePntInfo(Model model, PntInfoPO po, BindingResult br) throws Exception {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		pntInfoService.updatePntInfo(po);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 등록 전 중복 체크
	 * </pre>
	 * @param PntInfoSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/getValidPntInfoCount")
	public int getValidPntInfoCount(PntInfoSO so) {
		int result = pntInfoService.getValidCount(so);
		
		return result;
	}
}