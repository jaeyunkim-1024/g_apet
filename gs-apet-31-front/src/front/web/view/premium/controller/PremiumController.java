package front.web.view.premium.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.service.DisplayService;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.goods.service.GoodsService;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
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
* - 패키지명	: front.web.view.main.controller
* - 파일명		: PremiumController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 메인 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("premium")
public class PremiumController {
	
	private static final String[] NAVIGATION_PREMIUM = {"프리미엄"};

	@Autowired private DisplayService displayService;
	@Autowired private GoodsService goodsService;
	@Autowired private Properties webConfig;


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: PremiumController.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: hjko
	* - 설명		: 메인 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexPremium")
	public String indexPremium(ModelMap map, Session session, ViewBase view){
		view.setNavigation(NAVIGATION_PREMIUM);
		
		Long mbrNo = 0L;
		if(session.getMbrNo() != 0){
			mbrNo = session.getMbrNo();
		}
		map.put("session", session);
		map.put("view", view);
		
		// WEB or Mobile에 따른 구분
		List<String> webMobileGbCds = new ArrayList<>();
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_00);	// 전체
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_10);	// 웹
		
		GoodsListSO gso = new GoodsListSO();
		gso.setSidx("DISP_PRIOR_RANK");
		gso.setStId(view.getStId());
		gso.setWebMobileGbCds(webMobileGbCds);
		gso.setMbrNo(mbrNo);
		gso.setDispCornNoBest(view.getDispCornNoBest());
		
		// 상단 비정형 모든 아이템 조회(배너, 테마2)
		List<DisplayCornerTotalVO> cornerList = displayService.getDisplayCornerItemTotalFO(Long.valueOf(webConfig.getProperty("disp.clsf.no.premium")), gso);
		map.put("corners", cornerList);

		DisplayCategorySO dso = new DisplayCategorySO();
		
		//dso.setUpDispClsfNo(Long.valueOf(CommonConstants.DISP_CLSF_70));
		dso.setDispLvl(Long.valueOf(FrontConstants.DISP_LVL_1));
		map.put("dispClsfNos", displayService.listCategory(dso));
		
		return TilesView.common(new String[]{"premium","indexPremium"});
	}
	
	/**
	 * 
	 * - 프로젝트명	: 32.front.mobile
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2017. 3. 23.
	 * - 작성자		: wyjeong
	 * - 설명		: 상품 목록 조회
	 * </pre>
	 *
	 * @param session
	 * @param view
	 * @param listType
	 * @param listGb
	 * @param so
	 * 
	 * @return
	 */
	@RequestMapping(value = "getGoodsList")
	public String getGoodsList(ModelMap map, ViewBase view, String targetId, String listType, String ctgGb, GoodsListSO so, Session session){
		if (session.getMbrNo() != 0) {
			so.setMbrNo(session.getMbrNo());
		}
		so.setStId(view.getStId());
		so.setRows(FrontWebConstants.PAGE_ROWS_25);

		if (StringUtil.isEmpty(so.getSortType())) {
			so.setSortType(FrontWebConstants.SORT_TYPE_POPULAR);
		}
		
		if (StringUtil.isEmpty(so.getCtgGb())) {
			so.setCtgGb(FrontWebConstants.CATEGORY_GB_NORMAL);
		}
		
		// WEB or Mobile에 따른 구분
		List<String> webMobileGbCds = new ArrayList<>();
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_00); // 전체
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_10); // PC
		
		List<Long> dispClsfNos = new ArrayList<>();
		if(StringUtil.isEmpty(so.getDispClsfNo())){
			DisplayCategorySO dso = new DisplayCategorySO();
			
			//dso.setUpDispClsfNo(Long.valueOf(CommonConstants.DISP_CLSF_70));
			dso.setDispLvl(Long.valueOf(FrontConstants.DISP_LVL_1));
			List<DisplayCategoryVO> cateList = displayService.listCategory(dso);
			for(DisplayCategoryVO vo : cateList){
				dispClsfNos.add(vo.getDispClsfNo());
			}
			so.setRows(FrontWebConstants.PAGE_ROWS_25 * cateList.size());
		}else{
			dispClsfNos.add(so.getDispClsfNo());
		}
		so.setDispClsfNos(dispClsfNos);
		so.setDispCornNoBest(view.getDispCornNoBest());
		
		// 상품 리스트 조회
		List<GoodsListVO> goodsList = goodsService.pageGoodsByDispClsfCornNo(so);

		map.put("goodsList", goodsList);

		map.put("view", view);
		map.put("targetId", targetId);
		map.put("listType", listType);
		map.put("ctgGb", ctgGb);
		map.put("so", so);

		return TilesView.none(new String[] { "goods", "indexGoodsList" });
	}
}