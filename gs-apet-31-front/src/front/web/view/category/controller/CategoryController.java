package front.web.view.category.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupVO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.PopupService;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;
import biz.app.member.service.MemberInterestGoodsService;
import biz.app.search.model.SearchDqVo;
import biz.app.search.model.SearchResultVo;
import biz.app.search.result.SearchResult;
import biz.app.search.util.SearchUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewCommon;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.category.controller
* - 파일명		: CategoryController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("category")
public class CategoryController {
	
	private static final String[] NAVIGATION_BEST = {"베스트"};

	@Autowired private DisplayService displayService;
	@Autowired private PopupService popupService;
	
	@Autowired private Properties webConfig;
	
	@Autowired private SearchUtil util;
	
	@Autowired private MemberInterestGoodsService memberInterestGoodsService;
	
	
	/**
	 * BEST 화면
	 * @param 
	 * @return JSP
	 * @throws Exception
	 */
	@RequestMapping(value="indexBest")
	public String indexBest(ModelMap map, Session session, ViewBase view){
		
		view.setNavigation(NAVIGATION_BEST);

		// 1depth 카테고리만 조회
		List<DisplayCategoryVO> category = view.getDisplayCategoryList().stream()
				.filter(item -> Objects.equals(item.getDispLvl(), 1L))
				.collect(Collectors.toList());
		
		if (CollectionUtils.isEmpty(category)) {
			throw new CustomException(ExceptionConstants.ERROR_CATE_NO_DATA);
		}
				
		map.put("dispCornNo", view.getDispCornNoBest());
		map.put("category", category);
		map.put("session", session);
		map.put("view", view);
		
		
		// 팝업 가져오기
		PopupSO pso = new PopupSO();
		pso.setStId(view.getStId());
		pso.setSvcGbCd(view.getSvcGbCd()); // 서비스 구분코드 pc/mb
		pso.setDispClsfNo(view.getDispCornNoBest()); // 전시분류번호

		List<PopupVO> pvo = popupService.listPopupFO(pso);
		if (CollectionUtils.isNotEmpty(pvo)) {
			map.put("popupList", pvo);
		}

		return TilesView.common(new String[] { "category", "indexBest" });
	}
	
	/**
	 * 카테고리 화면
	 * @param 
	 * @return JSP
	 * @throws Exception
	 */
	@RequestMapping(value="indexCategory")
	public String indexCategory(ModelMap map, Session session, ViewBase view,
			@RequestParam(value = "dispClsfNo", required = true) Long dispClsfNo, String page, SearchDqVo searchVo) throws Exception {
		
		List<DisplayCategoryVO> allCategories = view.getDisplayCategoryList();
		
		List<DisplayCategoryVO> sCategories = new ArrayList<>();
		
		if (dispClsfNo == null) {
			throw new CustomException(ExceptionConstants.ERROR_CATE_NO_DATA);
		}
		
		List<DisplayCategoryVO> category = allCategories.stream()
				.filter(item -> Objects.equals(item.getDispClsfNo(), dispClsfNo))
				.collect(Collectors.toList());
		
		if (CollectionUtils.isEmpty(category) ) {
			throw new CustomException(ExceptionConstants.ERROR_CATE_NO_DATA);
		}
		
		String url = "indexCategory";
		
		if (category.get(0).getDispLvl() == 1) {
			url = "indexBigCategory";
			
			List<DisplayCategoryVO> mCategories = category.get(0).getSubDispCateList();
			map.put("midDispCateList", mCategories);
			
			// 대카테고리 전시 배너 정보 조회
			List<DisplayCornerTotalVO> list = displayService.getDisplayCornerItemTotalFO(dispClsfNo, null);
			
			int index = 1;
			for (DisplayCornerTotalVO vo : list) {
				if (vo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_30)) {		// 배너
					map.put("banner" + index, vo.getListBanner());
					index++;
				}
			}
			map.put("bannerCount", index-1);
			
			searchVo.setCateLcode(dispClsfNo+"");
			ModelMap result = search(session, searchVo);
			map.addAllAttributes(result);
		}
		else if (category.get(0).getDispLvl() == 2) {
			sCategories = category.get(0).getSubDispCateList();
			
			searchVo.setCateMcode(dispClsfNo+"");
			ModelMap result = search(session, searchVo);
			map.addAllAttributes(result);
		}
		else if (category.get(0).getDispLvl() == 3) {
			List<DisplayCategoryVO> upCategory = allCategories.stream()
					.filter(item -> Objects.equals(item.getDispClsfNo(), category.get(0).getUpDispClsfNo()))
					.collect(Collectors.toList());
			
			sCategories = upCategory.get(0).getSubDispCateList();
			
			searchVo.setCateScode(dispClsfNo+"");
			ModelMap result = search(session, searchVo);
			map.addAllAttributes(result);
		}
		
