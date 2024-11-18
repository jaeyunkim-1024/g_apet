package admin.web.view.privacy.controller;

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
import biz.app.privacy.model.PrivacyPolicyPO;
import biz.app.privacy.model.PrivacyPolicySO;
import biz.app.privacy.model.PrivacyPolicyVO;
import biz.app.privacy.service.PrivacyService;
import framework.admin.util.JsonUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PrivacyController {

	@Autowired
	private PrivacyService privacyService;


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 등록
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/privacy/privacyInsertView.do")
	public String stInsertView (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "PRIVACY 등록");
			log.debug("==================================================");
		}

		return "/privacy/privacyInsertView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: stController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 등록
	* </pre>
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping("/privacy/privacyInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String privacyInsert (Model model
			, @RequestParam("privacyPolicyPO") String stStr) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "PRIVACY 등록");
			log.debug("==================================================");
		}

		JsonUtil jsonUt = new JsonUtil();
		Long policyNo = null;

		// Site 기본
		PrivacyPolicyPO privacyPolicyPO = (PrivacyPolicyPO)jsonUt.toBean(PrivacyPolicyPO.class, stStr);

		policyNo = privacyService.insertPrivacy(privacyPolicyPO);
		model.addAttribute("policyNo", policyNo );

		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 상세
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/privacy/privacyDetailView.do")
	public String siteDetailView (Model model,  PrivacyPolicySO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "PRIVACY 상세");
			log.debug("==================================================");
		}

		// 개인정보처리방침 기본 조회
		Integer policyNo = so.getPolicyNo();
		PrivacyPolicyVO privacyPolicyVO = privacyService.getPrivacyPolicy(policyNo);

		model.addAttribute("privacyPolicy", privacyPolicyVO );

		return "/privacy/privacyDetailView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 목록
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/privacy/privacyListView.do")
	public String privacyListView (Model model, PrivacyPolicySO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "PRIVACY 목록");
			log.debug("==================================================");
		}

		return "/privacy/privacyListView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 리스트 GRID
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/privacy/privacyPolicyGrid.do", method=RequestMethod.POST)
	public GridResponse privacyPolicyGrid (PrivacyPolicySO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : {} ", so.toString());
		}

		if(!StringUtil.isEmpty(so.getVersionInfoArea()) ) {
			String[] bndNmList = StringUtil.splitEnter(so.getVersionInfoArea());
			so.setVersionInfos(bndNmList );
		}

		if(!StringUtil.isEmpty(so.getPolicyNoArea()) ) {
			String[] noList = StringUtil.splitEnter(so.getPolicyNoArea());
			Integer[] nos = null;
			if(noList != null && noList.length > 0 ) {
				nos = new Integer[noList.length];
				for(int i = 0; i < noList.length; i++ ) {
					nos[i] = Integer.valueOf(noList[i] );
				}
				so.setPolicyNos(nos );
			}
		}
		
		// 개인정보처리방침 리스트 조회
		List<PrivacyPolicyVO> list = privacyService.pagePrivacyPolicy(so);
		return new GridResponse(list, so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 수정
	* </pre>
	* @param model
	* @param privacyPolicyPO
	* @return
	*/
	@RequestMapping("/privacy/privacyUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String privacyUpdate (Model model
			, @RequestParam("privacyPolicyPO") String stStr) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "PRIVACY 수정");
			log.debug("==================================================");
		}

		JsonUtil jsonUt = new JsonUtil();
		Long policyNo = null;

		// Site 기본
		PrivacyPolicyPO privacyPolicyPO = (PrivacyPolicyPO)jsonUt.toBean(PrivacyPolicyPO.class, stStr);

		policyNo = privacyService.updatePrivacyPolicy(privacyPolicyPO);
		model.addAttribute("policyNo", policyNo );

		return View.jsonView();
	}
}
