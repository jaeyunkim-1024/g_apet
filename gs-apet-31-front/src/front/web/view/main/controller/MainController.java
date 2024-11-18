package front.web.view.main.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Properties;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.gson.Gson;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.DisplayGroupBuySO;
import biz.app.display.model.DisplayGroupBuyVO;
import biz.app.display.model.DisplayHotDealSO;
import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupVO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.PopupService;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import framework.common.constants.CommonConstants;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.main.controller
* - 파일명		: MainController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 메인 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("")
public class MainController {
	
	private static final String[] NAVIGATION_DEAL = {"DC 딜"};
	private static final String[] NAVIGATION_GROUPBUY = {"팔때사"};

	@Autowired private PopupService popupService;
	@Autowired private DisplayService displayService;
	@Autowired private MemberService memberService;
	@Autowired private PushService pushService;
	@Autowired private Properties webConfig;
	


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MainController.java
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
	@RequestMapping(value="main")
	public String main(ModelMap map, Session session, ViewBase view){
		SessionUtil.removeAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL);
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


		// 비정형 모든 아이템 조회
		List<DisplayCornerTotalVO> cornerList = displayService.getDisplayCornerItemTotalFO(Long.valueOf(webConfig.getProperty("disp.clsf.no.main")), gso);


		// 딜 상품 목록 조회 - 전시구좌 303
		/*List<DisplayCornerTotalVO> dealCorner = cornerList.stream().filter(item -> Objects.equals(item.getDispCornNo(), 303L)).collect(Collectors.toList());

		DisplayHotDealSO so = new DisplayHotDealSO();
		if(dealCorner != null && dealCorner.size() > 0){
			DisplayCornerTotalVO deal = dealCorner.get(0);
			so.setDispClsfCornNo(deal.getDispClsfCornNo());
			so.setRows(deal.getShowCnt().intValue());
			so.setSidx("DISP_PRIOR_RANK");
		}
		so.setMbrNo(mbrNo);
		so.setStId(view.getStId());

		// WEB or Mobile에 따른 구분
		so.setWebMobileGbCds(webMobileGbCds);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		List<DisplayHotDealVO> dealList = displayService.listDisplayHotDeal(so);*/

		// 공동구매 상품 목록 조회
		List<DisplayCornerTotalVO> groupCorner = cornerList.stream().filter(item -> Objects.equals(item.getDispCornNo(),
				Long.valueOf(webConfig.getProperty("disp.corn.no.main.group")))).collect(Collectors.toList());

		DisplayGroupBuySO so = new DisplayGroupBuySO();
		if (CollectionUtils.isNotEmpty(groupCorner)) {
			DisplayCornerTotalVO group = groupCorner.get(0);
			so.setDispClsfCornNo(group.getDispClsfCornNo());
			so.setRows(group.getShowCnt().intValue());
			so.setSidx("DISP_PRIOR_RANK");
			so.setSord(FrontWebConstants.SORD_ASC);
		}
		so.setMbrNo(mbrNo);
		so.setStId(view.getStId());

		// WEB or Mobile에 따른 구분
		so.setWebMobileGbCds(webMobileGbCds);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		List<DisplayGroupBuyVO> groupList = displayService.pageGroupBuyGoods(so);

		Gson gson = new Gson();

		map.put("corners", gson.toJson(cornerList));

		map.put("confCornerStr", webConfig.getProperty("disp.corn.no.main"));
		map.put("confCorner", webConfig.getProperty("disp.corn.no.main").split(":"));
		map.put("groupList", groupList);

		/* 팝업 가져오기 */
		PopupSO pso = new PopupSO();
		String stGbCd = "10";//CommonConstants.SHOW_GB_10;

		pso.setStId(view.getStId());
		pso.setStGbCd(stGbCd); //사이트 구분
		pso.setSvcGbCd(view.getSvcGbCd()); // 서비스 구분코드 pc/mb
		pso.setDispClsfNo(view.getMainDispClsfNo());  // 전시분류번호

