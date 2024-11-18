package admin.web.view.st.controller;

import java.util.List;

import framework.admin.constants.AdminConstants;
import framework.common.util.FileUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
 
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.DataGridResponse;
import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
 
import biz.app.st.model.StPolicyPO;
import biz.app.st.model.StPolicySO;
import biz.app.st.model.StPolicyVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
 
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StController {

	@Autowired
	private StService stService;


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StController.java
	* - 작성일		: 2017. 1. 6.
	* - 작성자		: hongjun
	* - 설명			: 사이트 전체 조회
	* </pre>
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/st/stList.do", method=RequestMethod.POST)
	public DataGridResponse stList () {		
		// 사이트 리스트 조회
		StStdInfoSO so = new StStdInfoSO();
		so.setUseYn(CommonConstants.COMM_YN_Y);
		List<StStdInfoVO> list = stService.listStStdInfo(so);
		return new DataGridResponse(list);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StController.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 등록
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/st/stInsertView.do")
	public String stInsertView (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "SITE 등록");
			log.debug("==================================================");
		}

		return "/st/stInsertView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: stController.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 등록
	* </pre>
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping("/st/stInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String stInsert (Model model
			, @RequestParam("stStdInfoPO") String stStr) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "SITE 등록");
			log.debug("==================================================");
		}

		JsonUtil jsonUt = new JsonUtil();
		Long stId = null;

		// Site 기본
		StStdInfoPO stStdInfoPO = (StStdInfoPO)jsonUt.toBean(StStdInfoPO.class, stStr);

		stId = stService.insertSt(stStdInfoPO);
		model.addAttribute("stId", stId );

		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StController.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 상세
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/st/stDetailView.do")
	public String siteDetailView (Model model,  StStdInfoSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "SITE 상세");
			log.debug("==================================================");
		}

		// 사이트 기본 조회
		Long stId = so.getStId();
		StStdInfoVO stStdInfoVO = stService.getStStdInfo(stId);

		model.addAttribute("stStdInfo", stStdInfoVO );

		return "/st/stDetailView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StController.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 목록
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/st/stListView.do")
	public String siteListView (Model model, StStdInfoSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "SITE 목록");
			log.debug("==================================================");
		}

		return "/st/stListView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StController.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 리스트 GRID
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/st/stStdInfoGrid.do", method=RequestMethod.POST)
	public GridResponse stStdInfoGrid (StStdInfoSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : {} ", so.toString());
		}

		if(!StringUtil.isEmpty(so.getStNmArea()) ) {
			String[] stNmList = StringUtil.splitEnter(so.getStNmArea());
			so.setStNms(stNmList );
		}

		if(!StringUtil.isEmpty(so.getStIdArea()) ) {
			String[] stIdList = StringUtil.splitEnter(so.getStIdArea());
			Long[] stIds = null;
			if(stIdList != null && stIdList.length > 0 ) {
				stIds = new Long[stIdList.length];
				for(int i = 0; i < stIdList.length; i++ ) {
					stIds[i] = Long.valueOf(stIdList[i] );
				}
				so.setStIds(stIds );
			}
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {
			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}
		
		// 사이트 리스트 조회
		List<StStdInfoVO> list = stService.pageStStdInfo(so);
		return new GridResponse(list, so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StController.java
	* - 작성일		: 2017. 1. 3.
	* - 작성자		: hongjun
	* - 설명			: 사이트 수정
	* </pre>
	* @param model
	* @param stStdInfoPO
	* @param orgLogoImgPath
	* @return
	*/
	@RequestMapping("/st/stUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String stUpdate (Model model
			, @RequestParam("stStdInfoPO") String stStr
			, @RequestParam("orgLogoImgPath") String orgLogoImgPath ) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "SITE 수정");
			log.debug("==================================================");
		}

		JsonUtil jsonUt = new JsonUtil();
		Long stId = null;

		// Site 기본
		StStdInfoPO stStdInfoPO = (StStdInfoPO)jsonUt.toBean(StStdInfoPO.class, stStr);

		stId = stService.updateSt(stStdInfoPO, orgLogoImgPath);
		model.addAttribute("stId", stId );

		return View.jsonView();
	}
	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.st.controller
	* - 파일명      : StController.java
	* - 작성일      : 2017. 4. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 홈 > 시스템 관리 > 사이트 관리 > 사이트 목록   > 사이트 상세 > 사이트 정책 목록 
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/st/stPolicyListGrid.do", method=RequestMethod.POST)
	public GridResponse stPolicyListGrid(StPolicySO so) {
		List<StPolicyVO> list = stService.listStPolicy(so);
		return new GridResponse(list, so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.st.controller
	* - 파일명      : StController.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  사이트 정책 등록 팝업 
	* </pre>
	 */
	@RequestMapping("/st/stPolicyViewPop.do")
	public String memberAddressViewPop(Model model,@ModelAttribute("stPolicyResult") StPolicySO so ) 
	{
		model.addAttribute("stPolicy", stService.getStPolicy(so));
		return "/st/stPolicyViewPop";
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.st.controller
	* - 파일명      : StController.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 사이트 정책 저장 
	* </pre>
	 */
	@RequestMapping("/st/stPolicySave.do")
	public String stPolicySave(Model model, StPolicyPO po   ) {
		stService.stPolicySave(po);
		return View.jsonView();
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.st.controller
	* - 파일명      : StController.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 삭제
	* </pre>
	 */
	@RequestMapping("/st/stPolicyDelete.do")
	public String stPolicyDelete(Model model, StPolicySO so) {
		stService.stPolicyDelete(so);
		return View.jsonView();
	}

	@RequestMapping("/st/deleteLogoImage.do")
	public String deleteLogoImage(Model model,String filePath) {
		String result = AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		try{
			FileUtil.delete(filePath);
		}catch(Exception e){
			result = AdminConstants.CONTROLLER_RESULT_CODE_FAIL;
			// 보안성 진단. 오류메시지를 통한 정보노출
			//model.addAttribute("exMsg",e.getMessage());
			model.addAttribute("exMsg",e.getClass());
		}
		model.addAttribute("result",result);
		return View.jsonView();
	}
}
