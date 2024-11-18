package front.web.view.event.controller;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import biz.app.display.model.*;
import biz.app.display.service.SeoService;
import biz.app.event.model.EventBasePO;
import biz.app.event.model.EventEntryWinInfoPO;
import biz.app.event.service.FrontEventService;
import biz.common.service.CacheService;
import framework.common.exception.CustomException;
import framework.front.constants.FrontConstants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.display.service.DisplayService;
import biz.app.display.service.PopupService;
import biz.app.event.model.EventBaseSO;
import biz.app.event.model.EventBaseVO;
import biz.app.event.service.EventService;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.service.GoodsDispService;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponSO;
import biz.app.member.model.MemberCouponVO;
import biz.app.member.service.MemberCouponService;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.model.CouponTargetSO;
import biz.app.promotion.model.ExhibitionBaseVO;
import biz.app.promotion.model.ExhibitionSO;
import biz.app.promotion.model.ExhibitionThemeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.service.CouponService;
import biz.app.promotion.service.ExhibitionService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.NhnShortUrlUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.util.ImagePathUtil;
import front.web.config.view.ViewBase;
import front.web.view.event.model.CouponTargetParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Nullable;
import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.Null;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.event.controller
* - 파일명		: EventController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("event")
public class EventController {
	
	private static final String[] NAVIGATION_EVENT = {"이벤트"};
	private static final String[] NAVIGATION_EVENT_DETAIL = {"이벤트",""};
	private static final String[] NAVIGATION_EXHIBITION_DETAIL = {"기획전",""};
	
	@Autowired private Properties webConfig;

	@Autowired private EventService eventService;

	@Autowired private FrontEventService frontEventService;

	@Autowired private SeoService seoService;

	@Autowired private CouponService couponService;
	
	@Autowired private DisplayService displayService;
	
	@Autowired private MemberCouponService memberCouponService;
	
	@Autowired private MessageSourceAccessor message;
	
	@Autowired private PopupService popupService;
	
	@Autowired private ExhibitionService exhibitionService;
	
	@Autowired private GoodsDispService goodsDispService;
	
	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;

