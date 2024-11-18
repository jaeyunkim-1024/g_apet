package front.web.view.search.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.contents.model.SeriesVO;
import biz.app.goods.service.FilterService;
import biz.app.member.model.MemberSearchWordPO;
import biz.app.member.model.MemberSearchWordSO;
import biz.app.member.model.MemberSearchWordVO;
import biz.app.member.service.MemberService;
import biz.app.search.model.IBricksResultVO;
import biz.app.search.model.PopWordVO;
import biz.app.search.model.RecommendTagVO;
import biz.app.search.service.IBricksSearchService;
import framework.common.constants.CommonConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.search.controller
* - 파일명		: IBricksSearchController.java
* - 작성일		: 2021. 2. 17.
* - 작성자		: pkt
* - 설명		: i-Bricks 검색 Controller
* </pre>
*/
@Slf4j
@Controller
public class IBricksSearchController {
	
	private static final String[] NAVIGATION_SEARCH = {"검색"};

	@Autowired
	private IBricksSearchService iBricksSearchService;
	
	@Autowired
	private SearchApiUtil searchApiUtil;

	@Autowired
	private MemberService memberService;
	
	@Autowired 
	private FilterService filterService;
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: IBricksSearchController.java
	* - 작성일		: 2021. 2. 17.
	* - 작성자		: pkt
	* - 설명		: 검색 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="commonSearch")
	public String indexSearch(ModelMap map, Session session, ViewBase view, String srchWord, Long cateCdL,
			Long series, Long video, Long member, Long content, Long brand, Long goods,
			String focus, String vSort, String cSort, String gSort, String filtArrString, String filtBSort
			) {
		//외부링크로 cateCdL param 없이 접근시 처리.20210625
		String cateCdLStr = String.valueOf(cateCdL);
		if(StringUtil.isEmpty(cateCdL)|| cateCdL == 0L) {		
			cateCdLStr = CommonConstants.PETSHOP_DOG_DISP_CLSF_NO+","+CommonConstants.PETSHOP_CAT_DISP_CLSF_NO+","+CommonConstants.PETSHOP_FISH_DISP_CLSF_NO+","+CommonConstants.PETSHOP_ANIMAL_DISP_CLSF_NO;
		}
		//펫로그 제휴업체. 펫로그탭만 선택 되도록.
		if(StringUtil.isNotEmpty(session.getBizNo())) {
			focus = "30";
		}
		
		view.setNocache(true);
		view.setNavigation(NAVIGATION_SEARCH);
		map.put("session", session);
		map.put("view", view);
		map.put("srchWord", srchWord);
		map.put("cateCdL", StringUtil.isEmpty(cateCdL)?0:cateCdL);		
		map.put("series", series);
		map.put("video", video);
		map.put("member", member);
		map.put("content", content);
		map.put("brand", brand);
		map.put("goods", goods);
		map.put("focus", focus);
		map.put("vSort", vSort);
		map.put("cSort", cSort);
		map.put("gSort", gSort);
		map.put("filtArrString", filtArrString);
		map.put("filtBSort", filtBSort);
		// 기본페이지 결과 페이지 구분
		Boolean isDefault = (StringUtil.isBlank(srchWord))? true  : false;
		map.put("isDefault", isDefault);
		
		if(!session.getMbrNo().equals(FrontConstants.NO_MEMBER_NO)) {	// 로그인 경우
			MemberSearchWordPO mswpo = new MemberSearchWordPO();
			mswpo.setMbrNo(session.getMbrNo());
			mswpo.setSrchGbCd(CommonConstants.SRCH_GB_10);
			
			// 최근 검색어 조회
			MemberSearchWordSO mswso = new MemberSearchWordSO();
			mswso.setMbrNo(session.getMbrNo());
			mswso.setSrchGbCd(CommonConstants.SRCH_GB_10);
			List<MemberSearchWordVO> listMemberSearchWord = memberService.listMemberSearchWord(mswso);
			
			if(isDefault) { // srchWord 가 없는 경우 최근 검색어 view단 전송
				map.put("listMemberSearchWord", listMemberSearchWord);
				try {
					//관심태그 맞춤추천(I)
					List<RecommendTagVO> interestTagList = iBricksSearchService.getRecommendTagList(session, "I");
					map.put("interestTagList", interestTagList);
					
					//마이펫 맞춤추천(P)
					List<RecommendTagVO> myPetTagList = iBricksSearchService.getRecommendTagList(session, "P");
					map.put("myPetTagList", myPetTagList);
					
					//내 활동 맞춤추천(A)
					List<RecommendTagVO> myAcTagList = iBricksSearchService.getRecommendTagList(session, "A");
					map.put("myAcTagList", myAcTagList);
				} catch (Exception e) {
					// 보안성 진단. 오류메시지를 통한 정보노출
					log.error("인기 검색어", e.getClass());
				}
			}else { // srchWord 가 있을 경우 검색어 저장
				// 동일 검색어 저장여부 확인
				MemberSearchWordVO duplvo= null;
				for(int i = 0 ; i < listMemberSearchWord.size() ; i++) { 
					if(listMemberSearchWord.get(i).getSrchWord().equals(srchWord)) {
						duplvo = listMemberSearchWord.get(i);
					}
				}
				// 검색어 DB삭제
				if(duplvo != null) { // 동일 검색어 존재
					mswpo.setSeq(duplvo.getSeq());
					memberService.deleteMemberSearchWord(mswpo);
				} else if(listMemberSearchWord.size() >= 10){ // 동일 검색어 없고 현재 저장된 검색어 10개 이하인경우 가장 먼저 등록된 검색어 삭제
					mswpo.setSeq(listMemberSearchWord.get(listMemberSearchWord.size()-1).getSeq());
					memberService.deleteMemberSearchWord(mswpo);
				}
				
				// 최근 검색어 등록
				mswpo.setSrchWord(srchWord);
				memberService.insertMemberSearchWord(mswpo);
			}
		}
		
		if(isDefault) {	// 로그인 여부 상관없이 검색어 없는 경우 인기 검색어, 배너 호출
			try {
				// 인기 검색어
				List<PopWordVO> popWordList = iBricksSearchService.getPopWordList();
				map.put("popWordList", popWordList);
				
				// 배너(인기 오리지널영상 배너 노출)
				List<SeriesVO> seriesList = iBricksSearchService.getOriginalVodBnrFO();
				map.put("seriesList", seriesList);
			} catch (Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("인기 검색어, 배너 호출", e.getClass());
			}
		}else {	// 검색어 입력시
			String webMobileGbCd = 
					StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
					? CommonConstants.WEB_MOBILE_GB_10
					: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
	        requestParam.put("KEYWORD",srchWord);
	        requestParam.put("CATEGORY",cateCdLStr);
	        requestParam.put("INDEX","shop,log,tv");
	        requestParam.put("FROM","1");
	        requestParam.put("SIZE","10");	// 10개씩
	        requestParam.put("SORT","default"); // 디폴트 화면 인기순
	        requestParam.put("WEB_MOBILE_GB_CD" , webMobileGbCd);
	        IBricksResultVO result = null;
	        try {
				result = iBricksSearchService.getSearchResult(requestParam, session, view.getDeviceGb());
			} catch (Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("검색결과", e.getClass());
			}
	        map.put("result", result);
		}
		return "/search/indexIBricksSearch";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 03. 11.
	 * - 작성자		: KKB
	 * - 설명		: 최근 검색어 삭제
	 * </pre>
	 * @param so
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="search/delLatelyTag")
	public ModelMap delLatelyTag(Session session, Long seq){
		ModelMap map = new ModelMap();
		MemberSearchWordPO mswpo = new MemberSearchWordPO();
		mswpo.setMbrNo(session.getMbrNo());
		mswpo.setSrchGbCd(CommonConstants.SRCH_GB_10);
		mswpo.setSeq(seq);
		int result = memberService.deleteMemberSearchWord(mswpo);
		map.put("result", (result == 1)?"S":"F");
        return map;
    }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 03. 12.
	 * - 작성자		: KKB
	 * - 설명		: 맞춤추천 데이터 Ajax
	 * </pre>
	 * @param so
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="search/getRecArea")
	public ModelMap getRecArea(Session session){
		ModelMap map = new ModelMap();
		try {
			//관심태그 맞춤추천(I)
			List<RecommendTagVO> interestTagList = iBricksSearchService.getRecommendTagList(session, "I");
			map.put("interestTagList", interestTagList);
			
			//마이펫 맞춤추천(P)
			List<RecommendTagVO> myPetTagList = iBricksSearchService.getRecommendTagList(session, "P");
			map.put("myPetTagList", myPetTagList);
			
			//내 활동 맞춤추천(A)
			List<RecommendTagVO> myAcTagList = iBricksSearchService.getRecommendTagList(session, "A");
			map.put("myAcTagList", myAcTagList);
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("인기 검색어", e.getClass());
		}
        return map;
    }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: KKB
	 * - 설명		: 필터 팝업
	 * </pre>
	 * @param so
	 * @return String
	 */
	@RequestMapping(value="search/getFilterPop")
	public String getFilterPop(ModelMap map, Session session, ViewBase view, String srchWord, Long cateCdL, String bndSort){
		//외부링크로 cateCdL param 없이 접근시 처리.20210625
		String cateCdLStr = String.valueOf(cateCdL);
		if(StringUtil.isEmpty(cateCdL) || cateCdL == 0L) {
			cateCdLStr = CommonConstants.PETSHOP_DOG_DISP_CLSF_NO+","+CommonConstants.PETSHOP_CAT_DISP_CLSF_NO+","+CommonConstants.PETSHOP_FISH_DISP_CLSF_NO+","+CommonConstants.PETSHOP_ANIMAL_DISP_CLSF_NO;
		}
		Map<String,String> requestParam = new HashMap<String,String>();
		
        String thisSrchWord = srchWord.trim();
        String webMobileGbCd = 
				StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
        requestParam.put("TARGET_NAME","all");
    	requestParam.put("KEYWORD",thisSrchWord);
    	requestParam.put("CATEGORY",cateCdLStr);
        
    	// [21.06.16 CSR-1075] 통합검색 팝업 - 필터/브랜드 헤딩토글, 브랜드 통합검색으로 정렬
    	if ( StringUtils.isEmpty(bndSort) ) {
    		bndSort = "pop_rank"; // 디폴트로 '인기순'
    	}
    	requestParam.put("BND_SORT", bndSort);    	
    	requestParam.put("WEB_MOBILE_GB_CD" , webMobileGbCd);
        IBricksResultVO result = null;
        try {
			result = iBricksSearchService.getSearchGoodsFilterResult(requestParam, session, view.getDeviceGb());
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("필터팝업", e.getClass());
		}
		if(!StringUtil.isEmpty(result)) {
			map.put("filter", result.getFilterList());
			map.put("brandList", result.getFilterBrandList());
		}
		
        return "/search/include/filterPop";
    }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 03. 22
	 * - 작성자		: KKB
	 * - 설명		: 브랜드 리스트 호출
	 * </pre>
	 * @param so
	 * @return String
	 */
	/*
	// [21.06.16 CSR-1075] 통합검색 팝업 - 필터/브랜드 헤딩토글, 브랜드 통합검색으로 정렬
	// 통합검색으로 변경되어 주석처리함.
	@ResponseBody
	@RequestMapping(value="search/getBrandList")
	public ModelMap getBrandList(String gb){
		ModelMap map = new ModelMap();
		BrandBaseSO brandSo = new BrandBaseSO();
		if("10".equals(gb)) {
			brandSo.setSidx("SALE_QTY");
			brandSo.setSord("DESC");
		}else {
			brandSo.setSidx("BND_NM");
			brandSo.setSord("ASC");
		}
		List<BrandBaseVO> brand = filterService.filterGoodsBrand(brandSo);
		map.put("brandList",brand);
        return map;
    }
    */
	
	
	// [21.06.16 CSR-1075] 통합검색 팝업 - 필터/브랜드 헤딩토글, 브랜드 통합검색으로 정렬
	// this.getFilterPop()유사함. this.getFilterPop()함수에서  브랜드 리스트만 Ajax로 리턴함.
	@ResponseBody
	@RequestMapping(value="search/getBrandListForSearch")
	public ModelMap getBrandListForSearch(ModelMap map, Session session, ViewBase view, String srchWord, Long cateCdL, String bndSort){
		//외부링크로 cateCdL param 없이 접근시 처리.20210625
		String cateCdLStr = String.valueOf(cateCdL);
		if(StringUtil.isEmpty(cateCdL) || cateCdL == 0L) {
			cateCdLStr = CommonConstants.PETSHOP_DOG_DISP_CLSF_NO+","+CommonConstants.PETSHOP_CAT_DISP_CLSF_NO+","+CommonConstants.PETSHOP_FISH_DISP_CLSF_NO+","+CommonConstants.PETSHOP_ANIMAL_DISP_CLSF_NO;
		}
		Map<String,String> requestParam = new HashMap<String,String>();
		
	    String thisSrchWord = srchWord.trim();
	    String webMobileGbCd = 
				StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
	    requestParam.put("TARGET_NAME","all");
		requestParam.put("KEYWORD",thisSrchWord);
		requestParam.put("CATEGORY",cateCdLStr);
	    
		if ( StringUtils.isEmpty(bndSort) ) {
			bndSort = "pop_rank"; // 디폴트로 '인기순'
		}
		requestParam.put("BND_SORT", bndSort);
		requestParam.put("WEB_MOBILE_GB_CD" , webMobileGbCd);
		
	    IBricksResultVO result = null;
	    try {
			result = iBricksSearchService.getSearchGoodsFilterResult(requestParam, session, view.getDeviceGb());
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("필터팝업", e.getClass());
		}
		    
	    ModelMap mapResult = new ModelMap();
	    
	    if(!StringUtil.isEmpty(result)) {
	    	mapResult.put("brandList", result.getFilterBrandList());
		}
	    
	    return mapResult;
	    
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 02. 23.
	 * - 작성자		: pkt
	 * - 설명			: 검색어 자동완성(해쉬태그)
	 * </pre>
	 * @param so
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="searchAutoComplete")
	public String getAutocomplete(@RequestParam(value="searchText")String searchText){
    	
    	Map<String,String> requestParam = new HashMap<String,String>();
    	requestParam.put("MIDDLE","true");
        requestParam.put("KEYWORD",searchText);
        requestParam.put("LABEL",CommonConstants.SEARCH_AUTO_COMPLETE_LABEL_TOTAL);
         
        return searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_AUTOCOMPLETE, requestParam);
    }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 02. 25.
	 * - 작성자		: KKB
	 * - 설명		: 검색 결과
	 * </pre>
	 * @param so
	 * @return String
	 */
	@RequestMapping(value="commonSearchResults")
	public String getSearchResults(ModelMap map, ViewBase view, Session session, String srchWord, Long cateCdL, String index, String tagetIndex, String sort, String from, String size, String petGbCd, String bndNo, String filter){
		//외부링크로 cateCdL param 없이 접근시 처리.20210625
		String cateCdLStr = String.valueOf(cateCdL);
		if(StringUtil.isEmpty(cateCdL) || cateCdL == 0L) {
			cateCdLStr = CommonConstants.PETSHOP_DOG_DISP_CLSF_NO+","+CommonConstants.PETSHOP_CAT_DISP_CLSF_NO+","+CommonConstants.PETSHOP_FISH_DISP_CLSF_NO+","+CommonConstants.PETSHOP_ANIMAL_DISP_CLSF_NO;
		}
		
		Map<String,String> requestParam = new HashMap<String,String>();
        String thisSrchWord = srchWord.trim();
        String webMobileGbCd = 
				StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
    	requestParam.put("KEYWORD",thisSrchWord);
    	requestParam.put("CATEGORY",cateCdLStr);
        requestParam.put("INDEX",index);
        requestParam.put("TARGET_INDEX",tagetIndex);
        requestParam.put("SORT",sort);
        requestParam.put("FROM",from);
        requestParam.put("SIZE",size);
        requestParam.put("WEB_MOBILE_GB_CD" , webMobileGbCd);
        if(petGbCd != null) {
        	requestParam.put("PET_GB_CD",petGbCd);
        }
        if(bndNo != null) {
        	requestParam.put("BND_NO",bndNo);
        }
        if(filter != null) {
        	requestParam.put("FILTER",filter);
        }
        IBricksResultVO result = null;
        try {
			result = iBricksSearchService.getSearchResult(requestParam, session, view.getDeviceGb());
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("검색결과", e.getClass());
		}
        map.put("srchWord", thisSrchWord);
        map.put("result", result);
        
        String jspPath = "";
        if(tagetIndex.equals("se_tv_series")) { 		// TV-시리즈
        	jspPath = "/search/include/includeSeries";
        }else if(tagetIndex.equals("se_tv_video")) { 	// TV-동영상
        	jspPath = "/search/include/includeVideo";
        }else if(tagetIndex.equals("se_log_member")) { 	// LOG - 펫로그 사용자
        	jspPath = "/search/include/includeMember";
        }else if(tagetIndex.equals("se_log_content")) { // LOG - 펫로그 
        	jspPath = "/search/include/includeContent";
        }else if(tagetIndex.equals("se_shop_brand")) { 	// SHOP - 브랜드
        	jspPath = "/search/include/includeBrand";
        }else if(tagetIndex.equals("se_shop_goods")) { 	// SHOP - 상품
        	jspPath = "/search/include/includeGoods";
        }
        return jspPath;
    }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web 
	 * - 파일명		: IBricksSearchController.java
	 * - 작성일		: 2021. 04. 27.
	 * - 작성자		: KKB
	 * - 설명		: 필터 검색 카운트
	 * </pre>
	 * @param so
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="commonSearchGoodsCnt")
	public ModelMap getSearchGoodsCnt(ViewBase view, Session session, String srchWord, Long cateCdL, String petGbCd, String bndNo, String filter){
		//외부링크로 cateCdL param 없이 접근시 처리.20210625
		String cateCdLStr = String.valueOf(cateCdL);
		if(StringUtil.isEmpty(cateCdL) || cateCdL == 0L) {
			cateCdLStr = CommonConstants.PETSHOP_DOG_DISP_CLSF_NO+","+CommonConstants.PETSHOP_CAT_DISP_CLSF_NO+","+CommonConstants.PETSHOP_FISH_DISP_CLSF_NO+","+CommonConstants.PETSHOP_ANIMAL_DISP_CLSF_NO;
		}
		ModelMap map = new ModelMap();
		Map<String,String> requestParam = new HashMap<String,String>();
        String thisSrchWord = srchWord.trim();
        String webMobileGbCd = 
				StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
    	requestParam.put("KEYWORD",thisSrchWord);
    	requestParam.put("CATEGORY",cateCdLStr);
        requestParam.put("INDEX","shop");
        requestParam.put("TARGET_INDEX","se_shop_goods");
        requestParam.put("SORT","pop_rank");
        requestParam.put("FROM","1");
        requestParam.put("SIZE","1");
        requestParam.put("WEB_MOBILE_GB_CD" , webMobileGbCd);
        if(petGbCd != null) {
        	requestParam.put("PET_GB_CD",petGbCd);
        }
        if(bndNo != null) {
        	requestParam.put("BND_NO",bndNo);
        }
        if(filter != null) {
        	requestParam.put("FILTER",filter);
        }
        IBricksResultVO result = null;
        try {
			result = iBricksSearchService.getSearchResult(requestParam, session, view.getDeviceGb());
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("검색결과", e.getClass());
		}
        map.put("result", result);
        return map;
    }
}