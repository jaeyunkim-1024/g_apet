package front.web.view.pay.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Hex;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.appweb.service.TermsService;
import biz.app.cart.service.CartService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderComplete;
import biz.app.order.model.OrderException;
import biz.app.order.service.OrderService;
import biz.app.pay.model.BillingRegist;
import biz.app.pay.model.PayIfLogVO;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoPO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.pay.service.PayBaseService;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.service.CashReceiptService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import biz.interfaces.nicepay.service.NicePayCashReceiptService;
import framework.admin.constants.AdminConstants;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.view.ViewBase;
import front.web.view.order.model.OrderPaymentParam;
import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * - 프로젝트명	: 31.front.web
 * - 패키지명		: front.web.view.pay.controller
 * - 파일명		: NicepayController.java
 * - 작성일		: 2021. 1. 01.
 * - 작성자		: valfac
 * - 설명		: NICEPAY 결제 관련 Contorller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("pay/nicepay")

public class NicepayController {

	@Value("#{bizConfig['nicepay.api.simple.mid']}")
	private String easyPayMerchantID;

	@Value("#{bizConfig['nicepay.api.simple.merchant.key']}")
	private String easyPayMerchantKey;

	@Value("#{bizConfig['nicepay.api.billing.mid']}")
	private String unauthMerchantID;

	@Value("#{bizConfig['nicepay.api.billing.merchant.key']}")
	private String unauthMerchantKey;

	@Value("#{bizConfig['nicepay.api.certify.mid']}")
	private String authMerchantID;

	@Value("#{bizConfig['nicepay.api.certify.merchant.key']}")
	private String authMerchantKey;

	@Value("#{bizConfig['nicepay.billing.regist.api.url']}")
	private String billingRegistUrl;

	@Value("#{bizConfig['nicepay.billing.delete.api.url']}")
	private String billingDeleteUrl;

	@Value("#{bizConfig['nicepay.billing.payment.api.url']}")
	private String billingPaymentUrl;

	@Value("#{bizConfig['nicepay.api.request.url.IF_CANCEL_PROCESS']}")
	private String nicepayCancelUrl;

	@Autowired
	private BizService bizService;

	@Autowired OrderService orderService;

	@Autowired MemberAddressService memberAddressService;

	@Autowired CartService cartService;

	@Autowired
	MemberService memberService;

	@Autowired
	private TermsService termsService;

	@Autowired NicePayCashReceiptService nicePayCashReceiptService;

	@Autowired CashReceiptService cashReceiptService;

	@Autowired PayBaseService payBaseService;
	
	@Autowired private MessageSourceAccessor message;
	
	@Autowired private CacheService cacheService;
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getSignData
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: sorce
	 * - 설명			: 암호화 데이터
	 * </pre>
	 * @param payAmt
	 * @param payMethod
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@ResponseBody
	@RequestMapping(value = "getSignData")
	public ModelMap getSignData(String payAmt, String payMethod, String moid, String payMeansCd) throws Exception {

		DataEncrypt sha256Enc = new DataEncrypt();
		String ediDate = getyyyyMMddHHmmss();
		String merchantID = "";
		String merchantKey = "";

		if(CommonConstants.PAY_METHOD_CARD.equals(payMethod)&&StringUtils.equals(payMeansCd, "10")){

			merchantID = authMerchantID;
			merchantKey = authMerchantKey;

		}else if(CommonConstants.PAY_METHOD_CARD.equals(payMethod)&&!StringUtils.equals(payMeansCd, "10")){

			merchantID = easyPayMerchantID;
			merchantKey = easyPayMerchantKey;

		}else if(CommonConstants.PAY_METHOD_VBANK.equals(payMethod)){

			merchantID = authMerchantID;
			merchantKey = authMerchantKey;

		}else if(CommonConstants.PAY_METHOD_BANK.equals(payMethod)){

			merchantID = authMerchantID;
			merchantKey = authMerchantKey;

		}else{

			merchantID = unauthMerchantID;
			merchantKey = unauthMerchantKey;

		}

		String  hashString = sha256Enc.encrypt(ediDate + merchantID + payAmt + merchantKey);

		ModelMap map = new ModelMap();

		map.put("ediDate",ediDate);
		map.put("signData", hashString);
		map.put("mid", merchantID);

		return map;
	}

