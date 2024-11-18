package front.web.view.mypage.controller;

import biz.app.claim.service.ClaimService;
import biz.app.contents.model.VodSO;
import biz.app.display.service.DisplayService;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.member.model.*;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberInterestBrandService;
import biz.app.member.service.MemberInterestGoodsService;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderSO;
import biz.app.order.model.OrderStatusVO;
import biz.app.order.service.OrderService;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.service.PetService;
import biz.app.petlog.model.PetLogListSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.app.tv.service.TvDetailService;
import biz.common.service.CacheService;
import biz.interfaces.gsr.model.GsrMemberPointSO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.StringUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Optional;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyPageController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 마이페이지 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage")
public class MyPageController {

	@Autowired private OrderService orderService;
	@Autowired private ClaimService claimService;
	@Autowired private CacheService codeCacheService;
	@Autowired private MemberInterestGoodsService memberInterestGoodsService;
	@Autowired private MemberInterestBrandService memberInterestBrandService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private DisplayService displayService;
	@Autowired private PetService petService;
	@Autowired private MemberCouponService memberCouponService;
	@Autowired private GsrService gsrService;
	@Autowired private MemberService memberService;
	@Autowired private TvDetailService tvDetailService;
	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyPageController.java
	* - 작성일		: 2021. 3. 9.
	* - 작성자		: 이지희
	* - 설명			: 마이페이지 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="indexMyPage")
	public String indexMyPage(ModelMap map, Session session, ViewBase view){
		
		MemberBaseSO mso = new MemberBaseSO();
		mso.setMbrNo(session.getMbrNo()); 
		MemberBaseVO vo = memberService.getMemberBase(mso);
		map.put("ciCtfVal", vo.getCiCtfVal());
		map.put("prflImg", vo.getPrflImg());

		//마이펫 리스트
		PetBaseSO petSo = new PetBaseSO();
		petSo.setMbrNo(session.getMbrNo());
		//petSo.setSort("sys_reg_dtm");
		List<PetBaseVO> petList = petService.listPetBase(petSo);
		map.put("petList", petList);
		
		//gs포인트 조회
		String gsptNo = vo.getGsptNo();
		if(gsptNo != null && !gsptNo.equals("")) {
			GsrMemberPointSO gsrSo = new GsrMemberPointSO();
			gsrSo.setCustNo(gsptNo);
			try {
				GsrMemberPointVO gspointVo = gsrService.getGsrMemberPoint(gsrSo);
				map.put("gsPoint", gspointVo.getTotRestPt());
			}catch (Exception e) {
				map.put("gsPoint", 0);
			}
		}else {
			map.put("gsPoint", 0);
		}
		session.setGsptNo(gsptNo);
		map.put("gsptStateCd",vo.getGsptStateCd());
		map.put("gsptUseYn",vo.getGsptUseYn());

		//등급조회
		CodeDetailVO grdCodeList = codeCacheService.getCodeCache(CommonConstants.MBR_GRD_CD, session.getMbrGrdCd());
		map.put("mbrGrd", grdCodeList.getDtlNm());
		
		//보유 쿠폰 갯수 조회
		MemberCouponSO couponSo = new MemberCouponSO();
		couponSo.setSidx("CB.CP_APL_CD ASC, CB.APL_VAL DESC , MC.USE_END_DTM ASC , CB.SYS_REG_DTM");
		couponSo.setSord("DESC");
		couponSo.setRows(99999);
		couponSo.setUseYn(FrontConstants.USE_YN_N);
		couponSo.setMbrNo(session.getMbrNo()); 
		map.put("couponCnt", memberCouponService.getMemberCouponCountMyPage(couponSo));
		
		//최근 시청한 영상
		//최근 시청한 영상 목록 조회
		TvDetailSO tso = new TvDetailSO();
		tso.setMbrNo(session.getMbrNo());
		tso.setLimit(6);
		List<TvDetailVO> recentVdoList = tvDetailService.selectRecentVdoList(tso);
		map.put("recentVdoList", recentVdoList);
		
		//마이 찜 리스트 정보
		//펫tv 
    	VodSO so = new VodSO();
    	//펫로그
    	PetLogListSO pso = new PetLogListSO();
    	//펫샵
    	MemberInterestGoodsSO mgSO = new MemberInterestGoodsSO();
    	
    	if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
    		so.setMbrNo(session.getMbrNo());
    		pso.setMbrNo(session.getMbrNo());
    		
    		mgSO.setMbrNo(session.getMbrNo());
    		mgSO.setStId(view.getStId());
    		mgSO.setDeviceGb(view.getDeviceGb());
    		// TODO 임시 처리..
//    		mgSO.setRows(FrontWebConstants.PAGE_ROWS_100);
    		mgSO.setSidx("SYS_REG_DTM");
    		mgSO.setSord(FrontWebConstants.SORD_DESC);
    	}
		map.put("myWishListTv", displayService.myWishListTv(so));
		map.put("myWishListLog", displayService.myWishListLog(pso));
		map.put("myWishListGoods", memberInterestGoodsService.listMemberInterestGoods(mgSO));
		
		//최근 본 상품 갯수
		GoodsDtlInqrHistSO dtlHistSO = new GoodsDtlInqrHistSO();
		dtlHistSO.setMbrNo(session.getMbrNo());
		dtlHistSO.setStId(view.getStId());
		List<GoodsBaseVO> goodsDtlHistList = goodsDtlInqrHistService.listGoodsDtlInqrHist(dtlHistSO);
		
		map.put("goodsDtlHistList", goodsDtlHistList);
		
		
		//주문진행건 입금대기~배송완료 까지 갯수 카운트
		OrderSO orderso = new OrderSO();
		if (orderso.getPeriod() == null) {orderso.setPeriod("3");}
		orderso.setSidx("ORD_ACPT_DTM");
		orderso.setSord(FrontWebConstants.SORD_DESC);
		orderso.setRows(FrontWebConstants.PAGE_ROWS_10);	
		orderso.setMbrNo(session.getMbrNo());
		orderso.setOrdrShowYn("Y");
		
		//주문상태별 갯수 선택 검색
		orderso.setArrOrdDtlStatCd(orderso.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		orderso.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", orderso.getOrdAcptDtmStart()));
		orderso.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", orderso.getOrdAcptDtmEnd()));
		
		//주문진행상태 카운트
		OrderStatusVO orderSummary = orderService.listOrderCdCountList( orderso );
		
		int orderCnt = orderSummary.getOrdAcpt() + orderSummary.getOrdCmplt() + orderSummary.getOrdShpRdy()
						+ orderSummary.getOrdShpIng() + orderSummary.getOrdShpCmplt()  ;
		map.put("orderSummary", orderCnt);		
		
		
		/*************************
		 * 주문 정보 요약
		 ************************//*
		OrderSO os = new OrderSO();
		os.setMbrNo(session.getMbrNo());
 		os.setOrdAcptDtmStart(DateUtil.convertSearchDate("S", Timestamp.valueOf(LocalDateTime.now().minusMonths(1).plusDays(1))));
 		os.setOrdAcptDtmEnd(DateUtil.convertSearchDate("E", Timestamp.valueOf(LocalDateTime.now())));
		OrderStatusVO orderSummary = orderService.listOrderCdCountList(os);
		map.put("orderSummary", orderSummary);

		// 나의 최근 교환/반품 현황
		ClaimSO cso = new ClaimSO();
		cso.setMbrNo(session.getMbrNo());
		cso.setClmAcptDtmStart(DateUtil.convertSearchDate("S", Timestamp.valueOf(LocalDateTime.now().minusMonths(1).plusDays(1))));
		cso.setClmAcptDtmEnd(DateUtil.convertSearchDate("E", Timestamp.valueOf(LocalDateTime.now())));
		ClaimSummaryVO claimSummary = claimService.claimSummary(cso);
		map.put("claimSummary", claimSummary);

		*//*************************
		 * 최근 주문내역
		 * - 최근 한달내에 최대 5건
		 ************************//*
 		os.setRows(FrontWebConstants.PAGE_ROWS_5);
		os.setOrdAcptDtmStart(DateUtil.convertSearchDate("S", Timestamp.valueOf(LocalDateTime.now().minusMonths(1).plusDays(1))));
		os.setOrdAcptDtmEnd(DateUtil.convertSearchDate("E", Timestamp.valueOf(LocalDateTime.now())));
 		List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList(os);
 		map.put("orderList", orderList);
 		map.put("ordDtlStatCdList", this.codeCacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));

		*//*************************
		 * 위시리스트
		 ************************//*
		MemberInterestGoodsSO migs = new MemberInterestGoodsSO();
		migs.setStId(view.getStId());
		migs.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		migs.setRows(FrontWebConstants.PAGE_ROWS_4);
		migs.setSidx("SYS_REG_DTM");
		migs.setSord(FrontWebConstants.SORD_DESC);
		migs.setMbrNo(session.getMbrNo());
		List<MemberInterestGoodsVO> wishList = null;
		map.put("wishList", wishList);*/

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40); 
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, "");

		return  TilesView.mypage(new String[]{"indexMyPage"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyPageController.java
	* - 작성일		: 2021. 3. 9.
	* - 작성자		: 이지희
	* - 설명			: 마이페이지 > gs포인트 조회
	* </pre>
	* @param session
	* @param authData
	* @return
	*/
	@RequestMapping(value="getGsrPoint", method= RequestMethod.POST)
	@ResponseBody
	public String getGsrPoint(Session session, String authData ) {
		
		String authJsonRpl =  StringEscapeUtils.unescapeXml(authData);
		JSONObject auth = new JSONObject(authJsonRpl);
		String ciVal = auth.getString("CI");
		
		MemberBaseSO gsrSo = new MemberBaseSO(); 
 		gsrSo.setCiCtfVal(ciVal);
		MemberBaseVO gsrVo = gsrService.getGsrMemberBase(gsrSo);
		
		if(gsrVo.getGsptNo() != null && !gsrVo.getGsptNo().equals("")) {
			
			MemberBasePO updatePo = new MemberBasePO();
			updatePo.setMbrNo(session.getMbrNo()); 
			
			String natinalCd  = auth.getString("RSLT_NTV_FRNR_CD");
			if(natinalCd.equals("L")) {natinalCd = "10";}
			else if(natinalCd.equals("F")) {natinalCd = "20";}
			updatePo.setNtnGbCd(natinalCd);
			
			updatePo.setCiCtfVal(auth.getString("CI"));
			updatePo.setDiCtfVal(auth.getString("DI"));
			updatePo.setCtfYn("Y");
			
			updatePo.setGsptNo(gsrVo.getGsptNo());
			updatePo.setGsptUseYn("Y");
			updatePo.setGsptStateCd(FrontConstants.GSPT_STATE_10);
			updatePo.setMbrGbCd(CommonConstants.MBR_GB_CD_10);
			
			memberService.updateMemberBase(updatePo); 
			
			session.setCertifyYn("Y");
			session.setGsptNo(gsrVo.getGsptNo()); 
			FrontSessionUtil.setSession(session); 
			
			return gsrVo.getPoint();
		}else {
			return "0";
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyPageController.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 회원 등급별 혜택 보기 팝업
	* </pre>
	* @param map
	* @param view
	* @return
	 */
	@RequestMapping(value="popupMemberGradeInfo")
	public String popupCashReceiptRequest(ModelMap map, ViewBase view){

		view.setTitle(message.getMessage("front.web.view.mypage.member.grade.info.popup.title"));
		
		map.put("mbrCodeList", this.codeCacheService.listCodeCache(FrontWebConstants.MBR_GRD_CD, null, null, null, null, null));
		map.put("view", view);

		return TilesView.popup(new String[] { "mypage", "popupMemberGradeInfo" });
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 마이 찜리스트 화면
	 * </pre>
	 * 
	 * @param  session
	 * @param  view
	 * @param  model
	 */
    @LoginCheck 
	@RequestMapping(value = "/{seoSvcGbCd}/myWishList", method = RequestMethod.GET)
	public String myWishList(ModelMap map, Model model, ViewBase view, Session session, @PathVariable String seoSvcGbCd, String callParam) {
    	//펫tv 
    	VodSO so = new VodSO();
    	//펫로그
    	PetLogListSO pso = new PetLogListSO();
    	//펫샵
    	MemberInterestBrandSO mbSO = new MemberInterestBrandSO();
    	MemberInterestGoodsSO mgSO = new MemberInterestGoodsSO();
    	
    	if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
    		so.setMbrNo(session.getMbrNo());
    		pso.setMbrNo(session.getMbrNo());
    		
    		mbSO.setMbrNo(session.getMbrNo());
    		mbSO.setSidx("SYS_REG_DTM");
    		if(!StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10)){
    			mbSO.setRows(FrontWebConstants.PAGE_ROWS_6);
    		}else {
    			mbSO.setRows(FrontWebConstants.PAGE_ROWS_10);
    		}
    		mbSO.setSord(FrontWebConstants.SORD_DESC);
    		
    		mgSO.setMbrNo(session.getMbrNo());
    		mgSO.setStId(view.getStId());
    		mgSO.setDeviceGb(view.getDeviceGb());
    		// TODO 임시 처리..
//    		mgSO.setRows(FrontWebConstants.PAGE_ROWS_100);
    		mgSO.setSidx("SYS_REG_DTM");
    		mgSO.setSord(FrontWebConstants.SORD_DESC);
    	}
    	view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("myWishListTv", displayService.myWishListTv(so));
		model.addAttribute("myWishListLog", displayService.myWishListLog(pso));
		model.addAttribute("myWishListBrand", memberInterestBrandService.pageMemberInterestBrand(mbSO));
		model.addAttribute("mbSO", mbSO);
		model.addAttribute("myWishListGoods", memberInterestGoodsService.listMemberInterestGoods(mgSO));
    	
		model.addAttribute("session", session);
		model.addAttribute("view", view);
		model.addAttribute("seoSvcGbCd", seoSvcGbCd);
		model.addAttribute("callParam", callParam);
		
		return TilesView.none(new String[] { "mypage","include", "myWishList" });
	}
    
    /**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 찜 리스트 영상 찜 해제
	 * </pre>
	 * 
	 * @param  session
	 * @param  model
	 * @param  map
	 * @param  po
	 */
	@ResponseBody
	@RequestMapping(value = "/favorites", method = RequestMethod.POST)
	public ModelMap tvTagVodList(ModelMap map, Model model, Session session, ViewBase view, TvDetailPO po) {
		ModelMap modelmap = new ModelMap();
		
		displayService.noFavorites(po);
		
		return modelmap;
	}
}