package front.web.view.mypage.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.google.gson.Gson;

import biz.app.attribute.model.AttributePO;
import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailRefundVO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimRefundPayDetailVO;
import biz.app.claim.model.ClaimRefundPayVO;
import biz.app.claim.model.ClaimRefundVO;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClaimRegist.ClaimSub;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClaimSummaryVO;
import biz.app.claim.service.ClaimAcceptService;
import biz.app.claim.service.ClaimBaseService;
import biz.app.claim.service.ClaimDetailService;
import biz.app.claim.service.ClaimService;
import biz.app.delivery.model.DeliveryVO;
import biz.app.delivery.service.DeliveryChargeService;
import biz.app.delivery.service.DeliveryService;
import biz.app.goods.model.GoodsAttributeVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.ItemAttributeValueVO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.service.GoodsService;
import biz.app.goods.service.ItemService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderClaimVO;
import biz.app.order.model.OrderDeliveryVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderReceiptVO;
import biz.app.order.model.OrderSO;
import biz.app.order.model.OrderStatusVO;
import biz.app.order.service.OrderBaseService;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderDlvraService;
import biz.app.order.service.OrderService;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.service.PayBaseService;
import biz.app.receipt.dao.CashReceiptDao;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.model.TaxInvoicePO;
import biz.app.receipt.service.CashReceiptService;
import biz.app.receipt.service.TaxInvoiceService;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.app.system.service.LocalPostService;
import biz.app.system.service.PntInfoService;
import biz.common.service.CacheService;
import biz.godomall.order.service.OrderGdmService;
import biz.interfaces.nicepay.model.request.data.CheckBankAccountReqVO;
import biz.interfaces.nicepay.model.response.data.CheckBankAccountResVO;
import biz.interfaces.nicepay.service.NicePayCommonService;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.view.mypage.model.CashReceiptRequestParam;
import front.web.view.mypage.model.OrderOptionChangeParam;
import front.web.view.mypage.model.PurchaseReceiptParam;
import front.web.view.mypage.model.TaxInvoiceRequestParam;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyOrderController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 나의 주문 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage/order")
public class MyOrderController {

	@Autowired
	private OrderBaseService orderBaseService;

	@Autowired
	private OrderDetailService orderDetailService;

	@Autowired private OrderService orderService;

	@Autowired private OrderGdmService orderGdmService;

	@Autowired private OrderDlvraService orderDlvraService;

	@Autowired private MessageSourceAccessor message;

	@Autowired private CacheService cacheService;

	@Autowired private ClaimService claimService;
	
	@Autowired	private ClaimBaseService claimBaseService;

	@Autowired private ClaimDetailService claimDetailService;

	@Autowired private TaxInvoiceService taxService;

	@Autowired private CashReceiptService cashReceiptService;

	@Autowired private GoodsService goodsService;

	@Autowired private DeliveryService deliveryService;

	@Autowired private Properties bizConfig;

	@Autowired private CacheService codeCacheService;

	@Autowired private MemberService memberService;

	@Autowired private PayBaseService payBaseService;
	
	@Autowired private ItemService itemService;
	
	@Autowired private LocalPostService localPostService;
	
	@Autowired private NicePayCommonService nicePayCommonService;
	
	@Autowired private CashReceiptDao cashReceiptDao;
	
	@Autowired private ClaimAcceptService claimAcceptService;
	
	@Autowired private DeliveryChargeService deliveryChargeService;
	
	@Autowired private SktmpService sktmpService;
	