		// MD pick 상품 조회
		GoodsListSO gso = new GoodsListSO();
		
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDispClsfNo(dispClsfNo);
		
		List<String> webMobileGbCds = new ArrayList<>();			// WEB or Mobile에 따른 구분
		webMobileGbCds.add(FrontConstants.WEB_MOBILE_GB_00); 			// 전체
		webMobileGbCds.add(FrontConstants.WEB_MOBILE_GB_10); 			// WEB
		gso.setWebMobileGbCds(webMobileGbCds);
		gso.setWebMobileGbCd(FrontConstants.WEB_MOBILE_GB_10);			// WEB
		
		List<GoodsListVO> pick = displayService.listMdRcomGoodsFO(gso);
		map.put("pick", pick);
		
		
		// NAVIGATION PATH 설정 
		Map<Long,String> navigationMap = displayService.getFullCategoryNaviList(dispClsfNo);
    	view.setCateNavigation(navigationMap);   
    	
    	map.put("session", session);
		map.put("view", view);
		map.put("dispClsfNo", dispClsfNo);
		map.put("so", category.get(0));
		map.put("smallDispCateList", sCategories);
		map.put("searchVo", searchVo);
		map.put("page", page);
		
		// 팝업 가져오기 
		PopupSO pso = new PopupSO();
		pso.setStId(view.getStId());
		pso.setSvcGbCd(view.getSvcGbCd()); 		// 서비스 구분코드 pc/mb
		pso.setDispClsfNo(dispClsfNo); 			// 전시분류번호

		List<PopupVO> pvo = popupService.listPopupFO(pso);
		if (CollectionUtils.isNotEmpty(pvo)) {
			map.put("popupList", pvo);
		}
		