		List<PopupVO> pvo = popupService.listPopupFO(pso);
		if(CollectionUtils.isNotEmpty(pvo)){
			map.put("popupList",pvo);
		}
		return "main/indexMain";

	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MainController.java
	* - 작성일		: 2016. 3. 17.
	* - 작성자		:
	* - 설명		: 딜
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param kind
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="deal/indexDeal")
	public String indexDeal(ModelMap map, Session session, ViewBase view, DisplayHotDealSO so) {

		view.setNavigation(NAVIGATION_DEAL);

		so.setRows(FrontWebConstants.PAGE_ROWS_20); 		// 한페이지 데이터 20건씩

		if (session.getMbrNo() != 0) {
			so.setMbrNo(session.getMbrNo());
		}
		so.setStId(view.getStId());

		// WEB or Mobile에 따른 구분
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		//List<DisplayHotDealVO> dealList = displayService.listDisplayHotDeal(so);
		//map.put("dealList", dealList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);

		return TilesView.common(new String[] { "main", "indexDeal" });

	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MainController.java
	* - 작성일		: 2017. 08. 21.
	* - 작성자		:
	* - 설명		: 공동구매
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param kind
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="deal/indexGroupBuy")
	public String indexGroupBuy(ModelMap map, Session session, ViewBase view, DisplayGroupBuySO so) {

		view.setNavigation(NAVIGATION_GROUPBUY);

		// 1. 공동구매 전시 코너 상품 조회 so
		// WEB or Mobile에 따른 구분
		List<String> webMobileGbCds = new ArrayList<>();
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_00); // 전체
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_10); // 웹

		GoodsListSO gso = new GoodsListSO();
		gso.setSidx("DISP_PRIOR_RANK");
		gso.setStId(view.getStId());
		gso.setWebMobileGbCds(webMobileGbCds);
		if (session.getMbrNo() != 0)
			gso.setMbrNo(session.getMbrNo());


		// 2. 공동구매 상품 조회 so
		if (session.getMbrNo() != 0) {
			so.setMbrNo(session.getMbrNo());
		}
		so.setStId(view.getStId());

		// WEB or Mobile에 따른 구분
		so.setWebMobileGbCds(webMobileGbCds);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		// 공동구매 상단 전시 코너 조회
		List<DisplayCornerTotalVO> cornerList = displayService.getDisplayCornerItemTotalFO(Long.valueOf(webConfig.getProperty("disp.clsf.no.groupbuy")), gso);
		Integer currPage = so.getPage();

		boolean bTopGoods = false;
		for (DisplayCornerTotalVO vo : cornerList) {
			// 배너 이미지
			if (vo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_30) && CollectionUtils.isNotEmpty(vo.getListBanner())) {
				map.put("banner", vo.getListBanner().get(0));
			}
			// 상품
			if (vo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_60) && CollectionUtils.isNotEmpty(vo.getGoodsList())) {
				bTopGoods = true;

				so.setRows(FrontWebConstants.PAGE_ROWS_2);
				so.setGoodsInYn("Y");
				List<String> goodsIds = new ArrayList<>();

				for (GoodsListVO goods : vo.getGoodsList()) {
					goodsIds.add(goods.getGoodsId());
				}
				so.setGoodsIds(goodsIds);

				so.setDispClsfCornNo(vo.getDispClsfCornNo());
				so.setSidx("DISP_PRIOR_RANK");
				so.setSord(FrontWebConstants.SORD_ASC);
				so.setPage(1);

				List<DisplayGroupBuyVO> top = displayService.pageGroupBuyGoods(so);
				map.put("topGoods", top);
			}
		}

		if (StringUtil.isEmpty(so.getSortType()))
			so.setSortType(FrontWebConstants.SORT_TYPE_POPULAR);

		switch (so.getSortType()) {
			case FrontWebConstants.SORT_TYPE_NEW:				// 신상품 순
				so.setSidx("SYS_REG_DTM");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			case FrontWebConstants.SORT_TYPE_POPULAR:			// 인기상품 순
				so.setSidx("TOTAL_SCR");
				so.setSord(FrontWebConstants.SORD_ASC);
				break;
			case FrontWebConstants.SORT_TYPE_PRICE_LOW:			// 낮은가격 순
				so.setSidx("SALE_AMT");
				so.setSord(FrontWebConstants.SORD_ASC);
				break;
			case FrontWebConstants.SORT_TYPE_PRICE_HIGH:		// 높은가격 순
				so.setSidx("SALE_AMT");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			case FrontWebConstants.SORT_TYPE_REVIEW:			// 리뷰많은 순
				so.setSidx("REVIEW_CNT");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			default:
				break;	
		}

		so.setRows(FrontWebConstants.PAGE_ROWS_20); 		// 한페이지 데이터 20건씩
		if (bTopGoods) {
			so.setDispClsfCornNo(null);
			so.setGoodsInYn("N");
			so.setPage(currPage);
		}

		if (StringUtil.isNotEmpty(so.getGoodsId())) {
			DisplayGroupBuySO voPage = displayService.getGroupBuyGoodPage(so);
			Integer page = 1;
			if (voPage != null)
				page = voPage.getGoodsPage();

			so.setPage(page);
		}

		List<DisplayGroupBuyVO> list = displayService.pageGroupBuyGoods(so);

		map.put("list", list);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);

		return TilesView.common(new String[] { "main", "indexGroupBuy" });

	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MainController.java
	 * - 작성일		: 2021 02. 26.
	 * - 작성자		: 김재윤
	 * - 설명		: 초대 코드 환영 페이지
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="welcome" , method= RequestMethod.GET)
	public String indexInvite(Model model, Session session, ViewBase view ,String frdRcomKey
			, @RequestParam(value="returnUrl",required = false)String returnUrl
			, @RequestParam(value="method",required = false)String method){
		
		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();
		
		model.addAttribute("session", session);
		model.addAttribute("view", view);
		model.addAttribute("method", StringUtil.isEmpty(method) ? "GET" : method);
		model.addAttribute("frdRcomKey",frdRcomKey);
		model.addAttribute("returnUrl",StringUtil.isEmpty(returnUrl) ? "/" : returnUrl);
		
		Cookie cookie = new Cookie(FrontConstants.SESSION_INVITE_SNS, frdRcomKey);
		cookie.setMaxAge(-1);
		cookie.setPath("/");
		
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		
		String envGb = bizConfig.getProperty("envmt.gb");
		if(!envGb.equals(FrontConstants.ENVIRONMENT_GB_LOCAL)) {cookie.setSecure(true);}
		
		String domain = bizConfig.getProperty("cookie.domain");
		cookie.setDomain(domain);
		response.addCookie(cookie); 
		
		return TilesView.main(new String[]{"indexInvite"});
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MainController.java
	 * - 작성일		: 2021 02. 26.
	 * - 작성자		: 김재윤
	 * - 설명		: 알림 List
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="alertList")
	public String indexAlertList(Model model,Session session,ViewBase view){
		List<PushVO> pushList = new ArrayList<>();
		Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->0L);
		    // 알림 리스트
		    if(mbrNo != 0L) {
		    	PushSO psSo = new PushSO();
		  	    psSo.setMbrNo(session.getMbrNo());
		  	    pushList = pushService.getFrontPushList(psSo);
		  	    
		  	    for(PushVO vo : pushList) {
		  		    JSONParser parser = new JSONParser();
		  		    JSONObject obj;
					try {
						obj = (JSONObject) parser.parse(vo.getSndInfo());
						vo.setLandingUrl(String.valueOf(obj.get("landingUrl")));
					} catch (ParseException e) {
						e.printStackTrace();
					}
		  	  }
		}
		
		// 알림 수신 여부가 Y일 시 N으로 UPDATE
		if(StringUtil.equals(session.getAlmRcvYn() , CommonConstants.COMM_YN_Y)) {
			MemberBaseVO vo = new MemberBaseVO();
			vo.setMbrNo(mbrNo);
			int result = memberService.updateAlmRcvYn(vo);
			if(result > 0 ) {
				session.setAlmRcvYn(CommonConstants.COMM_YN_N);
				FrontSessionUtil.setSession(session);
			}
		}
		    
		model.addAttribute("session" , session);
		model.addAttribute("pushList" , pushList);
		model.addAttribute("view" , view);
		if(StringUtil.equals(view.getDeviceGb() , CommonConstants.DEVICE_GB_10)) {
			return "/main/indexAlertListPc";
		}else {
			return "/main/indexAlertList";	
		}
	}
	
	@ResponseBody
	@RequestMapping(value="updateAlmRcvYn")
	public int updateAlmRcvYn(Model model , ViewBase view , Long mbrNo) {
		MemberBaseVO vo = new MemberBaseVO();
		vo.setMbrNo(mbrNo);
		int result = memberService.updateAlmRcvYn(vo);
		if(result > 0 ) {
			Session session = FrontSessionUtil.getSession();
			session.setAlmRcvYn(CommonConstants.COMM_YN_N);
			FrontSessionUtil.setSession(session);
		}
		
		return result;
	}
	
	
}