	@Autowired private PntInfoService pntInfoService;
	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문/배송 목록 조회  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH, noMemCheck=false)	 
	@RequestMapping(value="indexDeliveryList")
	public String indexDeliveryList(ModelMap map, OrderSO so, Session session, ViewBase view, String mngb){
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);	
		so.setMbrNo(session.getMbrNo());
		so.setOrdrShowYn("Y");
		
		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getOrdAcptDtmStart()));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getOrdAcptDtmEnd()));
		
		//주문진행상태 카운트
		OrderStatusVO orderSummary = orderService.listOrderCdCountList( so );

		// 마이룸 주문/배송조회 리스트 조회
		//List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );
		List<OrderBaseVO> orderList = orderService.pageOrderDeliveryList2ndE( so );
		
		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("session", session);
		map.put("view", view);
		map.put("orderSummary", orderSummary);		
		map.put("orderList", orderList);
		map.put("orderSO", so);
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_DELIVERY);	
		map.put("mngb", mngb);

		//2021.07.20 -> 운영 제외 노출
		if(!(StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER))){
			map.put("migMemno",session.getMigMemno());
		}

		return  TilesView.mypage(new String[]{"order", "indexDeliveryList"});
	}

	@RequestMapping(value="indexPetsbeDeliveryList",method = RequestMethod.GET)
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH, noMemCheck=false)
	public String indexPetsbeDeliveryListMethodGet(ModelMap map,Session session,ViewBase view){
		return "redirect:/mypage/order/indexDeliveryList";
	}
	@RequestMapping(value="indexPetsbeDeliveryList",method = RequestMethod.POST)
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH, noMemCheck=false)
	public String indexDeliveryListMethodPost(ModelMap map, OrderSO so, Session session, ViewBase view, String mngb){
		Long migMemno = session.getMigMemno();

		if (so.getPeriod() == null) {so.setPeriod("12");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMigMemno(migMemno);
		so.setOrdrShowYn("Y");

		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());
		// 날짜 조회 param 설정
		String ordAcptStrtDtmStr = DateUtil.addMonth("yyyyMMdd",-(Integer.parseInt(so.getPeriod())));
		Timestamp ordAcptStrtDtm =Optional.ofNullable(so.getOrdAcptDtmStart()).orElseGet(()->DateUtil.getTimestamp(ordAcptStrtDtmStr,"yyyyMMdd"));
		Timestamp ordAcptEndDtm = Optional.ofNullable(so.getOrdAcptDtmEnd()).orElseGet(()->DateUtil.getTimestamp());
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", ordAcptStrtDtm));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", ordAcptEndDtm));

		//주문진행상태 카운트
		OrderStatusVO orderSummary = orderGdmService.listOrderCdCountList( so );

		// 마이룸 주문/배송조회 리스트 조회
		//List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );
		List<OrderBaseVO> orderList = orderGdmService.pageOrderDeliveryList2ndE( so );

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("session", session);
		map.put("view", view);
		map.put("orderSummary", orderSummary);
		map.put("orderList", orderList);
		map.put("orderSO", so);
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_DELIVERY);

		map.put("mngb", mngb);

		return  TilesView.mypage(new String[]{"order", "indexPetsbeDeliveryList"});
	}

	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexPetsbeDeliveryDetail")
	public String indexPetsbeDeliveryDetail(ModelMap map,Session session,ViewBase view,String ordNo,String mngb){
		/******************************
		 * Validation
		 *****************************/

		if(CommonConstants.NO_MEMBER_NO.equals(session.getMigMemno())){
			ordNo = session.getNoMemOrdNo();
		}

		/*
		 * Param Check
		 */
		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/******************************
		 * 주문 기본 정보 조회
		 *****************************/
		// OrderBaseVO orderBase = orderBaseService.getOrderBase(ordNo);

		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(ordNo);
		OrderBaseVO orderBase = orderGdmService.listOrderDetail2ndE(odso);

		/*
		 * 주문 정보가 존재하지 않은 경우
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}

		/*
		 * 회원 구분에 따른 처리
		 */
		if(!FrontWebConstants.NO_MEMBER_NO.equals(session.getMigMemno())){
			if(!orderBase.getMbrNo().equals(session.getMigMemno())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}else{
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, ordNo);

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}

		map.put("orderBase", orderBase);

		/************************
		 *  배송지 정보
		 ************************/
		OrderDlvraSO odaso = new OrderDlvraSO();
		odaso.setOrdNo(orderBase.getOrdNo());
		OrderDlvraVO orderDlvraInfo =  orderGdmService.getOrderDlvra(odaso);

		map.put("orderDlvraInfo", orderDlvraInfo);

		/*********************************
		 * 결제 정보 조회
		 *********************************/
		List<OrderPayVO> payInfoList = orderGdmService.getOrderPayInfo(orderBase.getOrdNo());
		payInfoList.stream().filter(v->
					StringUtil.isNotEmpty(v.getPayMeansCd())
				&& !StringUtil.equals(v.getPayMeansCd(),"gd") && !StringUtil.equals(v.getPayMeansCd(),"gm")
				&& !StringUtil.equals(v.getPayMeansCd(),"fp")&& !StringUtil.equals(v.getPayMeansCd(),"navepoint")).collect(Collectors.toList());
		map.put("payInfoList", payInfoList);

		// 프론트 결제 정보 조희 추가, 2021.04.26, ssmvf01
		OrderPayVO frontPayInfo = orderGdmService.getFrontPayInfo(orderBase.getOrdNo());
		map.put("frontPayInfo", frontPayInfo);

		//=============================================================================
		// 현금영수증 기 접수/승인 건 체크
		//=============================================================================
		payInfoList.stream().forEach(v->{
			if(v.getPayMeansCd() != null && StringUtil.isNotEmpty(v.getPayMeansCd())){
				if(StringUtil.equals(CommonConstants.PAY_MEANS_20,v.getPayMeansCd()) || StringUtil.equals(CommonConstants.PAY_MEANS_30,v.getPayMeansCd())){
					CashReceiptSO cashReceiptSO = new CashReceiptSO();
					cashReceiptSO.setOrdNo(v.getOrdNo());
					Integer check = orderGdmService.getCashReceiptExistsCheck( cashReceiptSO );

					map.put("cashReceiptCheck", check);

					//5일 이내에 발급가능
					Calendar cal = Calendar.getInstance();
					cal.setTimeInMillis(orderBase.getOrdAcptDtm().getTime());
					cal.add(Calendar.DATE, 5);
					Timestamp lastTime = new Timestamp(cal.getTime().getTime());

					Date date = new Date();
					long time = date.getTime();
					Timestamp now = new Timestamp(time);

					map.put("fiveDaysBefore", now.before(lastTime));
				}
			}
		});

		/*********************************
		 * 기타코드정보 설정
		 ********************************/
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));

		map.put("goodsRcvPstList", this.cacheService.listCodeCache(FrontWebConstants.GOODS_RCV_PST, null, null, null, null, null));
		map.put("pblGateEntMtdList", this.cacheService.listCodeCache(FrontWebConstants.PBL_GATE_ENT_MTD, null, null, null, null, null));

		/**
		 * 2021.06.03, ssmvf01, ORD_PROPS.10's usrDfn1Val 을 구주문 기준 주문번호로 정의함.
		 */
		CodeDetailVO ordPropsCode = this.cacheService.listCodeCache(FrontWebConstants.ORD_PROPS, null, null, null, null, null)
				.stream().filter(s -> s.getDtlCd().equals(FrontWebConstants.ORD_PROPS_10)).findFirst().orElse(null);
		map.put("oldStdOrdNo", ordPropsCode != null ? ordPropsCode.getUsrDfn1Val():null);

		map.put("mngb", mngb);

		map.put("session", session);

		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);
		}else {
			view.setBtnGnbHide(true);
		}

		map.put("view", view);

		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_NOMEM_ORDER_DELIVERY);
			String checkCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			map.put("checkCode", checkCode);
		}else if(mngb != null && !"".equals(mngb)){		// 취소/교환/반품 화면에서 이동시
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);
		}else{
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_DELIVERY);
		}

		return  TilesView.mypage(new String[]{"order", "indexPetsbeDeliveryDetail"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 02. 4.
	* - 작성자		: 
	* - 설명			: 주문/배송 목록 조회  ajax 페이징 
	* </pre>	
	* @param session	
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="ajaxDeliveryHtml")
	public String ajaxDeliveryHtml(ModelMap map, OrderSO so, Session session){
		
		Gson gson = new Gson();
		
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo());
		so.setOrdrShowYn("Y");
		
		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getOrdAcptDtmStart()));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getOrdAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		//List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );	
		List<OrderBaseVO> orderList = orderService.pageOrderDeliveryList2ndE( so );
		//주문별 클레임 리스트
		ClaimDetailSO cdso = new ClaimDetailSO();		
		/*for(int i=0; i< orderList.size() ; i++){		
			
			cdso.setOrdNo(orderList.get(i).getOrdNo());
			cdso.setOrdrShowYn("Y");
			cdso.setClmDtlTpCdNot40(true);
			cdso.setMbrNo(session.getMbrNo());
			List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);
			
			if(CollectionUtils.isNotEmpty(claimDetailList)){				
				orderList.get(i).setClaimDetailListVO(claimDetailList);				
			}	
			
		}*/
		
		OrderStatusVO orderSummary = orderService.listOrderCdCountList(so);
		
		map.put("orderSummary", orderSummary);
		map.put("orderList", orderList);
		map.put("orderSOAjax", so);
		map.put("orderSO", so);
		
		map.put("orderListAjax", gson.toJson(orderList));
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));

		//System.out.println("================="+ gson.toJson(orderList).toString());
		
		return "/mypage/order/include/includeDelivery";
	}

	@RequestMapping(value="ajaxDeliveryHtmlPetsbe")
	public String ajaxDeliveryHtmlPetsbe(ModelMap map, OrderSO so, Session session){

		Gson gson = new Gson();

		if (so.getPeriod() == null) {so.setPeriod("12");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMigMemno(session.getMigMemno());
		so.setOrdrShowYn("Y");

		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		String ordAcptStrtDtmStr = DateUtil.addMonth("yyyyMMdd",-(Integer.parseInt(so.getPeriod())));
		Timestamp ordAcptStrtDtm =Optional.ofNullable(so.getOrdAcptDtmStart()).orElseGet(()->DateUtil.getTimestamp(ordAcptStrtDtmStr,"yyyyMMdd"));
		Timestamp ordAcptEndDtm = Optional.ofNullable(so.getOrdAcptDtmEnd()).orElseGet(()->DateUtil.getTimestamp());
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", ordAcptStrtDtm));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", ordAcptEndDtm));

		// 마이룸 주문/배송조회 리스트 조회
		//List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );
		List<OrderBaseVO> orderList = orderGdmService.pageOrderDeliveryList2ndE( so );
		//주문별 클레임 리스트
		ClaimDetailSO cdso = new ClaimDetailSO();
		/*for(int i=0; i< orderList.size() ; i++){

			cdso.setOrdNo(orderList.get(i).getOrdNo());
			cdso.setOrdrShowYn("Y");
			cdso.setClmDtlTpCdNot40(true);
			cdso.setMbrNo(session.getMbrNo());
			List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);

			if(CollectionUtils.isNotEmpty(claimDetailList)){
				orderList.get(i).setClaimDetailListVO(claimDetailList);
			}

		}*/


		map.put("orderList", orderList);
		map.put("orderSOAjax", so);
		map.put("orderSO", so);

		map.put("orderListAjax", gson.toJson(orderList));
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));

		//System.out.println("================="+ gson.toJson(orderList).toString());

		return "/mypage/order/include/includeDelivery";
	}

	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 06. 30.
	* - 작성자		: 
	* - 설명			: 주문/배송 목록 ajax 페이징 
	* </pre>	
	* @param session	
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="ajaxDeliveryListHtml")
	public String ajaxDeliveryListHtml(ModelMap map, OrderSO so, Session session){
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo());
		so.setOrdrShowYn("Y");
		
		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getOrdAcptDtmStart()));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getOrdAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		//List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );	
		List<OrderBaseVO> orderList = orderService.pageOrderDeliveryList2ndE( so );
		
		map.put("orderList", orderList);
		map.put("orderSO", so);
		
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		
		return "/mypage/order/include/includeDeliveryList";
	}

	@RequestMapping(value="ajaxDeliveryListHtmlPetsbe")
	public String ajaxDeliveryListHtmlPetsbe(ModelMap map,OrderSO so,Session session){
		if (so.getPeriod() == null) {so.setPeriod("12");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMigMemno(session.getMigMemno());
		so.setOrdrShowYn("Y");

		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		String ordAcptStrtDtmStr = DateUtil.addMonth("yyyyMMdd",-(Integer.parseInt(so.getPeriod())));
		Timestamp ordAcptStrtDtm =Optional.ofNullable(so.getOrdAcptDtmStart()).orElseGet(()->DateUtil.getTimestamp(ordAcptStrtDtmStr,"yyyyMMdd"));
		Timestamp ordAcptEndDtm = Optional.ofNullable(so.getOrdAcptDtmEnd()).orElseGet(()->DateUtil.getTimestamp());
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", ordAcptStrtDtm));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", ordAcptEndDtm));

		// 마이룸 주문/배송조회 리스트 조회
		//List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );
		List<OrderBaseVO> orderList = orderGdmService.pageOrderDeliveryList2ndE( so );

		map.put("orderList", orderList);
		map.put("orderSO", so);

		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));

		return "/mypage/order/include/includeDeliveryList";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: ajaxDeliveryHtml2ndE
	 * - 작성일		: 2021. 04. 15.
	 * - 작성자		: sorce
	 * - 설명			: 테스트를 위한 임시메서드
	 * </pre>
	 * @param so
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="ajaxDeliveryHtml2ndE")
	public ModelMap ajaxDeliveryHtml2ndE(OrderSO so, Session session){
		ModelMap map = new ModelMap();
		Gson gson = new Gson();
		
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo());
		so.setOrdrShowYn("Y");
		
		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getOrdAcptDtmStart()));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getOrdAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		List<OrderBaseVO> orderList = orderService.pageOrderDeliveryList2ndE( so );	

		map.put("orderList", orderList);
		map.put("orderSOAjax", so);

		return  map;
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 02. 4.
	* - 작성자		: 
	* - 설명			: 주문/배송 목록 조회  ajax 페이징 
	* </pre>	
	* @param session	
	* @return
	* @throws Exception
	*/
	@Deprecated
	@RequestMapping(value="indexDeliveryAjaxList")
	@ResponseBody
	public ModelMap indexDeliveryAjaxList( OrderSO so, Session session){
		
		ModelMap map = new ModelMap();
		Gson gson = new Gson();
		
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo());
		so.setOrdrShowYn("Y");
		
		//주문상태별 갯수 선택 검색
		so.setArrOrdDtlStatCd(so.getArrOrdDtlStatCd());

		// 날짜 조회 param 설정
		so.setOrdAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getOrdAcptDtmStart()));
		so.setOrdAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getOrdAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList( so );	
		
		//주문별 클레임 리스트
		ClaimDetailSO cdso = new ClaimDetailSO();		
		for(int i=0; i< orderList.size() ; i++){		
			
			cdso.setOrdNo(orderList.get(i).getOrdNo());
			cdso.setOrdrShowYn("Y");
			cdso.setClmDtlTpCdNot40(true);
			cdso.setMbrNo(session.getMbrNo());
			List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);
			
			if(CollectionUtils.isNotEmpty(claimDetailList)){				
				orderList.get(i).setClaimDetailListVO(claimDetailList);				
			}	
			
		}
	
		map.put("orderListAjax", gson.toJson(orderList));
		map.put("orderSOAjax", so);
		map.put("ordDtlStatCdListAjax", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPListAjax", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		
		//System.out.println("================="+ gson.toJson(orderList).toString());
		
		return  map;
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 7. 3.
	* - 작성자		: Administrator
	* - 설명			: 비회원 주문 체크
	* </pre>
	* @param session
	* @param orderSO
	* @return
	*/
	@RequestMapping(value="checkNoMemOrder", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap checkNoMemOrder(ViewBase view, Session session, OrderBaseSO obso){

		/**************************
		 * 비회원 주문 조회
		 *************************/
		obso.setMbrNo(FrontConstants.NO_MEMBER_NO);
		obso.setStId(view.getStId());
		OrderBaseVO order = this.orderBaseService.getOrderBase(obso);

		// 해당 주문건이 없을 경우
		if(order == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_MATCH);
		}


		/***********************
		 * 비회원 세션 생성
		 ***********************/
		String checkCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, order.getOrdNo());

		Session newSession = new Session();
		newSession.setNoMemOrdNo(order.getOrdNo());
		newSession.setNoMemCheckCd(checkCode);
		FrontSessionUtil.setSession(newSession);

		return new ModelMap();
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문/배송 상세 조회  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param ord_no
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexDeliveryDetail")
	public String indexDeliveryDetail(ModelMap map, Session session, ViewBase view, String ordNo, String mngb){

		/******************************
		 * Validation
		 *****************************/

		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			ordNo = session.getNoMemOrdNo();
		}
		
		/*
		 * Param Check
		 */
		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/******************************
		 * 주문 기본 정보 조회
		 *****************************/
		// OrderBaseVO orderBase = orderBaseService.getOrderBase(ordNo);
		
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(ordNo);
		OrderBaseVO orderBase = orderDetailService.listOrderDetail2ndE(odso);
		
		/*
		 * 주문 정보가 존재하지 않은 경우
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}

		/*
		 * 회원 구분에 따른 처리
		 */
		if(!FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){ 
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}else{
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, ordNo);

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}

		map.put("orderBase", orderBase);

		/*****************************
		 * 주문 상세 정보 조회
		 *****************************/
		
		/*
		 * 주문 상세 목록
		 */

		//List<OrderDetailVO> orderDetailList = orderDetailService.listOrderDetail(odso);

		/*
		 * 클레임 상세 목록
		 */
		//ClaimDetailSO cdso = new ClaimDetailSO();
		//cdso.setOrdrShowYn("Y");
		//cdso.setClmDtlTpCdNot40(true);		
		//cdso.setOrdNo(orderBase.getOrdNo());
		//List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);

		/*
		 * 주문 상세에 따른 클레임 목록 설정
		 */
		//List<ClaimDetailVO> orderClaimList = null;
		//OrderDetailVO orderDetail = null;

		/*for(int i=0; i< orderDetailList.size() ; i++){
			orderClaimList = new ArrayList<>();
			orderDetail = orderDetailList.get(i);

			for(ClaimDetailVO cdvo : claimDetailList){
				if(orderDetail.getOrdNo().equals(cdvo.getOrdNo()) && orderDetail.getOrdDtlSeq().equals(cdvo.getOrdDtlSeq())){
					orderClaimList.add(cdvo);
				}
			}

			if(CollectionUtils.isNotEmpty(orderClaimList)){
				orderDetail.setClaimDetailList(orderClaimList);
				orderDetailList.set(i, orderDetail);
			}
		}*/

		//map.put("orderDetailList", orderDetailList);
		
		//int isuSchdPnt = 0;
		//for(int i=0; i<orderDetailList.size(); i++) {
		//	isuSchdPnt += orderDetailList.get(i).getIsuSchdPnt();
		//}

		//map.put("isuSchdPnt", isuSchdPnt);
		
		if(orderBase.getMpLnkHistNo() != null) {
			SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
			mpSO.setMpLnkHistNo(orderBase.getMpLnkHistNo());
			SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
			map.put("mpVO", mpVO);
		}
		
		PntInfoSO pntSO = new PntInfoSO();
		pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
		pntSO.setMbrNo(session.getMbrNo());
		PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
		map.put("mpPntVO", mpPntVO);
		/************************
		 *  배송지 정보
		 ************************/
		OrderDlvraSO odaso = new OrderDlvraSO();
		odaso.setOrdNo(orderBase.getOrdNo());
		OrderDlvraVO orderDlvraInfo =  this.orderDlvraService.getOrderDlvra(odaso);
		
		map.put("orderDlvraInfo", orderDlvraInfo);

		/*********************************
		 * 결제 정보 조회
		 *********************************/
		OrderPayVO payInfo = this.orderService.getOrderPayInfo(orderBase.getOrdNo());
		map.put("payInfo", payInfo);
		
		// 프론트 결제 정보 조희 추가, 2021.04.26, ssmvf01
		OrderPayVO frontPayInfo = orderService.getFrontPayInfo(orderBase.getOrdNo());
		map.put("frontPayInfo", frontPayInfo);
		
		//=============================================================================
		// 현금영수증 기 접수/승인 건 체크
		//=============================================================================
		if(payInfo.getPayMeansCd() != null && !"".equals(payInfo.getPayMeansCd()) ) {
			if(payInfo.getPayMeansCd().equals(CommonConstants.PAY_MEANS_20) || payInfo.getPayMeansCd().equals(CommonConstants.PAY_MEANS_30) ) {
				CashReceiptSO cashReceiptSO = new CashReceiptSO();
				cashReceiptSO.setOrdNo(ordNo);
				Integer check = cashReceiptDao.getCashReceiptExistsCheck( cashReceiptSO );
				
				map.put("cashReceiptCheck", check);
				
				//5일 이내에 발급가능
				Calendar cal = Calendar.getInstance(); 
				cal.setTimeInMillis(orderBase.getOrdAcptDtm().getTime()); 
				cal.add(Calendar.DATE, 5); 
				Timestamp lastTime = new Timestamp(cal.getTime().getTime());
				
				Date date = new Date();
				long time = date.getTime();
				Timestamp now = new Timestamp(time);
				
				map.put("fiveDaysBefore", now.before(lastTime));
			}	
		}

		/*********************************
		 * 기타코드정보 설정
		 ********************************/

		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		
		map.put("goodsRcvPstList", this.cacheService.listCodeCache(FrontWebConstants.GOODS_RCV_PST, null, null, null, null, null));
		map.put("pblGateEntMtdList", this.cacheService.listCodeCache(FrontWebConstants.PBL_GATE_ENT_MTD, null, null, null, null, null));
		
		/**
		 * 2021.06.03, ssmvf01, ORD_PROPS.10's usrDfn1Val 을 구주문 기준 주문번호로 정의함.
		 */
		CodeDetailVO ordPropsCode = this.cacheService.listCodeCache(FrontWebConstants.ORD_PROPS, null, null, null, null, null)
			.stream().filter(s -> s.getDtlCd().equals(FrontWebConstants.ORD_PROPS_10)).findFirst().orElse(null);
		map.put("oldStdOrdNo", ordPropsCode != null ? ordPropsCode.getUsrDfn1Val():null);
		
		map.put("mngb", mngb);		

		map.put("session", session);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}		
		
		map.put("view", view);

		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_NOMEM_ORDER_DELIVERY);
			String checkCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			map.put("checkCode", checkCode);
		}else if(mngb != null && !"".equals(mngb)){		// 취소/교환/반품 화면에서 이동시
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);
		}else{
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_DELIVERY);
		}

		return  TilesView.mypage(new String[]{"order", "indexDeliveryDetail"});
	}
	
	@ResponseBody
	@RequestMapping(value="indexDeliveryDetail2")
	public ModelMap indexDeliveryDetail2(Session session, ViewBase view, String ordNo, String mngb){

		ModelMap map = new ModelMap();
		/******************************
		 * Validation
		 *****************************/

		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			ordNo = session.getNoMemOrdNo();
		}
		
		/*
		 * Param Check
		 */
		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/******************************
		 * 주문 기본 정보 조회
		 *****************************/
		// OrderBaseVO orderBase = orderBaseService.getOrderBase(ordNo);
		
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(ordNo);
		OrderBaseVO orderBase = orderDetailService.listOrderDetail2ndE(odso);
		
		/*
		 * 주문 정보가 존재하지 않은 경우
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}

		map.put("orderBase", orderBase);



		/*********************************
		 * 기타코드정보 설정
		 ********************************/

		return  map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 3. 4.
	* - 작성자		: 
	* - 설명			: 주문 구매확정 신청 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @returnR
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)	
	@RequestMapping(value="indexPurchaseRequest")
	public String indexPurchaseRequest(ModelMap map, OrderSO so, Session session, ViewBase view, String mngb){		
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(so.getOrdNo() == null || "".equals(so.getOrdNo())){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		/*****************************************
		 * 주문 기본 조회
		 *****************************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(so.getOrdNo());
		
		/*********************************
		 * Validation Data
		 *********************************/		
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		
		//비회원
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){ 
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}		
		// 회원
		}else{
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}
		
		OrderDeliveryVO order = new OrderDeliveryVO();
		List<OrderDeliveryVO> orderCancelList = orderService.listPurchaseDetail(so);
		if (CollectionUtils.isNotEmpty(orderCancelList)) {
			order = orderCancelList.get(0);
		}
		
		map.put("order", order);
		
		if (!FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			MemberBaseSO memberBaseSO = new MemberBaseSO();
			memberBaseSO.setMbrNo(session.getMbrNo());
	    	MemberBaseVO member = this.memberService.getMemberBase(memberBaseSO);
	    	map.put("member", member);
		}

		map.put("session", session);
		map.put("so", so);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
		
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);

		map.put("mngb", mngb);
		
		return  TilesView.mypage(new String[]{"order", "indexPurchaseRequest"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 6. 10.
	* - 작성자		: yhkim
	* - 설명		: 구매확정 완료 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexPurchaseCompletion")
	public String indexPurchaseCompletion(ModelMap map, String ordNo, Integer[] arrOrdDtlSeq, Session session, ViewBase view){
		
		/*ordNo="C202103300000758";	//임시코딩
		arrOrdDtlSeq = new Integer[1];	//임시코딩
		arrOrdDtlSeq[0] = 1;		//임시코딩
		arrOrdDtlSeq[1] = 2;		//임시코딩	*/
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}		
	
		if(arrOrdDtlSeq == null || arrOrdDtlSeq.length == 0 ){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(ordNo);	
		
		/*
		 * 주문 데이터 존재 여부 체크
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		/***************************
		 * 주문상세 조회 
		 ***************************/
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(ordNo);
		odso.setArrOrdDtlSeq(arrOrdDtlSeq);
		
		List<OrderDetailVO> orderDetailList = orderDetailService.listOrderDetail(odso);

		if (orderDetailList == null || orderDetailList.isEmpty()) {		
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}
		
		int isuSchdPnt = 0;
		
		
		for(OrderDetailVO detail : orderDetailList) {
			isuSchdPnt += detail.getIsuSchdPnt();
		}
		
		//비회원 	
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}		
		// 회원
		}else{
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}
		}
		
		SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
		mpSO.setOrdNo(ordNo);
		SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
		map.put("mpVO", mpVO);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
				
		map.put("orderBase", orderBase);
		map.put("orderDetailList", orderDetailList);
		map.put("isuSchdPnt", isuSchdPnt);	
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);

		return  TilesView.mypage(new String[]{"order", "indexPurchaseCompletion"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 7. 4.
	* - 작성자		: Administrator
	* - 설명			: 구매완료 처리
	* </pre>
	* @param po
	* @param session
	* @return
	*/
	/*@RequestMapping(value = "purchaseProcess") 다중처리로 변경
	@ResponseBody
	public ModelMap purchaseProcess(OrderDetailPO po, Session session) {

		OrderDetailVO orderDetail = this.orderDetailService.getOrderDetail(po.getOrdNo(), po.getOrdDtlSeq());

		if(orderDetail == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}

		ModelMap map = new ModelMap();

		if(FrontConstants.ORD_DTL_STAT_160.equals(orderDetail.getOrdDtlStatCd())) {
			this.orderDetailService.updateOrderDetailStatus(po.getOrdNo(), po.getOrdDtlSeq(), FrontConstants.ORD_DTL_STAT_170);
		}else{
			throw new CustomException(ExceptionConstants.ERROR_ORDER_IMPOSSIBLE_PURCHASE);
		}

		return map;
	}*/
	@LoginCheck
	@ResponseBody
	@RequestMapping(value = "purchaseProcess", method=RequestMethod.POST)	
	public ModelMap purchaseProcess(OrderDetailPO po, Session session,  Integer[] arrOrdDtlSeq) {
		
		//상품 갯수
		int GoodsCount = 0;
		
		//배송상태 갯수
		int deliverySatusCount = 0;
		
		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			
			OrderDetailVO orderDetail = null;
			for(int i=0; i<arrOrdDtlSeq.length; i++){
				orderDetail = this.orderDetailService.getOrderDetail(po.getOrdNo(), arrOrdDtlSeq[i]);

				if(orderDetail != null){
					GoodsCount ++;										
				}
				
				if(FrontConstants.ORD_DTL_STAT_150.equals(orderDetail.getOrdDtlStatCd()) || FrontConstants.ORD_DTL_STAT_160.equals(orderDetail.getOrdDtlStatCd())) {
					deliverySatusCount ++;
				}
			}
			
		}else {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_IMPOSSIBLE_PURCHASE);
		}
		
		if(GoodsCount == 0) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}
		
		if(deliverySatusCount == 0) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_IMPOSSIBLE_PURCHASE);
		}
		
		ModelMap map = new ModelMap();		
		
		this.orderDetailService.updateOrderDetailPurchase(po.getOrdNo(), arrOrdDtlSeq);
		map.put("ordNo", po.getOrdNo());
		map.put("arrOrdDtlSeq", arrOrdDtlSeq);
		
		return map;
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: hjko
	* - 설명			: 구매 영수증 팝업
	* </pre>
	* @param map
	* @param view
	* @param session
	* @param param
	* @return
	 */
	@RequestMapping(value="popupPurchaseReceipt")
	public String popupPurchaseReceipt(ModelMap map, ViewBase view, Session session, PurchaseReceiptParam param){


		/**********************************
		 * 주문 기본 정보 조회
		 **********************************/
		OrderBaseVO orderBase = orderBaseService.getOrderBase(param.getOrdNo());

		map.put("orderBase", orderBase);

		/********************************
		 * 주문 상세 목록 조회
		 *********************************/
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(param.getOrdNo());
		odso.setMbrNo(session.getMbrNo());

		List<OrderDetailVO> orderDetailList = orderDetailService.listOrderDetail(odso);

		map.put("orderDetailList", orderDetailList);

		
		/********************************
		 * 결제 정보 조회
		 *********************************/
		OrderPayVO payInfo = this.orderService.getOrderPayInfo(param.getOrdNo());

		map.put("payInfo", payInfo);
		
		/*******************************
		 * 기타 코드 조회
		 *******************************/
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));

		map.put("issueDay", Timestamp.valueOf(LocalDateTime.now()));	//발급일자(오늘)

		view.setTitle(message.getMessage("front.web.view.mypage.order.purchase.receipt.output.popup.title"));
		map.put("view", view);
		map.put("param", param);

		return TilesView.popup(
				new String[]{"mypage", "order", "popupPurchaseReceipt"}
				);
	}

	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 1:1문의 주문정보 선택 popup
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)	
	@RequestMapping(value="popupOrderList")
	public String popupOrderList(ModelMap map, OrderSO so, Session session, ViewBase view, String popId, String callBackFnc){
		view.setTitle(message.getMessage("front.web.view.counsel.order.select.title"));

		so.setRows(FrontWebConstants.PAGE_ROWS_5);
		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setMbrNo(session.getMbrNo());

		// 조회기간 null 일때 15일 지정
		if(so.getOrdAcptDtmStart() == null && so.getOrdAcptDtmEnd() == null){

			Calendar calendar = Calendar.getInstance();

			Date dates = null;
			Date datee = null;
			String formats = "";
			String formate= "";

			formate = "yyyy-MM-dd 23:59:59";
			datee = calendar.getTime();

			formats = "yyyy-MM-dd 00:00:00";
			calendar.add(Calendar.DATE, -15);
			dates = calendar.getTime();

			String days = new SimpleDateFormat(formats).format(dates);
			String daye = new SimpleDateFormat(formate).format(datee);

			so.setOrdAcptDtmStart(DateUtil.getTimestamp(days, CommonConstants.COMMON_DATE_FORMAT));
			so.setOrdAcptDtmEnd(DateUtil.getTimestamp(daye, CommonConstants.COMMON_DATE_FORMAT));

		}else{

			// 날짜 조회 param 설정
			so.setOrdAcptDtmStart(DateUtil.convertSearchDate("S", so.getOrdAcptDtmStart()));
			so.setOrdAcptDtmEnd(DateUtil.convertSearchDate("E", so.getOrdAcptDtmEnd()));

		}

 		List<OrderDeliveryVO> orderList = orderService.pageOrderDeliveryList(so);
 		map.put("orderList", orderList);
 		map.put("ordDtlStatCdList", this.codeCacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));


		if(StringUtils.isNotEmpty(popId) && StringUtils.isNotEmpty(callBackFnc)){

			Map<String,String> param = new HashMap<>();

			param.put("popId", popId);
			param.put("callBackFnc", callBackFnc);

			map.put("param", param);
		}

		map.put("view", view);
		map.put("orderSO", so);

		return  TilesView.popup(new String[]{"mypage", "order", "popupOrderList"});
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 취소/교환/반품 신청 목록 화면(TAB)
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexClaimRequestList")
	public String indexClaimRequestList(ModelMap map, OrderSO orderSO, Session session, ViewBase view){
		orderSO.setSidx("ORD_NO");
		orderSO.setSord(FrontWebConstants.SORD_DESC);
		orderSO.setRows(FrontWebConstants.PAGE_ROWS_10);
		orderSO.setMbrNo(session.getMbrNo());

		if(FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			
			if(!StringUtils.isEmpty(session.getNoMemOrdNo())){
				String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrdNo());

				if(!session.getNoMemCheckCd().equals(newCheckCode)){
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				
				orderSO.setOrdNo(session.getNoMemOrdNo());
				map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_NOMEM_ORDER_CLAIM);
			}else{
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		
		} else {
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);

			// 취소/교환/반품 현황
			ClaimSO os = new ClaimSO();
			os.setMbrNo(session.getMbrNo());
			os.setClmAcptDtmStart(DateUtil.convertSearchDate("S", Timestamp.valueOf(LocalDateTime.now().minusMonths(1).plusDays(1))));
			os.setClmAcptDtmEnd(DateUtil.convertSearchDate("E", Timestamp.valueOf(LocalDateTime.now())));
			ClaimSummaryVO claimSummary = claimService.claimSummary(os);
			map.put("claimSummary", claimSummary);


			// 날짜 조회 param 설정
			orderSO.setOrdAcptDtmStart(DateUtil.convertSearchDate("S", Timestamp.valueOf(LocalDateTime.now().minusMonths(1).plusDays(1))));
			orderSO.setOrdAcptDtmEnd(DateUtil.convertSearchDate("E", Timestamp.valueOf(LocalDateTime.now())));
		}

		// 취소/교환/반품 대상 리스트 조회
		List<OrderClaimVO> orderList = orderService.pageClaimRequestList( orderSO );

		map.put("orderList", orderList);
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		map.put("orderSO", orderSO);

		return  TilesView.mypage(new String[]{"order", "indexClaimRequestList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 취소/교환/반품 목록 조회 화면(TAB)
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH) 
	@RequestMapping(value="indexClaimList")
	public String indexClaimList(ModelMap map, ClaimSO so, Session session, ViewBase view){
		so.setSidx("CLM_NO");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo()); 
		so.setOrdrShowYn("Y");
		//so.setMbrNo(1425L);

		if(!FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){			
			
			// 취소/교환/반품 현황 사용안함
			/*ClaimSO os = new ClaimSO();
			os.setMbrNo(session.getMbrNo());
			
			os.setClmAcptDtmStart(DateUtil.convertSearchOrderDate("S", Timestamp.valueOf(LocalDateTime.now().minusMonths(1).plusDays(1))));
			os.setClmAcptDtmEnd(DateUtil.convertSearchOrderDate("E", Timestamp.valueOf(LocalDateTime.now())));
			ClaimSummaryVO claimSummary = claimService.claimSummary(os);
			map.put("claimSummary", claimSummary);*/

			if (so.getPeriod() == null) {so.setPeriod("3");}

			// 날짜 조회 param 설정
			so.setClmAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getClmAcptDtmStart()));
			so.setClmAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getClmAcptDtmEnd()));
			
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);
		} else {
			if(!StringUtils.isEmpty(session.getNoMemOrdNo())){
				String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrdNo());

				if(!session.getNoMemCheckCd().equals(newCheckCode)){
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				
				so.setOrdNo(session.getNoMemOrdNo());
				map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_NOMEM_ORDER_CLAIM);
			}else{
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}

		//  취소/교환/반품 진행  리스트 조회
		List<OrderBaseVO> orderList = claimService.pageClaimCancelRefundList2ndE( so );

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("orderList", orderList);
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		
		map.put("so", so);
		

		return  TilesView.mypage(new String[]{"order", "indexClaimList"});
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 03. 6.
	* - 작성자		: 
	* - 설명			: 클레임 목록 조회  ajax 페이징 
	* </pre>	
	* @param session	
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="ajaxClaimHtml")
	public String indexClaimAjaxList(ModelMap map, ClaimSO so, Session session){
		
		Gson gson = new Gson();
		
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("CLM_NO");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo()); 
		so.setOrdrShowYn("Y");
		//so.setMbrNo(1425L);		
		
		// 날짜 조회 param 설정
		so.setClmAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getClmAcptDtmStart()));
		so.setClmAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getClmAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		//List<ClaimBaseVO> claimList = claimService.pageClaimCancelRefundList( so );
		List<OrderBaseVO> orderList = claimService.pageClaimCancelRefundList2ndE( so );

		map.put("orderList", orderList);
		map.put("so", so);
		
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));

		//System.out.println("================="+ gson.toJson(claimList).toString());
		
		return  "/mypage/order/include/includeClaim";
	}
	@ResponseBody
	@RequestMapping(value="ajaxClaimJson")
	public ModelMap ajaxClaimJson(ClaimSO so, Session session){
		ModelMap map = new ModelMap();
		Gson gson = new Gson();

		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("CLM_NO");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo()); 
		so.setOrdrShowYn("Y");
		//so.setMbrNo(1425L);		
		
		// 날짜 조회 param 설정
		so.setClmAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getClmAcptDtmStart()));
		so.setClmAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getClmAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		//List<ClaimBaseVO> claimList = claimService.pageClaimCancelRefundList( so );
		List<OrderBaseVO> orderList = claimService.pageClaimCancelRefundList2ndE( so );

		map.put("orderList", orderList);
		map.put("so", so);
		/*
		map.put("claimListAjax", gson.toJson(claimList));
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		*/	
		
		//System.out.println("================="+ gson.toJson(claimList).toString());
		
		return  map;
	}

	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 03. 6.
	* - 작성자		: 
	* - 설명			: 클레임 목록 조회  ajax 페이징 
	* </pre>	
	* @param session	
	* @return
	* @throws Exception
	*/
	@Deprecated
	@RequestMapping(value="indexClaimAjaxList")
	@ResponseBody
	public ModelMap indexClaimAjaxList( ClaimSO so, Session session){
		
		ModelMap map = new ModelMap();
		Gson gson = new Gson();
		
		if (so.getPeriod() == null) {so.setPeriod("3");}
		so.setSidx("CLM_NO");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setMbrNo(session.getMbrNo()); 
		so.setOrdrShowYn("Y");
		//so.setMbrNo(1425L);		
		
		// 날짜 조회 param 설정
		so.setClmAcptDtmStart(DateUtil.convertSearchOrderDate("S", so.getClmAcptDtmStart()));
		so.setClmAcptDtmEnd(DateUtil.convertSearchOrderDate("E", so.getClmAcptDtmEnd()));	

		// 마이룸 주문/배송조회 리스트 조회
		List<ClaimBaseVO> claimList = claimService.pageClaimCancelRefundList( so );	
	
		map.put("claimListAjax", gson.toJson(claimList));
		map.put("so", so);
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));	
		
		//System.out.println("================="+ gson.toJson(claimList).toString());
		
		return  map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문/배송 상세 조회  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param ord_no
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH) 
	@RequestMapping(value="indexClaimDetail")
	public String indexClaimDetail(ModelMap map, Session session, ViewBase view, ClaimSO so, String mngb){		
		
		/*
		 * Param Check
		 */
		if(so.getClmNo() == null || "".equals(so.getClmNo())){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/******************************
		 * 클레임 기본 정보 조회
		 *****************************/
		ClaimBaseVO claimBaseVO = claimService.getClaimRefund(so);	

		/*
		 * 클레임 정보가 존재하지 않은 경우
		 */
		if(claimBaseVO == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		List<ClaimDetailRefundVO> claimDetailRefundList = claimBaseVO.getClaimDetailRefundListVO();
		for(ClaimDetailRefundVO refund : claimDetailRefundList) {
			if(StringUtil.isNotEmpty(refund.getOrgCardNo())){
				refund.setOrgCardNo(maskingCard(refund.getOrgCardNo()));
			}
		}

		map.put("claimBaseVO", claimBaseVO);	

		/*****************************
		 * 클레임 상세 정보 조회
		 *****************************/
		if(CommonConstants.CLM_TP_30.equals(claimBaseVO.getClmTpCd())){
			if (claimBaseVO.getRtrnaNo() != null && claimBaseVO.getDlvraNo() != null) {
				OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
				orderDlvraSO.setOrdDlvraNo(claimBaseVO.getRtrnaNo());
				OrderDlvraVO rtrnaInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
				//회수지
				map.put("rtrnaInfo", rtrnaInfo);
				
				for(ClaimDetailRefundVO vo : claimBaseVO.getClaimDetailRefundListVO()) {
					
					if (StringUtils.equals(vo.getClmDtlStatCd(), CommonConstants.CLM_DTL_STAT_410)
							||StringUtils.equals(vo.getClmDtlStatCd(), CommonConstants.CLM_DTL_STAT_420) 
							||StringUtils.equals(vo.getClmDtlStatCd(), CommonConstants.CLM_DTL_STAT_430)
							||StringUtils.equals(vo.getClmDtlStatCd(), CommonConstants.CLM_DTL_STAT_440)
							||StringUtils.equals(vo.getClmDtlStatCd(), CommonConstants.CLM_DTL_STAT_450)
						) {
						orderDlvraSO.setOrdDlvraNo(Long.parseLong(String.valueOf(vo.getDlvraNo())));
						OrderDlvraVO dlvraInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
						//교환 배송지
						map.put("dlvraInfo", dlvraInfo);
						break; //한번 담으면 그만 담자
					}
				}
			}
		} else {
			if (claimBaseVO.getRtrnaNo() != null || claimBaseVO.getDlvraNo() != null) {
				OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
				orderDlvraSO.setOrdDlvraNo(claimBaseVO.getRtrnaNo() != null ? claimBaseVO.getRtrnaNo() : claimBaseVO.getDlvraNo());
				OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
				map.put("deliveryInfo", deliveryInfo);
			}
		}
		
		
		OrderBaseVO orderBaseVO = claimDetailService.listClaimDetail2ndE(so);
		map.put("orderBase", orderBaseVO);
		
		//취소상세
		PayBaseSO paySO = new PayBaseSO();
		
		/* 추가 결제 금액*/
		paySO.setClmNo(claimBaseVO.getClmNo());
		//40 마이너스 환불인 데이터만 가져오기 
		paySO.setPayGbCd(CommonConstants.PAY_GB_40);
		
		PayBaseVO PayBaseVO = payBaseService.getPayBase(paySO);
		
		map.put("PayBaseVO", PayBaseVO);
		
		
		ClaimRefundPayVO claimRefundPayVO = claimService.getClaimRefundPay(so);
		if (claimRefundPayVO!=null) {
			// 20210828 APETQA-6935 관련 수정
			for(ClaimRefundPayDetailVO payVO : claimRefundPayVO.getClaimRefundPayDetailListVO()) {
				if (CommonConstants.PAY_MEANS_10.equals(payVO.getPayMeansCd())) {
					payVO.setPayMeansNm("신용카드");
				}else if(CommonConstants.PAY_MEANS_11.equals(payVO.getPayMeansCd())) {
					payVO.setPayMeansNm("간편카드");
				}else if(CommonConstants.PAY_MEANS_20.equals(payVO.getPayMeansCd())
						|| CommonConstants.PAY_MEANS_30.equals(payVO.getPayMeansCd())) {
					payVO.setPayMeansNm("계좌이체");
				}else if(CommonConstants.PAY_MEANS_70.equals(payVO.getPayMeansCd())) {
					payVO.setPayMeansNm("네이버페이");
				}else if(CommonConstants.PAY_MEANS_71.equals(payVO.getPayMeansCd())) {
					payVO.setPayMeansNm("카카오페이");
				}else if(CommonConstants.PAY_MEANS_72.equals(payVO.getPayMeansCd())) {
					payVO.setPayMeansNm("페이코");
				}
			}
			
			// 환불 받을 '배송비 = orgDlvrcAmt'와 추가 과금할 '추가 배송비=clmDlvrcAmt' 계산. claimRefundPayVO는 cncl로 계산하던데 이러면 부분 환불 되는 경우 전액으로 조회되서 수정함. 
			ClaimBasePO po = new ClaimBasePO();
			po.setClmNo(so.getClmNo());
			ClaimBasePO claimBasePO = deliveryChargeService.selectDeliveryCharge(po);
			claimRefundPayVO.setClmDlvrcAmt(claimBasePO.getClmDlvrcAmt());
			claimRefundPayVO.setOrgDlvrcAmt(claimBasePO.getRefundDlvrAmt());			
		}
		
		map.put("claimRefundPayVO", claimRefundPayVO);
		
		map.put("session", session);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
		
		map.put("view", view);
		map.put("clmRsnCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put("ordDtlPrcsTPList", this.cacheService.listCodeCache(FrontWebConstants.DLVR_PRCS_TP, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));
		
		/**
		 * 2021.06.03, ssmvf01, ORD_PROPS.10's usrDfn1Val 을 구주문 기준 주문번호로 정의함.
		 */
		CodeDetailVO ordPropsCode = this.cacheService.listCodeCache(FrontWebConstants.ORD_PROPS, null, null, null, null, null)
				.stream().filter(s -> s.getDtlCd().equals(FrontWebConstants.ORD_PROPS_10)).findFirst().orElse(null);
		map.put("oldStdOrdNo", ordPropsCode != null ? ordPropsCode.getUsrDfn1Val():null);
		
		return  TilesView.mypage(new String[]{"order", "indexClaimDetail"});
	}

	@ResponseBody
	@RequestMapping(value="indexClaimDetail2")
	public ModelMap indexClaimDetail2(Session session, ViewBase view, ClaimSO so, String mngb){		
		ModelMap map = new ModelMap();
		/*
		 * Param Check
		 */
		if(so.getClmNo() == null || "".equals(so.getClmNo())){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/******************************
		 * 클레임 기본 정보 조회
		 *****************************/
		ClaimBaseVO claimBaseVO = claimService.getClaimRefund(so);	

		/*
		 * 클레임 정보가 존재하지 않은 경우
		 */
		if(claimBaseVO == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		map.put("claimBaseVO", claimBaseVO);	

		/*****************************
		 * 클레임 상세 정보 조회
		 *****************************/
		if(CommonConstants.CLM_TP_30.equals(claimBaseVO.getClmTpCd())){
			if (claimBaseVO.getRtrnaNo() != null && claimBaseVO.getDlvraNo() != null) {
				OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
				orderDlvraSO.setOrdDlvraNo(claimBaseVO.getRtrnaNo());
				OrderDlvraVO rtrnaInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
				//회수지
				map.put("rtrnaInfo", rtrnaInfo);
				
				orderDlvraSO.setOrdDlvraNo(claimBaseVO.getDlvraNo());
				OrderDlvraVO dlvraInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
				//교환 배송지
				map.put("dlvraInfo", dlvraInfo);
			}
		} else {
			if (claimBaseVO.getRtrnaNo() != null || claimBaseVO.getDlvraNo() != null) {
				OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
				orderDlvraSO.setOrdDlvraNo(claimBaseVO.getRtrnaNo() != null ? claimBaseVO.getRtrnaNo() : claimBaseVO.getDlvraNo());
				OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
				map.put("deliveryInfo", deliveryInfo);
			}
		}
		
		OrderBaseVO orderBaseVO = claimDetailService.listClaimDetail2ndE(so);
		map.put("orderBase", orderBaseVO);

		return  map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw ,yhkim
	* - 설명			: 주문 취소 신청 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @returnR
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexCancelRequest")
	public String indexCancelRequest(ModelMap map, OrderSO so, Session session, ViewBase view, String mngb){
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(so.getOrdNo() == null || "".equals(so.getOrdNo())){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		/*****************************************
		 * 주문 기본 조회
		 *****************************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(so.getOrdNo());
		
		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 클레임 데이터 존재 여부 체크
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		//비회원
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}		
		// 회원
		}else{
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}
		
		OrderDeliveryVO order = new OrderDeliveryVO();
		List<OrderDeliveryVO> orderCancelList = orderService.listCancelDetail(so);
		if (CollectionUtils.isNotEmpty(orderCancelList)) {
			order = orderCancelList.get(0);
		}
		
		
		//결제 시 MP 포인트 조회
		SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
		mpSO.setPayOrdNo(orderBase.getOrdNo());
		SktmpLnkHistVO payMpVO = sktmpService.getSktmpLnkHist(mpSO);
		map.put("payMpVO", payMpVO);
		
		/*********************************
		 * 결제 정보 조회
		 *********************************/
		OrderPayVO payInfo = this.orderService.getOrderPayInfo(orderBase.getOrdNo());
		map.put("payInfo", payInfo);
		
		
		map.put("order", order);
		map.put("clmRsnList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, FrontWebConstants.CLM_TP_10, null, FrontWebConstants.COMM_YN_Y, null, null));
		map.put("ordDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.ORD_DTL_STAT, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));		
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		
		/**
		 * 2021.06.03, ssmvf01, ORD_PROPS.10's usrDfn1Val 을 구주문 기준 주문번호로 정의함.
		 */
		CodeDetailVO ordPropsCode = this.cacheService.listCodeCache(FrontWebConstants.ORD_PROPS, null, null, null, null, null)
				.stream().filter(s -> s.getDtlCd().equals(FrontWebConstants.ORD_PROPS_10)).findFirst().orElse(null);
		map.put("oldStdOrdNo", ordPropsCode != null ? ordPropsCode.getUsrDfn1Val():null);

		if (!FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			MemberBaseSO memberBaseSO = new MemberBaseSO();
			memberBaseSO.setMbrNo(session.getMbrNo());
	    	MemberBaseVO member = this.memberService.getMemberBase(memberBaseSO);
	    	map.put("member", member);
		}

		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}	
		
		map.put("session", session);
		map.put("so", so);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);
		map.put("mngb", mngb);

		return  TilesView.mypage(new String[]{"order", "indexCancelRequest"});
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 6. 10.
	* - 작성자		: yhkim
	* - 설명		: 주문취소 완료 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexCancelCompletion")
	public String indexCancelCompletion(ModelMap map, String clmNo,  Session session, ViewBase view){	
		
		//clmNo="C20210407000089901";
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(clmNo == null || "".equals(clmNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		
		/***************************
		 * 클레임 기본 조회 
		 ***************************/
		ClaimBaseVO claimBase = this.claimBaseService.getClaimBase(clmNo);

		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 클레임 데이터 존재 여부 체크
		 */
		if(claimBase == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		//비회원 
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, claimBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}		
		// 회원
		}else{
			if(!claimBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}
		}

		/**************************
		 * 환불 내역 조회
		 **************************/
		ClaimSO cso = new ClaimSO();
		cso.setClmNo(clmNo);
		ClaimRefundPayVO claimPay = this.claimService.getClaimRefundPay(cso);
		
		/**************************
		 *  취소 리스트 완료 조회
		 **************************/
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);
		
		/**************************
		 *  장바구니 다시 담기 리스트 조회
		 **************************/
		ClaimDetailSO ccdso = new ClaimDetailSO();
		ccdso.setClmNo(clmNo);
		ccdso.setIsCartReSet(true);
		List<ClaimDetailVO> cartReSetList = this.claimDetailService.listClaimDetail(ccdso);
		
		/**************************
		 * 결제 정보 조회
		 *********************************/
//		OrderPayVO payInfo = this.orderService.getOrderPayInfo(claimBase.getOrdNo());
		PayBaseSO so = new PayBaseSO();
		so.setClmNo(clmNo);
		List<PayBaseVO> payInfoList = payBaseService.listPayBase(so);
		for (PayBaseVO pbpo : payInfoList) {
			if (StringUtil.isNotEmpty(pbpo.getCardNo())) {
				pbpo.setCardNo(MaskingUtil.getCard(pbpo.getCardNo()));
			}
			
			if (CommonConstants.PAY_MEANS_10.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("신용카드");
			}else if(CommonConstants.PAY_MEANS_11.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("간편카드");
			}else if(CommonConstants.PAY_MEANS_20.equals(pbpo.getPayMeansCd())
					|| CommonConstants.PAY_MEANS_30.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("계좌이체");
			}else if(CommonConstants.PAY_MEANS_70.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("네이버페이");
			}else if(CommonConstants.PAY_MEANS_71.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("카카오페이");
			}else if(CommonConstants.PAY_MEANS_72.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("페이코");
			}
			
		}
		
		map.put("payInfoList", payInfoList);
		
		/**************************
		 * 원 결제 정보 조회
		 *********************************/
		PayBaseSO checkSo = new PayBaseSO();
		checkSo.setOrdNo(claimBase.getOrdNo());
		checkSo.setPayGbCd(FrontConstants.PAY_GB_10);
		PayBaseVO checkOrgPayBase = payBaseService.checkOrgPayBase(checkSo);
		map.put("checkOrgPayBase", checkOrgPayBase);
		

		map.put("claimPay", claimPay);
		map.put("claimBase", claimBase);
		map.put("claimDetailList", claimDetailList);
		map.put("cartReSetList", cartReSetList);
		map.put("clmRsnList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
		
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);

		return  TilesView.mypage(new String[]{"order", "indexCancelCompletion"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw,yhkim
	* - 설명		: 교환 신청 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexExchangeRequest")
	public String indexExchangeRequest(ModelMap map, OrderSO orderSO, Session session, ViewBase view, String mngb){
		/*********************************
		 * Validation Param
		 *********************************/
		if(orderSO.getOrdNo() == null || "".equals(orderSO.getOrdNo())){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		/*****************************************
		 * 주문 기본 조회
		 *****************************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(orderSO.getOrdNo());
		
		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 클레임 데이터 존재 여부 체크
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		//비회원 
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}		
		// 회원
		}else{
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}
		
		//주문 교환/반품 리스트 조회
		OrderDeliveryVO order = new OrderDeliveryVO();
		List<OrderDeliveryVO> orderExchangeList = orderService.listExchangeDetail(orderSO);
		if (CollectionUtils.isNotEmpty(orderExchangeList)) {
			order = orderExchangeList.get(0);
		}
		map.put("order", order);

		OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
		orderDlvraSO.setOrdNo(orderSO.getOrdNo());
		OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO); // 배송정보
		map.put("deliveryInfo", deliveryInfo);

		//Long itemNo = order.getOrderDetailListVO().get(0).getItemNo(); // 2021.03.28, 서성민, 교환선택 상품이 여러개인데 마지막 상품을 교환시에 첫벗째 itemNo를 가져오면 교환이 불가. 		
		Long itemNo = order.getOrderDetailListVO().stream().filter(el -> el.getOrdDtlSeq().equals(orderSO.getOrdDtlSeq())).findFirst().get().getItemNo();
		List<ItemAttributeValueVO> orgGoodsAttrList = this.goodsService.getItemAttrValueList(itemNo);
		map.put("orgGoodsAttrList", orgGoodsAttrList);

//		// 단품속성
//		AttributePO attr = new AttributePO();
//		attr.setGoodsId(goodsId);
//		attr.setUseYn(CommonConstants.COMM_YN_Y);
////		List<AttributeVO>  goodsAttrList = this.goodsService.getItemList(attr);
//		List<GoodsAttributeVO>  goodsAttrList = this.goodsService.listGoodsAttribute(goodsId, true);
//		map.put("goodsAttrList", goodsAttrList);

		map.put("clmRsnList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, FrontWebConstants.CLM_DTL_TP_30, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));

//		map.put("checkCode", checkCode);
		map.put("session", session);
		map.put("orderSO", orderSO);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
		
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);
		
		map.put("mngb", mngb);

		return  TilesView.mypage(new String[]{"order", "indexExchangeRequest"});
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 교환 신청 완료 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexExchangeCompletion")
	public String indexExchangeCompletion(ModelMap map, String clmNo, Session session, ViewBase view){
		
		//clmNo = "C20210324000054201";
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(clmNo == null || "".equals(clmNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		/***************************
		 * 클레임 기본 조회 
		 ***************************/
		ClaimBaseVO claimBase = this.claimBaseService.getClaimBase(clmNo);
		
		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 클레임 데이터 존재 여부 체크
		 */
		if(claimBase == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		//비회원 
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, claimBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}		
		// 회원
		}else{
			if(!claimBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}
		}
		
		/**************************
		 *  취소 리스트 완료 조회
		 **************************/
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		cdso.setClmDtlTpCd(FrontWebConstants.CLM_DTL_TP_30);
		List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimExchangeDetail(cdso);
		
		if (claimDetailList.get(0).getRtrnaNo() != null && claimDetailList.get(0).getDlvraNo() != null) {
			OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
			orderDlvraSO.setOrdDlvraNo(claimDetailList.get(0).getRtrnaNo());
			OrderDlvraVO rtrnaInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
			//회수지
			map.put("rtrnaInfo", rtrnaInfo);
			
			orderDlvraSO.setOrdDlvraNo(claimDetailList.get(0).getRtrnaNo());
			OrderDlvraVO dlvraInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
			//교환 배송지
			map.put("dlvraInfo", dlvraInfo);
		}
		
		/**************************
		 *  장바구니 다시 담기 리스트 조회
		 **************************/
		ClaimDetailSO ccdso = new ClaimDetailSO();
		ccdso.setClmNo(clmNo);
		ccdso.setIsCartReSet(true);
		List<ClaimDetailVO> cartReSetList = this.claimDetailService.listClaimDetail(ccdso);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
		
		map.put("claimBase", claimBase);
		map.put("claimDetailList", claimDetailList);
		map.put("cartReSetList", cartReSetList);
		
		map.put("clmRsnList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);

		return  TilesView.mypage(new String[]{"order", "indexExchangeCompletion"});
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw, yhkim
	* - 설명		: 반품 신청 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexReturnRequest")
	public String indexReturnRequest(ModelMap map, OrderSO orderSO, Session session, ViewBase view, String mngb){
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(orderSO.getOrdNo() == null || "".equals(orderSO.getOrdNo())){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		/*****************************************
		 * 주문 기본 조회
		 *****************************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(orderSO.getOrdNo());
		
		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 주문 데이터 존재 여부 체크
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		//비회원
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}		
		// 회원
		}else{
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}
		
		//주문 반품/교환 리스트 조회
		OrderDeliveryVO order = new OrderDeliveryVO();
		orderSO.setRtnPsbYn(FrontConstants.COMM_YN_Y);
		List<OrderDeliveryVO> orderReturnList = orderService.listReturnDetail(orderSO);
		if (CollectionUtils.isNotEmpty(orderReturnList)) {
			order = orderReturnList.get(0);
		}
		map.put("order", order);

		OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
		orderDlvraSO.setOrdNo(orderSO.getOrdNo());
		OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO); // 배송정보
		map.put("deliveryInfo", deliveryInfo);

		if (!FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			MemberBaseSO memberBaseSO = new MemberBaseSO();
			memberBaseSO.setMbrNo(session.getMbrNo());
	    	MemberBaseVO member = this.memberService.getMemberBase(memberBaseSO);
	    	map.put("member", member);
		}
		
		//결제 시 MP 포인트 조회
		SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
		mpSO.setPayOrdNo(orderBase.getOrdNo());
		SktmpLnkHistVO payMpVO = sktmpService.getSktmpLnkHist(mpSO);
		map.put("payMpVO", payMpVO);
				
		/*********************************
		 * 결제 정보 조회
		 *********************************/
		OrderPayVO payInfo = this.orderService.getOrderPayInfo(orderBase.getOrdNo());
		map.put("payInfo", payInfo);

		map.put("clmRsnList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, FrontWebConstants.CLM_DTL_TP_20, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		
		/**
		 * 2021.06.03, ssmvf01, ORD_PROPS.10's usrDfn1Val 을 구주문 기준 주문번호로 정의함.
		 */
		CodeDetailVO ordPropsCode = this.cacheService.listCodeCache(FrontWebConstants.ORD_PROPS, null, null, null, null, null)
				.stream().filter(s -> s.getDtlCd().equals(FrontWebConstants.ORD_PROPS_10)).findFirst().orElse(null);
		map.put("oldStdOrdNo", ordPropsCode != null ? ordPropsCode.getUsrDfn1Val():null);

//		map.put("checkCode", checkCode);
		map.put("session", session);
		map.put("orderSO", orderSO);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}		
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);
		map.put("mngb", mngb);

		return  TilesView.mypage(new String[]{"order", "indexReturnRequest"}	);
	}



	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 반품 신청 완료 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexReturnCompletion")
	public String indexReturnCompletion(ModelMap map, String clmNo,  Session session, ViewBase view){		
		
		//clmNo="C20210323000050901";
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(clmNo == null || "".equals(clmNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/***************************
		 * 클레임 기본 조회 
		 ***************************/
		ClaimBaseVO claimBase = this.claimBaseService.getClaimBase(clmNo);

		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 클레임 데이터 존재 여부 체크
		 */
		if(claimBase == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		//비회원 
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, claimBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}		
		// 회원
		}else{
			if(!claimBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
			}
		}
		
		/*********************************
		 * 결제 정보 조회
		 *********************************/
//		OrderPayVO payInfo = this.orderService.getOrderPayInfo(claimBase.getOrdNo());
//		map.put("payInfo", payInfo);
		PayBaseSO so = new PayBaseSO();
		so.setClmNo(clmNo);
		List<PayBaseVO> payInfoList = payBaseService.listPayBase(so);
		
		for (PayBaseVO pbpo : payInfoList) {
			if (StringUtil.isNotEmpty(pbpo.getCardNo())) {
				pbpo.setCardNo(MaskingUtil.getCard(pbpo.getCardNo()));
			}
			
			if (CommonConstants.PAY_MEANS_10.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("신용카드");
			}else if(CommonConstants.PAY_MEANS_11.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("간편카드");
			}else if(CommonConstants.PAY_MEANS_20.equals(pbpo.getPayMeansCd())
					|| CommonConstants.PAY_MEANS_30.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("계좌이체");
			}else if(CommonConstants.PAY_MEANS_70.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("네이버페이");
			}else if(CommonConstants.PAY_MEANS_71.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("카카오페이");
			}else if(CommonConstants.PAY_MEANS_72.equals(pbpo.getPayMeansCd())) {
				pbpo.setPayMeansNm("페이코");
			}
		}
		
		map.put("payInfoList", payInfoList);
		
		/**************************
		 * 환불 내역 조회
		 **************************/
		ClaimSO cso = new ClaimSO();
		cso.setClmNo(clmNo);
		ClaimRefundPayVO claimPay = this.claimService.getClaimRefundPay(cso);
		
		/**************************
		 *  취소 리스트 완료 조회
		 **************************/
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);		
	
		if (claimDetailList.get(0).getRtrnaNo() != null || claimDetailList.get(0).getDlvraNo() != null) {
			OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
			orderDlvraSO.setOrdDlvraNo(claimDetailList.get(0).getRtrnaNo() != null ? claimDetailList.get(0).getRtrnaNo() : claimDetailList.get(0).getDlvraNo());
			OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
			map.put("deliveryInfo", deliveryInfo);
		}
		
		
		/**************************
		 *  장바구니 다시 담기 리스트 조회
		 **************************/
		ClaimDetailSO ccdso = new ClaimDetailSO();
		ccdso.setClmNo(clmNo);
		ccdso.setIsCartReSet(true);
		List<ClaimDetailVO> cartReSetList = this.claimDetailService.listClaimDetail(ccdso);
		
		
		/**************************
		 * 원 결제 정보 조회
		 *********************************/
		PayBaseSO checkSo = new PayBaseSO();
		checkSo.setOrdNo(claimBase.getOrdNo());
		checkSo.setPayGbCd(FrontConstants.PAY_GB_10);
		PayBaseVO checkOrgPayBase = payBaseService.checkOrgPayBase(checkSo);
		map.put("checkOrgPayBase", checkOrgPayBase);
		
		//메뉴 감춤
		if(CommonConstants.DEVICE_GB_10.equals(view.getDeviceGb())) {
			view.setBtnGnbHide(false);	
		}else {
			view.setBtnGnbHide(true);
		}
		
		map.put("claimBase", claimBase);
		map.put("claimPay", claimPay);
		map.put("claimDetailList", claimDetailList);
		map.put("cartReSetList", cartReSetList);
		map.put("clmRsnList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("cardcCdList", this.cacheService.listCodeCache(FrontWebConstants.CARDC, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_CLAIM);

		return  TilesView.mypage(new String[]{"order", "indexReturnCompletion"});
	}






	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyOrderController.java
	* - 작성일	: 2016. 5. 2.
	* - 작성자	: jangjy
	* - 설명		: 클레임 신청 (주문취소, 반품, 교환, AS)
	* </pre>
	* @param po
	* @param emailId
	* @param emailAddr
	* @param session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="applyClaim", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap applyClaim(Session session, ClaimRegist clmRegist){


		clmRegist.setAcptrNo(session.getMbrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);

		ModelMap map = new ModelMap();
		map.put("clmNo",clmNo);

		return  map;
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: hjko
	* - 설명			:  계산서, 영수증 조회/신청 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param so
	* @return
	 */
	@LoginCheck(loginType=FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH)
	@RequestMapping(value="indexReceiptList")
	public String indexReceiptList(ModelMap map, Session session, ViewBase view, OrderSO so){

		so.setSidx("ORD_ACPT_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_5);
		so.setMbrNo(session.getMbrNo());

		if(!FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){

			if (so.getPeriod() == null) {so.setPeriod("1");}

			// 날짜 조회 param 설정
			so.setOrdAcptDtmStart(DateUtil.convertSearchDate("S", so.getOrdAcptDtmStart()));
			so.setOrdAcptDtmEnd(DateUtil.convertSearchDate("E", so.getOrdAcptDtmEnd()));
			
			map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_ORDER_RECEIPT);
		} else {
			if(!StringUtils.isEmpty(session.getNoMemOrdNo())){
				String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrdNo());

				if(!session.getNoMemCheckCd().equals(newCheckCode)){
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				
				so.setOrdNo(session.getNoMemOrdNo());
				map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_NOMEM_ORDER_RECEIPT);
			}else{
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}
		
		// 계산서/영수증 조회 및 신청 리스트 조회
		List<OrderReceiptVO> receiptList = orderService.pageOrderReceiptList(so);

		map.put("receiptList", receiptList);
		map.put("cashRctStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CASH_RCT_STAT, null, null, null, null, null));
		map.put("taxIvcStatCdList", this.cacheService.listCodeCache(FrontWebConstants.TAX_IVC_STAT, null, null, null, null, null));
		map.put("session", session);
		map.put("view", view);

		return  TilesView.mypage(new String[]{"order", "indexReceiptList"});
	}

	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 세금계산서 신청 팝업 화면
	* </pre>
	* @param map
	* @param view
	* @param param
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="popupTaxInvoiceRequest")
	public String popupTaxInvoiceRequest(ModelMap map, ViewBase view, TaxInvoiceRequestParam param){

		view.setTitle(message.getMessage("front.web.view.mypage.order.tax.invoice.request.popup.title"));
		map.put("view", view);
		map.put("param", param);

		return TilesView.popup(
				new String[]{"mypage", "order", "popupTaxInvoiceRequest"}
				);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 현금영수증 신청 팝업 화면
	* </pre>
	* @param map
	* @param view
	* @param param
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="popupCashReceiptRequest")
	public String popupCashReceiptRequest(ModelMap map, Session session, ViewBase view,
			CashReceiptRequestParam param) {

		view.setTitle(message.getMessage("front.web.view.mypage.order.cash.receipt.request.popup.title"));
		map.put("cashRctSaveInfo", orderService.getCashReceiptSaveInfo(session.getMbrNo()));
		map.put("view", view);
		map.put("session", session);
		map.put("param", param);

//		String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrderInfo().getOrdNo());
//		if (newCheckCode.equals(session.getNoMemOrderInfo().getCheckCode())) {
//			// 이미 비회원 로그인 상태 일 때
//			// JSP 에서 비회원 로그인 판단할 때 사용함.
//			map.put("noMemberCheckCode", newCheckCode);
//		}

//		return TilesView.popup(new String[] { "mypage", "order", "popupCashReceiptRequest" });
		
		return TilesView.mypage(new String[] { "order", "popupCashReceiptRequest" });
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyOrderController.java
	* - 작성일	: 2016. 6. 21.
	* - 작성자	: jangjy
	* - 설명		: 현금영수증 수동 발행
	* </pre>
	* @param session
	* @param so
	* @param po
	* @return
	*/
	/*
	@ResponseBody
	@RequestMapping(value="insertCashReceipt", method=RequestMethod.POST)
	public ModelMap insertCashReceipt(Session session, OrderSO so, CashReceiptPO po){

		po.setMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		po.setPrcsrNo(session.getMbrNo().longValue());

		this.cashReceiptService.insertCashReceipt(so, po);

		ModelMap map = new ModelMap();

		return  map;
	}
*/
	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 28.
	* - 작성자		: hjko
	* - 설명		:  front PC 현금영수증 재발행 신청
	* </pre>
	* @param session
	* @param so
	* @param po
	* @return
	 */
	@ResponseBody
	@RequestMapping(value="insertCashReceipt", method=RequestMethod.POST)
	public ModelMap insertCashReceipt(Session session, OrderSO so, CashReceiptPO po){

		po.setMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		po.setPrcsrNo(session.getMbrNo().longValue());

		CashReceiptSO crso = new CashReceiptSO();
		crso.setCashRctNo(po.getCashRctNo());
		crso.setOrdNo(so.getOrdNo());

		cashReceiptService.cashReceiptRePublishExec( crso, po );

		return new ModelMap();
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 28.
	* - 작성자		: hjko
	* - 설명			:  비회원 front PC 현금영수증 재발행 신청
	* </pre>
	* @param session
	* @param so
	* @param po
	* @return
	 */
	@ResponseBody
	@RequestMapping(value="insertCashReceiptNoMem", method=RequestMethod.POST)
	public ModelMap insertCashReceiptNoMem(Session session, OrderSO so, CashReceiptPO po){
//		String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrderInfo().getOrdNo());
//
//		// 비회원 로그
//		if(newCheckCode.equals(session.getNoMemOrderInfo().getCheckCode())){
//
//		} else {
//			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_SESSION);
//		}

		// 이미 비회원 로그인 상태 일 때
		return this.insertCashReceipt(session, so, po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyOrderController.java
	* - 작성일	: 2016. 6. 29.
	* - 작성자	: jangjy
	* - 설명		: 세금계산서 신청
	* </pre>
	* @param session
	* @param so
	* @param po
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="insertTaxInvoice", method=RequestMethod.POST)
	public ModelMap insertTaxInvoice(Session session, OrderSO so, TaxInvoicePO po){

		po.setMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		po.setPrcsrNo(session.getMbrNo().longValue());

		this.taxService.insertTaxInvoice(so, po);

		return new ModelMap();
	}



	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 16.
	* - 작성자		: hjko
	* - 설명			: 옵션 변경 팝업
	* </pre>
	* @param map
	* @param view
	* @param session
	* @param param
	* @return
	 */
	@RequestMapping(value = "popupOrderOptionChange")
	public String popupOrderOptionChange(ModelMap map, ViewBase view, Session session, OrderOptionChangeParam param) {
		if (param.getMode() != null) {
			param.setMode("order");
		}

		/***************************
		 * 주문 상세 정보 조회
		 ***************************/
		OrderDetailVO orderDetail = this.orderDetailService.getOrderDetail(param.getOrdNo(), param.getOrdDtlSeq());

		/*******************************
		 * Validation
		 ********************************/
		/*
		 * 주문 상품 존재 유무 체크
		 */
		if(orderDetail == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}

		/*
		 * 회원 유형별 체크
		 */
		if(FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderDetail.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}else{
			if(!orderDetail.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}
		}

		map.put("orderDetail", orderDetail);

		/********************************
		 * 단품 속성 조회
		 ********************************/
		// 단품속성
		AttributePO attr = new AttributePO();
		attr.setGoodsId(orderDetail.getGoodsId());
		attr.setItemNo(orderDetail.getItemNo());
		attr.setUseYn(CommonConstants.COMM_YN_Y);
		List<GoodsAttributeVO>  goodsAttrList = this.goodsService.listGoodsAttribute(orderDetail.getGoodsId(), true);
		
		//ItemVO item = this.itemService.getItem(orderDetail.getGoodsId(), attrNos, attrValNos);
		
		/*
		 * for(int i=0;i<goodsAttrList.size();i++) {
		 * 
		 * Long attrNo =
		 * goodsAttrList.get(i).getGoodsAttrValueList().get(i).getAttrNo(); int
		 * attrValNo =
		 * goodsAttrList.get(i).getGoodsAttrValueList().get(i).getAttrValNo();
		 * 
		 * 
		 * }
		 */
		map.put("goodsAttrList", goodsAttrList);

		view.setTitle(message.getMessage("front.web.view.order.option.change.popup.title"));

		map.put("view", view);
		map.put("param", param);

		return TilesView.popup(new String[] {"mypage", "order", "popupOrderOptionChange" });
	}



	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 16.
	* - 작성자		: hjko
	* - 설명		:  주문 후 옵션 변경 실행
	* </pre>
	* @param po
	* @param session
	* @return
	 */
	@RequestMapping(value = "changeOrderOption")
	@ResponseBody
	public ModelMap changeOrderOption(String ordNo, Integer ordDtlSeq, Long[] attrNos, Long[] attrValNos, Session session) {

		/***************************
		 * 주문 상세 정보 조회
		 ***************************/
		OrderDetailVO orderDetail = this.orderDetailService.getOrderDetail(ordNo, ordDtlSeq);

		/*
		 * 주문 상품 존재 유무 체크
		 */
		if(orderDetail == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}

		/*
		 * 회원 유형별 체크
		 */
		if(FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderDetail.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}else{
			if(!orderDetail.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}
		}
		
		/*******************************
		 * Validation
		 ********************************/
			
		ItemVO item = this.itemService.getItem(orderDetail.getGoodsId(), attrNos, attrValNos);

		/*
		 * 해당 속성의 단품이 다른 경우
		 */
		if(item == null){
			throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_OPTION);
		}
		
		/*
		 * 해당 속성의 단품 추가 금액이 기존 주문의 추가금액과 다른경우
		 */
		if(!item.getAddSaleAmt().equals(orderDetail.getAddSaleAmt())){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_OPTION_CHANGE_NO_MATCH_AMT);
		}
		
		/*
		 * 재고가 부족한 경우 불가
		 */
		if(CommonConstants.COMM_YN_Y.equals(orderDetail.getStkMngYn()) &&  item.getWebStkQty() < orderDetail.getRmnOrdQty()){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_ITEM_CHANGE_NO_WEB_STK_QTY);
		}
		
		/*******************************
		 * 주문 옵션 변경 실행
		 *******************************/
		this.orderDetailService.updateOrderDetailItem(ordNo, ordDtlSeq, item.getItemNo());
		
		return new ModelMap();
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 16.
	* - 작성자		: hjko
	* - 설명		:  주문 후 옵션 변경 실행
	* </pre>
	* @param po
	* @param session
	* @return
	 */
	@RequestMapping(value = "changeOrderExchangeOption")
	@ResponseBody
	public ModelMap changeOrderExchangeOption(String ordNo, Integer ordDtlSeq, Long[] attrNos, Long[] attrValNos, Long[] itemNos, Session session) {
		
		/***************************
		 * 주문 상세 정보 조회
		 ***************************/
		OrderDetailVO orderDetail = this.orderDetailService.getOrderDetail(ordNo, ordDtlSeq);

		/*
		 * 주문 상품 존재 유무 체크
		 */
		if(orderDetail == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}

		/*
		 * 회원 유형별 체크
		 */
		if(FrontWebConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderDetail.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_PARAM);
			}
		}else{
			if(!orderDetail.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}
		}

		/*******************************
		 * Validation
		 ********************************/
		ItemVO item = this.itemService.getItem(orderDetail.getGoodsId(), attrNos, attrValNos);

		/*
		 * 해당 속성의 단품의 단품번호가 같을 경우
		 */
		/*
		 * if(item.getItemNo().equals(orderDetail.getItemNo())){ throw new
		 * CustomException(ExceptionConstants.ERROR_ORDER_NO_CHANGE_ITEM); }
		 */
		
		/*
		 * 해당 속성의 단품 추가 금액이 기존 주문의 추가금액과 다른경우
		 */
		if(!item.getAddSaleAmt().equals(orderDetail.getAddSaleAmt())){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_OPTION_CHANGE_NO_MATCH_AMT);
		}
		
		/*
		 * 재고가 부족한 경우 불가
		 */
		if(CommonConstants.COMM_YN_Y.equals(orderDetail.getStkMngYn()) &&  item.getWebStkQty() < orderDetail.getRmnOrdQty()){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_ITEM_CHANGE_NO_WEB_STK_QTY);
		}
		
		ModelMap map = new ModelMap();
		
		Long itemNo = item.getItemNo();
		
		map.addAttribute("itemNo", itemNo);
		
		return map;
	}



	/**
	 *
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 16.
	* - 작성자		: hjko
	* - 설명			: 주문하고 나서 단품 변경하려고 할 때 변경되는(새로운) 단품 정보 체크
	* </pre>
	* @param 바꾸는 단품정보 ItemSO
	* @return
	 */
	@RequestMapping("checkDeliveryGoodsOption")
	@ResponseBody
	public ModelMap checkDeliveryGoodsOption(ItemSO so ){

		OrderSO os = new OrderSO();

		os.setOrdNo(so.getOrdNo());
		os.setItemNo(so.getItemNo());

		//boolean result = this.orderDetailService.checkOrderItem(so.getOrdNo(), so.getItemNo(), so.getOrdDtlSeq());

		ModelMap map = new ModelMap();

		ItemVO item = this.goodsService.checkGoodsOption(so);
		map.put("item", item);

		return map;
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 16.
	* - 작성자		: hjko
	* - 설명		: 배송조회 팝업 화면
	* </pre>
	* @param map
	* @param view
	* @param session
	* @param param
	* @param deliverySO
	* @return
	 */
	@RequestMapping(value="popupDeliveryInquire")
	public String popupDeliveryInquire(ModelMap map, ViewBase view, Session session, OrderSO so){

		DeliveryVO delivery = deliveryService.getGoodsFlowCode(so);

		map.put("delivery", delivery);

		view.setTitle(message.getMessage("front.web.view.mypage.order.delivery.inquire.popup.title"));
		map.put("view", view);

		return TilesView.popup(
				new String[]{"mypage", "order", "popupDeliveryInquire"}
				);
	}



	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 2. 28.
	* - 작성자		: valuefactory 권성중
	* - 설명			: 배송지 수정
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param ordNo
	* @param viewTitle
	* @param mode
	* @return
	*/
	@RequestMapping(value="popupDeliveryAddressEdit", method=RequestMethod.POST)
	public String popupDeliveryAddressEdit(ModelMap map, Session session,   ViewBase view, String ordNo, String viewTitle, String mode){

		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		if(viewTitle == null || "".equals(viewTitle)){
			viewTitle = this.message.getMessage("front.web.view.mypage.order.dlvra.popup.title");
		}

		view.setTitle(viewTitle);

		OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
		orderDlvraSO.setOrdNo(ordNo);
		OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
		String localPostYn = localPostService.getLocalPostYn(deliveryInfo.getPostNoNew(), deliveryInfo.getPostNoOld());
		
		map.put("localPostYn", localPostYn);
		map.put("deliveryInfo", deliveryInfo);
		map.put("view", view);
		map.put("mode", mode);
		return  TilesView.popup(new String[]{"mypage", "order", "popupDeliveryAddressEdit"});
	}
	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일      : 2017. 2. 28.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 배송지 수정
	* </pre>
	 */
	@RequestMapping(value="updateDeliveryAddress", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap updateDeliveryAddress(Session session, OrderDlvraPO po) {
		po.setPrclDtlAddr(po.getRoadDtlAddr());
		this.orderDlvraService.updateDeliveryAddress(po);

		return new ModelMap();
	}

	/**
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: hongjun
	* - 설명			: 취소/반품/교환 신청 금액 조회
	* </pre>
	* @param session
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="getClaimRefundExcpect", method=RequestMethod.POST)
	public ModelMap getClaimRefundExcpect(Session session, ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, Integer[] arrClmQty) {
		ModelMap model = new ModelMap();
		clmRegist.setAcptrNo(session.getMbrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(arrClmQty != null){
					claimSub.setClmQty(arrClmQty[i]);
				}
				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		ClaimRefundVO claimRefundVO = claimService.getClaimRefundExcpect(clmRegist, clmRegist.getClmTpCd()); // 환불금액

		model.put("claimRefundVO", claimRefundVO);

		return model;
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyOrderController.java
	* - 작성일      : 2017. 4. 26.
	* - 작성자      : valuefactory 양홍준
	* - 설명      :  클레임 상세정보
	* </pre>
	 */
	@RequestMapping(value="popupCancelRefundInfo", method=RequestMethod.POST)
	public String popupCancelRefundInfo(ModelMap map, Session session, ViewBase view, ClaimSO so, String viewTitle){
		view.setTitle(viewTitle);

		ClaimBaseVO claimBaseVO = claimService.getClaimRefund(so);
		map.put("claimBaseVO", claimBaseVO);

		ClaimRefundPayVO claimRefundPayVO = claimService.getClaimRefundPay(so);
		map.put("claimRefundPayVO", claimRefundPayVO);
		
		if (claimBaseVO.getRtrnaNo() != null || claimBaseVO.getDlvraNo() != null) {
			OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
			orderDlvraSO.setOrdDlvraNo(claimBaseVO.getRtrnaNo() != null ? claimBaseVO.getRtrnaNo() : claimBaseVO.getDlvraNo());
			OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
			map.put("deliveryInfo", deliveryInfo);
		}

		map.put("session", session);
		map.put("view", view);
		map.put("clmRsnCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_RSN, null, null, null, null, null));
		map.put("clmStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_STAT, null, null, null, null, null));
		map.put("clmDtlStatCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_DTL_STAT, null, null, null, null, null));
		map.put("payMeansCdList", this.cacheService.listCodeCache(FrontWebConstants.PAY_MEANS, null, null, null, null, null));
		map.put("bankCdList", this.cacheService.listCodeCache(FrontWebConstants.BANK, null, null, null, null, null));
		map.put("clmTpCdList", this.cacheService.listCodeCache(FrontWebConstants.CLM_TP, null, null, null, null, null));

		return  TilesView.popup(new String[]{"mypage", "order", "popupCancelRefundInfo"});
	}

	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2017. 7. 6.
	* - 작성자		: hjko
	* - 설명			: 신용카드전표 목록 popup
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param popId
	* @param callBackFnc
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="popupCreditCardByOrderNo")
	public String popupCreditCardByOrderNo(ModelMap map, OrderSO orderSO, Session session, ViewBase view, String popId, String callBackFnc){
		view.setTitle(message.getMessage("front.web.view.mypage.order.creditcart.popup.title"));  // 신용카드전표

		PayBaseSO so = new PayBaseSO();
		so.setOrdNo(orderSO.getOrdNo());
		so.setPayMeansCd(CommonConstants.PAY_MEANS_10);
		so.setCncYn(CommonConstants.COMM_YN_N);
		List<PayBaseVO> payInfoList = payBaseService.listPayBase(so);

 		map.put("payInfoList", payInfoList);
 		map.put("payGbCdList", this.codeCacheService.listCodeCache(FrontWebConstants.PAY_GB, null, null, null, null, null));

 		if(StringUtils.isNotEmpty(popId) && StringUtils.isNotEmpty(callBackFnc)){
			Map<String,String> param = new HashMap<>();

			param.put("popId", popId);
			param.put("callBackFnc", callBackFnc);

			map.put("param", param);
		}

		map.put("view", view);
		map.put("orderSO", so);

		return  TilesView.popup(new String[]{"mypage", "order", "popupCreditCardByOrderNo"});
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 
	* - 작성자		: 
	* - 설명			: 계좌본인인증
	* </pre>	
	*/	
	@ResponseBody
	@RequestMapping(value="getAccountName", method=RequestMethod.POST)
	public ModelMap reqCheckBankAccount(CheckBankAccountReqVO reqVO) {
		
		ModelMap model = new ModelMap();
		
		if (reqVO.getBankCode() == null || reqVO.getAccountNo() == null) {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		CheckBankAccountResVO res =  nicePayCommonService.reqCheckBankAccount(reqVO);
		
		
		
		model.put("result", res.getResultCode());
		model.put("accountName", res.getAccountName());

		return model;
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 3. 14.
	* - 작성자		: 
	* - 설명			: 주문내역 삭제 처리
	* </pre>
	* @param po
	* @param session
	* @return
	*/		
	@LoginCheck
	@RequestMapping(value = "ordDeleteProcess")
	@ResponseBody
	public ModelMap ordDeleteProcess(String ordNo, Session session,  OrderBaseSO obso) {		
		
		/*********************************
		 * Validation Param
		 *********************************/
		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}		
		
		obso.setOrdNo(ordNo);
		obso.setMbrNo(session.getMbrNo());		
		OrderBaseVO orderBase = orderBaseService.getOrderBase(obso);

		/*
		 * 주문 정보가 존재하지 않은 경우
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		ModelMap map = new ModelMap();
		
		OrderBasePO obpo = new OrderBasePO();
		obpo.setOrdNo(orderBase.getOrdNo());
		obpo.setMbrNo(session.getMbrNo());
		this.orderBaseService.updateOrderBaseStatus(obpo);		

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyOrderController.java
	 * - 작성일		: 2021. 4. 9.
	 * - 작성자		: cyhvf01
	 * - 설명			: Goods Flow 배송정보 조회 팝업 연결
	 * </pre>
	 * @param po
	 * @param session
	 * @return
	 */
	@RequestMapping(value = {"goodsflow/{dlvrNo}"})
	public RedirectView goodsFlowRedirect(HttpServletRequest request, Session session, ModelMap map, ViewBase view, RedirectAttributes redirectAttr, @PathVariable Long dlvrNo) {
		biz.interfaces.goodsflow.model.request.data.DeliveryVO delivery = deliveryService.getGoodsFlowDelivery(dlvrNo);
		log.debug("dlvrNo: "+dlvrNo);
		log.debug(""+delivery);
		String url = "http://trace.goodsflow.com/VIEW/V1/whereis/"+bizConfig.getProperty("goodsflow.api.code.member")+"/"+delivery.getLogisticsCode()+"/"+delivery.getInvoiceNo();

		RedirectView redirectView = new RedirectView();
		redirectView.setUrl(url);
		return redirectView;
	}

	// 빌링 카드 관리
	@LoginCheck
	@RequestMapping(value="indexBillingCardList")
	public String indexBillingCardList(ModelMap map, OrderSO orderSO, Session session, ViewBase view){

		MemberBaseSO mbso = new MemberBaseSO();

		orderSO.setSidx("ORD_NO");
		orderSO.setSord(FrontWebConstants.SORD_DESC);
		orderSO.setRows(FrontWebConstants.PAGE_ROWS_10);
		orderSO.setMbrNo(session.getMbrNo());
		mbso.setMbrNo(session.getMbrNo());


		// 회원 정보 조회
		MemberBaseVO memberBase = this.memberService.decryptMemberBase(mbso);
		// 등록된 간편결제 정보
		List<PrsnCardBillingInfoVO> cardBillInfo = memberService.listMemberCardBillingInfo(mbso);
		String isEmptyCarBilingInfo = CollectionUtils.isEmpty(cardBillInfo) ?
				FrontConstants.COMM_YN_Y : FrontConstants.COMM_YN_N;

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("isEmptyCarBilingInfo",isEmptyCarBilingInfo);
		map.put("cardBillInfo", cardBillInfo);
		map.put("session", session);
		map.put("view", view);
		map.put("memberBase", memberBase);

		return "mypage/order/indexBillingCardList";

	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyOrderController.java
	* - 작성일		: 2021. 4. 21.
	* - 작성자		: pse
	* - 설명			: 클레임 신청하려는 상품이 클레임 가능한지 체크 
	* </pre>
	* @param 
	* @return
	 */
	@RequestMapping("checkOrderCurrentStatus")
	@ResponseBody
	public ModelMap checkOrderCurrentStatus(Session session, String ordNo){
		ModelMap map = new ModelMap();
		/******************************
		 * 주문 기본 정보 조회
		 *****************************/
		/*********************************
		 * Validation Param
		 *********************************/
		if(ordNo == null || "".equals(ordNo)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		/*****************************************
		 * 주문 기본 조회
		 *****************************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(ordNo);
		
		/*********************************
		 * Validation Data
		 *********************************/
		/*
		 * 클레임 데이터 존재 여부 체크
		 */
		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		//비회원
		if(CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())){
			String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, orderBase.getOrdNo());

			if(!session.getNoMemCheckCd().equals(newCheckCode)){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}		
		// 회원
		}else{
			if(!orderBase.getMbrNo().equals(session.getMbrNo())){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
			}
		}
		
		OrderDeliveryVO order = new OrderDeliveryVO();
		OrderSO so = new OrderSO();
		so.setOrdNo(ordNo);
		
		List<OrderDeliveryVO> orderCancelList = orderService.listClaimDetail(so);
		if (CollectionUtils.isNotEmpty(orderCancelList)) {
			order = orderCancelList.get(0);
		}
		
		map.put("order", order);
		
		// 교환 재고 확인
		String[] goodsIds = new String[order.getOrderDetailListVO().size()];
		for(int i=0; i < order.getOrderDetailListVO().size() ; i++) {
			goodsIds[i] = order.getOrderDetailListVO().get(i).getGoodsId();
		}
		GoodsBaseSO gbso = new GoodsBaseSO();
		gbso.setGoodsIds(goodsIds);
		List<GoodsBaseVO> stkQtyList = orderService.listWebStkQty(gbso);
		map.put("stkQtyList", stkQtyList);
		
		return map;
	}

	public static String maskingCard(String cardNo){

		String maskingCardNo = "";

		if(cardNo != null && !"".equals(cardNo) && !"null".equals(cardNo)){
			int total = cardNo.length();
			int startLen=4, endLen = 12;


			String start = cardNo.substring(0,startLen);
			String end = cardNo.substring(endLen, total);
			String padded = org.apache.commons.lang3.StringUtils.rightPad(start, endLen,'*');

			maskingCardNo = padded.concat(end);
		}

		return maskingCardNo;
	}

}