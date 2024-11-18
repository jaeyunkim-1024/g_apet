package admin.web.view.system.controller;

import biz.app.display.service.SeoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import admin.web.config.view.View;
import biz.app.display.model.SeoInfoPO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.service.DisplayService;
import framework.admin.constants.AdminConstants;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.system.controller
 * - 파일명		: SeoController.java
* - 작성일		: 2020. 12. 23.
* - 작성자		: CJA
 * - 설명		: SEO 기준 정보
 * </pre>
 */

@Controller
public class SeoController {
	
	@Autowired
	SeoService seoService;
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 패키지명	: admin.web.view.system.controller
	* - 작성일		: 2020. 12. 23.
	* - 작성자		: CJA
	 * - 설명		: SEO 기본 관리 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/system/seoManagement.do", method = RequestMethod.GET)
	public String seoManagementView(Model model) {
		
		return "/system/seoManagement";
	}
	
	@RequestMapping(value = "/system/getSeoInfo.do", method = {RequestMethod.POST})
	public String getSeoInfo(Model model, SeoInfoSO so) {
		so.setDftSetYn("Y");
		model.addAttribute("getSeoInfo", seoService.getSeoInfo(so));
		return View.jsonView();
	}
	
	@RequestMapping(value = "/system/saveSeoInfo.do", method = RequestMethod.POST)
	public String saveSeoInfo(Model model, SeoInfoPO po) {
		
		seoService.saveSeoInfo(po);
		return View.jsonView();
	}
	

}

