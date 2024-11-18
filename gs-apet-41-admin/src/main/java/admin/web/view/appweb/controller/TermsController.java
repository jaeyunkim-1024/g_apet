package admin.web.view.appweb.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.cfg.MapperConfig;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.appweb.model.TermsPO;
import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.appweb.service.TermsService;
import biz.app.contents.model.EduContsSO;
import biz.app.mobileapp.model.MobileVersionPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.appweb.controller
 * - 파일명		: TermsController.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 관리
 * </pre>
 */
@Controller
public class TermsController {
	
	@Autowired
	private TermsService termsService;
	
	@Autowired
	private CacheService cacheService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 관리 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/appweb/termsListView.do")
	public String termsListView() {
		return "/appweb/termsListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 목록 그리드
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/termsListGrid", method = RequestMethod.POST)
	public GridResponse termsListGrid(TermsSO so) {
		List<TermsVO> list = termsService.termsListGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 약관 카테고리 조회
	 * </pre>
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/getTermsCategoryList.do", method = RequestMethod.POST)
	public List<CodeDetailVO> getTermsCategoryList(TermsSO so) {
		//List<CodeDetailVO> codeList = termsService.getTermsCategoryList(so);
		List<CodeDetailVO> codeList = this.cacheService.listCodeCache(AdminConstants.TERMS_GB, null, null, null, null, null);
		return codeList;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 약관 버전 조회
	 * </pre>
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/getTermsVerCheck.do", method = RequestMethod.POST)
	public String getTermsVerCheck(TermsSO so) {
		String version = termsService.getTermsVerCheck(so);
		return version;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 관리 등록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/appweb/termsInsertView.do")
	public String termsInsertView() {
		return "/appweb/termsView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 등록
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/appweb/insertTerms.do")
	public String insertTerms(Model model, TermsPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		termsService.insertTerms(po);
		//model.addAttribute("version", po);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 관리 수정 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/appweb/termsUpdateView.do")
	public String termsUpdateView(Model model, TermsSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("termsDetailInfo", termsService.getTermsDetailInfo(so));
		model.addAttribute("codeList", this.cacheService.listCodeCache(AdminConstants.TERMS_GB, null, null, null, null, null));
		
		return "/appweb/termsView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TermsController.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 수정
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/appweb/updateTerms.do")
	public String updateTerms(Model model, TermsPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		termsService.updateTerms(po);
		//model.addAttribute("version", po);
		
		return View.jsonView();
	}
	
}
