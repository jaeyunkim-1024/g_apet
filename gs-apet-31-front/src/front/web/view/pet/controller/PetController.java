package front.web.view.pet.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.model.PetDaPO;
import biz.app.pet.model.PetDaVO;
import biz.app.pet.model.PetInclRecodePO;
import biz.app.pet.model.PetInclRecodeSO;
import biz.app.pet.model.PetInclRecodeVO;
import biz.app.pet.service.PetService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import framework.common.util.UrlUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * - 프로젝트명	: 31.front.web 
 * - 패키지명		: front.web.view.pet.controller
 * - 파일명		: PetController.java
 * - 작성일		: 2021. 1. 15.
 * - 작성자		: 조은지
 * - 설명			: 펫 관련 Controller
 * </pre>
 */
/**
 * <pre>
 * - 프로젝트명	: 
 * - 패키지명		: front.web.view.pet.controller
 * - 파일명		: PetController.java
 * - 작성일		: 2021. 3. 7.
 * - 작성자		: 조은지
 * - 설명			: 
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("my/pet")
public class PetController {
	
	@Autowired private PetService petService;				/** 펫 서비스 */

	@Autowired private CacheService codeCacheService;		/** 코드 서비스 */
	
	@Autowired private SearchApiUtil searchApiUtil;			/** 자동검색 서비스 */
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 조은지
	 * - 설명			: 마이 펫 리스트 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param so
	 * @param view
	 * @return myPetListView.jsp
	 */
	@LoginCheck 
	@RequestMapping(value="myPetListView")
	public String myPetListView(ModelMap map, PetBaseSO so, ViewBase view, Session session , String deleteYn) {
		so.setMbrNo(session.getMbrNo());
		
		List<PetBaseVO> voList = petService.listPetBase(so); 
		
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		map.put("voList", voList);
		map.put("session", session);
		
		map.put("petGdGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GD_GB, null, null, null, null, null));
		map.put("view", view);
		map.put("deleteYn", deleteYn);
				
		if(voList.size() > 0) {
			return TilesView.mypage(new String[]{"pet", "myPetListView"});	
		} else {
			return TilesView.mypage(new String[]{"pet", "noPet"});
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 1. 15.
	 * - 작성자		: 조은지
	 * - 설명			: 마이 펫 상세화면
	 * </pre>
	 * @param map
	 * @param so
	 * @param view
	 * @param session
	 * @return myPetView.jsp
	 */
	@LoginCheck 
	@RequestMapping(value="myPetView" , method = RequestMethod.POST)
	public String myPetView(ModelMap map, PetBaseSO so, ViewBase view, Session session) {
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		map.put("petGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GB, null, null, null, null, null));
		map.put("petGdGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GD_GB, null, null, null, null, null));
		map.put("vo", petService.getPetInfo(so));
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.mypage(new String[]{"pet", "myPetView"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 1. 18.
	 * - 작성자		: 조은지
	 * - 설명			: 마이 펫 등록 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param po
	 * @param daPo
	 * @param view
	 * @return petInsertView.jsp
	 */
	@LoginCheck 
	@RequestMapping(value="petInsertView")
	public String petInsertView(ModelMap map, PetBasePO po, PetDaPO daPo, ViewBase view, Session session, String returnUrl) {
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);

		map.put("petGdGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GD_GB, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		map.put("returnUrl", returnUrl);
		
		return TilesView.mypage(new String[]{"pet", "petInsertView"});
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 3. 7.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 질환/알러지 리스트
	 * </pre>
	 * @param so
	 * @return
	*/
	@ResponseBody
	@RequestMapping(value="selectPetDaList")
	public ModelMap selectPetDaList(PetBaseSO so) {
		ModelMap map = new ModelMap();
		
		map.put("diseaseList", this.codeCacheService.listCodeCache(CommonConstants.DA, CommonConstants.DA_GB_10, null, null, null, null));
		map.put("allergyList", this.codeCacheService.listCodeCache(CommonConstants.DA, CommonConstants.DA_GB_20, so.getPetGbCd(), null, null, null));
		
		return map;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 3. 7.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 등록
	 * </pre>
	 * @param po
	 * @param daPo
	 * @return
	*/
	@RequestMapping(value="petInsert")
	@ResponseBody
	public ModelMap petInsert(PetBasePO po, PetDaPO daPo, ViewBase view, Session session) {
		Long petNo = petService.insertPet(po, daPo, view.getDeviceGb());
		
		ModelMap map = new ModelMap();
		
		map.put("petNo", petNo);
		map.put("returnUrl", po.getReturnUrl());
		map.put("resultCode", CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS);
		
		return map;
		//return TilesView.redirect(new String[]{"my", "pet", "petInsertSuccess?petNo=" + petNo + "&returnUrl=" + URLEncoder.encode(po.getReturnUrl(), "UTF-8")});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 1. 22.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 등록 성공 페이지
	 * </pre>
	 * @param map
	 * @param so
	 * @param view
	 * @return petInsertSuccess.jsp
	 */
	@LoginCheck 
	@RequestMapping(value="petInsertSuccess")
	public String petInsertSuccess(ModelMap map, PetBaseSO so, ViewBase view, Session session, String returnUrl) {
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		so.setMbrNo(session.getMbrNo());
		PetBaseVO pbVO = petService.getPetInfo(so);
		if(StringUtil.isEmpty(pbVO)) {
			throw new CustomException(ExceptionConstants.ERROR_NO_PATH);
		}
		map.put("vo", pbVO);
		map.put("petGdGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GD_GB, null, null, null, null, null));
		map.put("session", session);
		map.put("returnUrl", returnUrl);
		map.put("view", view);
		
		return TilesView.mypage(new String[]{"pet", "petInsertSuccess"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 1. 25.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 검색어 자동완성
	 * </pre>
	 * @param so
	 * @return String
	 */
	@RequestMapping(value="petSearchAutoComplete")
	@ResponseBody
	public String petSearchAutoComplete(PetBaseSO so) {
		String label = null;
		String response = null;
		
		if(StringUtil.equals(so.getPetGbCd(), CommonConstants.PET_GB_10)) {
			label = CommonConstants.SEARCH_AUTO_COMPLETE_LABEL_DOG;
		} else {
			label = CommonConstants.SEARCH_AUTO_COMPLETE_LABEL_CAT;
		}
		
		Map<String, String> param = new HashMap<String, String>();
		param.put("LABEL", label);
		param.put("KEYWORD", so.getPetKindNm());
		param.put("MIDDLE", "true");
		param.put("SORT", "weight");
		param.put("SIZE", "999");
		
		response = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_AUTOCOMPLETE, param);
		
		return response;
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 검색어 자동완성 
	 * </pre>
	 * @param map
	 * @param po
	 * @param view
	 * @return popPetKindNmSearch.jsp
	 */
	@LoginCheck 
	@RequestMapping(value="popPetKindNmSearch")
	public String popPetKindNmSearch(ModelMap map, PetBasePO po, ViewBase view) {
		map.put("po", po);
		return TilesView.mypage(new String[]{"pet", "popPetKindNmSearch"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.fornt.web 
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 수정 화면
	 * </pre>
	 * @param map
	 * @param so
	 * @return petUpdateView.jsp
	 */
	@LoginCheck 
	@RequestMapping(value="petUpdateView" , method = RequestMethod.POST)
	public String petUpdateView(ModelMap map, PetBaseSO so, ViewBase view, Session session) {
		PetBaseVO vo = petService.getPetInfo(so);
		List<PetDaVO> daVo = petService.selectPetDa(so);

		String petGbCd = vo.getPetGbCd();
		
		map.put("diseaseList", this.codeCacheService.listCodeCache(CommonConstants.DA, CommonConstants.DA_GB_10, null, null, null, null));
		map.put("allergyList", this.codeCacheService.listCodeCache(CommonConstants.DA, CommonConstants.DA_GB_20, petGbCd, null, null, null));

		map.put("petGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GB, null, null, null, null, null));
		map.put("petGdGbCdList", this.codeCacheService.listCodeCache(CommonConstants.PET_GD_GB, null, null, null, null, null));

		map.put("vo", vo);
		map.put("daVo", daVo);
		map.put("session", session);
		map.put("view", view);		
		
		return TilesView.mypage(new String[]{"pet", "petUpdateView"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 수정
	 * </pre>
	 * @param map
	 * @param po
	 * @param daPo
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="petUpdate")
	public String petUpdate(ModelMap map, PetBasePO po, PetDaPO daPo, ViewBase view) {
		int result = petService.updatePet(po, daPo, view.getDeviceGb());
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		
		if(result != 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 삭제
	 * </pre>
	 * @param map
	 * @param po
	 * @param daPo
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="petDelete", method = RequestMethod.POST)
	public String petDelete(ModelMap map, PetBasePO po, PetDaPO daPo) {
		int result = petService.deletePet(po, daPo);
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		
		if(result != 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: kms
	 * - 설명			: 건강수첩 접종 목록
	 * </pre>
		@param view
		@param map
		@param so
		@return
	 */
	@LoginCheck
	@RequestMapping(value = "indexMypetInclRecode")
	public String indexMypetInclRecode(Session session , ViewBase view , Model model , PetInclRecodeSO so , Integer page , String deleteYn , String updateYn , String subYn) {
		String url;
		PetBaseSO bso = new PetBaseSO();
		bso.setPetNo(so.getPetNo());
		bso.setMbrNo(session.getMbrNo());
		PetBaseVO petBase = petService.getPetInfo(bso);
		if(StringUtil.isEmpty(petBase)) {
			throw new CustomException(ExceptionConstants.ERROR_NO_PATH);
		}
		
		so.setRows(FrontConstants.PAGE_ROWS_20);
		so.setSort("INCL_DT DESC, SYS_REG_DTM");
		so.setOrder("DESC");
		if(StringUtil.isEmpty(page)) {
			url = "mypage/pet/myPetInclRecodeList";
		}else {
			so.setPage(page);
			url = "mypage/pet/myPetInclRecodeListPaging";
		}
		
		List<PetInclRecodeVO> recodeList = petService.petInclRecodeList(so);
		
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("recodeList", recodeList);
		model.addAttribute("petBase", petBase);
		model.addAttribute("view", view);
		model.addAttribute("session" , session);
		model.addAttribute("updateYn" , updateYn);
		model.addAttribute("deleteYn" , deleteYn);
		model.addAttribute("subYn" , subYn);
		return url;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: kms
	 * - 설명			: 예방접종 기록 등록 화면
	 * </pre>
		@param view
		@param map
		@param vo
		@return
	 */
	@RequestMapping(value ="insertMyPetInclRecodePage")
	public String insertMyPetInclRecodePage(Session session ,ViewBase view , ModelMap map , Long petNo, String subYn , Long inclNo) {
		PetBaseSO so = new PetBaseSO();
		so.setPetNo(petNo);
		so.setMbrNo(session.getMbrNo());
		PetBaseVO vo = petService.getPetInfo(so);
		if(StringUtil.isEmpty(vo)) {
			throw new CustomException(ExceptionConstants.ERROR_NO_PATH);
		}
		
		PetInclRecodeVO inclRecode = new PetInclRecodeVO();
		PetInclRecodeSO inclSo = new PetInclRecodeSO();
		inclSo.setInclNo(inclNo);
		inclSo.setMbrNo(session.getMbrNo());
		
		if(StringUtil.isNotEmpty(inclNo)){
			inclRecode = petService.getMyPetInclRecode(inclSo);
		}
		
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		map.put("basicInclList", this.codeCacheService.listCodeCache(CommonConstants.INCL_KIND, vo.getPetGbCd(), CommonConstants.INCL_GB_10, null, null, null));
		map.put("regularInclList", this.codeCacheService.listCodeCache(CommonConstants.INCL_KIND, vo.getPetGbCd(), CommonConstants.INCL_GB_20, null, null, null));
		map.put("antibodyInclList", this.codeCacheService.listCodeCache(CommonConstants.INCL_KIND, vo.getPetGbCd(), CommonConstants.INCL_GB_30, null, null, null));
		map.put("subInclList", this.codeCacheService.listCodeCache(CommonConstants.INCL_KIND, null, CommonConstants.INCL_GB_40, null, null, null));
		map.put("addInclList" , this.codeCacheService.listCodeCache(CommonConstants.INCL_ADD , null , null ,null ,null , null));
		map.put("petBase", vo);
		map.put("recode", inclRecode);
		map.put("session", session);
		
		if(StringUtil.equals(subYn, CommonConstants.COMM_YN_N)) {
			return "mypage/pet/insertMyPetInclRecode";
		}else {
			return "mypage/pet/insertMyPetInclRecodeSub";
		}
		
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 등록 /수정
	 * </pre>
		@param map
		@param po
		@return
	 */
	@ResponseBody
	@RequestMapping(value ="insertMyPetInclRecode")
	public Long insertMyPetInclRecode(ModelMap map , Session session , PetInclRecodePO po , ViewBase view) {
		po.setMbrNo(session.getMbrNo());
		Long petInclNo = petService.insertMyPetInclRecode(po , view.getDeviceGb());
		return petInclNo;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 기록 상세
	 * </pre>
		@param map
		@param view
		@param so
		@return
	 */
	@RequestMapping(value ="myPetInclRecodeView")
	public String myPetInclRecodeView(Session session , ModelMap map , ViewBase view , PetInclRecodeSO so) {
		so.setMbrNo(session.getMbrNo());
		PetInclRecodeVO vo = petService.getMyPetInclRecode(so);
		
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		map.put("recode", vo);
		map.put("view", view);
		map.put("inclGbList" , this.codeCacheService.listCodeCache(CommonConstants.INCL_GB , null , null ,null ,null , null));
		map.put("session", session);
		return "mypage/pet/myPetInclRecodeView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetController.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 기록 삭제
	 * </pre>
		@param map
		@param view
		@param po
		@return
	 */
	@ResponseBody
	@RequestMapping(value ="deleteMyPetInclRecode")
	public int deleteMyPetInclRecode(ModelMap map , PetInclRecodePO po) {
		int result = petService.deleteMyPetInclRecode(po);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="appPetImageUpdate")
	public String appPetImageUpdate(ModelMap map, PetBasePO po) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		int result = petService.appPetImageUpdate(po);
		
		if(result != 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
	
	@ResponseBody
	@RequestMapping(value="appInclPetImageUpdate")
	public String appPetImageInclUpdate(ModelMap map, PetInclRecodePO po) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		int result = petService.appInclPetImageUpdate(po);
		
		if(result != 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
}
