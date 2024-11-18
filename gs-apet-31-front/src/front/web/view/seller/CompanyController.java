package front.web.view.seller;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanySO;
import biz.app.company.service.CompanyService;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.service.DisplayService;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.goods.service.GoodsService;
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
 * - 패키지명		: front.web.view.introduce.controller
 * - 파일명		: CompanyController.java
 * - 작성자		: ValueFactory
 * - 설명		: 업체 Controller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("seller")
public class CompanyController {
	
	private static final String[] NAVIGATION_COMPANY_DETAIL = {"판매자샵"};
	
	@Autowired private DisplayService displayService;
	@Autowired private CompanyService companyService;
	@Autowired private GoodsService goodsService;

	
	/**
	 * 샐러샵 메인
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 */
	@RequestMapping(value="indexCompDetail")
	public String indexCompDetail(ModelMap map, Session session, ViewBase view, Long compNo, GoodsListSO so,
			Integer menu1, Integer menu2) {
		// 업체 정보 조회
		CompanySO cso = new CompanySO();
		cso.setStId(view.getStId());
		cso.setCompNo(so.getCompNo());
		cso.setCompStatCd(CommonConstants.COMP_STAT_20);
		CompanyBaseVO comp = companyService.getCompany(cso);
		if (comp == null)
			throw new CustomException(ExceptionConstants.ERROR_SELLER_NO_DATA);
		
		map.put("comp", comp);
		
		// 전체 인기 상품 
		so.setStId(view.getStId());
		so.setDispCornNoBest(view.getDispCornNoBest());
		so.setCompNo(so.getCompNo());
		
		List<String> webMobileGbCds = new ArrayList<>();		// WEB or Mobile에 따른 구분
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_00); 	// 전체
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_10); 	// 웹
		so.setWebMobileGbCds(webMobileGbCds);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);	// 웹
		
		so.setMbrNo(session.getMbrNo());
		so.setLimitCount(FrontConstants.PAGE_ROWS_5);
		
		List<GoodsListVO> goods = goodsService.listBestGoodsByComp(so);
		map.put("goods", goods);		
		
		// 카테고리 조회
		DisplayCategorySO dso = new DisplayCategorySO();
		dso.setStId(view.getStId());
		dso.setCompNo(so.getCompNo());
		List<DisplayCategoryVO> cateList = displayService.listDisplayCategoryByComp(dso);
		
		List<DisplayCategoryVO> bigCateList = cateList.stream()
				.filter(item -> Objects.equals(item.getDispLvl(), 1L))
				.collect(Collectors.toList());
		
		if (bigCateList != null && bigCateList.size() == 1)
			bigCateList = cateList.stream()
						.filter(item -> Objects.equals(item.getDispLvl(), 2L))
						.collect(Collectors.toList());
		map.put("cateList", bigCateList);
		
		view.setNavigation(NAVIGATION_COMPANY_DETAIL);
		
		if (menu1 == null)
			menu1 = -1;
		if (menu2 == null)
			menu2 = -1;
		
		map.put("session", session);
		map.put("view", view);
		map.put("menu1", menu1);
		map.put("menu2", menu2);
		
		return TilesView.common(new String[] { "seller", "indexCompanyDetail" });
	}
}