	@Autowired private CacheService cacheService;
	
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: EventController.java
	 * - 작성일		: 2021. 03. 30.
	 * - 작성자		: 김재윤
	 * - 설명		: 이벤트 상세
	 * </pre>
	* @param model
	* @param session
	* @param view
	* @param so
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="detail" , method = RequestMethod.GET)
	public String indexEventDetail(Session session, ViewBase view, EventBaseSO so, Model model
			, @RequestParam(value="returnUrl", required=false) String returnUrl){
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);

		if(Long.compare(Optional.ofNullable(so.getEventNo()).orElseGet(()->0L),0L) == 0){
			return TilesView.event(new String[] {"indexEventZone"});
		}
		EventBaseVO event = frontEventService.getEventDetail(so);

		//정상인 이벤트 아니면 임시로(주석 처리)
		if(!StringUtil.equals(event.getEventStatCd(),FrontConstants.EVENT_STAT_20)){
			//return "redirect:/event/main";
		}
		
		//SEO 정보 있을 시 SET
		Long seoInfoNo = Optional.ofNullable(event.getEventNo()).orElseGet(()->0L);
		if(Long.compare(seoInfoNo,0L)!=0){
			SeoInfoSO sso = new SeoInfoSO();
			sso.setSeoInfoNo(seoInfoNo);
			SeoInfoVO seo = seoService.getSeoInfo(sso);
			model.addAttribute("seoInfo",seo);
		}

		model.addAttribute("isLogin",Long.compare(Optional.ofNullable(session.getMbrNo()).orElseGet(()->0L),0L) == 0 ? FrontConstants.COMM_YN_N : FrontConstants.COMM_YN_Y); //로그인 여부
		model.addAttribute("event",event);
		model.addAttribute("replyList",frontEventService.listEventReply(so.getEventNo()));
		model.addAttribute("session",session);
		model.addAttribute("view",view);
		model.addAttribute("returnUrl",returnUrl);
		
		return TilesView.event(new String[] { "indexEventDetail" });
	}

	@LoginCheck
	@ResponseBody
	@RequestMapping(value="detail/aply" , method=RequestMethod.POST)
	public Map aply_update(EventEntryWinInfoPO po){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		if(Long.compare(Optional.ofNullable(po.getEventNo()).orElseGet(()->0L),0L) == 0){
			resultMap.put("resultCode",FrontConstants.CONTROLLER_RESULT_CODE_FAIL);
			return resultMap;
		}

		Session session = FrontSessionUtil.getSession();
		Long mbrNo = session.getMbrNo();
		po.setMbrNo(mbrNo);
		try{
			Long patiNo = frontEventService.saveEventEntryInfo(po);
			resultMap.put("resultCode",FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS);
			resultMap.put("resultMsg",patiNo);
		}catch(CustomException cep){
			resultMap.put("resultCode",cep.getExCode());
			resultMap.put("resultMsg",message.getMessage("business.exception."+cep.getExCode()));
		}
		return resultMap;
	}

	@LoginCheck
	@ResponseBody
	@RequestMapping(value="detail/rpt-aply" , method=RequestMethod.POST)
	public Map aply_report(EventEntryWinInfoPO po){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		//TO-DO :: 신고하기?
		return resultMap;
	}

	@LoginCheck
	@ResponseBody
	@RequestMapping(value="detail/delete-aply" , method=RequestMethod.POST)
	public Map aply_delete(EventEntryWinInfoPO po){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try{
			frontEventService.deleteEventEntryInfo(po);
			resultMap.put("resultCode",FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS);
		}catch(CustomException cep){
			resultMap.put("resultCode",cep.getExCode());
			resultMap.put("resultMsg",message.getMessage("business.exception."+cep.getExCode()));
		}
		return resultMap;
	}

	@RequestMapping(value = "detail/aply-list",method = RequestMethod.GET)
	public String replyList(Model model,EventBaseSO so){
		if(Long.compare(Optional.ofNullable(so.getEventNo()).orElseGet(()->0L),0L) == 0){
			return TilesView.event(new String[] {"indexEventZone"});
		}
		model.addAttribute("replyList",frontEventService.listEventReply(so.getEventNo()));
		model.addAttribute("session",FrontSessionUtil.getSession());
		return TilesView.event(new String[]{"indexEventAply"});
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: EventController.java
	* - 작성일		: 2021. 03. 30.
	* - 작성자		: 김재윤
	* - 설명		: 이벤트 목록
	* </pre>
	* @param model
	* @param view
	* @param session
	* @param so
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="main")
	public String indexEventZone(Model model, Session session, ViewBase view,EventBaseSO so){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		so.setRows(9999999);
		List<EventBaseVO> eventIngList = frontEventService.listIngEvent(so);
		List<EventBaseVO> eventEndList = frontEventService.listEndEvent(so);

		model.addAttribute("eventIngList",eventIngList);
		model.addAttribute("eventIngListSize",eventIngList.size());
		model.addAttribute("eventEndList",eventEndList);
		model.addAttribute("eventEndListSize",eventEndList.size());

		model.addAttribute("eventGb2Cd",so.getEventGb2Cd());
		model.addAttribute("session",session);
		model.addAttribute("view",view);

		return TilesView.event(new String[] {"indexEventZone"});
	}

	@RequestMapping(value="/shop/main")
	public String eventShopMain(Model model, Session session, ViewBase view,EventBaseSO so){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		DisplayCornerSO dso = new DisplayCornerSO();
		Long dispClsfNo = Optional.ofNullable(so.getDispClsfNo()).orElseGet(()->0l);

		if(Long.compare(dispClsfNo,0L)!=0) {
			dso.setCateCdL(getCateCdLFromDispClsfNo(dispClsfNo));    // 12564
			view.setDispClsfNo(dispClsfNo);
		}else {
			// LNB에서 넘어올 경우
			String dlgtPetGbCd = "";
			if(!StringUtil.isEmpty(dso.getLnbDispClsfNo())) {
				dispClsfNo = getDispClsfNoFromLnbDispClsfNo(dso.getLnbDispClsfNo());
				dso.setCateCdL(getCateCdLFromDispClsfNo(dispClsfNo));    // 12564
				view.setDispClsfNo(dispClsfNo);
			}
			// session에 현재 전시카테고리 번호 넣기
			session.setDispClsfNo(dispClsfNo);
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			
		}
		// view , session 현재 전시카테고리 번호 넣기
		view.setDispClsfNo(dispClsfNo);
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		session.setDispClsfNo(dispClsfNo);
		FrontSessionUtil.setSession(session);
		
		//펫 구분 코드 set
		if(Long.compare(Optional.ofNullable(session.getMbrNo()).orElseGet(()->0L),0L)!=0){
			session.setPetGbCd(displayService.updatePetGbCdLnbHistory(dispClsfNo, session.getMbrNo()));
		}
		//펫샵
		so.setEventGb2Cd(FrontConstants.EVENT_GB2_CD_40);
		model.addAttribute("dispClsfNo",dispClsfNo);

		//LNB SET
		DisplayCornerItemSO dscs = new DisplayCornerItemSO();
		dscs.setDispClsfNo(dispClsfNo);
		dscs.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(displayService.getBnrImgListFO(dscs));
		//LNB 중 카테고리
		view.setDisplayCategoryList(cacheService.listDisplayCategory());

		//이벤트 리스트
		so.setRows(9999999);
		so.setEventGb2Cd(CommonConstants.EVENT_GB2_CD_40);
		List<EventBaseVO> eventIngList = frontEventService.listIngEvent(so);
		List<EventBaseVO> eventEndList = frontEventService.listEndEvent(so);

		model.addAttribute("eventIngList",eventIngList);
		model.addAttribute("eventIngListSize",eventIngList.size());
		model.addAttribute("eventEndList",eventEndList);
		model.addAttribute("eventEndListSize",eventEndList.size());

		model.addAttribute("eventGb2Cd",so.getEventGb2Cd());
		model.addAttribute("session",session);
		model.addAttribute("view",view);
		model.addAttribute("so",dso);

		return TilesView.event(new String[] {"petShopEventContents"});
	}
	
	//전시번호로 펫샵 LNB - SELECT 선택값 가져오기
	private Long getCateCdLFromDispClsfNo(Long dispClsfNo){
		Long cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.dog"));
		if(Long.compare(dispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog"))) == 0){
			cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.dog"));
		}
		if(Long.compare(dispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat"))) == 0){
			cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.cat"));
		}
		if(Long.compare(dispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish"))) == 0){
			cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.fish"));
		}
		if(Long.compare(dispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal"))) == 0){
			cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.animal"));
		}
		return cateCdl;
	}

	//SELECT 선택값으로 전시번호 가져오기
	private Long getDispClsfNoFromLnbDispClsfNo(Long lnbDispClsfNo){
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.dog"));
		if(Long.compare(lnbDispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.dog"))) == 0){
			dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog"));
		}
		if(Long.compare(lnbDispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.cat"))) == 0){
			dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat"));
		}
		if(Long.compare(lnbDispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.fish"))) == 0){
			dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish"));
		}
		if(Long.compare(lnbDispClsfNo,Long.valueOf(webConfig.getProperty("disp.clsf.no.animal"))) == 0){
			dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal"));
		}
		return dispClsfNo;
	}

	@RequestMapping(value="main/event-ing")
	public String eventIngList(EventBaseSO so,Model model){
		int rows = 999999;
		so.setRows(rows);
		List<EventBaseVO> eventIngList = frontEventService.listIngEvent(so);

		model.addAttribute("eventIngList",eventIngList);
		model.addAttribute("eventIngListSize",eventIngList.size());

		return TilesView.event(new String[]{"include","eventListBody"});
	}

	@RequestMapping(value="main/event-end")
	public String eventEndList(EventBaseSO so,Model model){
		int rows = 999999;
		so.setRows(rows);
		List<EventBaseVO> eventEndList = frontEventService.listEndEvent(so);

		model.addAttribute("eventEndList",eventEndList);
		model.addAttribute("eventEndListSize",eventEndList.size());
		return TilesView.event(new String[]{"include","eventEndListBody"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: EventController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 특별 기획전
	* </pre>
	* @param map
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexSpecialExhibitionZone")
	public String indexSpecialExhibitionZone(ModelMap map, ExhibitionSO so, Session session, ViewBase view, String sortType){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		map.put("page", so.getPage());
	        
		// 메인 들어오면 so.getDispClsfNo()
		// 상세 들어오면 so.getCateCdL
		if(!StringUtil.isEmpty(so.getDispClsfNo())) {
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));    // 12564
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			}
			
			view.setDispClsfNo(so.getDispClsfNo());
		}else {
			// LNB에서 넘어올 경우 
			String dlgtPetGbCd = "";
			if(!StringUtil.isEmpty(so.getCateCdL())) {
				if(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")));
				} else {
				    view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
				}
			}
			// session에 현재 전시카테고리 번호 넣기
			session.setDispClsfNo(view.getDispClsfNo());
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			FrontSessionUtil.setSession(session);
		}
		
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(view.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		so.setMbrNo(session.getMbrNo());
		so.setDispClsfNo(so.getCateCdL());
		so.setDeviceGb(view.getDeviceGb());
		
		so.setExhbtGbCd(FrontWebConstants.EXHBT_GB_10); // 특별 기획전
		if(view.getDeviceGb() == FrontWebConstants.DEVICE_GB_10) {
			so.setRows(FrontWebConstants.PAGE_ROWS_8); // 한페이지에 데이터 8건씩
		}else if(view.getDeviceGb() == FrontWebConstants.DEVICE_GB_20) {
			so.setRows(FrontWebConstants.PAGE_ROWS_10); // 한페이지에 데이터 10건씩
		}
		List<ExhibitionVO> exhibitionList = exhibitionService.selectPageExhibitionFO(so, view.getStId(), view.getDeviceGb());

		map.put("exhibitionList", exhibitionList);
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		return TilesView.event(new String[] {"indexSpecialExhibitionZone"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : EventController.java
	 * - 작성일        : 2021. 3. 11.
	 * - 작성자        : YKU
	 * - 설명          : 특별기획전 더보기
	 * </pre>
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping("specialExhibitionZoneList")
	public String specialExhibitionZoneList(ModelMap map, Session session, ViewBase view, GoodsDispSO so){
		so.setRows(FrontWebConstants.PAGE_ROWS_8); // 한페이지에 데이터 20건씩
		so.setExhbtGbCd(FrontWebConstants.EXHBT_GB_10); // 특별 기획전
		
		List<GoodsDispVO> exhGoods = goodsDispService.getGoodsExhibited(view.getStId(), session.getMbrNo() ,so.getThmNo(), so.getExhbtNo(), so.getExhbtGbCd() , view.getDeviceGb(), so.getPage(), so.getRows() ,CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_Y, null);
		int exbCnt = goodsDispService.selectGoodsExhibitedCount(so);
		
		map.put("exhGoods", exhGoods);
		map.put("exbCnt", exbCnt);
		map.put("view", view);
		map.put("session", session);
		map.put("so", so);
		
		return TilesView.event(new String[] {"include", "specialExhibitionZoneList"});
	}
		
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : EventController.java
	 * - 작성일        : 2021. 3. 2.
	 * - 작성자        : YKU
	 * - 설명          : 일반기획전
	 * </pre>
	 * @param map
	 * @param so
	 * @param session
	 * @param view
	 * @return
	 */
	@RequestMapping(value="indexExhibitionZone")
	public String indexExhibitionZone(ModelMap map, ExhibitionSO so, Session session, ViewBase view){
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		// 메인 들어오면 so.getDispClsfNo()
		// 상세 들어오면 so.getCateCdL
		if(!StringUtil.isEmpty(so.getDispClsfNo())) {
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));    // 12564
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			}
			
			view.setDispClsfNo(so.getDispClsfNo());
		}else {
			// LNB에서 넘어올 경우 
			String dlgtPetGbCd = "";
			if(!StringUtil.isEmpty(so.getCateCdL())) {
				if(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")).equals(so.getCateCdL())) {
					view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")));
				} else {
				    view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
				}
			}
			// session에 현재 전시카테고리 번호 넣기
			session.setDispClsfNo(view.getDispClsfNo());
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			FrontSessionUtil.setSession(session);
		}
		
		//카테고리
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(view.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
				
		so.setDeviceGb(view.getDeviceGb());
		so.setMbrNo(session.getMbrNo());
		so.setDispClsfNo(so.getCateCdL());
		so.setExhbtGbCd(FrontWebConstants.EXHBT_GB_20); // 일반 기획전
		
		List<ExhibitionVO> exhibitionList = exhibitionService.selectPageExhibitionFO(so, view.getStId(), view.getDeviceGb());
		List<ExhibitionBaseVO> category = exhibitionList.stream()
                .map(p -> new ExhibitionBaseVO(p.getDispClsfNm(), p.getDispClsfNo())).distinct()
                .collect(Collectors.toList());
		 
		map.put("category", category);
		map.put("exhibitionList", exhibitionList);
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		return TilesView.event(new String[] {"indexExhibitionZone"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : EventController.java
	 * - 작성일        : 2021. 3. 10.
	 * - 작성자        : YKU
	 * - 설명          : 일반기획전
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value="exhibitionZoneList")
	public String exhibitionZoneList(ModelMap map, ViewBase view, Session session, ExhibitionSO so) {
		so.setTotalCount(8);
		so.setExhbtGbCd(FrontWebConstants.EXHBT_GB_20); // 일반 기획전
		List<ExhibitionVO> exhibitionList = exhibitionService.selectPageExhibitionFO(so, view.getStId(), view.getDeviceGb());
		
		map.put("exhibitionList", exhibitionList);
		map.put("view", view);
		map.put("session", session);
		return TilesView.event(new String[]{"include", "exhibitionZoneList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: EventController.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: syj
	* - 설명		:	기획전 상세
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param so
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexExhibitionDetail")
	public String indexExhibitionDetail(ModelMap map, Session session, ViewBase view, ExhibitionSO so){
		so.setDeviceGb(view.getDeviceGb());
		so.setExhbtGbCd(FrontWebConstants.EXHBT_GB_20); // 일반 기획전
		
		if(!StringUtil.isEmpty(so.getDispClsfNo())) {
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));    // 12564
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			}
			view.setDispClsfNo(so.getDispClsfNo());
		}
		
		// 1. 기획전 기본 정보
		ExhibitionVO base = exhibitionService.getExhibitionBase(so);
		if (base != null) {
	//		 2. 기획전 테마 리스트
			List<ExhibitionThemeVO>themeList = exhibitionService.listExhibitionTheme(so);

			ExhibitionSO tagSo = new ExhibitionSO();
			tagSo.setExhbtNo(so.getExhbtNo());
			List<ExhibitionVO> tag = exhibitionService.listExhibitionTagMap(so);
			
			if ( themeList.size() > 0 ) {
				ExhibitionThemeVO vo = themeList.get(0);
				List<GoodsDispVO> exhGoods = goodsDispService.getGoodsExhibited(view.getStId(), session.getMbrNo() ,vo.getThmNo(), vo.getExhbtNo(), so.getExhbtGbCd() , view.getDeviceGb(), null, null ,CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N);
				map.put("exhGoods", exhGoods);
			}
			
			map.put("tag", tag);
		}
		
		String shortUrl = null;
		try {
			shortUrl = NhnShortUrlUtil.getUrl(view.getStDomain()+"/event/exhShareView?exhbtNo="+so.getExhbtNo()+"&dispClsfNo="+so.getDispClsfNo());
		} catch (Exception e) {

		}
		
		//다른 기획전 명
		ExhibitionSO exhSo = new ExhibitionSO();
		exhSo.setDispClsfNo(so.getCateCdL());
		exhSo.setExhbtGbCd(FrontWebConstants.EXHBT_GB_20); // 일반 기획전
		exhSo.setExhbtNo(so.getExhbtNo());
		List<ExhibitionVO> exhbtName = exhibitionService.getThemeTitle(exhSo);
		
		//서브
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(so.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		
		map.put("shareUrl", shortUrl);
		map.put("exhbtName", exhbtName);
		map.put("exhbt", base);
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		return TilesView.event(new String[] {"indexExhibitionDetail"});
		
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : EventController.java
	 * - 작성일        : 2021. 8. 9.
	 * - 작성자        : YKU
	 * - 설명          : 기획전상세 공유하기
	 * </pre>
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "exhShareView")
	public String exhShareView(ModelMap map, ViewBase view 
			,@RequestParam(value="exhbtNo", required=false) Long exhbtNo
			,@RequestParam(value="dispClsfNo", required=false) Long dispClsfNo) {
		String title = "";
		String desc =  "";
		String imgPath = "";
		String orgPath = "";
		
		ExhibitionSO so = new ExhibitionSO();
		so.setExhbtNo(exhbtNo);
		so.setDispClsfNo(dispClsfNo);
		ExhibitionVO vo = exhibitionService.getExhibitionBase(so);
		
		if(!StringUtil.isEmpty(vo)) {
			title = vo.getExhbtNm();
			
			if(StringUtil.isNotEmpty(vo.getBnrImgPath()) || StringUtil.isNotEmpty(vo.getBnrMoImgPath())) {
				if(view.getDeviceGb() == CommonConstants.DEVICE_GB_10) {
					orgPath = vo.getBnrImgPath();
				}else {
					orgPath = vo.getBnrMoImgPath();
				}
				
				if(orgPath.lastIndexOf("cdn.ntruss.com") != -1) {
					imgPath = orgPath;
				}else {
					imgPath = ImagePathUtil.imagePath(orgPath, FrontConstants.IMG_OPT_QRY_560);
				}
			}
		}
		
		map.put("img", imgPath);
		map.put("desc", desc);
		map.put("title", title);
		
		map.put("pageGb", "exhibit");
		map.put("exhbtNo", exhbtNo);
		map.put("dispClsfNo", dispClsfNo);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_50);	
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		if(seoInfo != null) {
			map.put("site_name", seoInfo.getPageTtl());
		}else {
			map.put("site_name", "");
		}
		
		return TilesView.none(new String[]{"common", "common", "indexShareView"}); 
	}
	
	@RequestMapping("exibitionChange")
	@ResponseBody
	public ModelMap exibitionChange (Session session, ViewBase view, ExhibitionSO so){
		ModelMap map = new ModelMap();
		so.setDeviceGb(view.getDeviceGb());
		so.setExhbtGbCd(FrontWebConstants.EXHBT_GB_20); // 일반 기획전
		so.setDispYn(FrontWebConstants.COMM_YN_Y);
		so.setDispYn(FrontWebConstants.COMM_YN_Y);
		List<ExhibitionVO> exhbtName = exhibitionService.pageExhibitionFO(so);
		map.put("exhbtName", exhbtName);
		
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : EventController.java
	 * - 작성일        : 2021. 8. 9.
	 * - 작성자        : YKU
	 * - 설명          : 친구초대 공유하기
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param eventNo
	 * @return
	 */
	@RequestMapping(value = "eventShare")
	public String eventShare(ModelMap map, Session session, ViewBase view, EventBaseSO so
			,@RequestParam(value="eventNo", required=false) Long eventNo) {
		
		String title = "";
		String imgPath = "";
		String desc =  "";
		
		EventBaseVO vo = frontEventService.getEventDetail(so);
		so.setEventNo(eventNo);
		
		if(!StringUtil.isEmpty(so)) {
			title = vo.getTtl();
			desc = vo.getEventSubNm();
			String orgPath = vo.getDlgtImgPath();
			
			if(orgPath.lastIndexOf("cdn.ntruss.com") != -1) {
				imgPath = orgPath;
			}else {
				imgPath = ImagePathUtil.imagePath(orgPath, FrontConstants.IMG_OPT_QRY_560);
			}
		}
		
		map.put("title", title);
		map.put("img", imgPath);
		map.put("desc", desc);
		
		map.put("pageGb", "event");
		map.put("eventNo", eventNo);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		if(StringUtil.isNotEmpty(vo.getSeoInfoNo())) {
			seoSo.setSeoInfoNo(vo.getSeoInfoNo());
			SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
			if(seoInfo != null) {
				map.put("site_name", seoInfo.getPageTtl());
			}else {
				map.put("site_name", "");
			}
		}
		
		return TilesView.none(new String[]{"common", "common", "indexShareView"});
	}
}