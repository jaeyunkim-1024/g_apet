package front.web.view.order.controller;

import java.util.Enumeration;
import java.util.Optional;
import java.util.Properties;

import javax.annotation.Nullable;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import biz.app.order.service.OrderBaseService;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.service.PayBaseService;
import biz.common.service.BizService;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import framework.common.util.DateUtil;
import framework.front.constants.FrontConstants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import biz.app.cart.service.CartService;
import biz.app.order.model.OrderComplete;
import biz.app.order.model.OrderException;
import biz.app.pay.model.PaymentException;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.service.NicePayCommonService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.util.CookieSessionUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: front.web.view.order.controller
 * - 파일명		: OrderExceptionController.java
 * - 작성일		: 2021. 03. 24.
 * - 작성자		: sorce
 * - 설명			: 결제부분에서 사용될 exception handler
 * </pre>
 */
@Slf4j
@ControllerAdvice
public class OrderExceptionController {
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpServletResponse response;
	
	@Autowired private Properties webConfig;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	NicePayCommonService nicePayCommonService;

	@Autowired
	GsrService gsrService;

	@Autowired
	PayBaseService payBaseService;

	@Autowired
	OrderBaseService orderBaseService;

	@Autowired
	BizService bizService;

	@Autowired private MessageSourceAccessor message;
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: paymentException
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: sorce
	 * - 설명			: 주문 Exception 결제취소처리되지 않음
	 * </pre>
	 * @param exception
	 * @return
	 */
	@ExceptionHandler(OrderException.class)
	public ModelAndView orderException(OrderException exception) {
		ModelAndView mav = new ModelAndView();

		String exCode = null;
		String loginType = null;
		String[] params = null;
		String exMsg = null;
		StringBuilder returnUrl = new StringBuilder(1024);

		exCode = exception.getExCode();
		loginType = StringUtil.nvl(exception.getLoginType());
		params = exception.getParams();
		if(StringUtil.isNotEmpty(exception.getReturnUrl())){
			returnUrl.append(exception.getReturnUrl());
		}

		// 디바이스 OS구분
		String deviceGbCookie = CookieSessionUtil.getCookie(CommonConstants.DEVICE_GB);

		DeviceUtils.getCurrentDevice(request);
		String userAgent = request.getHeader("user-agent");
		ViewBase view = new ViewBase(); 
		if(userAgent.toLowerCase().indexOf("apet") != -1 ) { 
			if(userAgent.toLowerCase().indexOf("android") != -1 ) {
				view.setOs(CommonConstants.DEVICE_TYPE_10);
			} else {
				 view.setOs(CommonConstants.DEVICE_TYPE_20);
			}
		} else {
			view.setOs(CommonConstants.DEVICE_TYPE);
		}
		
		// 기기구분 [PC, MO, APP]
		if(userAgent.toLowerCase().indexOf("apet") != -1 ) { // APP
			view.setDeviceGb(CommonConstants.DEVICE_GB_30);
		}else if(CommonConstants.DEVICE_GB_20.equals(deviceGbCookie)) { // MO (cookie)
			view.setDeviceGb(CommonConstants.DEVICE_GB_20);
		}else if(CommonConstants.DEVICE_GB_10.equals(deviceGbCookie)) { // PC (cookie)
			view.setDeviceGb(CommonConstants.DEVICE_GB_10);
		}else if(!DeviceUtils.getCurrentDevice(request).isNormal()) { 	// MO
			view.setDeviceGb(CommonConstants.DEVICE_GB_20);
		}else if(DeviceUtils.getCurrentDevice(request).isNormal()) {	// PC
			view.setDeviceGb(CommonConstants.DEVICE_GB_10);
		}

		if(checkAjax(request)) { // ajax일 경우
			mav.setViewName(FrontWebConstants.JSON_VIEW_NAME);
			if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)){
				if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR_OD);
				}else if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR_ODS);
				}else{
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR);
					if (StringUtil.isNotEmpty(returnUrl)) {
						try {
							response.setCharacterEncoding("UTF-8");
							response.getWriter().write("returnUrl="+returnUrl.toString());
							response.getWriter().flush();
							response.getWriter().close();
						} catch (Exception e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						}
					}
				}
				
			}else if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP.equals(exCode)){

				if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR_OD);
				}else if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR_ODS);
				}else{
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR);
				}
			}
		} else { // 일반 페이지일 경우
			if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)) {
				mav.setViewName("redirect:/indexLogin");
				mav.addObject("loginType", loginType);
				mav.addObject("returnUrl", request.getRequestURI());

				returnUrl.append(request.getRequestURI());
				
				boolean paramExt = true;
				if(returnUrl.indexOf("?") < 0){
					paramExt = false;
					returnUrl.append("?");
				}
					
				Enumeration<String> paramNames = request.getParameterNames();
				
				while (paramNames.hasMoreElements()){

					String name = paramNames.nextElement();
					String value = request.getParameter(name);
					
					if(paramExt){
						returnUrl.append("&");
					}
					
					returnUrl.append(name +"=" + value);
					
					paramExt = true;
				}
				
				mav.addObject("returnUrl", returnUrl.toString());
				
			}else{
				if(StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10)) {
					mav.setViewName(FrontWebConstants.EXCEPTION_VIEW_NAME);
				}
				else { 
					mav.setViewName(FrontWebConstants.PAYMENTEXCEPTION_VIEW_NAME);
				}
			}
		}
		
		if(params != null){
			exMsg = message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode, params);
		}else{
			exMsg = message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode);
		}
		
		if (!ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)) {
			mav.addObject("exCode", exCode);
			mav.addObject("exMsg", exMsg);
		}
		
		view.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		view.setStGb(webConfig.getProperty("site.gb"));
		view.setStNm(webConfig.getProperty("site.nm"));
		view.setSvcGbCd(webConfig.getProperty("site.service"));
		Session session = FrontSessionUtil.getSession();
		view.setCartCnt(cartService.getCartCnt(view.getStId(), session.getSessionId(), session.getMbrNo()));
		mav.addObject("view", view);
		mav.addObject("session", session);
		
		return mav;
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: orderException
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: sorce
	 * - 설명			: 결제 Exception (결제취소가 동반됨)
	 * </pre>
	 * @param exception
	 * @return
	 */
	@ExceptionHandler(PaymentException.class)
	public ModelAndView orderException(PaymentException exception) {
		ModelAndView mav = new ModelAndView();
		OrderComplete ordComplete = exception.getOrdComplete();
		GsrMemberPointVO gsrMemberPointVO = exception.getGsrMemberPointVO();

		String exCode = null;
		String loginType = null;
		String[] params = null;
		String exMsg = null;
		StringBuilder returnUrl = new StringBuilder(1024);

		exCode = exception.getExCode();
		loginType = StringUtil.nvl(exception.getLoginType());
		params = exception.getParams();
		if(StringUtil.isNotEmpty(exception.getReturnUrl())){
			returnUrl.append(exception.getReturnUrl());
		}

		// 디바이스 OS구분
		String deviceGbCookie = CookieSessionUtil.getCookie(CommonConstants.DEVICE_GB);

		DeviceUtils.getCurrentDevice(request);
		String userAgent = request.getHeader("user-agent");
		ViewBase view = new ViewBase(); 
		if(userAgent.toLowerCase().indexOf("apet") != -1 ) { 
			if(userAgent.toLowerCase().indexOf("android") != -1 ) {
				view.setOs(CommonConstants.DEVICE_TYPE_10);
			} else {
				 view.setOs(CommonConstants.DEVICE_TYPE_20);
			}
		} else {
			view.setOs(CommonConstants.DEVICE_TYPE);
		}
		
		// 기기구분 [PC, MO, APP]
		if(userAgent.toLowerCase().indexOf("apet") != -1 ) { // APP
			view.setDeviceGb(CommonConstants.DEVICE_GB_30);
		}else if(CommonConstants.DEVICE_GB_20.equals(deviceGbCookie)) { // MO (cookie)
			view.setDeviceGb(CommonConstants.DEVICE_GB_20);
		}else if(CommonConstants.DEVICE_GB_10.equals(deviceGbCookie)) { // PC (cookie)
			view.setDeviceGb(CommonConstants.DEVICE_GB_10);
		}else if(!DeviceUtils.getCurrentDevice(request).isNormal()) { 	// MO
			view.setDeviceGb(CommonConstants.DEVICE_GB_20);
		}else if(DeviceUtils.getCurrentDevice(request).isNormal()) {	// PC
			view.setDeviceGb(CommonConstants.DEVICE_GB_10);
		}
		
		view.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		view.setStGb(webConfig.getProperty("site.gb"));
		view.setStNm(webConfig.getProperty("site.nm"));
		view.setSvcGbCd(webConfig.getProperty("site.service"));

		if(checkAjax(request)) { // ajax일 경우
			mav.setViewName(FrontWebConstants.JSON_VIEW_NAME);
			
			if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)){
				if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR_OD);
				}else if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR_ODS);
				}else{
					response.setStatus(FrontWebConstants.AJAX_LOGIN_SESSION_ERROR);
					if (StringUtil.isNotEmpty(returnUrl)) {
						try {
							response.setCharacterEncoding("UTF-8");
							response.getWriter().write("returnUrl="+returnUrl.toString());
							response.getWriter().flush();
							response.getWriter().close();
						} catch (Exception e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						}
					}
				}
				
			}else if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP.equals(exCode)){

				if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR_OD);
				}else if(FrontWebConstants.LOGIN_TYPE_NO_MEM_ORDER_SEARCH.equals(loginType)){
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR_ODS);
				}else{
					response.setStatus(FrontWebConstants.AJAX_LOGIN_POPUP_SESSION_ERROR);
				}
			}
		} else { // 일반 페이지일 경우
			if(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)) {
				mav.setViewName("redirect:/indexLogin");
				mav.addObject("loginType", loginType);
				mav.addObject("returnUrl", request.getRequestURI());

				returnUrl.append(request.getRequestURI());
				
				boolean paramExt = true;
				if(returnUrl.indexOf("?") < 0){
					paramExt = false;
					returnUrl.append("?");
				}
					
				Enumeration<String> paramNames = request.getParameterNames();
				
				while (paramNames.hasMoreElements()){

					String name = paramNames.nextElement();
					String value = request.getParameter(name);
					
					if(paramExt){
						returnUrl.append("&");
					}
					
					returnUrl.append(name +"=" + value);
					
					paramExt = true;
				}
				
				mav.addObject("returnUrl", returnUrl.toString());
				
			}else{
				if(StringUtils.equals(view.getDeviceGb(), CommonConstants.DEVICE_GB_10))
					mav.setViewName(FrontWebConstants.EXCEPTION_VIEW_NAME);
				else 
					mav.setViewName(FrontWebConstants.PAYMENTEXCEPTION_VIEW_NAME);
			}
		}
		
		if(params != null){
			exMsg = message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode, params);
		}else{
			exMsg = message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + exCode);
		}
		
		if (!ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED.equals(exCode)) {
			mav.addObject("exCode", exCode);
			mav.addObject("exMsg", exMsg);
		}
		
		Session session = FrontSessionUtil.getSession();
		view.setCartCnt(cartService.getCartCnt(view.getStId(), session.getSessionId(), session.getMbrNo()));
		mav.addObject("view", view);
		mav.addObject("session", session);
		
		// 결제취소
		try {
			if(cancelPayment(ordComplete,gsrMemberPointVO)){
				orderBaseService.updateOrderBaseProcessResult(ordComplete.getOrdNo(), exCode, exMsg, CommonConstants.DATA_STAT_02);
			}
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//e.printStackTrace();
			log.error("cancelPayment Exception!", e.getClass());
		}
		log.debug("viewname=="+mav.getViewName());
		log.info("####################### Exception Handler ###########################");
		return mav;
	}

	/*
	 * Request Ajax Check
	 */
	private boolean checkAjax(HttpServletRequest request) {
		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: cancelPayment
	 * - 작성일		: 2021. 03. 25.
	 * - 작성자		: sorce
	 * - 설명			: 결제실패시 취소시키는 프로세스
	 * </pre>
	 * @param request
	 * @return
	 */
	public boolean cancelPayment(OrderComplete ordComplete,@Nullable GsrMemberPointVO gsrMemberPointVO){
		if(ordComplete==null) {
			return false;
		}

		// 취소 데이터 생성
		CancelProcessReqVO vo = new CancelProcessReqVO();
		String midGb = null;

		String payMeans = ordComplete.getPayMeansCd();
		String payMethod = ordComplete.getPayMethod();
		String mdaGb = NicePayConstants.MDA_GB_01 ;

		// 결제 종류에 따른 mid 구분
		if((StringUtils.equals(payMethod, CommonConstants.PAY_METHOD_CARD) && StringUtils.equals(payMeans, CommonConstants.PAY_MEANS_10))
				||StringUtils.equals(payMethod, CommonConstants.PAY_METHOD_VBANK)) { // 가상계좌/ 카드결제
			midGb = NicePayConstants.MID_GB_CERTIFY;
		} else if(StringUtils.equals(payMethod, CommonConstants.PAY_METHOD_CARD) && !StringUtils.equals(payMeans, CommonConstants.PAY_MEANS_10)) { // 간편결제
			midGb = NicePayConstants.MID_GB_SIMPLE;
		} else if (StringUtils.equals(payMeans, CommonConstants.PAY_MEANS_11)) { // 빌링결제일떄
			midGb = NicePayConstants.MID_GB_BILLING;
		}

		vo.setTID(ordComplete.getTid());
		vo.setMoid(ordComplete.getMoid());
		vo.setCancelAmt(String.valueOf(ordComplete.getAmt()));
		vo.setCancelMsg(NicePayConstants.CANCEL_MSG_CS);
		vo.setPartialCancelCode(NicePayConstants.PART_CANCEL_CODE_0);

		if(StringUtils.isNotEmpty(vo.getMoid())) {
			CancelProcessResVO cvo = nicePayCommonService.reqCancelProcess(vo, midGb, payMeans, mdaGb);

			PayBasePO mainPayBase = new PayBasePO();
			mainPayBase.setPayNo(bizService.getSequence(FrontConstants.SEQUENCE_PAY_BASE_SEQ));
			mainPayBase.setOrdClmGbCd(FrontConstants.ORD_CLM_GB_20);
			mainPayBase.setPayGbCd(FrontConstants.PAY_GB_20);
			mainPayBase.setCfmNo(cvo.getTID());
			mainPayBase.setDealNo(cvo.getTID());
			mainPayBase.setLnkRspsRst(cvo.getResponseBody());
			mainPayBase.setOrgPayNo(ordComplete.getPayNo());
			mainPayBase.setOrdNo(ordComplete.getOrdNo());
			mainPayBase.setPayAmt(ordComplete.getAmt());
			mainPayBase.setCncYn(FrontConstants.COMM_YN_N);
			mainPayBase.setPayMeansCd(payMeans);
			mainPayBase.setStrId(ordComplete.getStrId());

			if(NicePayConstants.CANCEL_PROCESS_SUCCESS_CODE.equals(cvo.getResultCode()) || NicePayConstants.VIRTUAL_CANCEL_PROCESS_SUCCESS_CODE.equals(cvo.getResultCode())) {
				mainPayBase.setPayStatCd(FrontConstants.PAY_STAT_01);
				mainPayBase.setCfmDtm(DateUtil.getTimestamp(cvo.getCancelDate() + cvo.getCancelTime(), "yyyyMMddHHmmss"));
			}else {
				mainPayBase.setPayStatCd(FrontConstants.PAY_STAT_00);
			}
			mainPayBase.setCfmNo(cvo.getCancelNum());
			mainPayBase.setCfmRstMsg(Optional.ofNullable(cvo.getResultMsg()).orElseGet(()->cvo.getErrorMsg()));
			mainPayBase.setCfmRstCd(Optional.ofNullable(cvo.getResultCode()).orElseGet(()->cvo.getErrorCD()));

			payBaseService.insertPayBase(mainPayBase);
		}

		// DB 인서트
		// 나중에 필요하면 넣고.
		// 지금은 필요없음.

		// 세션있으면 비우기
		request.getSession().setAttribute("ordComplete", null);
		request.getSession().setAttribute("ordRegist", null);

		/*
		 	포인트 취소
		 * CASE1 : NULL -> GS 포인트 사용 전에 Exception
		 * CASE2: NULL 은 아니지만, APPR_NO가 없을 때 = API 호출 및 응답은 성공이지만 정상 회원이 아니거나 포인트 사용이 안됨
		*/ 
		if(gsrMemberPointVO != null && StringUtil.isNotEmpty(Optional.ofNullable(gsrMemberPointVO.getApprNo()).orElseGet(()->""))){
			/*
			 	ROLLBACK 되어 넘어왔기에, PAY_BASE
			 	PAY_MEANS_CD = '80' (=포인트)
			 	PAY_STAT_CD = '00' 을
			 	PAY_STAT_CD = '01'로 업데이트
			 */
			PayBaseSO pso = new PayBaseSO();
			PayBasePO ppo = new PayBasePO();
			pso.setOrdNo(ordComplete.getOrdNo());
			pso.setPayMeansCd(FrontConstants.PAY_MEANS_80);

			PayBaseVO pvo = gsrService.getPayBase(pso);
			Long payNo = pvo.getPayNo();
			ppo.setPayNo(payNo);
			gsrService.updatePayBaseComplete(ppo);

			GsrMemberPointPO pntPO = new GsrMemberPointPO();
			pntPO.setPntRsnCd(CommonConstants.PNT_RSN_ORDER);
			pntPO.setMbrNo(ordComplete.getMbrNo());
			pntPO.setRcptNo(ordComplete.getOrdNo());
			//전체 취소
			pntPO.setPoint(Optional.ofNullable(ordComplete.getUseGsPoint()).orElse(0L).toString());
			pntPO.setSaleDate(DateUtil.getTimestampToString(DateUtil.getTimestamp()));
			pntPO.setSaleEndDt(DateUtil.getTimestampToString(DateUtil.getTimestamp(), "HHmmss"));
			pntPO.setOrgApprNo(gsrMemberPointVO.getApprNo());
			pntPO.setOrgApprDate(gsrMemberPointVO.getApprDate() == null ? null : DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd"));

			GsrMemberPointVO result = gsrService.useCancelGsPoint(pntPO);

			String payStatCd = FrontConstants.PAY_STAT_00;
			PayBasePO pbpo = new PayBasePO();
			pbpo.setPayNo(bizService.getSequence(FrontConstants.SEQUENCE_PAY_BASE_SEQ));
			pbpo.setOrdClmGbCd(FrontConstants.ORD_CLM_GB_20);
			pbpo.setOrgPayNo(payNo);
			pbpo.setPayGbCd(FrontConstants.PAY_GB_20);
			pbpo.setOrdNo(ordComplete.getOrdNo());
			pbpo.setPayAmt(ordComplete.getUseGsPoint());
			pbpo.setCfmDtm(DateUtil.getTimestamp());
			pbpo.setCncYn(FrontConstants.COMM_YN_N);
			pbpo.setPayMeansCd(FrontConstants.PAY_MEANS_80);
			pbpo.setPayStatCd(FrontConstants.PAY_STAT_00);
			pbpo.setCfmRstMsg("[주문 완료 프로세스 오류로 인한 포인트 취소 요청] - GS 포인트 롤백 처리 위해 포인트 사용 취소 호출 실패");

			//정상 취소 되었을 때만
			if(StringUtil.isNotEmpty(Optional.ofNullable(result.getApprNo()).orElseGet(()->""))){
				/*
				 	취소 요청이 정상적으로 이루어졌으면 , PAY_BASE 에 정상 상태로 구분코드는 클레임, 클레임번호 없이 INSERT, 상태는 정상
				*/
				pbpo.setDealNo(result.getApprNo());
				pbpo.setPayStatCd(FrontConstants.PAY_STAT_01);
				pbpo.setCfmRstMsg("[주문 완료 프로세스 오류로 인한 포인트 취소 요청] - GS 포인트 롤백 처리 위해 포인트 사용 취소 호출 성공");
				pbpo.setCfmRstCd(result.getResultCode());
			}

			gsrService.insertPayBase(pbpo);
		}

		return true;
	}
}