		return TilesView.common(new String[] { "category", url });		
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.brand.mobile
	 * - 파일명		: CategoryController.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 중/소 카테고리 검색
	 * </pre>
	 * @param session
	 * @param searchVo
	 * @param ajax
	 * @return
	 * @throws Exception
	 */
	private ModelMap search(Session session, SearchDqVo searchVo) throws Exception {
		SearchResult sr = new SearchResult();
		String searchIp = webConfig.getProperty("search.diquest.diver.ip");
		int searchPort = Integer.parseInt(webConfig.getProperty("search.diquest.diver.port"));
		searchVo.setSearchIp(searchIp);
		searchVo.setSearchPort(searchPort);
		searchVo.setSearchType("view");
		if (searchVo.getSearchDisplay() < FrontWebConstants.PAGE_ROWS_20)
			searchVo.setSearchDisplay(FrontWebConstants.PAGE_ROWS_20);
		
		if (searchVo.getSearchBrand() != null && searchVo.getSearchBrand().length == 0)
			searchVo.setSearchBrand(null);
		if (searchVo.getButtonPrice() != null && searchVo.getButtonPrice().length == 0)
			searchVo.setButtonPrice(null);
		
		int prmtCnt = 0;
		
		List<SearchResultVo> scateGroupList = new ArrayList<>();		// 소 카테고리 리스트
		List<SearchResultVo> brandGroupList = new ArrayList<>();		// 브랜드 리스트
		List<SearchResultVo> goodsList = new ArrayList<>();

		List<String> plist = new ArrayList<>(); 								// 가격대 버튼
		
		if ((searchVo.getCateLcode() != null && !searchVo.getCateLcode().equals(""))
				|| (searchVo.getCateMcode() != null && !searchVo.getCateMcode().equals(""))
				|| (searchVo.getCateScode() != null && !searchVo.getCateScode().equals(""))) {

//			Result[] result = util.getCateSearch(searchVo);
//			if (util.getReturnCode() > 0) {
//
//				GroupResult[] groupResult = result[0].getGroupResults();
//				searchVo.setGroup_totalSize(result[0].getTotalSize());						// 전체 상품 수
//
//				if (result[0].getRealSize() > 0) {
//					searchVo.setResultStartPrice(new String(result[0].getResult(0, 0)));	// 검색 결과의 최소가격
//				}
//
//				if (result[1].getRealSize() > 0) {
//					searchVo.setResultEndPrice(new String(result[1].getResult(0, 0)));		// 검색 결과의 최대가격
//				}
//
//				if (!searchVo.getResultStartPrice().equals("") && !searchVo.getResultEndPrice().equals("")) {
//					plist = util.plist(searchVo.getResultStartPrice(), searchVo.getResultEndPrice());
//				}
//
//				for (int r = 0; r < groupResult.length; r++) {
//					GroupResult group = groupResult[r];
//
//					for (int g = 0; g < group.getIds().length; g++) {
//						SearchResultVo searchResult = new SearchResultVo();
//						searchResult.setGroupNm(String.copyValueOf(group.getIds()[g]));
//						searchResult.setGroupCount(group.getIntValues()[g]);
//						String[] groupArr = searchResult.getGroupNm().split("\\>");
//
//						if (!String.copyValueOf(group.getIds()[g]).equals("")) {
//							if (r == 0) {
//								if (groupArr.length == 3)
//									scateGroupList.add(searchResult);
//							} else if (r == 1) {
//								brandGroupList.add(searchResult);
//							} 
//						}
//					}
//				}
//				
//				groupResult = result[2].getGroupResults();
//				for (int r = 0; r < groupResult.length; r++) {
//					GroupResult group = groupResult[r];
//
//					for (int g = 0; g < group.getIds().length; g++) {
//						SearchResultVo searchResult = new SearchResultVo();
//						searchResult.setGroupNm(String.copyValueOf(group.getIds()[g]));
//						searchResult.setGroupCount(group.getIntValues()[g]);
//
//						if (!String.copyValueOf(group.getIds()[g]).equals("") && r == 2 && "Y".equals(String.copyValueOf(group.getIds()[g]))) {
//							prmtCnt = group.getIntValue(g);
//						}
//					}
//				}
//				
//				searchVo.setTab_totalSize(result[2].getTotalSize());
//
//				goodsList = sr.getResult(result[3], searchVo);
//				searchVo.setShop_totalSize(result[3].getTotalSize());		// 조건 필터링 된 상품 수
//				searchVo.setTotalPage(((searchVo.getShop_totalSize() - 1) / searchVo.getSearchDisplay()) + 1);
//
//			}

		}

		Long mbrNo = session.getMbrNo();
		if (mbrNo > 0L) {
			MemberInterestGoodsSO so = new MemberInterestGoodsSO();
			so.setMbrNo(mbrNo);
			
			String [] goodsIds = new String[searchVo.getSearchDisplay()];
			for (int i=0; i<goodsList.size(); i++) {
				goodsIds[i] = goodsList.get(i).getGoodsid();
			}
			so.setGoodsIds(goodsIds);
			
			List<MemberInterestGoodsVO> ivo = memberInterestGoodsService.checkMemberInterestGoods(so);
			
			for (int i=0; i<goodsList.size(); i++) {
				goodsList.get(i).setInterestyn(ivo.get(i).getInterestYn());
			}
		}
		
		ModelMap map = new ModelMap();
		map.put("brandGroupList", brandGroupList);			// 브랜드 리스트
		map.put("prmtCnt", prmtCnt);						// 프리미엄 수
		map.put("searchVo", searchVo);						// 파라미터Vo
		map.put("goodsList", goodsList);					// 상품 리스트
		map.put("plist", plist);							// 가격대 버튼
		
		return map;
	}
	
}