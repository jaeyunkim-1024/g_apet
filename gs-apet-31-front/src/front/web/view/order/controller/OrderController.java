package front.web.view.order.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.appweb.service.TermsService;
import biz.app.cart.model.CartCouponDlvrcVO;
import biz.app.cart.model.CartCouponDlvrcVO.Coupon;
import biz.app.cart.model.CartCouponSO;
import biz.app.cart.model.CartCouponVO;
import biz.app.cart.model.CartFreebieRtnVO;
import biz.app.cart.model.CartGoodsSO;
import biz.app.cart.model.CartGoodsVO;
import biz.app.cart.model.CartPO;
import biz.app.cart.model.CartSO;
import biz.app.cart.model.CartVO;
import biz.app.cart.service.CartService;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.delivery.service.DeliveryChargePolicyService;
import biz.app.display.model.SeoInfoVO;
import biz.app.event.service.EventService;
import biz.app.goods.model.GoodsAttributeVO;
import biz.app.goods.model.ItemAttributeValueVO;
import biz.app.goods.service.GoodsService;
import biz.app.goods.service.ItemService;
import biz.app.member.model.MemberAddressSO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberService;
import biz.app.order.model.CardcInstmntInfoSO;
import biz.app.order.model.OrderAdbrixVO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderComplete;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderRegist;
import biz.app.order.service.OrderBaseService;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderDlvrAreaService;
import biz.app.order.service.OrderDlvraService;
import biz.app.order.service.OrderSendService;
import biz.app.order.service.OrderService;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.app.system.service.CodeService;
import biz.app.system.service.DepositAcctInfoService;
import biz.app.system.service.LocalPostService;
import biz.app.system.service.PntInfoService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.gsr.service.GsrService;
import biz.interfaces.sktmp.model.SktmpCardInfoPO;
import biz.interfaces.sktmp.model.SktmpCardInfoSO;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00108ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00110ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00114ReqVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00102ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00108ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00110ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00114ResVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.admin.util.JsonUtil;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.view.order.model.AddressListParam;
import front.web.view.order.model.CartDeliveryTotalInfo;
import front.web.view.order.model.CartTotalInfo;
import front.web.view.order.model.CouponUseParam;
import front.web.view.order.model.OptionChangeParam;
import front.web.view.order.model.OrderPaymentParam;
import lombok.extern.slf4j.Slf4j;

//import biz.app.pay.model.EasyPayVO;

