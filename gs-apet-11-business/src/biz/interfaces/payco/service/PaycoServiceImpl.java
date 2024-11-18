package biz.interfaces.payco.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import biz.interfaces.payco.client.PaycoUtil;
import biz.interfaces.payco.model.PaycoApproveDTO;
import biz.interfaces.payco.model.PaycoApproveResult;
import biz.interfaces.payco.model.PaycoCancelDTO;
import biz.interfaces.payco.model.PaycoCancelResult;
import biz.interfaces.payco.model.PaycoPayment;
import biz.interfaces.payco.model.PaycoReserveDTO;
import biz.interfaces.payco.model.PaycoReserveResult;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.easypay.service
* - 파일명		: PaycoServiceImpl.java
* - 작성일		: 2016. 5. 31.
* - 작성자		: snw
* - 설명		: PayCo 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("paycoService")
public class PaycoServiceImpl implements PaycoService {

	@Autowired private Properties bizConfig;

	@Autowired private MessageSourceAccessor message;

	/*
	 * 페이코 주문 예약
	 * @see biz.itf.payco.service.PaycoService#reserve(biz.itf.payco.model.PaycoReserveDTO)
	 */
	@Override
	public PaycoReserveResult reserve(PaycoReserveDTO dto) {

		String serverType = this.bizConfig.getProperty("payco.server.type");
		String sellerKey = this.bizConfig.getProperty("payco.seller.key");
		String cpId = this.bizConfig.getProperty("payco.cp.id");
		String productId = this.bizConfig.getProperty("payco.product.id");
		String logYn = this.bizConfig.getProperty("payco.log.yn");


		ObjectMapper mapper = new ObjectMapper(); 		  //jackson json object
		PaycoUtil    util 	= new PaycoUtil(serverType); //CommonUtil

		/* 이전 페이지에서 전달받은 고객 주문번호 설정 */
//		String customerOrderNumber = (String)request.getParameter("customerOrderNumber");

		/*======== 상품정보 변수 선언 ========*/
		int orderNumber;
		int orderQuantity;
		int productUnitPrice;
		int productUnitPaymentPrice;
		int productAmt;
		//int deliveryFeeAmt;
		int productPaymentAmt;
		int totalProductPaymentAmt;
		int sortOrdering;
		int totalTaxfreeAmt;
		int totalTaxableAmt;
		int totalVatAmt;
		int unitTaxfreeAmt;
		int unitTaxableAmt;
		int unitVatAmt;
		String iOption;
		String productName;
		//String productInfoUrl;
		String orderConfirmUrl;
		String orderConfirmMobileUrl;
		String productImageUrl;
		String sellerOrderProductReferenceKey;
		String taxationType;
		/*=====================================*/

		/*======== 변수 초기화 ========*/
		totalProductPaymentAmt = 0;	//주문 상품이 여러개일 경우 상품들의 총 금액을 저장할 변수
		orderNumber 	= 0;		//주문 상품이 여러개일 경우 순번을 매길 변수
		unitTaxfreeAmt  = 0;		//개별상품단위 면세금액
		unitTaxableAmt  = 0;		//개별상품단위 공급가액
		unitVatAmt      = 0;		//개별상품단위 부가세액
		totalTaxfreeAmt = 0;		//총 면세 금액
		totalTaxableAmt = 0;		//총 과세 공급가액
		totalVatAmt 	= 0;		//총 과세 부가세액
		/*=============================*/

		/*==== 상품정보 값 입력 ====*/
		orderNumber = orderNumber + 1; 										 // 상품에 순번을 정하기 위해 값을 증가합니다.
		orderQuantity = 1;													 //[필수]주문수량 (배송비 상품인 경우 1로 세팅)
		productUnitPrice = Integer.parseInt(dto.getGoodsAmt());	 //상품 단가 ( 테스트용으로써 79000원으로 설정)
		productUnitPaymentPrice = Integer.parseInt(dto.getGoodsAmt());					 		 		 //상품 결제 단가 ( 테스트용으로써 79000원으로 설정)
		productAmt = productUnitPrice * orderQuantity;						 //[필수]상품 결제금액(상품단가 * 수량)
		productPaymentAmt = productUnitPaymentPrice * orderQuantity;	 //[필수]상품 결제금액(상품결제단가 * 수량, 배송비 설정시 상품가격에 포함시킴 ex) 2500원)
		iOption = "280";											 		 //[선택]옵션(최대 100 자리)
		sortOrdering = orderNumber;											 //[필수]상품노출순서, 10자 이내
		productName = "[GLOBE] TILT KIDS (NAVY/ORANGE)";					 //[필수]상품명, 4000자 이내
		orderConfirmUrl = "http://www.naver.com";							 //[선택]주문완료 후 주문상품을 확인할 수 있는 url, 4000자 이내
		orderConfirmMobileUrl = "";											 //[선택]주문완료 후 주문상품을 확인할 수 있는 모바일 url, 1000자 이내
		productImageUrl = "";												 //[선택]이미지URL(배송비 상품이 아닌 경우는 필수), 4000자 이내, productImageUrl에 적힌 이미지를 썸네일해서 PAYCO 주문창에 보여줍니다.
		sellerOrderProductReferenceKey = "ITEM_100001";						 //[필수]가맹점에서 관리하는 상품키, 100자 이내.(외부가맹점에서 관리하는 주문상품 연동 키(sellerOrderProductReferenceKey)는 주문 별로 고유한 key이어야 합니다.)
																			 // 단 주문당 1건에 대한 상품을 보내는 경우는 연동키가 1개이므로 주문별 고유값을 고려하실 필요 없습니다.
		taxationType = "TAXATION";											 //[선택]과세타입(기본값 : 과세). DUTYFREE :면세, COMBINE : 결합상품, TAXATION : 과세


		//totalTaxfreeAmt(면세상품 총액) / totalTaxableAmt(과세상품 총액) / totalVatAmt(부가세 총액) => 일부 필요한 가맹점을위한 예제입니다.
		//과세상품일 경우
		if(taxationType.equals("TAXATION")){
			unitTaxfreeAmt = 0;
			unitTaxableAmt = (int)(productPaymentAmt / 1.1);
			unitVatAmt	   = (int)((productPaymentAmt / 1.1) * 0.1);

			if(unitTaxableAmt + unitVatAmt != productPaymentAmt){
				unitTaxableAmt = unitTaxableAmt +1;
			}

		//면세상품일 경우
		}else if(taxationType.equals("DUTYFREE")){
			unitTaxfreeAmt = productPaymentAmt;
			unitTaxableAmt = 0;
			unitVatAmt	   = 0;

		//복합상품일 경우
		}else if(taxationType.equals("COMBINE")){
			unitTaxfreeAmt = 24960;
			unitTaxableAmt = (int)((productPaymentAmt - unitTaxfreeAmt) / 1.1);
			unitVatAmt	   = (int)(((productPaymentAmt - unitTaxfreeAmt) / 1.1) * 0.1);

			if(unitTaxableAmt + unitVatAmt != productPaymentAmt - unitTaxfreeAmt){
				unitTaxableAmt = unitTaxableAmt +1;
			}

		}

		totalTaxfreeAmt = totalTaxfreeAmt + unitTaxfreeAmt;
		totalTaxableAmt = totalTaxableAmt + unitTaxableAmt;
		totalVatAmt		= totalVatAmt + unitVatAmt;

		//주문정보를 구성하기 위한 상품들 누적 결제 금액(상품결제금액)
		totalProductPaymentAmt = totalProductPaymentAmt + productPaymentAmt; // 주문상품 총 금액


		//상품값으로 읽은 변수들로 Json String 을 작성합니다.
		List<Map<String,Object>> orderProducts = new ArrayList<>();

		Map<String,Object> productInfo = new HashMap<>();
		productInfo.put("cpId", cpId);														//[필수]상점ID
		productInfo.put("productId", productId);											//[필수]상품ID
		productInfo.put("productAmt", productAmt);											//[필수]상품금액(상품단가 * 수량)
		productInfo.put("productPaymentAmt", productPaymentAmt);						    //[필수]상품결제금액(상품결제단가 * 수량)
		productInfo.put("orderQuantity", orderQuantity);									//[필수]주문수량(배송비 상품인 경우 1로 셋팅)
		productInfo.put("option", iOption);													//[선택]상품 옵션
		productInfo.put("sortOrdering", sortOrdering);										//[필수]상품 노출순서
		productInfo.put("productName", productName);										//[필수]상품명
		productInfo.put("orderConfirmUrl", orderConfirmUrl);								//[선택]주문완료 후 주문상품을 확인할 수 있는 URL
		productInfo.put("orderConfirmMobileUrl", orderConfirmMobileUrl); 					//[선택]주문완료 후 주문상품을 확인할 수 있는 모바일 URL
		productInfo.put("productImageUrl", productImageUrl);								//[선택]이미지 URL(배송비 상품이 아닌 경우는 필수)
		productInfo.put("sellerOrderProductReferenceKey", sellerOrderProductReferenceKey);	//[필수]외부가맹점에서 관리하는 주문상품 연동 키
		productInfo.put("taxationType", taxationType);										//[선택]과세타입(면세상품 : DUTYFREE, 과세상품 : TAXATION (기본), 결합상품 : COMBINE)
		orderProducts.add(productInfo);
		/*=====================================================================================================*/

		/*======== 주문정보 변수 선언 ========*/
		//int totalOrderAmt;
		//int totalDeliveryFeeAmt;
		int totalPaymentAmt;
		String sellerOrderReferenceKey;
		String sellerOrderReferenceKeyType;
		String iCurrency;
		String orderSheetUiType;
		String orderTitle;
		String orderMethod;
		String returnUrl;
		String returnUrlParam;
		String nonBankbookDepositInformUrl;
		String orderChannel;
		String inAppYn;
		String individualCustomNoInputYn;
		String payMode;
		/*=====================================*/

		/*==== 주문정보 값 입력(가맹점 수정 가능 부분) ========================================================*/
		sellerOrderReferenceKey 	= dto.getOrdNo();						 	 //[필수]외부가맹점의 주문번호
		sellerOrderReferenceKeyType = "UNIQUE_KEY";								 //[선택]외부가맹점의 주문번호 타입(UNIQUE_KEY : 기본값, DUPLICATE_KEY : 중복가능한 키->외부가맹점의 주문번호가 중복 가능한 경우 사용)
		iCurrency 					= "KRW";									 //[선택]통화(default=KRW)
		totalPaymentAmt 			= totalProductPaymentAmt;			 		 //[필수]총 결재 할 금액
		orderTitle 					= "payco 결제 테스트 주문(JSP)";			 		 //[선택]주문 타이틀
		returnUrl 					= dto.getReturnUrl();						 //[선택]주문완료 후 Redirect 되는 Url
		returnUrlParam 				= "{\"cart_no\":\"20151234567\"}";			 //[선택]주문완료 후 Redirect 되는 URL과 함께 전달되어야 하는 파라미터(Json 형태의 String)
		//nonBankbookDepositInformUrl = domainName+"/payco_without_bankbook.jsp";	 //[선택]무통장입금완료통보 URL
		nonBankbookDepositInformUrl = "";
		orderMethod					= "EASYPAY";								 //[필수]주문유형
		orderChannel 				= dto.getChannel();							 //[선택]주문채널 (default : PC/MOBILE)
		inAppYn 					= "N";										 //[선택]인앱결제 여부(Y/N) (default = N)
		individualCustomNoInputYn 	= "N";										 //[선택]개인통관고유번호 입력 여부 (Y/N) (default = N)
		orderSheetUiType 			= "GRAY";									 //[선택]주문서 UI 타입 선택(선택 가능값 : RED/GRAY)
		payMode						= "PAY2";									 //[선택]결제모드(PAY1 : 결제인증,승인통합 / PAY2 : 결제인증,승인분리)
																				 // payMode는 선택값이나 값을 넘기지 않으면 DEFALUT 값은 PAY1 으로 셋팅되어있습니다.

		//설정한 주문정보로 Json String 을 작성합니다.
		Map<String,Object> orderInfo = new HashMap<>();
		orderInfo.put("sellerKey", sellerKey);										//[필수]가맹점 코드
		orderInfo.put("sellerOrderReferenceKey", sellerOrderReferenceKey); 			//[필수]외부가맹점 주문번호
		orderInfo.put("sellerOrderReferenceKeyType", sellerOrderReferenceKeyType);  //[선택]외부가맹점의 주문번호 타입
		orderInfo.put("currency", iCurrency);										//[선택]통화
		orderInfo.put("totalPaymentAmt", totalPaymentAmt);							//[필수]총 결제금액(면세금액,과세금액,부가세의 합) totalTaxfreeAmt + totalTaxableAmt + totalVatAmt
		orderInfo.put("totalTaxfreeAmt", totalTaxfreeAmt);							//[선택]면세금액(면세상품의 공급가액 합)
		orderInfo.put("totalTaxableAmt", totalTaxableAmt);							//[선택]과세금액(과세상품의 공급가액 합)
		orderInfo.put("totalVatAmt", totalVatAmt);									//[선택]부가세(과세상품의 부가세액 합)
		orderInfo.put("orderTitle", orderTitle); 									//[선택]주문 타이틀
		orderInfo.put("returnUrl", returnUrl);										//[선택]주문완료 후 Redirect 되는 URL
		orderInfo.put("returnUrlParam", returnUrlParam);							//[선택]주문완료 후 Redirect 되는 URL과 함께 전달되어야 하는 파라미터(Json 형태의 String)
		orderInfo.put("nonBankbookDepositInformUrl", nonBankbookDepositInformUrl); 	//[선택]무통장입금완료 통보 URL
		orderInfo.put("orderMethod", orderMethod);									//[필수]주문유형
		orderInfo.put("orderChannel", orderChannel);								//[선택]주문채널
		orderInfo.put("inAppYn", inAppYn);											//[선택]인앱결제 여부
		orderInfo.put("individualCustomNoInputYn", individualCustomNoInputYn);		//[선택]개인통관 고유번호 입력 여부
		orderInfo.put("orderSheetUiType", orderSheetUiType);						//[선택]주문서 UI타입 선택
		orderInfo.put("payMode", payMode);											//[선택]결제모드(PAY1 : 결제인증,승인통합 / PAY2 : 결제인증,승인분리)
		orderInfo.put("orderProducts", orderProducts);								//[필수]주문상품 리스트


		/* 부가정보(extraData) - Json 형태의 String */
		Map<String,Object> extraData = new HashMap<>();
		String orderExpiryDate = DateUtil.addDay("yyyyMMddHHmmss", 1);
		extraData.put("payExpiryYmdt", orderExpiryDate);							//[선택]해당 주문예약건 만료 처리 일시 (해당 일시 이후에는 결제 불가)(14자리로 맞춰주세요)
		String virtualExpiryDate = DateUtil.addDay("yyyyMMddHHmmss", 7);
		extraData.put("virtualAccountExpiryYmd", virtualExpiryDate);					//[선택]가상계좌만료일시(14자리로 맞춰주세요)

		//모바일 결제페이지에서 취소 버튼 클릭시 이동할 URL (결제창 이전 URL 등)
	 	//1순위 : (앱결제인 경우) 주문예약 > customUrlSchemeUseYn 의 값이 Y인 경우 => "nebilres://orderCancel" 으로 이동
		//2순위 : 주문예약 > extraData > cancelMobileUrl 값이 있을시 => cancelMobileUrl 이동
		//3순위 : 주문예약시 전달받은 returnUrl 이동 + 실패코드(오류코드:2222)
		//4순위 : 가맹점 URL로 이동(가맹점등록시 받은 사이트URL)
		//5순위 : 이전 페이지로 이동 => history.Back();
		extraData.put("cancelMobileUrl", "http://www.payco.com");					//[선택][모바일 일경우 필수]모바일 결제페이지에서 취소 버튼 클릭시 이동할 URL

		Map<String,Object> viewOptions = new HashMap<>();
		viewOptions.put("showMobileTopGnbYn", "N");									//[선택]모바일 상단 GNB 노출여부RKAODWJA
		viewOptions.put("iframeYn", "N");											//[선택]Iframe 호출(모바일에서 접근하는경우 iframe 사용시 이값을 "Y"로 보내주셔야 합니다.)
																					// Iframe 사용시 연동가이드 내용중 [Iframe 적용가이드]를 참고하시길 바랍니다.

		extraData.put("viewOptions", viewOptions);									//[선택]화면 UI 옵션

		try {
			orderInfo.put("extraData",  mapper.writeValueAsString(extraData).toString().replaceAll("\"", "\\\"")); //[선택]부가정보 - Json 형태의 String
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		//주문예약 API 호출 함수
		String apiResult = util.payco_reserve(orderInfo,logYn);
		log.info(">>>>>>>>>>>>>>PAYCO Reserve Result="+apiResult);

		PaycoReserveResult result;
		try {
			result = new ObjectMapper().readValue(apiResult, PaycoReserveResult.class);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return result;
	}

	/*
	 * 페이코 승인
	 * @see biz.itf.payco.service.PaycoService#approve(biz.itf.payco.model.PaycoApproveDTO)
	 */
	@Override
	public PaycoApproveResult approve(PaycoApproveDTO dto) {
		//System.out.println("Payco Approve dto="+dto.toString());
		PaycoApproveResult approveResult = new PaycoApproveResult();

		String sellerKey = this.bizConfig.getProperty("payco.seller.key");
		String serverType = this.bizConfig.getProperty("payco.server.type");
		String logYn = this.bizConfig.getProperty("payco.log.yn");

		/* 승인데이타 변수선언 */
		String approval_orderNo 				= "";
		String approval_orderCertifyKey 		= "";
		String approval_sellerOrderReferenceKey = "";
		//String approval_totalPaymentAmt 		= "";

		String approval_paymentTradeNo		= "";
		String approval_paymentMethodCode	= "";
		String approval_paymentMethodName	= "";
		String approval_tradeYmdt			= "";

		String approval_cardCompanyName_card	= "";
		String approval_cardCompanyCode_card	= "";
		String approval_cardNo_card				= "";

		ObjectMapper mapper = new ObjectMapper();		 //jackson json object
		PaycoUtil    util   = new PaycoUtil(serverType); //CommonUtil

		//Boolean existStock  = true; //재고 존재 여부

		/* 결제 인증 성공시 */
		if("0".equals(dto.getCode())){

			/* 수신된 데이터 중 필요한 정보를 추출하여
			 * 총 결제금액과 요청금액이 일치하는지 확인하고,
			 * 결제요청 상품의 재고파악을 실행하여
			 * PAYCO 결제 승인 API 호출 여부를 판단한다.
			 */
			/*----------------------------------------------------------------
			.. 가맹점 처리 부분
			..
			-----------------------------------------------------------------*/

			Map<String,Object> sendMap = new HashMap<>();
			sendMap.put("sellerKey", sellerKey);
			sendMap.put("reserveOrderNo", dto.getReserveOrderNo());
			sendMap.put("sellerOrderReferenceKey", dto.getSellerOrderReferenceKey());
			sendMap.put("paymentCertifyToken", dto.getPaymentCertifyToken());
			sendMap.put("totalPaymentAmt", dto.getTotalPaymentAmt());

			/* payco 결제승인 API 호출 */
			String result = util.payco_approval(sendMap,logYn);

			log.info(">>>>>>>>>>>>>>PAYCO Approve Result="+result);

			// jackson Tree 이용
			JsonNode node;
			try {
				node = mapper.readTree(result);
			} catch (IOException e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			approveResult.setCode(node.path("code").toString());

			if(node.path("code").toString().equals("0")){

				/* 결제승인 후 리턴된 데이터 중 필요한 정보를 추출하여
				 * 가맹점 에서 필요한 작업을 실시합니다.(예 주문서 작성 등..)
				 * 결제연동시 리턴되는 PAYCO주문번호(orderNo)와 주문인증키(orderCertifyKey)에 대해
				 * 가맹점 DB 저장이 필요합니다.
				 */

				// 결제승인 후 리턴된 데이터 중 필요한 정보를 추출 예시
				approval_orderNo 				 = node.path("result").get("orderNo").textValue();
				approval_orderCertifyKey 		 = node.path("result").get("orderCertifyKey").textValue();
				approval_sellerOrderReferenceKey = node.path("result").get("sellerOrderReferenceKey").textValue();
				//approval_totalPaymentAmt 		 = node.path("result").get("memberName").textValue();

				approveResult.setOrdNo(approval_orderNo);
				approveResult.setOrderCertifyKey(approval_orderCertifyKey);
				approveResult.setSellerOrderReferenceKey(approval_sellerOrderReferenceKey);

				// orderProducts, paymentDetails 추출 예시
				ArrayNode arr = (ArrayNode)node.path("result").get("paymentDetails");

				List<PaycoPayment> payList = new ArrayList<>();
				PaycoPayment payment = null;

				for(int i = 0; i < arr.size(); i++){

					payment = new PaycoPayment();

					approval_paymentTradeNo	= arr.get(i).get("paymentTradeNo").textValue();
					approval_paymentMethodCode = arr.get(i).get("paymentMethodCode").textValue();	//31(신용카드), 98(페이코 포인트)
					approval_paymentMethodName = arr.get(i).get("paymentMethodName").textValue();
					approval_tradeYmdt		    = arr.get(i).get("tradeYmdt").textValue();

					payment.setPaymentTradeNo(approval_paymentTradeNo);
					payment.setPaymentMethodCode(approval_paymentMethodCode);
					payment.setPaymentMethodName(approval_paymentMethodName);
					payment.setTradeYmdt(approval_tradeYmdt);

					if(arr.get(i).get("paymentMethodCode").textValue().equals("31")){
						// 신용카드 상세정보(cardSettleInfo) 추출 예시
						approval_cardCompanyName_card = arr.get(i).get("cardSettleInfo").get("cardCompanyName").textValue();
						approval_cardCompanyCode_card = arr.get(i).get("cardSettleInfo").get("cardCompanyCode").textValue();
						approval_cardNo_card 		  = arr.get(i).get("cardSettleInfo").get("cardNo").textValue();

						payment.setCardCompanyCode(approval_cardCompanyCode_card);
						payment.setCardCompanyName(approval_cardCompanyName_card);
						payment.setCardNo(approval_cardNo_card);
					}

					payList.add(payment);

				}
				approveResult.setPayList(payList);
			}else{
				approveResult.setMessage(node.path("message").toString());
			}
		}else{
			approveResult.setCode(dto.getCode());
		}

		return approveResult;
	}

	/*
	 * 취소
	 * @see biz.itf.payco.service.PaycoService#cancel(biz.itf.payco.model.PaycoCancelDTO)
	 */
	@Override
	public PaycoCancelResult cancel(PaycoCancelDTO dto) {

		PaycoCancelResult result  = new PaycoCancelResult();

		String sellerKey = this.bizConfig.getProperty("payco.seller.key");
		String serverType = this.bizConfig.getProperty("payco.server.type");
		String logYn = this.bizConfig.getProperty("payco.log.yn");
		String cpId = this.bizConfig.getProperty("payco.cp.id");
		String productId = this.bizConfig.getProperty("payco.product.id");

		ObjectMapper mapper = new ObjectMapper(); 	//jackson json object
		PaycoUtil util = new PaycoUtil(serverType);	//CommonUtil
		String strResult = "";				  	  	//반환값


		//String cancelType 						= dto.getCancelType();						//취소 Type 받기 - ALL 또는 PART
		String orderNo							= dto.getOrderNo();							//PAYCO에서 발급받은 주문번호
		String orderCertifyKey					= dto.getOrderCertifyKey();					//PAYCO에서 발급받은 주문인증 key
		String cancelTotalAmt 					= dto.getCancelTotalAmt();					//총 취소 금액

		int unitVatAmt	   = (int)((Integer.valueOf(cancelTotalAmt != null ? cancelTotalAmt : "0").doubleValue() / 1.1) * 0.1);
		int unitTaxableAmt = Integer.parseInt(cancelTotalAmt != null ? cancelTotalAmt : "0") - unitVatAmt;

		String totalCancelTaxfreeAmt			= "0";			//주문 총 면세금액
		String totalCancelTaxableAmt			= String.valueOf(unitTaxableAmt);			//주문 총 과세 공급가액
		String totalCancelVatAmt				= String.valueOf(unitVatAmt);				//주문 총 과세 부가세액
		String totalCancelPossibleAmt			= dto.getTotalCancelPossibleAmt();			//총 취소가능금액
		String sellerOrderProductReferenceKey 	= "ITEM_100001";	//가맹점 주문 상품 연동 키(PART 취소 시)
		String cancelDetailContent 				= dto.getCancelDetailContent();				//취소 상세 사유
		String cancelAmt 						= dto.getCancelAmt();						//취소 상품 금액(PART 취소 시)
		String requestMemo						= dto.getRequestMemo();						//취소처리 요청메모

		/* orderNo 값이 없으면 로그를 기록한 뒤 JSON 형태로 오류를 돌려주고 API를 종료합니다. */
		if(orderNo == null ||orderNo.equals("")){
			result.setCode("9999");
			result.setMessage("주문번호 값이 전달되지 않았습니다.");

		/* cancelTotalAmt 값이 없으면 로그를 기록한 뒤 JSON 형태로 오류를 돌려주고 API를 종료합니다. */
		}else if(cancelTotalAmt == null || cancelTotalAmt.equals("")){
			result.setCode("9999");
			result.setMessage("총 취소 금액이 전달되지 않았습니다.");

		}else if(orderCertifyKey == null || orderCertifyKey.equals("")){
			result.setCode("9999");
			result.setMessage("주문인증 key가 전달되지 않았습니다.");

		}

		List<Map<String,Object>> orderProducts = new ArrayList<>();

		/* 전체 취소 = "ALL", 부분취소 = "PART" */
		//보안 진단. 불필요한 코드 (비어있는 IF문)
		//if(CommonConstants.PAYCO_CANCEL_TYPE_ALL.equals(dto.getCancelType())){
			/*
			 * 주문상품 데이터 불러오기
			 * 파라메터로 값을 받을 경우 받은 값으로만 작업을 하면 됩니다.
			 * 주문 키값으로만 DB에서 취소 상품 데이터를 불러와야 한다면 이 부분에서 작업하세요.
			 */

		/*}else*/ if(CommonConstants.PAYCO_CANCEL_TYPE_PART.equals(dto.getCancelType())){
			/*
			 * 주문상품 데이터 불러오기
			 * 파라메터로 값을 받을 경우 받은 값으로만 작업을 하면 됩니다.
			 * 주문 키값으로만 DB에서 취소 상품 데이터를 불러와야 한다면 이 부분에서 작업하세요.
			 */

			if(StringUtils.isEmpty(sellerOrderProductReferenceKey)){
				result.setCode("9999");
				result.setMessage("주문상품 연동키가 전달되지 않았습니다.");
			}else if(cancelAmt == null || cancelAmt.equals("")){
				result.setCode("9999");
				result.setMessage("취소상품 금액이 전달되지 않았습니다.");
			}

			/* 부분 취소 할 상품정보 */
			Map<String,Object> orderProductsInfo = new HashMap<>();
			orderProductsInfo.put("sellerOrderProductReferenceKey", sellerOrderProductReferenceKey);	//[필수]취소상품 연동 키(파라메터로 넘겨 받은 값 - 필요시 DB에서 불러와 대입)
			orderProductsInfo.put("cpId", cpId);														//[필수]상점 ID(common_include.jsp 에 설정)
			orderProductsInfo.put("productId", productId);												//[필수]상품 ID(common_include.jsp 에 설정)
			orderProductsInfo.put("productAmt", cancelAmt);												//[필수]취소상품 금액( 파라메터로 넘겨 받은 금액 - 필요시 DB에서 불러와 대입)
			orderProductsInfo.put("cancelDetailContent", cancelDetailContent);							//[선택]취소 상세 사유
			orderProducts.add(orderProductsInfo);

		/* 취소타입이 잘못되었음. ( ALL과 PART 가 아닐경우 ) */
		}else{
			result.setCode("9999");
			result.setMessage("취소 요청 타입이 잘못되었습니다.");

		}

		/* 설정한 주문취소 정보로 Json String 을 작성합니다. */
		Map<String, Object> param = new HashMap<>();
		param.put("sellerKey", sellerKey);								//[필수]가맹점 코드
		param.put("orderNo", orderNo);									//[필수]주문번호
		param.put("orderCertifyKey", orderCertifyKey);					//[필수]주문인증 key
		param.put("cancelTotalAmt", Integer.parseInt(cancelTotalAmt));  //[필수]취소할 총 금액(전체취소, 부분취소 전부다)

		if(!orderProducts.isEmpty()){
			param.put("orderProducts", orderProducts);					//[선택]취소할 상품 List(부분취소인 경우 사용, 입력하지 않는 경우 전체 취소)
		}

		param.put("totalCancelTaxfreeAmt", totalCancelTaxfreeAmt);		//[선택]총 취소할 면세금액
		param.put("totalCancelTaxableAmt", totalCancelTaxableAmt);		//[선택]총 취소할 과세금액
		param.put("totalCancelVatAmt", totalCancelVatAmt);				//[선택]총 취소할 부가세
		param.put("requestMemo", requestMemo);							//[선택]취소처리 요청메모

		/* 부분취소 중복을 막기위해 totalCancelPossibleAmt 컬럼을 사용하는 예
		 * 예를들어 고객이 10만원 주문을 하고 2만원을 부분취소 하고 싶은데 두번눌러서 4만원이 취소 되는 케이스
		 * 또는 어떠한 이유로 PAYCO 에서는 2만원 부분취소가 되었지만 가맹점 에서는 취소가 발생하지 않았을때 등의
		 * 예외상황이 발생했을때를 대비하여 totalCancelPossibleAmt 컬럼의 값을 설정하여 보내주시면 중복취소를 막을 수 있습니다.
		 * 고객이 10만원 결제금액 중 2만원 부분취소시도 -> PAYCO에는 2만원 취소성공, 그러나 어떠한 이유로 고객 화면에는 취소가 안되었음
		 * -> 고객이 다시 2만원 취소 -> 이때 가맹점 에서는 취소된상품이 하나도 없으므로 totalCancelPossibleAmt 값을 10만원으로 보냄 ->
		 * 가맹점은 totalCancelPossibleAmt 값이 10만원이고 PAYCO 는 2만원을 제외한 8만원이 취소가능금액 이므로 취소가능금액이 일치하지않아 부분취소 불가.
		 */
		param.put("totalCancelPossibleAmt", totalCancelPossibleAmt);	//[선택]총 취소가능금액(현재기준) : 취소가능금액 검증

		/* 주문 결제 취소 API 호출 */
		strResult = util.payco_cancel(param,logYn);

		log.info(">>>>>>>>>>>>>>PAYCO Cancel Result="+result.toString());
		
		JsonNode node;
		try {
			node = mapper.readTree(strResult);
		} catch (IOException e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		result.setCode(node.path("code").toString());
		result.setMessage(node.path("message").toString());

		if(node.path("code").toString().equals("0")){
			result.setCancelTradeSeq(node.path("cancelTradeSeq").toString());
			result.setTotalCancelPaymentAmt(node.path("totalCancelPaymentAmt").toString());
		}

		return result;
	}

}