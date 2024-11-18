package admin.web.view.mobileapp.controller;

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
import biz.app.mobileapp.model.MobileSplashPO;
import biz.app.mobileapp.model.MobileSplashSO;
import biz.app.mobileapp.model.MobileSplashVO;
import biz.app.mobileapp.service.MobileSplashService;
import biz.app.system.service.CodeService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

@Controller
@RequestMapping("/mobileapp/splash")
public class MobileSplashController {
	@Autowired
	private MobileSplashService mobileSplashService;
	
	@Autowired
	private CodeService codeService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: 모바일 앱 Splash 관리 화면
	 * </pre>
	 * 
	 * @return
	 */
	@RequestMapping("/list.do")
	public String listView() {
		return "/mobileapp/splashListView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: 모바일 앱 Splash 목록 리스트
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/listGrid.do", method = RequestMethod.POST)
	public GridResponse listGrid(MobileSplashSO so) {
		List<MobileSplashVO> list = mobileSplashService.pageMobileSplash(so);
		return new GridResponse(list, so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: 모바일 앱 Splash 등록 화면
	 * </pre>
	 * 
	 * @return
	 */
	@RequestMapping("/reg.do")
	public String reg() {
		return "/mobileapp/splashView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: 모바일 앱 Splash 정보 조회
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/view.do")
	public String view(Model model, MobileSplashSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("splash", mobileSplashService.getMobileSplash(so));
		
		return "/mobileapp/splashView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 등록
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/insert.do")
	public String insert(Model model, MobileSplashPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		po.setAppId(CommonConstants.MOBILE_APP_ID);
		if (po.getLinkType().equals(CommonConstants.APP_SPLASH_TP_I)) {
			po.setLink(po.getImageUrl());
		}
		
		mobileSplashService.insertMobileSplash(po);
		model.addAttribute("splash", po);
		
		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 18.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 수정
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/update.do")
	public String update(Model model, MobileSplashPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		po.setAppId(CommonConstants.MOBILE_APP_ID);
		if (po.getLinkType().equals(CommonConstants.APP_SPLASH_TP_I)) {
			po.setLink(po.getImageUrl());
		}
		mobileSplashService.updateMobileSplash(po);
		model.addAttribute("splash", po);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileSplashController.java
	 * - 작성일		: 2016. 08. 18.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 삭제
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/delete.do")
	public String delete(Model model, MobileSplashPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		int delCnt = mobileSplashService.deleteMobileSplash(po);
		model.addAttribute("delCnt", delCnt);
		
		return View.jsonView();
	}
}