/**
 * 주문 Controller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("order")
public class OrderController {

	@Autowired private Properties bizConfig;
	
	@Autowired private Properties webConfig;
	
	@Autowired private MessageSourceAccessor message;

	@Autowired private CacheService cacheService;
	
	@Autowired private CodeService codeService;
	
	@Autowired private CartService cartService;
	
	@Autowired private MemberService memberService;
	
	@Autowired private MemberAddressService memberAddressService;

	@Autowired private GoodsService goodsService;

	@Autowired private ItemService itemService;

	@Autowired private DepositAcctInfoService depositAcctInfoService;

	@Autowired private OrderService orderService;

	@Autowired private OrderBaseService orderBaseService;

	@Autowired private OrderDetailService orderDetailService;

	@Autowired private LocalPostService localPostService;

	@Autowired private OrderSendService orderSendService;

	@Autowired private EventService eventService;

	@Autowired private OrderDlvraService orderDlvraService;

	@Autowired private OrderDlvrAreaService orderDlvrAreaService;

	@Autowired private DeliveryChargePolicyService deliveryChargePolicyService;

	@Autowired private GsrService gsrService;

	@Autowired
	private BizService bizService;
	
	@Autowired 
	private TermsService termsService;
	
	@Autowired private PntInfoService pntInfoService;
	
	@Autowired private SktmpService sktmpService;
	
	

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 01.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 담기
	 * </pre>
	 * @param response
	 * @param session
	 * @param goodsIdsStr
	 * @param buyQtys
	 * @param nowBuyYn
	 * @return
	 */
	@RequestMapping("insertCart")
	@ResponseBody
	public ModelMap insertCart(HttpServletRequest request, HttpServletResponse response, ViewBase view, Session session, String [] goodsIdsStr, Integer[] buyQtys, String nowBuyYn, String[] goodsCpInfos, String cartYn){
		
		
		/*
		 * goodsIdsStr 형태 :  goodsId:itemNo:grpGoodsId
		 * 단품,세트 - 'GI000054400:302558:'
		 * 옵션 - GIXXX:300040:GO444444
		 * pkgGoodsId : 옵션, 묶음 상품일 경우 묶은 상품 번호.
		 * */
		if(FrontWebConstants.COMM_YN_Y.equals(nowBuyYn)){
			String newCartGoodsCpInfos = StringUtil.unSplit(goodsCpInfos, FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS_SEPARATOR);
			
			CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_TYPE, FrontWebConstants.CART_ORDER_TYPE_ONCE);
			CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS, null);
			CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS, newCartGoodsCpInfos);
			CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_YN, cartYn);
		}
		
		Long mbrNo = null;
		String ssnId = null;
		
		//비회원
		if(session.getMbrNo() == 0){
			//비회원 장바구니 최초 ssnId 저장 , 24시간 유지
			Cookie[] cookies = request.getCookies();
			String cartTempKey = ""; 
			if(cookies != null){
		         
				for(int i=0; i < cookies.length; i++){
					Cookie c = cookies[i] ;
		            if(c.getName().equals("CART_TEMP_KEY")) {
		            	cartTempKey = c.getValue() ;
		            	break;
		            }
				}
			}
			
			if(StringUtils.isNotEmpty(cartTempKey)) { 
				ssnId = cartTempKey;
			}else {
				ssnId = session.getSessionId();
			}
			String domain = bizConfig.getProperty("cookie.domain").replaceAll("\r", "").replaceAll("\n", "");
			
			Cookie cookie = new Cookie("CART_TEMP_KEY", ssnId);
			cookie.setMaxAge(60 * 60 * 24);
			cookie.setPath("/");
			if (domain != null && !"".equals(domain)) {
				cookie.setDomain(domain);
			}
			response.addCookie(cookie);
		}else{
			mbrNo = session.getMbrNo();
		}

		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		
		Map<String, Object> result = this.cartService.insertCart(stId, mbrNo, ssnId, goodsIdsStr, buyQtys, nowBuyYn);
		
		String rtnCode = result.get("rtnCode") == null ? null : String.valueOf(result.get("rtnCode"));
		String rtnMsg = result.get("rtnMsg") == null ? null : String.valueOf(result.get("rtnMsg"));
		
		ModelMap map = new ModelMap();
		
		//장바구니 카운트
		if(FrontWebConstants.COMM_YN_N.equals(nowBuyYn)){
			Integer cartCnt = this.cartService.getCartCnt(stId, session.getSessionId(), session.getMbrNo());
			map.put("cartCnt", cartCnt);
		}
		CartGoodsSO so = new CartGoodsSO();
		String [] goodsIds = new String[goodsIdsStr.length];
		for (int i = 0; i < goodsIdsStr.length; i++) {
			String[] arrGoodsIds = StringUtils.splitPreserveAllTokens(goodsIdsStr[i], "\\:");
			
			goodsIds[i] = arrGoodsIds[0];
		}
		
		so.setGoodsIds(goodsIds);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		so.setStId(view.getStId());
		
		List<OrderAdbrixVO> adbrixList = orderService.listCartAdbrix(so);
		
		for(OrderAdbrixVO adbrix : adbrixList) {
			for(int i=0; i<goodsIds.length; i++) {
				if(adbrix.getGoodsId().equals(goodsIds[i])) {
					adbrix.setBuyQty(buyQtys[i]);
				}
			}
		}
		
		map.put("adbrixList", adbrixList);
		map.put("rtnCode", rtnCode);
		map.put("rtnMsg", rtnMsg);
		
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controllerjjjjjjjjjj
	 * - 작성일		: 2021. 03. 01.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 */
	@RequestMapping(value = "indexCartList")
	public String indexCartList(ModelMap map, Session session, ViewBase view, @RequestParam(value = "callParam", required = false) String callParam) {
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		
		SeoInfoVO seoInfoVo = new SeoInfoVO();
		seoInfoVo.setPageTtl("장바구니");
		map.put("seoInfo", seoInfoVo);
		map.put("session", session);
		map.put("view", view);
		map.put("callParam", callParam);
		
		// GTM 데이터
		CartGoodsSO so = new CartGoodsSO();
		so.setNowBuyYn(FrontWebConstants.COMM_YN_N);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		
		if(!StringUtil.isEmpty(session.getDispClsfNo())) {
			Long cateCdl = getDispClsfNoFromLnbDispClsfNo(session.getDispClsfNo());
			//so.setCateCdL(cateCdl);
		}else {
			//so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));
		}
		
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
		} else {
			so.setSsnId(session.getSessionId());
		}
		so.setStId(view.getStId());
		List<CartGoodsVO> cartList = this.cartService.listCartGoods(so, "N");
		
		map.put("so", so);
		map.put("cartList", cartList);
		
		return "order/indexCartList";
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 01. 27.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 선택값, 수량 업데이트
	 * </pre>
	 * @param
	 */
	@RequestMapping("updateCartBuyQtyAndCheckYn")
	@ResponseBody
	public ModelMap updateCart(Session session, ViewBase view, 
			@RequestParam(value = "cartListStr", required = true) String cartListStr) {
		JsonUtil<CartPO> jsonUtil =  new JsonUtil<>();
		List<CartPO> cartList = jsonUtil.toArray(CartPO.class, cartListStr);
		this.cartService.updateCartBuyQtyAndCheckYn(cartList);

		return new ModelMap();
	}
	
	/**
	 * <pre>장바구니 선택상품에 대한 비용 계산</pre>
	 * 
	 * @param cartIds
	 * @param session
	 * @param view
	 * @return
	 */
	@Deprecated
	@RequestMapping("getCartTotalInfo")
	@ResponseBody
	public ModelMap getCartTotalInfo(String[] cartIds, String [] goodsCpInfos, Session session, ViewBase view) {

		//------------------------------------------------
		// 1. 장바구니 상품 목록 조회
		CartGoodsSO so = new CartGoodsSO();
		so.setNowBuyYn(FrontWebConstants.COMM_YN_N);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
		} else {
			so.setSsnId(session.getSessionId());
		}
		so.setCartIds(cartIds);
		so.setStId(view.getStId());
		List<CartGoodsVO> cartList = null;

		if (cartIds != null && cartIds.length > 0) {
			cartList = this.cartService.listCartGoods(so, "N");
		}

		
		//------------------------------------------------
		// 2. 상품 및 배송비 금액 계산
		Long totalGoodsAmt = 0L;
		Long totalDlvrAmt = 0L;
		Integer beforePkgDlvrNo = 0;

		if (CollectionUtils.isNotEmpty(cartList)) {
			for (CartGoodsVO cgvo : cartList) {
				totalGoodsAmt += (cgvo.getSalePrc() - cgvo.getPrmtDcAmt()) * cgvo.getBuyQty();

				if (!beforePkgDlvrNo.equals(cgvo.getPkgDlvrNo())) {
					totalDlvrAmt += cgvo.getPkgDlvrAmt() + cgvo.getPkgAddDlvrAmt();
					beforePkgDlvrNo = cgvo.getPkgDlvrNo();
				}
			}
		}
		
		// 전체 금액
		Long totalAmt = totalGoodsAmt + totalDlvrAmt;

		// 적립 예정 금액
		Double mbrSvmnRate = this.memberService.getMemberSaveMoneyRate(session.getMbrNo());
		Long totalSvmnAmt = Math.round(totalGoodsAmt * (mbrSvmnRate / 100));

		CartTotalInfo cartInfo = new CartTotalInfo();
		cartInfo.setTotalGoodsAmt(totalGoodsAmt);
		cartInfo.setTotalDlvrAmt(totalDlvrAmt);
		cartInfo.setTotalAmt(totalAmt);
		cartInfo.setTotalSvmnAmt(totalSvmnAmt);

		ModelMap map = new ModelMap();
		map.put("cartInfo", cartInfo);
		map.put("cartList", cartList);

		return map;
	}

	
	/**
	 * <pre>장바구니 상품 삭제</pre>
	 * 
	 * @param cartIds
	 * @return
	 */
	@RequestMapping("deleteCart")
	@ResponseBody
	public ModelMap deleteCart(String[] cartIds) {
		this.cartService.deleteCart(cartIds);

		return new ModelMap();
	}

	/**
	 * <pre>장바구니 상품 관심상품으로 등록</pre>
	 * 
	 * @param cartIds
	 * @return
	 */
	@Deprecated
	@LoginCheck
	@RequestMapping("insertWish")
	@ResponseBody
	public ModelMap insertWish(String[] cartIds) {

		this.cartService.insertWishFromCart(cartIds);

		return new ModelMap();
	}
	
	
	/**
	 * <pre>장바구니 옵션 변경 팝업 화면</pre>
	 * 
	 * @param map
	 * @param view
	 * @param param
	 * @return
	 */
	@Deprecated
	@RequestMapping(value = "popupCartOptionChange")
	public String popupCartOptionChange(ModelMap map, ViewBase view, OptionChangeParam param) {
		CartVO cart = this.cartService.getCart(param.getCartId());
		List<GoodsAttributeVO> goodsAttrList = this.goodsService.listGoodsAttribute(cart.getGoodsId(), true);
		List<ItemAttributeValueVO> itemAttrValList = this.itemService.listItemAttributeValue(cart.getItemNo());

		map.put("goodsAttrList", goodsAttrList);
		map.put("itemAttrValList", itemAttrValList);

		view.setTitle(message.getMessage("front.web.view.order.cart.option.change.popup.title"));
		map.put("cart", cart);
		map.put("view", view);
		map.put("param", param);

		return TilesView.popup(new String[] { "order", "popupCartOptionChange" });
	}

	
	/**
	 * <pre>장바구니 옵션 변경</pre>
	 * 
	 * @param session
	 * @param cartId
	 * @param goodsId
	 * @param attrNos
	 * @param attrValNos
	 * @param buyQty
	 * @return
	 */
	@Deprecated
	@RequestMapping(value = "changeOption")
	@ResponseBody
	public ModelMap changeOption(Session session, String cartId, String goodsId, Long[] attrNos, Long[] attrValNos, Integer buyQty) {

		this.cartService.updateCartOption(cartId, session.getSessionId(), session.getMbrNo(), goodsId, attrNos, attrValNos, buyQty);

		return new ModelMap();
	}
	
	
	/**
	 * <pre>장바구니 구매수량 변경</pre>
	 * 
	 * @param cartId
	 * @param buyQty
	 * @return
	 */
	@Deprecated
	@RequestMapping(value = "changeBuyQty")
	@ResponseBody
	public ModelMap changeBuyQty(String cartId, Integer buyQty) {
		this.cartService.updateCartBuyQty(cartId, buyQty);

		return new ModelMap();
	}

	
	/**
	 * <pre>장바구니 상품 주문 정보 설정</pre>
	 * 
	 * @param cartIds
	 * @return
	 */
	@RequestMapping("setOrderInfo")
	@ResponseBody
	public ModelMap setOrderInfo(String[] cartIds, String[] goodsCpInfos , ViewBase view) {
		String newCartIds = StringUtil.unSplit(cartIds, FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS_SEPARATOR);
		String newCartGoodsCpInfos = StringUtil.unSplit(goodsCpInfos, FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS_SEPARATOR);
		
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_TYPE, FrontWebConstants.CART_ORDER_TYPE_NORMAL);
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS, newCartIds);
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS, newCartGoodsCpInfos);
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_YN, null);

		ModelMap result = new ModelMap();
		result.put("deviceGb",view.getDeviceGb());
		result.put("os",view.getOs());

		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 33.front.order.web
	 * - 파일명		: OrderController.java
	 * - 작성일		: 2017. 4. 3.
	 * - 작성자		: snw
	 * - 설명			: 주문 결제 화면
	 * </pre>
	 *
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "indexOrderPayment")
	public String indexOrderPayment(ModelMap map, Session session, ViewBase view, OrderPaymentParam op, HttpServletRequest request, HttpServletResponse response) {
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		map.put("svrEnv", bizConfig.getProperty("envmt.gb"));
		
		OrderPaymentParam dlvrInfo = new OrderPaymentParam();
		CartGoodsSO so = new CartGoodsSO();
		MemberBaseSO mbso = new MemberBaseSO();
		//EasyPayVO easyPayInfo = new EasyPayVO();
		List<CartGoodsVO> orderGoodsList = null;

		so.setStId(view.getStId());
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		
		so.setMbrNo(session.getMbrNo());
		mbso.setMbrNo(session.getMbrNo());

		// 2. Parameter Validation
		String orderType = session.getOrder().getOrderType();
		String[] cartIds = session.getOrder().getCartIds();
		String[] goodsCpInfos = session.getOrder().getCartGoodsCpInfos();

		if (orderType == null || "".equals(orderType)) {
			throw new CustomException(ExceptionConstants.ERROR_REQUEST);
		}

		if (FrontWebConstants.CART_ORDER_TYPE_NORMAL.equals(orderType) && cartIds == null) {
			throw new CustomException(ExceptionConstants.ERROR_REQUEST);
		}
		
		if (FrontWebConstants.CART_ORDER_TYPE_NORMAL.equals(orderType)) {
			if (cartIds != null && cartIds.length > 0) {
				so.setNowBuyYn(FrontWebConstants.COMM_YN_N);
				so.setCartIds(cartIds);
				orderGoodsList = this.cartService.listCartGoods(so, dlvrInfo.getLocalPostYn(), goodsCpInfos, true);
			} else {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}
		}
		// 바로 구매
		else if (FrontWebConstants.CART_ORDER_TYPE_ONCE.equals(orderType)) {
			so.setNowBuyYn(FrontWebConstants.COMM_YN_Y);
			orderGoodsList = this.cartService.listCartGoods(so, dlvrInfo.getLocalPostYn(), goodsCpInfos, true);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		//상품공급사
		Set<String> append = new HashSet<>();
		// 주문 상품의 상태 체크
		if (orderGoodsList != null && orderGoodsList.size() > 0) {
			for (CartGoodsVO cgvo : orderGoodsList) {
				if (!CommonConstants.SALE_PSB_00.equals(cgvo.getSalePsbCd())) {
					throw new CustomException(ExceptionConstants.ERROR_ORDER_SALE_PSB);
				}
				if(StringUtil.isNotEmpty(cgvo.getCompNm()) && StringUtil.equals(cgvo.getCompTpCd(),FrontConstants.COMP_TP_20)){
					append.add(cgvo.getCompNm());
				}
			}
			//상품공급사
			map.put("partnerCompanyNm", String.join(",",append));
		}
		else {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}
		
		//약관조회 - GSR관련포함(신규회원가입, sns회원가입 CI있는경우) / GSR포함x(sns회원가입 CI없는 경우)
		List<TermsVO> termsList = new ArrayList<>();

		String pocGbcd = "";
		String viewOs = view.getOs();			//OS 구분 코드
		String deviceGb = view.getDeviceGb();	//디바이스 구분 코드


		//앱 IOS
		if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && !StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbcd = FrontConstants.TERMS_POC_IOS;
		}
		//앱 AOS
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbcd = FrontConstants.TERMS_POC_ANDR;
		}
		//모바일
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_20)){
			pocGbcd = FrontConstants.TERMS_POC_MO;
		}
		//PC
		else{
			pocGbcd = FrontConstants.TERMS_POC_WEB;
		}

		TermsSO tso = new TermsSO();
		tso.setPocGbCd(pocGbcd);

		// 결제약관
		tso.setUsrDfn1Val("20"); 
		tso.setUsrDfn2Val("102");
		
		List<TermsVO> allTerms = this.termsService.listTermsForPayment(tso);
		termsList = allTerms;

		//약관
		map.put("terms", termsList) ;

		// 본사제품 카운트
		map.put("gb10Cnt", orderGoodsList.stream().filter(vo -> StringUtils.equals(CommonConstants.COMP_GB_10, vo.getCompGbCd())).count());
		// 업체제품 카운트
		map.put("gb20Cnt", orderGoodsList.stream().filter(vo -> StringUtils.equals(CommonConstants.COMP_GB_20, vo.getCompGbCd())).count());

		map.put("orderGoodsList", orderGoodsList);

		// 회원 정보 조회
		MemberBaseVO memberBase = this.memberService.decryptMemberBase(mbso);

		// 개인결제저장 정보 (기본결제수단, 현금영수증)
		PrsnPaySaveInfoVO paySaveInfo = memberService.getMemberPaySaveInfo(mbso.getMbrNo());

		// 등록된 간편결제 정보
		//List<PrsnCardBillingInfoVO> cardBillInfo = memberService.listMemberCardBillingInfo(mbso);

		/*
		 * 회원의 기본 배송지 조회 및 설정
		 */
		if (StringUtil.isEmpty(dlvrInfo.getPostNoNew())) {

			MemberAddressVO address = this.memberAddressService.getMemberAddressDefault(session.getMbrNo());

			if (address != null) {
				dlvrInfo.setOrderDeliverySel("default");
				dlvrInfo.setMbrDlvraNo(address.getMbrDlvraNo().intValue());
				dlvrInfo.setGbNm(address.getGbNm());
				dlvrInfo.setAdrsNm(address.getAdrsNm());
				dlvrInfo.setAdrsTel(address.getTel());
				dlvrInfo.setAdrsMobile(address.getMobile());
				dlvrInfo.setPostNoNew(address.getPostNoNew());
				dlvrInfo.setRoadAddr(address.getRoadAddr());
				dlvrInfo.setRoadDtlAddr(address.getRoadDtlAddr());
				dlvrInfo.setLocalPostYn(this.localPostService.getLocalPostYn(address.getPostNoNew(), address.getPostNoOld()));
				dlvrInfo.setDlvrDemandYn(address.getDlvrDemandYn());
				dlvrInfo.setGoodsRcvPstCd(address.getGoodsRcvPstCd());
				dlvrInfo.setGoodsRcvPstNm(this.cacheService.getCodeName(CommonConstants.GOODS_RCV_PST, address.getGoodsRcvPstCd()));
				dlvrInfo.setGoodsRcvPstEtc(address.getGoodsRcvPstEtc());
				dlvrInfo.setPblGateEntMtdCd(address.getPblGateEntMtdCd());
				dlvrInfo.setPblGateEntMtdNm(this.cacheService.getCodeName(CommonConstants.PBL_GATE_ENT_MTD, address.getPblGateEntMtdCd()));
				dlvrInfo.setPblGatePswd(address.getPblGatePswd());
				dlvrInfo.setDlvrDemand(address.getDlvrDemand());

			} else {
				dlvrInfo.setOrderDeliverySel("new");
				dlvrInfo.setLocalPostYn(CommonConstants.COMM_YN_N);
			}

			map.put("address", address);
		}

		view.setStDomain(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort());
		
		if(!StringUtil.isEmpty(session.getDispClsfNo())) {
			Long cateCdl = getDispClsfNoFromLnbDispClsfNo(session.getDispClsfNo());
			//so.setCateCdL(cateCdl);
		}else {
			//so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));
		}
		
		map.put("so", so);
		map.put("memberBase", memberBase);
		map.put("goodsRcvPstList", this.cacheService.listCodeCache(FrontWebConstants.GOODS_RCV_PST, null, null, null, null, null));
		map.put("pblGateEntMtdList", this.cacheService.listCodeCache(FrontWebConstants.PBL_GATE_ENT_MTD, null, null, null, null, null));
		map.put("cardList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, true, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		map.put("dlvrInfo", dlvrInfo);
		map.put("paySaveInfo", paySaveInfo);
		//map.put("cardBillInfo", cardBillInfo);

		SeoInfoVO seoInfoVo = new SeoInfoVO();
		seoInfoVo.setPageTtl("주문서");
		map.put("seoInfo", seoInfoVo);
		//2021-06-14 실시간 조회로 DB CodeService 조회
		//2021-07-26 DB 조회로 변경
		PntInfoSO pntSO = new PntInfoSO();
		pntSO.setPntTpCd(CommonConstants.PNT_TP_GS);
		pntSO.setMbrNo(session.getMbrNo());
		PntInfoVO gsPntVO = pntInfoService.getPntInfo(pntSO);
		
		double gsPntRate = gsPntVO == null || gsPntVO.getSaveRate() == null ? 0d : gsPntVO.getSaveRate() * 0.01d;
		map.put("gsPntRate", gsPntRate);
		
		pntSO = new PntInfoSO();
		pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
		pntSO.setMbrNo(session.getMbrNo());
		PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
		
		map.put("mpPntVO", mpPntVO);
		map.put("gsptNoIsNull",StringUtil.isEmpty(Optional.ofNullable(memberBase.getGsptNo()).orElseGet(()->"")) ? FrontConstants.COMM_YN_Y : FrontConstants.COMM_YN_N);
		
		map.put("callParam", op.getCallParam());
		
		return "order/indexOrderPayment";
	}
	
	private Long getDispClsfNoFromLnbDispClsfNo(Long dispClsfNo) {
		 //cateCdL -> 설정
		Long cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.dog"));//12564
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

	/**
	 * <pre>
	 * 배송 유형 리스트
	 * </pre>
	 * @param model
	 * @param postNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getDlvrAreaInfo")
	public ModelMap getDlvrAreaInfo(Model model, Session session, String postNo, boolean isCart) {
		ModelMap map = new ModelMap();
		
		//장바구니 일경우 기본 배송지 우편번호로 조회
		if(isCart) {
			MemberAddressVO dftAddress = memberAddressService.getMemberAddressDefault(session.getMbrNo());
			if(dftAddress != null) {
				postNo = dftAddress.getPostNoNew();
				map.addAttribute("mbrPostNo", postNo);
			}
		}
		
		List<OrderDlvrAreaVO> list = orderDlvrAreaService.getDlvrPrcsListFromTime(postNo);
		map.addAttribute("list", list);
		return map;
	}
	
	/**
	 * <pre>
	 * 배송 유형 리스트
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getDefaultCoupon")
	public ModelMap getDefaultCoupon(Model model, Session session, ViewBase view, CouponUseParam param) {
		ModelMap map = new ModelMap();
		
		if(StringUtils.isNotEmpty(param.getSelDlvrcCouponStr())) {
			JsonUtil jsonUt3 = new JsonUtil();
			CartGoodsSO.DlvrcCoupon cartDlvrc = (CartGoodsSO.DlvrcCoupon) jsonUt3.toBean(CartGoodsSO.DlvrcCoupon.class, param.getSelDlvrcCouponStr());
		
			// 기본 적용시킬 배송 쿠폰 조회
			CartCouponSO dlvrcSO = new CartCouponSO();
			dlvrcSO.setStId(view.getStId());
			dlvrcSO.setMbrNo(session.getMbrNo());
			dlvrcSO.setDlvrcPlcNo(cartDlvrc.getDlvrcPlcNo()); // 자사 정책 적용
			dlvrcSO.setDlvrAmt(cartDlvrc.getDlvrAmt());
			dlvrcSO.setTotGoodsAmt(param.getTotLocalGoodsAmt()); //최소 구매 금액 적용
			if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
				dlvrcSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
			}else {
				dlvrcSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
			}

			Coupon dlvrcCoupon = null;
			CartCouponDlvrcVO coupon = Optional.ofNullable(cartService.getCartCouponDlvrc(dlvrcSO))
					.orElse(null);
			if(coupon != null){
				List<Coupon> list = coupon.getCouponList();
				dlvrcCoupon = Optional.ofNullable(list.get(0)).orElse(null);
			}
			map.addAttribute("dlvrcCoupon", dlvrcCoupon);
		}

		// 기본 적용시킬  장바구니 쿠폰 조회
		CartCouponSO cartSO = new CartCouponSO();
		cartSO.setMbrNo(session.getMbrNo());
		cartSO.setTotGoodsAmt(param.getTotGoodsAmt());
		cartSO.setCartSelMbrCpNo(param.getCartSelMbrCpNo());
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			cartSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			cartSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}

		List<CartCouponVO> cartCouponList = this.cartService.listCartCoupon(cartSO);
		if(CollectionUtils.isNotEmpty(cartCouponList)) {
			CartCouponVO cartCoupon = Optional.ofNullable(cartCouponList.get(0)).orElse(null);
			
			map.addAttribute("cartCoupon", cartCoupon);
		}

		return map;
	}

	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 6. 1.
	* - 작성자		: Administrator
	* - 설명			: 도서 산간 지역 여부
	 * </pre>
	 * 
	 * @param postNoOld
	 * @param postNoNew
	 * @return
	 */
	@RequestMapping("checkLocalPost")
	@ResponseBody
	public ModelMap checkLocalPost(String postNoOld, String postNoNew) {

		String localPostYn = this.localPostService.getLocalPostYn(postNoNew, postNoOld);

		ModelMap map = new ModelMap();
		map.put("localPostYn", localPostYn);

		return map;
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 04. 06.
	 * - 작성자		: JinHong
	 * - 설명		: 회원 주소록 조회(주문)
	 * </pre>
	 * @param map
	 * @param so
	 * @param session
	 * @param view
	 * @param param
	 * @return
	 */
	@RequestMapping("popupAddressList")
	public String popupAddressList(ModelMap map, MemberAddressSO so, Session session, ViewBase view, AddressListParam param){

		so.setMbrNo(session.getMbrNo());

		List<MemberAddressVO> addressList = this.memberAddressService.listMemberAddress(so);
		
		map.put("addressList", addressList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);
		map.put("param", param);
		
		return TilesView.none(new String[] { "order", "popupAddressList" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 34.front.brand.mobile
	 * - 파일명		: OrderController.java
	 * - 작성일		: 2017. 2. 8.
	 * - 작성자		: snw
	 * - 설명		: 회원 주소록 정보 조회
	 * </pre>
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = "getMemberAddress")
	@ResponseBody
	public ModelMap getMemberAddress(Session session) {

		MemberAddressVO address = this.memberAddressService.getMemberAddressDefault(session.getMbrNo());

		ModelMap map = new ModelMap();
		map.put("address", address);

		return map;
	}

	/**
	 * <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 4. 4.
	* - 작성자		: snw
	* - 설명			: 쿠폰 적용 팝업
	 * </pre>
	 * 
	 * @param map
	 * @param view
	 * @param session
	 * @param param
	 * @return
	 */
	@LoginCheck
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "popupCouponUse")
	public String popupCouponUse(ModelMap map, ViewBase view, Session session, CouponUseParam param) {

		List<CartGoodsVO> goodsCouponList = null;
		List<CartCouponVO> cartCouponList = null;
		CartCouponDlvrcVO dlvrcCoupon = null;
		
		//주문서 장바구니쿠폰 제외
		if(!FrontConstants.CP_POP_TP_ORD_CART.equals(param.getCpPopTp()) &&  StringUtil.isNotEmpty(param.getSelGoodsCouponListStr())) {
			JsonUtil jsonUt = new JsonUtil();
			List<CartGoodsSO.Cart> cartList = jsonUt.toArray(CartGoodsSO.Cart.class, param.getSelGoodsCouponListStr());
			CartGoodsSO so = new CartGoodsSO();
			if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
				so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
			}else {
				so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
			}
			so.setStId(view.getStId());
			if (FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
				so.setSsnId(session.getSessionId());
			}
			else {
				so.setMbrNo(session.getMbrNo());
			}
			
			so.setCartList(cartList.stream().filter(vo-> vo.isSelected()).collect(Collectors.toList()));
			
			goodsCouponList = this.cartService.listCartGoods(so, "N");
			
			List<CartGoodsVO> localGoodsCouponList = goodsCouponList.stream().filter(vo -> CommonConstants.COMP_GB_10.equals(vo.getCompGbCd())).collect(Collectors.toList());
			List<CartGoodsVO> compGoodsCouponList = goodsCouponList.stream().filter(vo -> CommonConstants.COMP_GB_20.equals(vo.getCompGbCd())).collect(Collectors.toList());
			map.put("goodsCpParamList", cartList);
			map.put("localGoodsCouponList", localGoodsCouponList);
			map.put("compGoodsCouponList", compGoodsCouponList);
			
		}
		
		
		//주문서 장바구니쿠폰 조회
		if(FrontConstants.CP_POP_TP_ORD_CART.equals(param.getCpPopTp()) && StringUtil.isNotEmpty(param.getSelCartCouponListStr())) {
			JsonUtil jsonUt2 = new JsonUtil();
			List<CartGoodsSO.CartCoupon> selCartCouponList = jsonUt2.toArray(CartGoodsSO.CartCoupon.class, param.getSelCartCouponListStr());
			/*************************
			 * 장바구니 쿠폰 조회
			 *************************/
			CartCouponSO cartSO = new CartCouponSO();
			cartSO.setMbrNo(session.getMbrNo());
			cartSO.setTotGoodsAmt(param.getTotGoodsAmt());
			if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
				cartSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
			}else {
				cartSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
			}
			cartCouponList = this.cartService.listCartCoupon(cartSO);
			
			for(CartCouponVO cartCoupon : cartCouponList) {
				if(CollectionUtils.isNotEmpty(selCartCouponList) && selCartCouponList.stream().anyMatch(vo -> vo.getMbrCpNo() != null && cartCoupon.getMbrCpNo().equals(vo.getMbrCpNo()))){
					cartCoupon.setSelected(true);
				}
			}

			map.put("cartCouponList", cartCouponList);
		}
			
		/**************************
		 * 배송비 쿠폰 조회
		 **************************/
		//주문서 상품/배송비 쿠폰 조회
		if(FrontConstants.CP_POP_TP_ORD.equals(param.getCpPopTp()) && StringUtil.isNotEmpty(param.getSelDlvrcCouponStr())) {
			JsonUtil jsonUt3 = new JsonUtil();
			CartGoodsSO.DlvrcCoupon cartDlvrc = (CartGoodsSO.DlvrcCoupon) jsonUt3.toBean(CartGoodsSO.DlvrcCoupon.class, param.getSelDlvrcCouponStr());

			/*
			 * ======================================== 배송 금액이 존재하는 장바구니만 조회하기 위한 조건 설정
			 * =======================================
			 */
			if(cartDlvrc != null && StringUtil.isNotEmpty(cartDlvrc.getDlvrcPlcNo())) {
				
				CartCouponSO dlvrcSO = new CartCouponSO();
				dlvrcSO.setStId(view.getStId());
	
				dlvrcSO.setMbrNo(session.getMbrNo());
				dlvrcSO.setDlvrcPlcNo(cartDlvrc.getDlvrcPlcNo());
				dlvrcSO.setDlvrAmt(cartDlvrc.getDlvrAmt());
				
				if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
					dlvrcSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
				}else {
					dlvrcSO.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
				}
				dlvrcCoupon = this.cartService.getCartCouponDlvrc(dlvrcSO);
				
				
				if(dlvrcCoupon != null && CollectionUtils.isNotEmpty(dlvrcCoupon.getCouponList())){
					for(CartCouponDlvrcVO.Coupon coupon : dlvrcCoupon.getCouponList()) {
						if(cartDlvrc.getMbrCpNo() != null && coupon.getMbrCpNo().equals(cartDlvrc.getMbrCpNo())) {
							coupon.setSelected(true);
						}
					}
				}
				
				DeliveryChargePolicySO plcSO = new DeliveryChargePolicySO();
				plcSO.setDlvrcPlcNo(cartDlvrc.getDlvrcPlcNo());
				DeliveryChargePolicyVO localDlvrcPlc =  deliveryChargePolicyService.getDeliveryChargePolicy(plcSO);
				
				map.put("localDlvrcPlc", localDlvrcPlc);
				map.put("dlvrcCoupon", dlvrcCoupon);
				map.put("dlvrcSO", dlvrcSO);
			}
		}
		map.put("session", session);
		map.put("view", view);
		map.put("param", param);

		return TilesView.none(new String[] { "order", "popupCouponUse" });
	}

	/**
	 * <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 4. 4.
	* - 작성자		: snw
	* - 설명			: 주문 임시 등록 및 주문번호 생성
	 * </pre>
	 * 
	 * @param session
	 * @param ordRegist
	 * @return
	 */
	@RequestMapping(value = "insertOrderTemp")
	@ResponseBody
	public ModelMap insertOrderTemp(Session session, OrderRegist ordRegist, ViewBase view, HttpServletRequest request, OrderComplete ordComplete) {


		/*******************************
		 * 세션정보와 주문자 정보가 다른경우
		 *******************************/

		if (!session.getMbrNo().equals(ordRegist.getMbrNo())) {
			// 로그인이 끊겼을 경우 처리
			throw new CustomException(ExceptionConstants.TRY_LOGIN_REQUIRED);
		}
		// 회원 상태 검증
		if (ordComplete.getMbrNo() == null || CommonConstants.NO_MEMBER_NO.equals(ordComplete.getMbrNo())) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_STATUS_FAIL);
		}else {
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(ordComplete.getMbrNo());
			MemberBaseVO mbvo = memberService.getMemberBase(mbso);
			if(mbvo == null || !CommonConstants.MBR_STAT_10.equals(mbvo.getMbrStatCd())) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_STATUS_FAIL);
			}
		}
		
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			ordRegist.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
			ordRegist.setOrdMdaCd(FrontWebConstants.ORD_MDA_10);
		}else {
			ordRegist.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
			ordRegist.setOrdMdaCd(FrontWebConstants.ORD_MDA_20);
		}
		
		/*******************************
		 * 정보 설정
		 *******************************/
		ordRegist.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		ordRegist.setChnlId(CommonConstants.DEFAULT_CHANNEL_ID);
		ordRegist.setOrdrIp(session.getSessionIp());
		ordRegist.setOrdrId(session.getLoginId());

		String ordNo = this.orderService.insertOrder(ordRegist, ordComplete);
		ordComplete.setOrdNo(ordNo);
		ModelMap map = new ModelMap();

		map.put("ordNo", ordNo);

		// 장바구니리스트 쿠키에 담기
		CookieSessionUtil.createCookie("ordCartIds", StringUtils.join(ordRegist.getCartIds(), "|"));
		CookieSessionUtil.createCookie("paySaveYn", ordComplete.getDefaultPayMethodSaveYn());
		CookieSessionUtil.createCookie("prsnBi", ordComplete.getPrsnCardBillNo());
		CookieSessionUtil.createCookie("useGsPoint", String.valueOf(ordComplete.getUseGsPoint()));
		
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 04. 14.
	 * - 작성자		: JinHong
	 * - 설명		: 0원 결제 완료 처리
	 * </pre>
	 * @param session
	 * @param ordRegist
	 * @param ordComplete
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "insertOrderFreePayAmt")
	@ResponseBody
	public ModelMap insertOrderFreePayAmt(Session session, OrderRegist ordRegist, OrderComplete ordComplete) {


		/********************************
		 * 주문완료 호출
		 *******************************/
		this.orderService.insertOrderComplete(ordComplete);

		/********************************
		 * 기본결제수단 저장 하지 않음. 0원결제
		 *******************************/
		/*if(CommonConstants.COMM_YN_Y.equals(ordComplete.getDefaultPayMethodSaveYn())){

			PrsnPaySaveInfoPO ppsipo = new PrsnPaySaveInfoPO();

			ppsipo.setMbrNo(ordComplete.getMbrNo());
			ppsipo.setCardcCd(ordComplete.getCardcCd());
			ppsipo.setPayMeansCd(ordComplete.getPayMeansCd());
			ppsipo.setCashRctGbCd(ordComplete.getCashRctGbCd());
			ppsipo.setCashRctGbVal(ordComplete.getCashRctGbVal());

			orderService.saveDefaultPayMethod(ppsipo);
		}*/


		/***********************************************
		 * 주문 이메일/SMS 전송
		 ***********************************************/
		//this.orderSendService.sendOrderInfo(ordComplete.getOrdNo());

		/******************************
		 * 장바구니 삭제
		 *****************************/

		this.cartService.deleteCart(ordRegist.getCartIds());

		/********************************
		 * 주문관련 세션 삭제
		 *******************************/
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_TYPE, null);
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS, null);
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS, null);
		CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_YN, null);

		return new ModelMap();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 33.front.brand.web
	 * - 파일명		: OrderController.java
	 * - 작성일		: 2017. 4. 4.
	 * - 작성자		: snw
	 * - 설명			: 주문 완료
	 * </pre>
	 *
	 * @param map
	 * @param session
	 * @param view
	 * @param ordNo
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "indexOrderCompletion")
	public String indexOrderCompletion(ModelMap map, Session session, ViewBase view, @RequestParam String ordNo) {

		//view.setOrderStep(FrontWebConstants.ORDER_STEP_3);

		/*******************************
		 * 주문 정보 조회
		 ******************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(ordNo);


		/*************************
		 * 주문 결제 정보
		 *************************/
		OrderPayVO orderPay = this.orderService.getOrderPayInfo(ordNo);
		orderPay.setCardcNm(this.cacheService.getCodeName(CommonConstants.CARDC, orderPay.getCardcCd()));
		orderPay.setBankNm(this.cacheService.getCodeName(CommonConstants.BANK, orderPay.getBankCd()));
		if(StringUtils.isNotEmpty(orderPay.getDpstSchdDt())) {
			
			Timestamp dpstSchdTime = DateUtil.getTimestamp(orderPay.getDpstSchdDt(), "yyyyMMddHHmmss");
			orderPay.setDpstSchdDtNm(DateUtil.getTimestampToString(dpstSchdTime, "MM월 dd일 HH:mm"));
		}

		// 카드결제시 할부 정보
		if(CommonConstants.PAY_MEANS_10.equals(orderPay.getPayMeansCd()) || CommonConstants.PAY_MEANS_11.equals(orderPay.getPayMeansCd())) {

			if (orderPay.getInstmntInfo() != null && !orderPay.getInstmntInfo().equals("")) {
				if (!CommonConstants.SINGLE_INSTMNT.equals(orderPay.getInstmntInfo())) {
					orderPay.setInstmntInfo(orderPay.getInstmntInfo().replaceAll("0", ""));
				}
				if (CommonConstants.COMM_YN_Y.equals(orderPay.getFintrYn())) {
					orderPay.setFintrYn("무이자");
				}
			}

			orderPay.setCardNo(maskingCard(orderPay.getCardNo()));
		}
		
		if(orderBase.getMpLnkHistNo() != null) {
			SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
			mpSO.setMpLnkHistNo(orderBase.getMpLnkHistNo());
			SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
			map.put("mpVO", mpVO);
		}

		/**********************************
		 * 주문 상세 조회
		 **********************************/
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(orderBase.getOrdNo());
		List<OrderDetailVO> orderDetailList = this.orderDetailService.listOrderDetail(odso);

		OrderDlvraSO ordDlvraSO= new OrderDlvraSO();
		ordDlvraSO.setOrdNo(orderBase.getOrdNo());
		OrderDlvraVO orderDlvra = this.orderDlvraService.getOrderDlvra(ordDlvraSO);

		// 프론트 결제 정보 조희 추가, 2021.04.26, ssmvf01
		map.put("frontPayInfo", orderService.getFrontPayInfo(ordNo));

		map.put("orderBase", orderBase);
		map.put("orderPay", orderPay);
		map.put("orderDlvra", orderDlvra);
		map.put("orderDetailList", orderDetailList);
		map.put("goodsRcvPstList", cacheService.listCodeCache(FrontWebConstants.GOODS_RCV_PST, null, null, null, null, null));
		map.put("pblGateEntMtdList", cacheService.listCodeCache(FrontWebConstants.PBL_GATE_ENT_MTD, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		
		/**********************************
		 * 주문 알림톡 전송
		 **********************************/
		orderService.sendMessage(orderBase.getOrdNo(), "", "", null);

		//펫로그 후기 작성 지급 포인트
		CodeDetailVO period = gsrService.getCodeDetailVO(FrontConstants.GS_PNT_PERIOD,FrontConstants.GS_PNT_PERIOD_REVIEW);
		//기간 체크
		Boolean isPeriod = false;
		String strtDtm = Optional.ofNullable(period.getUsrDfn1Val()).orElseGet(()->"");
		String endDtm = Optional.ofNullable(period.getUsrDfn2Val()).orElseGet(()->"");
		Long today = System.currentTimeMillis();

		if(StringUtil.isNotEmpty(strtDtm) && StringUtil.isNotEmpty(endDtm)){
			Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
			Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
			isPeriod = strt <= today && today <= end;
		}else if(StringUtil.isNotEmpty(strtDtm)){
			Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
			isPeriod = strt <= today ;
		}else if(StringUtil.isNotEmpty(endDtm)){
			Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
			isPeriod = today <= end;
		}else{
			isPeriod = false;
		}

		if(isPeriod){
			CodeDetailVO reward = gsrService.getCodeDetailVO(FrontConstants.VARIABLE_CONSTANTS,FrontConstants.VARIABLE_CONSTATNS_PET_LOG_REVIEW_PNT);
			map.put("reviewPnt",reward);
		}
		return "order/indexOrderCompletion";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: JinHong
	 * - 설명		: 재고 체크
	 * </pre>
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "getValidGoods")
	@ResponseBody
	public ModelMap getValidGoods(Session session, CartSO so) {

		List<CartGoodsVO> stockList = this.cartService.listValidGoodsStock(so);
		
		ModelMap map = new ModelMap();
		map.put("stockList", stockList);

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: JinHong
	 * - 설명		: 사은품 체크
	 * </pre>
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "getValidFreebie")
	@ResponseBody
	public ModelMap getValidFreebie(Session session, String [] goodsIdsStr, Integer[] buyQtys) {
		
		List<CartVO> list = new ArrayList<>();
		CartVO vo = null;
		for(int i=0; i<goodsIdsStr.length; i++) {
			vo = new CartVO();
			String[] arrGoodsIds = StringUtils.splitPreserveAllTokens(goodsIdsStr[i], "\\:");
			vo.setGoodsId(arrGoodsIds[0]);
			vo.setBuyQty(buyQtys[i]);
			
			list.add(vo);
		}
		
		CartFreebieRtnVO rtn = cartService.checkCartFreebie(list);
		ModelMap map = new ModelMap();
		map.put("rtn", rtn);

		return map;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: JinHong
	 * - 설명		: 쿠폰 할인금액 계산
	 * </pre>
	 * @param cartInfo
	 * @param session
	 * @param view
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getCpDcAmt")
	@ResponseBody
	public ModelMap getCpDcAmt(String cartInfo, Session session, ViewBase view) {
		JsonUtil jsonUt = new JsonUtil();
		List<CartGoodsSO.Cart> cartList = jsonUt.toArray(CartGoodsSO.Cart.class, cartInfo);
		CartGoodsSO so = new CartGoodsSO();
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		so.setStId(view.getStId());
		if (FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setSsnId(session.getSessionId());
		}
		else {
			so.setMbrNo(session.getMbrNo());
		}
		
		so.setCartList(cartList);
		
		List<CartGoodsVO> cartGoodsList = this.cartService.listCartGoods(so, "N");

		ModelMap map = new ModelMap();
		
		map.put("cartGoodsList", cartGoodsList);

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: JinHong
	 * - 설명		: 배송비 계산
	 * </pre>
	 * @param cartInfo
	 * @param session
	 * @param view
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getDeliveryAmt")
	@ResponseBody
	public ModelMap getDeliveryAmt(String cartInfo, Session session, ViewBase view) {
		ModelMap map = new ModelMap();
		JsonUtil jsonUt = new JsonUtil();
		List<CartDeliveryTotalInfo> dlvrcList = new ArrayList<>();
		
		List<CartGoodsSO.Cart> cartList = jsonUt.toArray(CartGoodsSO.Cart.class, cartInfo);
		
		if(CollectionUtils.isEmpty(cartList)) {
			map.put("dlvrcList", dlvrcList);
			return map;
		}
		CartGoodsSO so = new CartGoodsSO();
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		so.setStId(view.getStId());
		if (FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setSsnId(session.getSessionId());
		}
		else {
			so.setMbrNo(session.getMbrNo());
		}
		
		so.setCartList(cartList);
		
		List<CartGoodsVO> cartGoodsList = this.cartService.listCartGoods(so, "N");

		if (CollectionUtils.isNotEmpty(cartGoodsList)) {
			Long totalGoodsAmt = 0L;
			Long totalDlvrAmt = 0L;
			Long totalCpDcAmt = 0L;
			Integer beforePkgDlvrNo = 0;
			
			for (int i=0; i<cartGoodsList.size(); i++) {
				CartGoodsVO cgvo = cartGoodsList.get(i);
				totalGoodsAmt += (cgvo.getSalePrc() - cgvo.getPrmtDcAmt()) * cgvo.getBuyQty();
				totalCpDcAmt += cgvo.getSelTotCpDcAmt();
				if (!beforePkgDlvrNo.equals(cgvo.getPkgDlvrNo())) {
					totalDlvrAmt += cgvo.getPkgDlvrAmt() + cgvo.getPkgAddDlvrAmt();
					beforePkgDlvrNo = cgvo.getPkgDlvrNo();
				}
				
				boolean isLeafDlvrc = false;
				if (i == cartGoodsList.size() - 1 ) {
					isLeafDlvrc = true;
					
				}else {
					if(!cgvo.getDlvrcPlcNo().equals(cartGoodsList.get(i + 1).getDlvrcPlcNo())) {
						isLeafDlvrc = true;
					}
				}
				
				if(isLeafDlvrc) {
					CartDeliveryTotalInfo dlvlcTotal = new CartDeliveryTotalInfo();
					dlvlcTotal.setDlvrcPlcNo(cgvo.getDlvrcPlcNo());
					dlvlcTotal.setTotalGoodsAmt(totalGoodsAmt);
					dlvlcTotal.setTotalDlvrAmt(totalDlvrAmt);
					dlvlcTotal.setTotalCpDcAmt(totalCpDcAmt);
					dlvlcTotal.setCompGbCd(cgvo.getCompGbCd());
					dlvrcList.add(dlvlcTotal);
					totalGoodsAmt = 0L;
					totalDlvrAmt = 0L;
					totalCpDcAmt = 0L;
				}
			}
		}
		
		map.put("dlvrcList", dlvrcList);

		return map;
	}
	
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 02. 25.
	 * - 작성자		: JinHong
	 * - 설명		: 추천상품 목록
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "incRecomeGoods")
	public String incRecomeGoods(HttpServletRequest request, ModelMap map, Session session, ViewBase view, CartGoodsSO so) {

		String ssnId = null;
		
		//------------------------------------------------
		// 1. 장바구니 상품 목록 조회
		so.setNowBuyYn(FrontWebConstants.COMM_YN_N);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
		} else {
			//비회원 장바구니 최초 ssnId 저장 , 24시간 유지
			Cookie[] cookies = request.getCookies();
			String cartTempKey = ""; 
			if(cookies != null){
		         
				for(int i=0; i < cookies.length; i++){
					Cookie c = cookies[i] ;
		            if(c.getName().equals("CART_TEMP_KEY")) {
		            	cartTempKey = c.getValue() ;
		            	break;
		            }
				}
			}
			
			if(StringUtils.isNotEmpty(cartTempKey)) { 
				ssnId = cartTempKey;
			}else{
				ssnId = session.getSessionId();
			}
			
			so.setSsnId(ssnId);
		}
		so.setStId(view.getStId());
		List<CartGoodsVO> cstrtList = this.cartService.listCartCstrtGoodsInfo(so);

		map.put("cstrtList", cstrtList);
		
		return TilesView.none(new String[] { "order", "include", "incRecomeGoods" });
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 02. 25.
	 * - 작성자		: JinHong
	 * - 설명		: 미니 장바구니
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "includeMiniCart")
	public String miniCart(ModelMap map, Session session, ViewBase view, CartGoodsSO so) {

		//------------------------------------------------
		// 1. 장바구니 상품 목록 조회
		so.setNowBuyYn(FrontWebConstants.COMM_YN_N);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
		} else {
			so.setSsnId(session.getSessionId());
		}
		so.setStId(view.getStId());
		so.setMiniCart(true);
		
		List<CartGoodsVO> cartList = this.cartService.listCartGoods(so, "N");

		cartList.sort(Comparator.comparing(CartGoodsVO::getSysRegDtm).reversed());

		List<CartGoodsVO> dlvrcList = new ArrayList<>();
		for(CartGoodsVO vo : cartList) {

			if(!dlvrcList.stream().anyMatch(temp -> temp.getDlvrcPlcNo().equals(vo.getDlvrcPlcNo()))) {
				dlvrcList.add(vo);
			}
		}

		map.put("dlvrcList", dlvrcList);
		map.put("cartList", cartList);
		map.put("session",session);
		
		return TilesView.none(new String[] { "common", "goods", "include", "includeMiniCart" });
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getOrderFreeHalbu
	 * - 작성일		: 2021. 05. 03.
	 * - 작성자		: sorce
	 * - 설명			: 카드 무이자 할부 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@LoginCheck
	@RequestMapping("getOrderFreeHalbu")
	@ResponseBody
	public ModelMap getOrderFreeHalbu(CardcInstmntInfoSO so) {

		ModelMap map = new ModelMap();
		map.put("freeHalbuList", orderService.getCardcInstmntInfo(so));

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 19.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 수량 가져오기
	 * </pre>
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "getCartCnt")
	@ResponseBody
	public ModelMap getCartCnt(Session session) {
		
		ModelMap map = new ModelMap();
		
		Integer cartCnt = this.cartService.getCartCnt(Long.valueOf(this.webConfig.getProperty("site.id")), session.getSessionId(), session.getMbrNo());
		map.put("cartCnt", cartCnt);

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 reload 용
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 */
	@RequestMapping(value = "incCartList")
	public String incCartList(ModelMap map, Session session, ViewBase view) {

		//------------------------------------------------
		// 1. 장바구니 상품 목록 조회
		CartGoodsSO so = new CartGoodsSO();
		so.setNowBuyYn(FrontWebConstants.COMM_YN_N);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
		} else {
			so.setSsnId(session.getSessionId());
		}
		so.setStId(view.getStId());
		List<CartGoodsVO> cartList = this.cartService.listCartGoods(so, "N");
		
		//2021-04-01 최근 담은 상품 상위로.
		cartList.sort(Comparator.comparing(CartGoodsVO::getSysRegDtm).reversed());
		
		Map<Integer, Long> sortMap = new HashMap<>();
		List<CartGoodsVO> dlvrcList = new ArrayList<>();
		int sortCnt = 0;
		for(CartGoodsVO vo : cartList) {
			if(!sortMap.containsValue(vo.getCompNo())) {
				sortMap.put(sortCnt, vo.getCompNo());
				vo.setSortOrder(sortCnt);
				sortCnt++;
			}else {
				for (Map.Entry<Integer, Long> entry : sortMap.entrySet()) {
					if(entry.getValue().equals(vo.getCompNo())) {
						vo.setSortOrder(entry.getKey());
						break;
					}
				}
			}
			
			if(!dlvrcList.stream().anyMatch(temp -> temp.getDlvrcPlcNo().equals(vo.getDlvrcPlcNo()))) {
				dlvrcList.add(vo);
			}
		}
		
		if(CollectionUtils.isNotEmpty(cartList)) {
			//첫번째 업체 구분 order
			if(CommonConstants.COMP_GB_10.equals(cartList.get(0).getCompGbCd())) {
				cartList.sort(Comparator.comparing(CartGoodsVO::getCompGbCd).thenComparing(Comparator.comparing(CartGoodsVO::getSortOrder)).thenComparing(Comparator.comparing(CartGoodsVO::getSysRegDtm).reversed()));
			}else {
				cartList.sort(Comparator.comparing(CartGoodsVO::getCompGbCd).reversed().thenComparing(Comparator.comparing(CartGoodsVO::getSortOrder)).thenComparing(Comparator.comparing(CartGoodsVO::getSysRegDtm).reversed()));
			}
		}
		
		map.put("dlvrcList", dlvrcList);
		map.put("cartList", cartList);
		
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.none(new String[] {"order", "include", "incCartList" });
	}

	@LoginCheck
	@RequestMapping(value = "registBillPassword")
	public String registBillPassword(ModelMap map, Session session, @RequestParam("birth") String birth, ViewBase view) {

		map.put("birth", birth);
		map.put("view", view);

		return "order/registBillPassword";
	}
	@LoginCheck
	@RequestMapping(value = "insertRegistBillCardTemp")
	@ResponseBody
	public ModelMap insertRegistBillCardTemp(Session session, ViewBase view, HttpServletRequest request,
	                                        @RequestParam("cardNo") String cardNo, @RequestParam("simpScrNo") String simpScrNo, @RequestParam("pgMoid") String pgMoid) {

		PrsnCardBillingInfoPO pcbipo = new PrsnCardBillingInfoPO();

		pcbipo.setMbrNo(session.getMbrNo());
		pcbipo.setCardNo(MaskingUtil.getCard(cardNo));
		pcbipo.setPgMoid(pgMoid);
		pcbipo.setSimpScrNo(simpScrNo);

		String prsnCardBillNo = orderService.insertRegistBillCardTemp(pcbipo);

		ModelMap map = new ModelMap();

		map.put("prsnCardBillNo", pcbipo.getPrsnCardBillNo());
		map.put("cardNo", pcbipo.getCardNo());

		return map;
	}

	@LoginCheck
	@RequestMapping(value = "confirmBillPassword")
	public String confirmBillPassword(ModelMap map, Session session, @RequestParam("birth") String birth, ViewBase view) {

		int billInputFailCnt = orderService.getBillInputFailCnt(session.getMbrNo());

		map.put("billInputFailCnt", billInputFailCnt);
		map.put("birth", birth.substring(2,8));
		map.put("view", view);

		return "order/confirmBillPassword";
	}	
	@LoginCheck
	@ResponseBody
	@RequestMapping(value = "checkBillPassword")
	public ModelMap checkBillPassword(Session session, PrsnCardBillingInfoPO pcbipo) {

		ModelMap map = new ModelMap();

		pcbipo.setMbrNo(session.getMbrNo());

		Map<String, Object> result = orderService.checkBillPassword(pcbipo);

		String resultCode = result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));
		String resultMsg = null;

		if(StringUtil.isNotBlank(resultCode)) {
			resultMsg = message.getMessage("business.exception." + resultCode);

		}else { //성공인 경우
			resultCode = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}

		map.addAttribute(FrontConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.addAttribute(FrontConstants.CONTROLLER_RESULT_MSG, resultMsg);
		map.put("prsnCardBillNo", result.get("prsnCardBillNo"));

		return map;
	}
	@LoginCheck
	@RequestMapping(value = "openResetPasswordPop")
	public String openResetPasswordPop(ModelMap map, Session session, ViewBase view, @RequestParam("birth") String birth) {

		map.put("birth", birth);
		map.put("view", view);

		return "order/resetBillPassword";
	}

	@LoginCheck
	@RequestMapping(value = "updateBillPassword")
	@ResponseBody
	public ModelMap updateBillPassword(Session session, ViewBase view, HttpServletRequest request, @RequestParam("simpScrNo") String simpScrNo) {

		PrsnCardBillingInfoPO pcbipo = new PrsnCardBillingInfoPO();

		pcbipo.setMbrNo(session.getMbrNo());
		pcbipo.setSimpScrNo(simpScrNo);

		orderService.updateBillPassword(pcbipo);

		ModelMap map = new ModelMap();

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 04. 08.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 - 배송 정책 valid 
	 * </pre>
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "validOrderDlvr")
	@ResponseBody
	public ModelMap validOrderDlvr(Session session, OrderDlvrAreaSO so) {

		OrderDlvrAreaVO valid = this.orderDlvrAreaService.validOrderDlvr(so);
		
		ModelMap map = new ModelMap();
		map.put("valid", valid);

		return map;
	}
	
	/**
	 * 
	 * <pre>
	 * - Method 명	: getDlvrPolicy
	 * - 작성일		: 2021. 4. 21.
	 * - 작성자		: SungHyun
	 * - 설 명			: 
	 * </pre>
	 *
	 * @param model
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getDlvrPolicy")
	public ModelMap getDlvrPolicy(Model model) {
		ModelMap map = new ModelMap();
		
		List<OrderDlvrAreaVO> list = orderDlvrAreaService.getDlvrPrcsListForGoodsDetail();
		map.addAttribute("list", list);
		return map;
	}

	public static String maskingCard(String cardNo){

		String maskingCardNo = "";

		if(cardNo != null && !"".equals(cardNo) && !"null".equals(cardNo)){
			int total = cardNo.length();
			int startLen=4, endLen = 12;


			String start = cardNo.substring(0,startLen);
			String end = cardNo.substring(endLen, total);
			String padded = StringUtils.rightPad(start, endLen,'*');

			maskingCardNo = padded.concat(end);
		}

		return maskingCardNo;
	}

	@LoginCheck
	@RequestMapping(value = "incEasyPay")
	public String incEasyPay(ModelMap map, Session session, ViewBase view) {

		// 등록된 간편결제 정보

		MemberBaseSO mbso = new MemberBaseSO();

		mbso.setMbrNo(session.getMbrNo());

		List<PrsnCardBillingInfoVO> cardBillInfo = memberService.listMemberCardBillingInfo(mbso);

		map.put("cardBillInfo", cardBillInfo);

		log.debug("==================================================================");
		log.debug("CARD BILL INFO: {} ", cardBillInfo);
		log.debug("==================================================================");

		return "order/incEasyPay";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 04. 24.
	 * - 작성자		: JinHong
	 * - 설명		: Adbrix 상품정보
	 * </pre>
	 * @param session
	 * @param view
	 * @param goodsIds
	 * @return
	 */
	@RequestMapping(value = "listAdbrixGoods")
	@ResponseBody
	public ModelMap validOrderDlvr(Session session, ViewBase view, String [] goodsIds, String ordNo) {

		CartGoodsSO so = new CartGoodsSO();
		so.setGoodsIds(goodsIds);
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);
		}else {
			so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_20);
		}
		so.setStId(view.getStId());
		
		List<OrderAdbrixVO> adbrixList = orderService.listCartAdbrix(so);
		
		OrderDetailSO detailSO = new OrderDetailSO();
		detailSO.setMbrNo(session.getMbrNo());
		detailSO.setOrdNo(ordNo); //현재 주문건 제외
		int oldOrdDtlCnt = orderDetailService.getOrderDetailCntByMbrNo(detailSO);
		ModelMap map = new ModelMap();
		map.put("oldOrdDtlCnt", oldOrdDtlCnt);
		map.put("adbrixList", adbrixList);

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 04. 28.
	 * - 작성자		: JinHong
	 * - 설명		: 살아있는 주문 체크
	 * </pre>
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "validLiveCart")
	@ResponseBody
	public ModelMap validLiveCart(Session session, CartSO so) {

		List<CartVO> cartList = this.cartService.listCart(so);
		boolean isLive = false;
		if(CollectionUtils.isNotEmpty(cartList)) {
			isLive = true;
		}else {
			isLive = false;
		}
		
		ModelMap map = new ModelMap();
		map.put("isLive", isLive);

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: JinHong
	 * - 설명		: 사용가능한 MP 포인트 조회
	 * </pre>
	 * @param session
	 * @param req
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "getUsableMpPnt")
	@ResponseBody
	public ModelMap getUsableMpPnt(Session session, ISR3K00108ReqVO req) {
		/*MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		MemberBaseVO member = memberService.getMemberBase(so);
		req.setCNNT_INFO(member.getCiCtfVal());*/
		ISR3K00108ResVO res = sktmpService.getUsableMpPnt(req);
		
		ModelMap map = new ModelMap();
		map.put("res", res);

		return map;
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 06.
	 * - 작성자		: hjh
	 * - 설명		: 우주코인 멤버십 등록 팝업
	 * </pre>
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "popupRegistSktmp")
	public String popupRegistSktmp(ModelMap map, Session session, ViewBase view) {
		List<TermsVO> termsList = new ArrayList<>();
		
		String pocGbCd = "";
		String viewOs = view.getOs();			//OS 구분 코드
		String deviceGb = view.getDeviceGb();	//디바이스 구분 코드

		//앱 IOS
		if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && !StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbCd = FrontConstants.TERMS_POC_IOS;
		}
		//앱 AOS
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbCd = FrontConstants.TERMS_POC_ANDR;
		}
		//모바일
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_20)){
			pocGbCd = FrontConstants.TERMS_POC_MO;
		}
		//PC
		else{
			pocGbCd = FrontConstants.TERMS_POC_WEB;
		}

		TermsSO tso = new TermsSO();
		tso.setPocGbCd(pocGbCd);
		tso.setMbrNo(session.getMbrNo());

		// 결제약관
		tso.setUsrDfn1Val(CommonConstants.TERMS_GB_ABP);
		tso.setUsrDfn2Val(CommonConstants.TERMS_GB_ABP_PAY);
		
		termsList = termsService.listSktmpTerms(tso);
		
		if (CollectionUtils.isNotEmpty(termsList)) {
			if (termsList.get(0).getTermsHistoryCnt() > 0) {
				map.put("firstYn", "N");
			} else {
				map.put("firstYn", "Y");
			}
		}
		
		map.put("session", session);
		map.put("view", view);
		map.put("termsList", termsList);
		
		String returnUrl = "order/popupRegistSktmp";
		if (!StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_10)) {
			returnUrl = "order/popupRegistSktmpMo";
		}

		return returnUrl;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 06.
	 * - 작성자		: hjh
	 * - 설명		: 우주코인 멤버십 약관 화면
	 * </pre>
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "indexSktmpTerms")
	public String indexSktmpTerms(ModelMap map, Session session, ViewBase view, @RequestParam String termsIndex) {
		List<TermsVO> termsList = new ArrayList<>();
		
		String pocGbCd = "";
		String viewOs = view.getOs();			//OS 구분 코드
		String deviceGb = view.getDeviceGb();	//디바이스 구분 코드

		//앱 IOS
		if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && !StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbCd = FrontConstants.TERMS_POC_IOS;
		}
		//앱 AOS
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbCd = FrontConstants.TERMS_POC_ANDR;
		}
		//모바일
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_20)){
			pocGbCd = FrontConstants.TERMS_POC_MO;
		}
		//PC
		else{
			pocGbCd = FrontConstants.TERMS_POC_WEB;
		}

		TermsSO tso = new TermsSO();
		tso.setPocGbCd(pocGbCd);
		tso.setMbrNo(session.getMbrNo());

		// 결제약관
		tso.setUsrDfn1Val(CommonConstants.TERMS_GB_ABP);
		tso.setUsrDfn2Val(CommonConstants.TERMS_GB_ABP_PAY);
		
		termsList = termsService.listSktmpTerms(tso);
		
		map.put("session", session);
		map.put("view", view);
		map.put("termsList", termsList);
		map.put("termsIndex", termsIndex);

		return "order/indexSktmpTerms";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 06.
	 * - 작성자		: hjh
	 * - 설명		: 우주코인 멤버십 비밀번호 확인 팝업
	 * </pre>
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "popupSktmpPassword")
	public String popupSktmpPassword(ModelMap map, Session session, ViewBase view) {
		String returnUrl = "order/popupSktmpPassword";
		if (!StringUtil.equals(view.getDeviceGb(),FrontConstants.DEVICE_GB_10)) {
			returnUrl = "order/popupSktmpPasswordMo";
		}
		return returnUrl;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 06.
	 * - 작성자		: hjh
	 * - 설명		: 우주코인 멤버십 PIN 번호 체크
	 * </pre>
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "sktmpPinNoCheck")
	@ResponseBody
	public ModelMap sktmpPinNoCheck(Session session, ViewBase view, SktmpCardInfoVO vo, String cardNo) {
		
		ModelMap map = new ModelMap();
		
		MemberBaseSO memberSO = new MemberBaseSO();
		memberSO.setMbrNo(session.getMbrNo());
		MemberBaseVO memberVO = memberService.getMemberBase(memberSO);
		//CI, 카드번호 일치 여부 조회
		ISR3K00114ReqVO reqVO = new ISR3K00114ReqVO();
		reqVO.setEBC_NUM(cardNo);
		reqVO.setCNNT_INFO(memberVO.getCiCtfVal());
		
		if (StringUtil.isEmpty(vo.getCardNo())) {
			SktmpCardInfoSO sciso = new SktmpCardInfoSO();
			sciso.setMbrNo(session.getMbrNo());
			SktmpCardInfoVO scivo = sktmpService.getSktmpCardInfo(sciso);
			vo.setCardNo(scivo.getCardNo());
			map.put("cardInfo", scivo);
			
			reqVO.setEBC_NUM(scivo.getCardNo());
		}
		
		ISR3K00114ResVO equalVO = sktmpService.getEqualCheckCiAndCardNo(reqVO);
		map.put("equalVO", equalVO);
		
		ISR3K00102ResVO resvo = sktmpService.sktmpPinNoCheck(vo);
		map.put("resvo", resvo);

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 06.
	 * - 작성자		: hjh
	 * - 설명		: 우주코인 멤버십 등록/변경
	 * </pre>
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "saveSktmpCardInfo")
	@ResponseBody
	public ModelMap saveSktmpCardInfo(Session session, ViewBase view, SktmpCardInfoPO po) {
		ModelMap map = new ModelMap();
		po.setMbrNo(session.getMbrNo());
		sktmpService.saveSktmpCardInfo(po);
		
		SktmpCardInfoVO scivo = new SktmpCardInfoVO();
		scivo.setCardNo(po.getCardNo());
		scivo.setPinNo(po.getPinNo());
		
		map.put("cardNo", scivo.getCardNo());
		map.put("pinNo", scivo.getPinNo());
		map.put("viewCardNo", scivo.getViewCardNo());

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.order.controller
	 * - 작성일		: 2021. 08. 10.
	 * - 작성자		: JinHong
	 * - 설명		: 잔여 적립 횟수 조회
	 * </pre>
	 * @param session
	 * @param req
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "getMpSaveRmnCount")
	@ResponseBody
	public ModelMap getMpSaveRmnCount(Session session, ISR3K00110ReqVO req) {
		PntInfoSO pntSO = new PntInfoSO();
		pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
		PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
		ISR3K00110ResVO res = null;
		if(mpPntVO != null) {
			req.setGOODS_CD(mpPntVO.getIfGoodsCd());
			
			res = sktmpService.getMpSaveRmnCount(req);
			
		}
		
		ModelMap map = new ModelMap();
		map.put("res", res);

		return map;
	}
	
}