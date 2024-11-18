package front.web.view.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.member.model.MemberInterestBrandSO;
import biz.app.member.model.MemberInterestBrandVO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;
import biz.app.member.service.MemberInterestBrandService;
import biz.app.member.service.MemberInterestGoodsService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyInterestController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 관심상품 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage/interest")
public class MyInterestController {

	@Autowired private CacheService cacheService;
	
	@Autowired private MemberInterestGoodsService memberInterestGoodsService;
	
	@Autowired private MemberInterestBrandService  memberInterestBrandService;
	

	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: MyInterestController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 위시리스트상품 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexWishList")
	public String indexWishList(ModelMap map, MemberInterestGoodsSO so, Session session, ViewBase view){
		
		// 회원 관심 상품 목록
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		
		// 회원 관심 상품 검색 조건
		if("".equals(so.getSidx()) || so.getSidx() == null){
			so.setSidx("SYS_REG_DTM");
		}
		if(so.getSidx().equals("SYS_REG_DTM")){
			so.setSord(FrontWebConstants.SORD_DESC);
		}
		if("".equals(so.getSord()) || so.getSidx() == null){
			so.setSord(FrontWebConstants.SORD_DESC);
		}
		
		so.setMbrNo(session.getMbrNo());
		so.setStId(view.getStId());
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		
		// 회원 관심 상품  목록 조회
		List<MemberInterestGoodsVO> wishList = memberInterestGoodsService.pageMemberInterestGoods(so);
		
		map.put("wishList", wishList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_INTEREST_WISH);
		map.put("goodsStatCdList", this.cacheService.listCodeCache(CommonConstants.GOODS_STAT, null, null, null, null, null));
		
		return  TilesView.mypage(new String[]{"interest", "indexWishList"});
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 31.front.web
	 * - 파일명		: MyInterestController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명			: 위시리스트브랜드 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="indexWishListBrand")
	public String indexWishListBrand(ModelMap map, MemberInterestBrandSO so, Session session, ViewBase view){
		
		// 회원 관심 상품 목록
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		// 회원 관심 상품 검색 조건
		so.setSidx("SYS_REG_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		
		so.setMbrNo(session.getMbrNo());
		
		//회원 관심 브랜드 목록 조회
		List<MemberInterestBrandVO> wishListBrand = memberInterestBrandService.pageMemberInterestBrands(so);
		
		map.put("wishListBrand", wishListBrand);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);
		
		return  TilesView.mypage(new String[]{"interest", "indexWishListBrand"});
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: MyInterestController.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: phy
	* - 설명			: 회원 관심 상품 삭제
	* </pre>
	* @param goodsIds
	* @return
	* @throws Exception
	*/
	@RequestMapping("deleteWish")
	@ResponseBody
	public ModelMap deleteWish(String[] goodsIds, Session session) {
		
		Long mbrNo = session.getMbrNo();
		
		this.memberInterestGoodsService.deleteMemberInterestGoods(mbrNo, goodsIds);
		
		return new ModelMap();
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명		: 34.front.web
	* - 파일명		: MyInterestController.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명			: 회원 관심 브랜드 삭제
	* </pre>
	* @param bndNos
	* @param session
	* @return
	 */
	@RequestMapping("deleteWishBrands")
	@ResponseBody
	public ModelMap deleteWishBrands(Long[] bndNos, Session session) {

		Long mbrNo = session.getMbrNo();

		this.memberInterestBrandService.deleteMemberInterestBrand(mbrNo, bndNos);

		return new ModelMap();
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 34.front.brand.mobile
	* - 파일명		: MyPageController.java
	* - 작성일		: 2017. 5. 29.
	* - 작성자		: tobe
	* - 설명		: 공통 최근 본 상품
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param request
	* @return
	 */
	@RequestMapping(value="wishList")
	@ResponseBody
	public ModelMap indexRecentViews(MemberInterestGoodsSO so, Session session, ViewBase view, HttpServletRequest request){

		// 회원 관심 상품 목록
		so.setRows(FrontWebConstants.PAGE_ROWS_12);
		
		// 회원 관심 상품 검색 조건
		if(so.getSidx() == null){
			so.setSidx("SYS_REG_DTM");
		}else{
			so.setSidx(so.getSidx());
		}
		if(so.getSidx().equals("SYS_REG_DTM")){
			so.setSord(FrontWebConstants.SORD_DESC);
		}
		if(so.getSord() == null){
			so.setSord(FrontWebConstants.SORD_DESC);
		}else{
			so.setSord(so.getSord());
		}
		so.setMbrNo(session.getMbrNo());
		so.setStId(view.getStId());
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		
		// 회원 관심 상품  목록 조회
		List<MemberInterestGoodsVO> wishList = memberInterestGoodsService.pageMemberInterestGoods(so);
		
		ModelMap map = new ModelMap();
		map.put("wishList", wishList);
		map.put("session", session);
		map.put("view", view);

		return  map;
	}
	
	@LoginCheck
	@RequestMapping("pageMemberInterestBrand")
	@ResponseBody
	public ModelMap pageMemberInterestBrand(Session session, MemberInterestBrandSO so, ViewBase view) {
		
		ModelMap map = new ModelMap();
//		pc일 경우 처음10개 모바일 6개 + 그 다음 30
		if(StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10)) {
			so.setRows(FrontWebConstants.PAGE_ROWS_30 + FrontWebConstants.PAGE_ROWS_10);
		}else{
			so.setRows(FrontWebConstants.PAGE_ROWS_30 + FrontWebConstants.PAGE_ROWS_6);
		}

		so.setSidx("SYS_REG_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		
		so.setMbrNo(session.getMbrNo());
		
		//회원 관심 브랜드 목록 조회
		List<MemberInterestBrandVO> wishListBrand = memberInterestBrandService.pageMemberInterestBrands(so);
		
		map.put("wishListBrand", wishListBrand);
		map.put("brandSO", so);
		
		return map;
		
	}

}