	// 빌링 카드결제 화면
	@LoginCheck
	@RequestMapping(value = "registBillingCard")
	public String registBillingCard(ModelMap map, Session session, MemberBasePO mb, @RequestParam("firstYn") String firstYn, ViewBase view) {

		//약관조회 - GSR관련포함(신규회원가입, sns회원가입 CI있는경우) / GSR포함x(sns회원가입 CI없는 경우)
		List<TermsVO> termsList = new ArrayList<>();

		String osType = "";
		if(view.getOs().equals(CommonConstants.DEVICE_TYPE))  {osType =  CommonConstants.POC_WEB;}
		else {osType=view.getOs();}

		TermsSO tso = new TermsSO();
		tso.setPocGbCd(osType);

		// 결제약관
		tso.setUsrDfn1Val("20");
		tso.setUsrDfn2Val("102");

		List<TermsVO> allTerms = this.termsService.listTermsForPayment(tso);
		termsList = allTerms;

		//약관
		map.put("terms", termsList) ;

		//회원 정보
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = memberService.decryptMemberBase(so);
		String birth = Optional.ofNullable(mb.getBirth()).orElseGet(()->vo.getBirth());
		mb.setBirth(birth.substring(2,8)); // 생년월일 (ex.860814)
		mb.setMbrNm(Optional.ofNullable(mb.getMbrNm()).orElseGet(()->vo.getMbrNm()));
		mb.setMobile(Optional.ofNullable(mb.getMobile()).orElseGet(()->vo.getMobile()));
		mb.setEmail(Optional.ofNullable(mb.getEmail()).orElseGet(()->vo.getEmail()));
		map.put("memberBase", mb);

		//firstYn(=최초 등록인지 아닌지) 분기 처리 . 2021-06-16 김재윤 추가
		// 서로 다른 디바이스에서 접속하여, 한쪽에서만 등록 하였을 때, 데이터 동시성을 위해 서버 체크
		List<PrsnCardBillingInfoVO> cardBillInfo = memberService.listMemberCardBillingInfo(so);
		firstYn = CollectionUtils.isEmpty(cardBillInfo) || cardBillInfo.size() == 0 ?
				FrontConstants.COMM_YN_Y : FrontConstants.COMM_YN_N ;
		map.put("firstYn", firstYn);
		map.put("view", view);

		return "pay/nicepay/registBillingCard";
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: popupPaymentGatewayForMo
	 * - 작성일		: 2021. 03. 21.
	 * - 작성자		: sorce
	 * - 설명			: 모바일 결제를 위한 결제 요청  팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param op
	 * @param request
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "popupPaymentRequestForMo")
	public String popupPaymentRequestForMo(ModelMap map, Session session, ViewBase view, OrderPaymentParam op, HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expires",0);
		if (request.getProtocol().equals("HTTP/1.1"))
			response.setHeader("Cache-Control", "no-cache");

		return "pay/nicepay/popupPaymentRequestForMo";
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: popupPaymentResultForMo
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: sorce
	 * - 설명			: 모바일 결제를 위한 결제 완료  팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value = "popupPaymentResultForMo")
	public String popupPaymentResultForMo(ModelMap map, Session session, ViewBase view, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");

		map.addAttribute("result", nicepayResult(request, response, session));
		return "pay/nicepay/popupPaymentResultForMo";
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: popupPaymentResultForMo
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: sorce
	 * - 설명			: 모바일 결제를 위한 결제 완료  팝업
	 * </pre>
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value = "indexNicepayResult")
	@ResponseBody
	public ModelMap indexNicepayResult(Session session, ViewBase view, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return nicepayResult(request, response, session);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: nicepayResult
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: sorce
	 * - 설명			: 결제 승인처리
	 * </pre>
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public ModelMap nicepayResult(HttpServletRequest request, HttpServletResponse response, Session session) throws Exception {
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String ediDate			= getyyyyMMddHHmmss();

		PayIfLogVO logVO = new PayIfLogVO();
		/*
		 ****************************************************************************************
		 * <인증 결과 파라미터>
		 ****************************************************************************************
		 */
		String authResultCode 	= (String)request.getParameter("AuthResultCode"); 	    // 인증결과 : 0000(성공)
		String authResultMsg 	= (String)request.getParameter("AuthResultMsg"); 	    // 인증결과 메시지
		String nextAppURL 		= (String)request.getParameter("NextAppURL"); 		    // 승인 요청 URL
		String txTid 			= (String)request.getParameter("TxTid"); 			    // 거래 ID
		String authToken 		= (String)request.getParameter("AuthToken"); 		    // 인증 TOKEN
		String payMethod 		= (String)request.getParameter("PayMethod"); 		    // 결제수단
		String mid 				= (String)request.getParameter("MID"); 				    // 상점 아이디
		String moid 			= (String)request.getParameter("Moid"); 			        // 상점 주문번호
		String amt 				= (String)request.getParameter("Amt"); 				    // 결제 금액
		String reqReserved 		= (String)request.getParameter("ReqReserved"); 		    // 상점 예약필드
		String netCancelURL 	= (String)request.getParameter("NetCancelURL"); 	        // 망취소 요청 URL
		String responseSignature 	= (String)request.getParameter("Signature"); 	    // 위변조 검증 데이터

		// log 기본정보
		logVO.setOrdNo(moid); // 주문번호
		logVO.setTid(txTid); // 트랜잭션 아이디

		/*
		 ****************************************************************************************
		 * <승인 결과 파라미터 정의>
		 * 샘플페이지에서는 승인 결과 파라미터 중 일부만 예시되어 있으며,
		 * 추가적으로 사용하실 파라미터는 연동메뉴얼을 참고하세요.
		 ****************************************************************************************
		 */
		// 공통 파라미터
		String ResultCode = ""; String ResultMsg = ""; String PayMethod = "";
		String GoodsName = ""; String Amt = ""; String TID = "";
		String AuthCode = ""; String AuthDate = "";

		// 카드 결제 파라미터
		String CardCode	= "";
		String CardNo = "";
		String CardQuota = "";
		String CardInterest = "";

		// 계좌이체 파라미터
		String BankCode = ""; String BankName = ""; String RcpType = "";
		String RcptTID = ""; String RcptAuthCode = "";

		// 가상계좌 파라미터터
		String VbankBankCode = ""; String VbankBankName = ""; String VbankNum = "";
		String VbankExpDate = ""; String VbankExpTime = "";

		String merchantID = "";
		String merchantKey = "";
		
		String[] cartIds = StringUtils.split(CookieSessionUtil.getCookie("ordCartIds"), "|");
		
		OrderComplete ordComplete = null;
		try {
			ordComplete = orderService.getTempPayInfo(moid);
		} catch (Exception e) {
			throw new OrderException(ExceptionConstants.ERROR_PAY_NO_ORG_INFO);
		}

		ordComplete.setDefaultPayMethodSaveYn(StringUtils.defaultIfEmpty(CookieSessionUtil.getCookie("paySaveYn"), ""));
		ordComplete.setUseGsPoint(Long.parseLong(StringUtils.defaultIfEmpty(CookieSessionUtil.getCookie("useGsPoint"), "0")));
		

		try {

			if(CommonConstants.PAY_METHOD_CARD.equals(payMethod)&&StringUtils.equals(ordComplete.getPayMeansCd(), "10")){
	
				merchantID = authMerchantID;
				merchantKey = authMerchantKey;
	
			}else if(CommonConstants.PAY_METHOD_CARD.equals(payMethod)&&!StringUtils.equals(ordComplete.getPayMeansCd(), "10")){
	
				merchantID = easyPayMerchantID;
				merchantKey = easyPayMerchantKey;
	
			}else if(CommonConstants.PAY_METHOD_VBANK.equals(payMethod)){
	
				merchantID = authMerchantID;
				merchantKey = authMerchantKey;
	
			}else if(CommonConstants.PAY_METHOD_BANK.equals(payMethod)){
	
				merchantID = authMerchantID;
				merchantKey = authMerchantKey;
	
			}else{
	
				merchantID = unauthMerchantID;
				merchantKey = unauthMerchantID;
			}
		} catch (Exception e) {
			throw new OrderException(ExceptionConstants.ERROR_ORDER_NO_PAY);
		}

		ModelMap map = new ModelMap();

		// 위변조 CHECK
		String signature = sha256Enc.encrypt((authToken + mid + amt + merchantKey));

		if(signature.equals(responseSignature)){

			/*
			 ****************************************************************************************
			 * <인증 결과 성공시 승인 진행>
			 ****************************************************************************************
			 */
			String resultJsonStr = "";
			boolean paySuccess = false;

			if(authResultCode.equals("0000")){
				/*
				 ****************************************************************************************
				 * <해쉬암호화> (수정하지 마세요)
				 * SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
				 ****************************************************************************************
				 */

				String signData = sha256Enc.encrypt(authToken + merchantID + amt + ediDate + merchantKey);
				/*
				 ****************************************************************************************
				 * <승인 요청>
				 * 승인에 필요한 데이터 생성 후 server to server 통신을 통해 승인 처리 합니다.
				 ****************************************************************************************
				 */
				StringBuffer requestData = new StringBuffer();

				requestData.append("TID=").append(txTid).append("&");
				requestData.append("AuthToken=").append(authToken).append("&");
				requestData.append("MID=").append(mid).append("&");
				requestData.append("Amt=").append(amt).append("&");
				requestData.append("EdiDate=").append(ediDate).append("&");
				requestData.append("CharSet=").append("utf-8").append("&");
				requestData.append("SignData=").append(signData);
				
				logVO.setSysReqDtm(new Timestamp((new Date()).getTime())); // 요청일시
				resultJsonStr = connectToServer(requestData.toString(), nextAppURL);
				logVO.setSysResDtm(new Timestamp((new Date()).getTime())); // 승인일시

				// 로그
				logVO.setReqJson(requestData.toString()); // request
				logVO.setResJson(resultJsonStr);

				HashMap resultData = new HashMap();
				if("9999".equals(resultJsonStr)){
					logVO.setResCd("9999");
					logVO.setResMsg(ExceptionConstants.ERROR_PG_CONNECTION);
					/*
					 *************************************************************************************
					 * <망취소 요청>
					 * 승인 통신중에 Exception 발생시 망취소 처리를 권고합니다.
					 *************************************************************************************
					 */
					StringBuffer netCancelData = new StringBuffer();
					requestData.append("&").append("NetCancel=").append("1");
					
					// 망취소 요청 로그
					PayIfLogVO logVO2 = new PayIfLogVO();
					logVO2.setSysReqDtm(new Timestamp((new Date()).getTime())); // 요청일시
					String cancelResultJsonStr = connectToServer(requestData.toString(), netCancelURL);
					logVO2.setSysResDtm(new Timestamp((new Date()).getTime())); // 승인일시

					HashMap cancelResultData = jsonStringToHashMap(cancelResultJsonStr);
					ResultCode = (String)cancelResultData.get("ResultCode");
					ResultMsg = (String)cancelResultData.get("ResultMsg");
					
					// PG Log Insert
					try {
						payBaseService.insertPayIfLog(logVO);
						
						logVO2.setReqJson(requestData.toString());
						logVO2.setResJson(cancelResultJsonStr);
						logVO2.setResCd(ResultCode);
						logVO2.setResMsg(ResultMsg);
						logVO2.setOrdNo(moid); // 주문번호
						logVO2.setTid(txTid); // 트랜잭션 아이디
						
						payBaseService.insertPayIfLog(logVO2);
					} catch(Exception e) {
						log.debug("LOG 작성 오류");
					}
					throw new OrderException(ExceptionConstants.ERROR_PG_CONNECTION);
				}else{

					resultData = jsonStringToHashMap(resultJsonStr);

					try {
						ordComplete.setMbrNo(session.getMbrNo());
						ordComplete.setResultCode 	(resultData.get("ResultCode") + ""); 	// 결과코드 (정상 결과코드:3001)
						ordComplete.setResultMsg 	(resultData.get("ResultMsg") + "");	    // 결과메시지
						ordComplete.setPayMethod 	(resultData.get("PayMethod") + "");	    // 결제수단
						ordComplete.setGoodsName    (resultData.get("GoodsName") + "");	    // 상품명
						ordComplete.setAmt       	(MapUtils.getLongValue(resultData, "Amt"));		    // 결제 금액
						ordComplete.setMoid(moid); // moid
						ordComplete.setTid       	(resultData.get("TID") + "");		    // 거래번호
						ordComplete.setAuthCode		(resultData.get("AuthCode") + "");		// 승인번호
						ordComplete.setAuthDate		(resultData.get("AuthDate") + "");		// 승인날짜
						ordComplete.setCardCode		(resultData.get("CardCode") + "");		// 카드사
						ordComplete.setCardQuota	(resultData.get("CardQuota") + "");      // 할부개월
						ordComplete.setCardNo		(resultData.get("CardNo") + "");         // 카드번호 마스킹처리 제거 (카드번호 길이 변동성(카카오페이, 아멕스카드 등)으로 앞단에서 처리)
						ordComplete.setCardInterest	(resultData.get("CardInterest") + "");   // 무이자여부
						ordComplete.setBankCode		(resultData.get("BankCode") + "");		// 결제은행 코드
						ordComplete.setBankName		(resultData.get("BankName") + "");		// 결제은행 명
						ordComplete.setRcpType		(resultData.get("RcptType") + "");		// 현금영수증 타입
						ordComplete.setRcptTID		(resultData.get("RcptTID") + "");		// 현금영수증 TID
						ordComplete.setRcptAuthCode	(resultData.get("RcptAuthCode") + "");		// 현금영수증 승인번호
						ordComplete.setVbankBankCode(resultData.get("VbankBankCode") + "");		// 결제은행 코드(가상계좌)
						ordComplete.setVbankBankName(resultData.get("VbankBankName") + "");		// 결제은행 명(카상계좌)
						ordComplete.setVbankNum		(resultData.get("VbankNum") + "");		    // 가상계좌 번호
						ordComplete.setVbankExpDate	(resultData.get("VbankExpDate") + "");		// 가상계좌 입금 만료일
						ordComplete.setVbankExpTime	(resultData.get("VbankExpTime") + "");		// 가상계좌 입금 만료시간
						ordComplete.setLnkRspsRst(resultJsonStr);
						
						/**
						 * 이 부분은 확인해 본 이후 삭제처리
						 */
						ResultCode 	= resultData.get("ResultCode") + ""; 	// 결과코드 (정상 결과코드:3001)
						ResultMsg 	= resultData.get("ResultMsg") + "";	    // 결과메시지
						PayMethod 	= resultData.get("PayMethod") + "";	    // 결제수단
						GoodsName   = resultData.get("GoodsName") + "";	    // 상품명
						Amt       	= resultData.get("Amt") + "";		    // 결제 금액
						TID       	= resultData.get("TID") + "";		    // 거래번호
						AuthCode    = resultData.get("AuthCode") + "";		// 승인번호
						AuthDate    = resultData.get("AuthDate") + "";		// 승인날짜
						CardCode    = resultData.get("CardCode") + "";		// 카드사
						CardQuota   = resultData.get("CardQuota") + "";      // 할부개월
						CardNo      = resultData.get("CardNo") + "";         // 카드번호
						CardInterest = resultData.get("CardInterest") + "";   // 무이자여부
						BankCode    = resultData.get("BankCode") + "";		// 결제은행 코드
						BankName    = resultData.get("BankName") + "";		// 결제은행 명
						RcpType     = resultData.get("RcptType") + "";		// 현금영수증 타입
						RcptTID     = resultData.get("RcptTID") + "";		// 현금영수증 TID
						RcptAuthCode     = resultData.get("RcptAuthCode") + "";		// 현금영수증 승인번호
						VbankBankCode    = resultData.get("VbankBankCode") + "";		// 결제은행 코드(가상계좌)
						VbankBankName    = resultData.get("VbankBankName") + "";		// 결제은행 명(카상계좌)
						VbankNum         = resultData.get("VbankNum") + "";		    // 가상계좌 번호
						VbankExpDate     = resultData.get("VbankExpDate") + "";		// 가상계좌 입금 만료일
						VbankExpTime     = resultData.get("VbankExpTime") + "";		// 가상계좌 입금 만료시간
					} catch (Exception e) {
						throw new OrderException(ExceptionConstants.ERROR_ORDER_NO_PAY);
					}
					
					/*
					 *************************************************************************************
					 * <결제 성공 여부 확인>
					 *************************************************************************************
					 */
					if(ordComplete.getPayMethod() != null){
						if(ordComplete.getPayMethod().equals("CARD")){
							if(ordComplete.getResultCode().equals("3001")) {paySuccess = true;} // 신용카드(정상 결과코드:3001)
						}else if(ordComplete.getPayMethod().equals("BANK")) {
							if (ordComplete.getResultCode().equals("4000")) {paySuccess = true;} // 계좌이체(정상 결과코드:4000)
						}else if(ordComplete.getPayMethod().equals("VBANK")){
							if(ordComplete.getResultCode().equals("4100")) {paySuccess = true;} // 가상계좌(정상 결과코드:4100)
						}
					}

					logVO.setResCd(ordComplete.getResultCode());
					logVO.setResMsg(ordComplete.getResultMsg());
					
					// PG Log Insert
					try {
						payBaseService.insertPayIfLog(logVO);
					} catch(Exception e) {
						log.debug("LOG 작성 오류");
					}

					if (paySuccess) {
						/*String strId = webConfig.getProperty("inipay.str.id");

						ordComplete.setStrId(strId);*/

						/********************************
						 * 주문완료 호출
						 *******************************/
						this.orderService.insertOrderComplete(ordComplete);

						/********************************
						 * 기본결제수단 저장
						 *******************************/

						if(CommonConstants.COMM_YN_Y.equals(ordComplete.getDefaultPayMethodSaveYn())){

							PrsnPaySaveInfoPO ppsipo = new PrsnPaySaveInfoPO();

							ppsipo.setMbrNo(ordComplete.getMbrNo());
							ppsipo.setCardcCd(ordComplete.getCardcCd());
							ppsipo.setPayMeansCd(ordComplete.getPayMeansCd());

							orderService.saveDefaultPayMethod(ppsipo);
						}


						/***********************************************
						 * 주문 이메일/SMS 전송
						 ***********************************************/
						//this.orderSendService.sendOrderInfo(ordComplete.getOrdNo());

						/******************************
						 * 장바구니 삭제
						 *****************************/

						try {
							
							this.cartService.deleteCart(cartIds);
	

							CookieSessionUtil.createCookie("ordCartIds", null);
							CookieSessionUtil.createCookie("paySaveYn", null);
							
						}catch(Exception ex) {
							// 보안성 진단. 오류메시지를 통한 정보노출
							//ex.printStackTrace();
							log.error("NicepayController deleteCart Exception", ex.getClass());
						}

						/********************************
						 * 주문관련 세션 삭제
						 *******************************/
						CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_TYPE, null);
						CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS, null);
						CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS, null);
						CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_YN, null);

					} else {
						throw new OrderException(ExceptionConstants.ERROR_PG_FAIL);
					}
				}
			}else{
				ordComplete.setResultCode(authResultCode);
				// 사용자가 결제 취소시 메시지만 별도 처리
				// 9991 인증이 취소 되었거나 실패하였습니다.
				// 9993 사용자가 인증을 취소 하였습니다.
				// 9994 인증이 취소되었거나 실패하였습니다.다시 시도하여 주십시요.
				ResultCode = authResultCode;
				if(StringUtils.equals(ResultCode, "9993") || StringUtils.equals(ResultCode, "9991") || StringUtils.equals(ResultCode, "9994")) {
					ordComplete.setResultMsg(ExceptionConstants.ERROR_PG_CANCEL);
					ResultMsg = message.getMessage("business.exception.PAY0009");
				} else {
					ordComplete.setResultMsg(authResultMsg);
					ResultMsg = message.getMessage("business.exception.PAY0009");
				}
				
				logVO.setSysReqDtm(new Timestamp((new Date()).getTime())); // 요청일시
				logVO.setResCd(ordComplete.getResultCode());
				logVO.setResMsg(ordComplete.getResultMsg());
				// PG Log Insert
				try {
					payBaseService.insertPayIfLog(logVO);
				} catch(Exception e) {
					log.debug("LOG 작성 오류");
				}
			}

			// 임시로 map에 넣은 data
			map.put("resultCode", ResultCode);
			map.put("resultMsg", ResultMsg);
			map.put("payMethod", PayMethod);
			map.put("goodsName", GoodsName);
			map.put("amt", Amt);
			map.put("tid", TID);
			map.put("authCode", AuthCode);
			map.put("authDate", AuthDate);
			map.put("cardCode", CardCode);
			map.put("cardNo", CardNo);
			map.put("cardQuota", CardQuota);
			map.put("cardInterest", CardInterest);
			map.put("bankCode", BankCode);
			map.put("bankName", BankName);
			map.put("rcpType", RcpType);
			map.put("rcptTID", RcptTID);
			map.put("rcptAuthCode", RcptAuthCode);
			map.put("vbankBankCode", VbankBankCode);
			map.put("vbankBankName", VbankBankName);
			map.put("vbankNum", VbankNum);
			map.put("vbankExpDate", VbankExpDate);
			map.put("vbankExpTime", VbankExpTime);
			map.put("paySuccess", paySuccess);

		} else {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_PAY_APPROVE_FAIL);
		}
		return map;
	}
	@LoginCheck
	@ResponseBody
	@RequestMapping(value = "getBillingRegistSignData")
	public ModelMap getBillingRegistSignData(BillingRegist billRegist) {

		DataEncrypt sha256Enc = new DataEncrypt();
		String ediDate = getyyyyMMddHHmmss();
		String merchantID = unauthMerchantID;
		String merchantKey = unauthMerchantKey;
		String moid = UUID.randomUUID().toString().replaceAll("-","");
		String hashString = sha256Enc.encrypt(merchantID + ediDate + moid + merchantKey);

		// 카드 정보 암호화
		StringBuffer encDataBuf = new StringBuffer();

		encDataBuf.append("CardNo=").append(billRegist.getCardNo()).append("&");
		encDataBuf.append("ExpYear=").append(billRegist.getExpYear()).append("&");
		encDataBuf.append("ExpMonth=").append(billRegist.getExpMonth()).append("&");
		encDataBuf.append("IDNo=").append(billRegist.getIDNo()).append("&");
		encDataBuf.append("CardPw=").append(billRegist.getCardPw());

		String encData = encryptAES(encDataBuf.toString(), merchantKey.substring(0,16));

		ModelMap map = new ModelMap();

		map.put("moid", moid);
		map.put("ediDate", ediDate);
		map.put("signData", hashString);
		map.put("mid", merchantID);
		map.put("encData", encData);

		return map;
	}

	@LoginCheck
	@ResponseBody
	@RequestMapping(value = "registNicepayBilling")
	public ModelMap registNicepayBilling(BillingRegist billRegist, Session session, HttpServletRequest request) throws Exception {

		StringBuffer requestData = new StringBuffer();

		requestData.append("MID=").append(billRegist.getMID()).append("&");
		requestData.append("EdiDate=").append(billRegist.getEdiDate()).append("&");
		requestData.append("Moid=").append(billRegist.getMoid()).append("&");
		requestData.append("EncData=").append(billRegist.getEncData()).append("&");
		requestData.append("SignData=").append(billRegist.getSignData()).append("&");
		requestData.append("BuyerName=").append(URLEncoder.encode(billRegist.getBuyerName(), "euc-kr")).append("&");
		requestData.append("BuyerEmail=").append(billRegist.getBuyerEmail()).append("&");
		requestData.append("BuyerTel=").append(billRegist.getBuyerTel()).append("&");
		requestData.append("CharSet=").append("utf-8").append("&");
		requestData.append("EdiType=").append(billRegist.getEdiType());

		String resultJsonStr = connectToServer(requestData.toString(), billingRegistUrl);

		log.debug("==================================================================");
		log.debug("NICEPAY : BILLING REGIST RESULT: {} ", resultJsonStr);
		log.debug("==================================================================");

		String ResultCode 	= ""; // 결과 코드
		String ResultMsg 	= ""; // 결과 메시지
		String TID = "";
		String BID = "";
		String AuthDate = "";
		String CardCode = "";
		String CardName = "";
		String CardCl = "";
		String AcquCardCode = "";
		String AcquCardName = "";

		HashMap resultData = new HashMap();
		ModelMap map = new ModelMap();

		if(!"ERROR".equals(resultJsonStr)){

			resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode 	= (String)resultData.get("ResultCode");
			ResultMsg 	= (String)resultData.get("ResultMsg");

			if(CommonConstants.NICEPAY_BILLING_REGIST_SUCCESS.equals(ResultCode)) {

				// 빌링 응답 data
				TID 	= (String)resultData.get("TID");
				BID 	= (String)resultData.get("BID");
				AuthDate 	= (String)resultData.get("AuthDate");
				CardCode 	= (String)resultData.get("CardCode");
				CardName 	= (String)resultData.get("CardName");
				CardCl 	= (String)resultData.get("CardCl");
				AcquCardCode 	= (String)resultData.get("AcquCardCode");
				AcquCardName 	= (String)resultData.get("AcquCardName");
				
				// CSR-1723 2021-09-08
				if(StringUtil.equals(CardCode, "16")) {
					CardCode = CardCode.replace(CardCode, "03");
					CardName = "[" + this.cacheService.getCodeName(CommonConstants.CARDC, CardCode) + "]";
					AcquCardCode = CardCode.replace(CardCode, "03");
					AcquCardName = "[" + this.cacheService.getCodeName(CommonConstants.CARDC, CardCode) + "]";
				}

				PrsnCardBillingInfoPO pcbipo = new PrsnCardBillingInfoPO();

				pcbipo.setMbrNo(session.getMbrNo());
				pcbipo.setPgMoid(billRegist.getMoid());
				pcbipo.setPrsnCardBillNo(Integer.parseInt(billRegist.getPrsnCardBillNo()));
				pcbipo.setPgTid(TID);
				pcbipo.setPgBid(BID);
				pcbipo.setPgAuthDate(AuthDate);
				pcbipo.setPgCardCode(CardCode);
				pcbipo.setPgCardName(CardName);
				pcbipo.setPgCardCl(CardCl);
				pcbipo.setPgAcquCardCode(AcquCardCode);
				pcbipo.setPgAcquCardName(AcquCardName);

				log.debug("==================================================");
				log.debug("빌링 정보 저장 DATA : {} ", pcbipo);
				log.debug("==================================================");

				orderService.updateRegistBillCard(pcbipo);
				
				map.put("cardcNm", this.cacheService.getCodeName(CommonConstants.CARDC, CardCode));

			}
			map.put("resultCode", ResultCode);
			map.put("resultMsg", ResultMsg);

		}else{
			throw new CustomException(ExceptionConstants.ERROR_REQUEST);
		}

		return map;
	}


	@ResponseBody
	@RequestMapping(value = "getBillingSignData")
	public ModelMap getBillingSignData(Session session, @RequestParam(value="prsnCardBillNo") String prsnCardBillNo, @RequestParam(value="payAmt") String payAmt, @RequestParam(value="moid") String moid) throws Exception {

		String ediDate = getyyyyMMddHHmmss();
		String merchantID = unauthMerchantID;
		String merchantKey = unauthMerchantKey;
		DataEncrypt sha256Enc = new DataEncrypt();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		String TID = unauthMerchantID + CommonConstants.NICEPAY_BILLING_PAY_METHOD + CommonConstants.NICEPAY_BILLING_MDA + sdf.format(now) + StringUtil.randomNumeric(4);
		String BID = orderService.getBillingKey(prsnCardBillNo);
		String hashString = sha256Enc.encrypt(merchantID + ediDate + moid + payAmt + BID + merchantKey);

		ModelMap map = new ModelMap();

		map.put("ediDate",ediDate);
		map.put("signData", hashString);
		map.put("mid", merchantID);
		map.put("tid", TID);

		return map;
	}

	@LoginCheck
	@RequestMapping(value = "indexNicepayBillingResult")
	@ResponseBody
	public ModelMap indexNicepayBillingResult(Session session, HttpServletRequest request, HttpServletResponse response) throws Exception {

		//request.setCharacterEncoding("utf-8");

		return nicepayBillingResult(request, response, session);
	}

	public ModelMap nicepayBillingResult(HttpServletRequest request, HttpServletResponse response, Session session) throws Exception {

		PayIfLogVO logVO = new PayIfLogVO();
		
		String moid 			= (String)request.getParameter("Moid"); 			        // 상점 주문번호
		String amt 				= (String)request.getParameter("Amt"); 				    // 결제 금액
		String goodsNms         = (String)request.getParameter("GoodsName");
		//String cardInterest     = "0"; // 간편결제 가맹점 분담 무이자 사용 여부 확인 해야함
		String cardInterest     = (String)request.getParameter("CardInterest");
		String cardQuota        = (String)request.getParameter("halbu");
		String cardPoint        = "0"; // 간편결제 카드 포인트 사용여부 확인 해야함
		/*String cardPoint        = (String)request.getParameter("CardPoint");*/
		String buyerName        = (String)request.getParameter("BuyerName");
		String buyerEmail       = (String)request.getParameter("BuyerEmail");
		String buyerTel         = (String)request.getParameter("BuyerTel");
		String ediType          = (String)request.getParameter("EdiType");
		String prsnCardBillNo   = (String)request.getParameter("prsnCardBillNo");
		String BID              = orderService.getBillingKey(prsnCardBillNo);

		String merchantID = unauthMerchantID;
		String merchantKey = unauthMerchantKey;
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String ediDate			= getyyyyMMddHHmmss();
		String resultJsonStr = "";
		String cancelResultStr = "";
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		String TID 	= unauthMerchantID + CommonConstants.NICEPAY_BILLING_PAY_METHOD + CommonConstants.NICEPAY_BILLING_MDA + sdf.format(now) + StringUtil.randomNumeric(4); 			    // 거래 ID
		String signData = sha256Enc.encrypt(merchantID + ediDate + moid + amt + BID + merchantKey);

		// 공통 파라미터
		String ResultCode = ""; String ResultMsg = ""; String PayMethod = "";
		String GoodsName = ""; String Amt = "";
		String AuthCode = ""; String AuthDate = "";

		// 카드 결제 파라미터
		String CardCode	= "";
		String CardNo = "";
		String CardQuota = "";
		String CardInterest = "";

		ModelMap map = new ModelMap();

		StringBuffer requestData = new StringBuffer();

		requestData.append("TID=").append(TID).append("&");
		requestData.append("BID=").append(BID).append("&");
		requestData.append("MID=").append(merchantID).append("&");
		requestData.append("EdiDate=").append(ediDate).append("&");
		requestData.append("Moid=").append(moid).append("&");
		requestData.append("Amt=").append(amt).append("&");
		requestData.append("GoodsName=").append(URLEncoder.encode(goodsNms, "euc-kr")).append("&");
		requestData.append("CardInterest=").append(cardInterest).append("&");
		requestData.append("CardQuota=").append(cardQuota).append("&");
		requestData.append("CardPoint=").append(cardPoint).append("&");
		requestData.append("SignData=").append(signData).append("&");
		requestData.append("BuyerName=").append(URLEncoder.encode(buyerName, "euc-kr")).append("&");
		requestData.append("BuyerEmail=").append(buyerEmail).append("&");
		requestData.append("BuyerTel=").append(buyerTel).append("&");
		requestData.append("CharSet=").append("utf-8").append("&");
		requestData.append("EdiType=").append(ediType);

		// log 기본정보
		logVO.setOrdNo(moid); // 주문번호
		logVO.setTid(TID); // 트랜잭션 아이디
		
		logVO.setSysReqDtm(new Timestamp((new Date()).getTime())); // 요청일시
		resultJsonStr = connectToServer(requestData.toString(), billingPaymentUrl);
		logVO.setSysResDtm(new Timestamp((new Date()).getTime())); // 승인일시
		
		// 로그
		logVO.setReqJson(requestData.toString()); // request
		logVO.setResJson(resultJsonStr);

		log.debug("==================================================================");
		log.debug("NICEPAY : BILLING SUCCESS RESULT: {} ", resultJsonStr);
		log.debug("==================================================================");


		HashMap resultData = new HashMap();
		boolean isSuccess = false;

		if("ERROR".equals(resultJsonStr)){
			logVO.setResCd("9999");
			logVO.setResMsg(ExceptionConstants.ERROR_PG_CONNECTION);
			/*
			 *************************************************************************************
			 * <망취소 요청>
			 * 승인 통신중에 Exception 발생시 망취소 처리를 권고합니다.
			 *************************************************************************************
			 */
			cancelResultStr = cancelProcess(TID, unauthMerchantID, moid, amt, ediDate, ediType);

			HashMap cancelResultData = jsonStringToHashMap(cancelResultStr);
			ResultCode = (String)cancelResultData.get("ResultCode");
			ResultMsg = (String)cancelResultData.get("ResultMsg");
			// PG Log Insert
			try {
				payBaseService.insertPayIfLog(logVO);
			} catch(Exception e) {
				log.debug("LOG 작성 오류");
			}
			throw new OrderException(ExceptionConstants.ERROR_PG_CONNECTION);

		}else {

			HttpSession dataSession = request.getSession();
			
			OrderComplete ordComplete = null;
			try {
				ordComplete = orderService.getTempPayInfo(moid);
			} catch (Exception e) {
				throw new OrderException(ExceptionConstants.ERROR_PAY_NO_ORG_INFO);
			}
			// 쿠키 내용 변수에 입력
			String[] cartIds = StringUtils.split(CookieSessionUtil.getCookie("ordCartIds"), "|");
			ordComplete.setPrsnCardBillNo(StringUtils.defaultIfEmpty(CookieSessionUtil.getCookie("prsnBi"), ""));
			ordComplete.setDefaultPayMethodSaveYn(StringUtils.defaultIfEmpty(CookieSessionUtil.getCookie("paySaveYn"), ""));
			ordComplete.setUseGsPoint(Long.parseLong(StringUtils.defaultIfEmpty(CookieSessionUtil.getCookie("useGsPoint"), "0")));
			
			resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode = (String)resultData.get("ResultCode");
			ResultMsg = (String)resultData.get("ResultMsg");

			if(CommonConstants.NICEPAY_BILLING_PAYMENT_SUCCESS.equals(ResultCode)) { //승인 성공
				isSuccess = true;
				ordComplete.setMbrNo(session.getMbrNo());
				ordComplete.setResultCode((String) resultData.get("ResultCode"));    // 결과코드 (정상 결과코드:3001)
				ordComplete.setResultMsg((String) resultData.get("ResultMsg"));        // 결과메시지
				ordComplete.setAmt(MapUtils.getLongValue(resultData, "Amt"));            // 결제 금액
				ordComplete.setMoid(moid); // moid
				ordComplete.setTid((String) resultData.get("TID"));            // 거래번호
				ordComplete.setAuthCode((String) resultData.get("AuthCode"));        // 승인번호
				ordComplete.setAuthDate((String) resultData.get("AuthDate"));        // 승인날짜
				ordComplete.setCardCode((String) resultData.get("CardCode"));        // 카드사
				ordComplete.setCardQuota((String) resultData.get("CardQuota"));      // 할부개월
				ordComplete.setHalbu((String) resultData.get("CardQuota"));      // 할부개월
				ordComplete.setCardNo((String) resultData.get("CardNo"));         // 카드번호
				ordComplete.setCardInterest((String) resultData.get("CardInterest"));   // 무이자여부
				ordComplete.setPrsnCardBillNo(prsnCardBillNo);
				ordComplete.setLnkRspsRst(resultJsonStr);

				// 변경된 데이터 세션에 반영 (오류시 취소를 위해)
				dataSession.setAttribute("ordComplete", ordComplete);

				/**
				 * 이 부분은 확인해 본 이후 삭제처리
				 */
				ResultCode = (String) resultData.get("ResultCode");    // 결과코드 (정상 결과코드:3001)
				ResultMsg = (String) resultData.get("ResultMsg");        // 결과메시지
				PayMethod = (String) resultData.get("PayMethod");        // 결제수단
				GoodsName = (String) resultData.get("GoodsName");        // 상품명
				Amt = (String) resultData.get("Amt");            // 결제 금액
				TID = (String) resultData.get("TID");            // 거래번호
				AuthCode = (String) resultData.get("AuthCode");        // 승인번호
				AuthDate = (String) resultData.get("AuthDate");        // 승인날짜
				CardCode = (String) resultData.get("CardCode");        // 카드사
				CardQuota = (String) resultData.get("CardQuota");      // 할부개월
				CardNo = (String) resultData.get("CardNo");         // 카드번호
				CardInterest = (String) resultData.get("CardInterest");   // 무이자여부

				/*
				 *************************************************************************************
				 * <결제 성공 여부 확인>
				 *************************************************************************************
				 */
			}else{	//승인 실패
				isSuccess = false;
				//TODO 실패 이후 프로세스 구현.
			}

			logVO.setResCd(ordComplete.getResultCode());
			logVO.setResMsg(ordComplete.getResultMsg());

			// PG Log Insert
			try {
				payBaseService.insertPayIfLog(logVO);
			} catch(Exception e) {
				log.debug("LOG 작성 오류");
			}

			if (isSuccess) {

				/********************************
				 * 간편결제 비밀번호 초기화
				 *******************************/
				PrsnCardBillingInfoPO pcbipo = new PrsnCardBillingInfoPO();

				pcbipo.setResetYn(CommonConstants.COMM_YN_Y);
				pcbipo.setMbrNo(ordComplete.getMbrNo());

				orderService.resetInputFailCnt(pcbipo);

				/********************************
				 * 주문완료 호출
				 *******************************/
				this.orderService.insertOrderComplete(ordComplete);

				/********************************
				 * 기본결제수단 저장
				 *******************************/

				if (CommonConstants.COMM_YN_Y.equals(ordComplete.getDefaultPayMethodSaveYn())) {

					PrsnPaySaveInfoPO ppsipo = new PrsnPaySaveInfoPO();

					ppsipo.setMbrNo(ordComplete.getMbrNo());
					ppsipo.setCardcCd(ordComplete.getCardCode());
					ppsipo.setPrsnCardBillNo(ordComplete.getPrsnCardBillNo());
					ppsipo.setPayMeansCd(ordComplete.getPayMeansCd());

					orderService.saveDefaultPayMethod(ppsipo);
				}


				/***********************************************
				 * 주문 이메일/SMS 전송
				 ***********************************************/
				//this.orderSendService.sendOrderInfo(ordComplete.getOrdNo());

				/******************************
				 * 장바구니 삭제
				 *****************************/

				this.cartService.deleteCart(cartIds);

				// 쿠키 삭제
				CookieSessionUtil.createCookie("ordCartIds", null);
				CookieSessionUtil.createCookie("prsnBi", null);
				CookieSessionUtil.createCookie("paySaveYn", null);
				CookieSessionUtil.createCookie("useGsPoint", null);

//				/********************************
//				 * 최초 주문 감사 쿠폰 지급 - 2021.03.29, by kek01 --> 결재시 쿠폰지급이 아니라 구매확정시 쿠폰지급으로 변경되어 주석처리함 - 2021.05.03, by kek01
//				 *******************************/
//				try {
//					log.debug("################### 최초 주문 감사 쿠폰 지급 START");
//					this.orderService.giveFirstOrderThanksCoupon(ordComplete);
//					log.debug("################### 최초 주문 감사 쿠폰 지급 END");
//				} catch (Exception ex) {
//					// 보안성 진단. 오류메시지를 통한 정보노출
//					//ex.printStackTrace();
//					log.error("NicepayController giveFirstOrderThanksCoupon Exception", ex.getClass());
//				}

				/********************************
				 * 주문관련 세션 삭제
				 *******************************/
				CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_TYPE, null);
				CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_IDS, null);
				CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS, null);
				CookieSessionUtil.createCookie(FrontWebConstants.SESSION_ORDER_PARAM_CART_YN, null);

			} else {
				throw new OrderException(ExceptionConstants.ERROR_PG_FAIL);
			}
		}

		// 임시로 map에 넣은 data
		map.put("resultCode", ResultCode);
		map.put("resultMsg", ResultMsg);
		map.put("payMethod", PayMethod);
		map.put("goodsName", GoodsName);
		map.put("amt", Amt);
		map.put("tid", TID);
		map.put("authCode", AuthCode);
		map.put("authDate", AuthDate);
		map.put("cardCode", CardCode);
		map.put("cardNo", CardNo);
		map.put("cardQuota", CardQuota);
		map.put("cardInterest", CardInterest);

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-front
	 * - 작성일		: 2021. 01. 14.
	 * - 작성자		: JinHong
	 * - 설명		: NICE PAY 현금영수증 승인 요청
	 * </pre>
	 * @param reqVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("reqCashReceipt")
	public ModelMap reqCashReceipt(Session session, CashReceiptReqVO reqVO, PrsnPaySaveInfoPO po) {
		ModelMap map = new ModelMap();

		Long payAmt = Long.parseLong(reqVO.getReceiptAmt());
		Long staxAmt = Math.round(payAmt.doubleValue() / 1.1 * 0.1);
		Long splAmt = payAmt - staxAmt;
		Long srvcAmt = 0L;
		reqVO.setReceiptSupplyAmt(splAmt.toString());
		reqVO.setReceiptVAT(staxAmt.toString());

		CashReceiptResVO res =  nicePayCashReceiptService.reqCashReceipt(reqVO);
		map.addAttribute("res", res);

		//CASH_RECEIPT INSERT
		CashReceiptPO cashReceiptPo = new CashReceiptPO();
		cashReceiptPo.setCashRctNo(bizService.getSequence(AdminConstants.SEQUENCE_CASH_RCT_NO_SEQ));
		cashReceiptPo.setCrTpCd("10"); //발행요청
		cashReceiptPo.setCashRctStatCd("20");//발행
		cashReceiptPo.setUseGbCd("1".equals(reqVO.getReceiptType())?"10":"20"); // 10:소득공제, 20:지출증빙
		cashReceiptPo.setIsuMeansCd("1".equals(reqVO.getReceiptType())?"20":"30");// 20:휴대폰번호, 30:사업자등록번호
		cashReceiptPo.setIsuMeansNo(reqVO.getReceiptTypeNo());
		cashReceiptPo.setIsuGbCd("20");//10:자동 20:수동
		cashReceiptPo.setPayAmt(payAmt);
		cashReceiptPo.setSplAmt(splAmt);
		cashReceiptPo.setStaxAmt(staxAmt);
		cashReceiptPo.setSrvcAmt(srvcAmt);
		cashReceiptPo.setStrId(reqVO.getMID());
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
			SimpleDateFormat orgFormat = new SimpleDateFormat("yyMMddhhmmss");
			Date parsedDate = orgFormat.parse(res.getAuthDate());
			Date autoDate = dateFormat.parse(dateFormat.format(parsedDate));
			cashReceiptPo.setLnkDtm(new java.sql.Timestamp(autoDate.getTime()));
		} catch(Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		cashReceiptPo.setLnkDealNo(res.getTID());
		cashReceiptPo.setLnkRstMsg(res.toString());
		cashReceiptPo.setSysRegrNo(session.getMbrNo());
		cashReceiptPo.setCfmRstCd(res.getResultCode());
		cashReceiptPo.setCfmRstMsg(res.getResultMsg());
		cashReceiptPo.setOrdClmNo(reqVO.getMoid());
//		cashReceiptPo.setOrdClmDtlSeq(ordClmDtlSeq); //찾아서 set 해줘야됨
		cashReceiptService.cashReceiptInsert(cashReceiptPo);

		/**
		 * 신청정보 저장
		 */
		po.setMbrNo(session.getMbrNo());
		if(StringUtils.equals(po.getCashRctSaveYn(), "Y")) {
			po.setCashRctGbType(cashReceiptPo.getUseGbCd()); // 현금 영수증 용도
			po.setCashRctGbCd(cashReceiptPo.getIsuMeansCd()); // 현금 영수증 구분 코드
			po.setCashRctGbVal(cashReceiptPo.getIsuMeansNo()); // 현금 영수증 구분 값
		}
		orderService.saveCashReceiptSaveInfo(po);
		return map;
	}

	//취소
	public String cancelProcess(String tid, String mid, String moid, String cancelAmt, String ediDate, String ediType){

		String merchantKey = unauthMerchantKey;
		String resultJsonStr = "ERROR";
		try{
			DataEncrypt sha256Enc 	= new DataEncrypt();
			String signData 		= sha256Enc.encrypt(mid + cancelAmt + ediDate + merchantKey);

			StringBuffer requestData = new StringBuffer();
			requestData.append("TID=").append(tid).append("&");
			requestData.append("MID=").append(mid).append("&");
			requestData.append("Moid=").append(moid).append("&");
			requestData.append("CancelAmt=").append(cancelAmt).append("&");
			requestData.append("CancelMsg=").append(URLEncoder.encode("취소 사유 입력", "euc-kr")).append("&");
			requestData.append("PartialCancelCode=").append("0").append("&");
			requestData.append("EdiDate=").append(ediDate).append("&");
			requestData.append("CharSet=").append("utf-8").append("&");
			requestData.append("SignData=").append(signData).append("&");
			requestData.append("EdiType=").append(ediType);

			resultJsonStr = connectToServer(requestData.toString(), nicepayCancelUrl);

		}catch(Exception e){
			resultJsonStr = "ERROR";
		}
		return resultJsonStr;
	}

	@ResponseBody
	@RequestMapping(value = "removeBillingCard")
	public ModelMap removeBillingCard(@RequestParam("prsnCardBillNo") int prsnCardBillNo, Session session, HttpServletRequest request) throws Exception {

		PrsnCardBillingInfoPO pcbipo = new PrsnCardBillingInfoPO();

		pcbipo.setMbrNo(session.getMbrNo());
		pcbipo.setPrsnCardBillNo(prsnCardBillNo);

		PrsnCardBillingInfoVO cardBillInfo = memberService.getBillCardInfo(pcbipo);

		int registCardCnt = cardBillInfo.getRegistCardCnt();
		String merchantID = unauthMerchantID;
		String merchantKey = unauthMerchantKey;
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String ediDate			= getyyyyMMddHHmmss();
		String moid = cardBillInfo.getPgMoid();
		String bid = cardBillInfo.getPgBid();
		String hashString = sha256Enc.encrypt(merchantID + ediDate + moid + bid + merchantKey);


		StringBuffer requestData = new StringBuffer();

		requestData.append("BID=").append(cardBillInfo.getPgBid()).append("&");
		requestData.append("MID=").append(merchantID).append("&");
		requestData.append("EdiDate=").append(ediDate).append("&");
		requestData.append("Moid=").append(cardBillInfo.getPgMoid()).append("&");
		requestData.append("SignData=").append(hashString).append("&");
		requestData.append("CharSet=").append("utf-8").append("&");
		requestData.append("EdiType=").append("JSON");

		String resultJsonStr = connectToServer(requestData.toString(), billingDeleteUrl);

		log.debug("==================================================================");
		log.debug("NICEPAY : BILLING DELETE RESULT: {} ", resultJsonStr);
		log.debug("==================================================================");

		String ResultCode 	= ""; // 결과 코드
		String ResultMsg 	= ""; // 결과 메시지
		HashMap resultData = new HashMap();
		ModelMap map = new ModelMap();

		if(!"ERROR".equals(resultJsonStr)){

			resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode 	= (String)resultData.get("ResultCode");
			ResultMsg 	= (String)resultData.get("ResultMsg");

			// 삭제 성공
			if(CommonConstants.NICEPAY_BILLING_DELETE_SUCCESS.equals(ResultCode)) {

				// 빌링 정보 update > data 삭제로 변경 2021.04.14(지종근차장 요청사항 : 유준희실장 confirm)
				PrsnCardBillingInfoPO delpo = new PrsnCardBillingInfoPO();

				delpo.setPrsnCardBillNo(prsnCardBillNo);
				delpo.setMbrNo(session.getMbrNo());

				orderService.deleteBillCardInfo(delpo);

				// 삭제한 카드가 기본결제수단일때 기본결제수단 TABLE DATA 삭제 처리
				PrsnPaySaveInfoVO ppsivo =  memberService.getMemberPaySaveInfo(session.getMbrNo());

				if(ppsivo != null){
					if(ppsivo.getPayMeansCd() != null && !"".equals(ppsivo.getPayMeansCd())){
						if(CommonConstants.PAY_MEANS_11.equals(ppsivo.getPayMeansCd())){


							if(prsnCardBillNo == pcbipo.getPrsnCardBillNo()){

								memberService.deletePrsnSavePayInfo(session.getMbrNo());
							}

						}
					}
				}

				// 모든 카드가 삭제 되었다면 member_base 간편카드 인증 비밀번호 초기화
				if(registCardCnt == 1){

					MemberBasePO mbpo = new MemberBasePO();

					mbpo.setRemoveBillYn(CommonConstants.COMM_YN_Y);
					mbpo.setMbrNo(session.getMbrNo());

					memberService.updateMemberBase(mbpo);
				}

				map.put("resultCode", ResultCode);
				map.put("resultMsg", ResultMsg);

			}else{

				// 삭제 실패
				map.put("resultCode", ResultCode);
				map.put("resultMsg", ResultMsg);

			}

		}else{
			throw new CustomException(ExceptionConstants.ERROR_REQUEST);
		}

		return map;
	}

	public final synchronized String getyyyyMMddHHmmss(){
		SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		return yyyyMMddHHmmss.format(new Date());
	}

	// SHA-256 형식으로 암호화
	public static class DataEncrypt{
		MessageDigest md;
		String strSRCData = "";
		String strENCData = "";
		String strOUTData = "";

		public String encrypt(String strData){
			String passACL = null;
			MessageDigest md = null;
			try{
				md = MessageDigest.getInstance("SHA-256");
				md.reset();
				md.update(strData.getBytes());
				byte[] raw = md.digest();
				passACL = encodeHex(raw);
			}catch(Exception e){
				// 보안성 진단. 오류메시지를 통한 정보노출
				//log.debug("암호화 에러" + e.toString());
				log.error("암호화 에러", e.getClass());
			}
			return passACL;
		}

		public String encodeHex(byte [] b){
			char [] c = Hex.encodeHex(b);
			return new String(c);
		}
	}

	public String connectToServer(String data, String reqUrl) throws Exception{
		HttpURLConnection conn 		= null;
		BufferedReader resultReader = null;
		PrintWriter pw 				= null;
		URL url 					= null;

		int statusCode = 0;
		StringBuffer recvBuffer = new StringBuffer();
		try{
			url = new URL(reqUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(15000);
			conn.setReadTimeout(30000);
			conn.setDoOutput(true);

			pw = new PrintWriter(conn.getOutputStream());
			pw.write(data);
			pw.flush();

			statusCode = conn.getResponseCode();
			resultReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			for(String temp; (temp = resultReader.readLine()) != null;){
				recvBuffer.append(temp).append("\n");
			}

			if(!(statusCode == HttpURLConnection.HTTP_OK)){
				throw new Exception();
			}

			return recvBuffer.toString().trim();
		}catch (Exception e){
			return "9999";
		}finally{
			recvBuffer.setLength(0);

			try{
				if(resultReader != null){
					resultReader.close();
				}
			}catch(Exception ex){
				resultReader = null;
			}

			try{
				if(pw != null) {
					pw.close();
				}
			}catch(Exception ex){
				pw = null;
			}

			try{
				if(conn != null) {
					conn.disconnect();
				}
			}catch(Exception ex){
				conn = null;
			}
		}
	}

	//JSON String -> HashMap 변환
	private static HashMap jsonStringToHashMap(String str) throws Exception{
		HashMap dataMap = new HashMap();
		JSONParser parser = new JSONParser();
		try{
			Object obj = parser.parse(str);
			JSONObject jsonObject = (JSONObject)obj;

			Iterator<String> keyStr = jsonObject.keySet().iterator();
			while(keyStr.hasNext()){
				String key = keyStr.next();
				Object value = jsonObject.get(key);

				dataMap.put(key, value);
			}
		}catch(Exception e){
			log.error("NicepayController jsonStringToHashMap Exception", e.getClass());
		}
		return dataMap;
	}

	//hex aes 암호화
	public static String encryptAES(String input, String key) {
		byte[] crypted = null;
		try {
			SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");

			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, skey);
			crypted = cipher.doFinal(input.getBytes());

			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < crypted.length; i++) {
				String hex = Integer.toHexString(crypted[i] & 0xFF);
				if (hex.length() == 1) {
					hex = '0' + hex;
				}
				sb.append(hex.toUpperCase());
			}
			return sb.toString();
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//e.printStackTrace();
			log.error("NicepayController encrypt Exception", e.getClass());
		}
		return null;
	}

}