package biz.interfaces.inicis.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.service
* - 파일명		: InipayServiceImpl.java
* - 작성일		: 2017. 4. 19.
* - 작성자		: Administrator
* - 설명			: INIpay 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("iniPayService")
public class INIPayServiceImpl implements INIPayService {

//	@Autowired Properties webConfig;
//
//	@Autowired Properties bizConfig;
//
//	/*
//	 * Web Standard 승인
//	 * @see biz.itf.inicis.service.InipayService#approveStd(biz.itf.inicis.model.InipayCertificationDTO)
//	 */
//	@Override
//	public INIStdApprove approveStd(INIStdCertification dto) {
//		//############################################
//		// 0. 변수 선언
//		//############################################
//		INIStdApprove result = new INIStdApprove();
//
//		String resultCode = "";
//		String resultMsg = "";
//
//		//############################################
//		// 1.전문 필드 값 설정(***가맹점 개발수정***)
//		//############################################
//		String mid 		= dto.getMid();					// 가맹점 ID 수신 받은 데이터로 설정
////		String signKey	= this.webConfig.getProperty("inipay.sign.key");	// 가맹점에 제공된 키(이니라이트키) (가맹점 수정후 고정) !!!절대!! 전문 데이터로 설정금지
//		String timestamp= SignatureUtil.getTimestamp();			// util에 의해서 자동생성
//		String charset 	= dto.getCharset();								// 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
//		String format 	= "JSON";								// 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)
//		String authToken= dto.getAuthToken();			// 취소 요청 tid에 따라서 유동적(가맹점 수정후 고정)
//		String authUrl	= dto.getAuthUrl();				// 승인요청 API url(수신 받은 값으로 설정, 임의 세팅 금지)
//		String netCancel= dto.getNetCancelUrl();			// 망취소 API url(수신 받은 값으로 설정, 임의 세팅 금지)
//
//		//#####################
//		// 2.signature 생성
//		//#####################
//		Map<String, String> signParam = new HashMap<>();
//		signParam.put("authToken",	authToken);		// 필수
//		signParam.put("timestamp",	timestamp);		// 필수
//		// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
//		String signature;
//		try {
//			signature = SignatureUtil.makeSignature(signParam);
//		} catch (Exception e) {
//			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//		}
//
//		//#####################
//		// 3.API 요청 전문 생성
//		//#####################
//		Map<String, String> authMap = new HashMap<>();
//		
//		authMap.put("mid"				,mid);			// 필수
//		authMap.put("authToken"		,authToken);	// 필수
//		authMap.put("signature"		,signature);	// 필수
//		authMap.put("timestamp"		,timestamp);	// 필수
//		authMap.put("charset"			,charset);		// default=UTF-8
//		authMap.put("format"			,format);		// default=XML
//
//		log.debug("##승인요청 API 요청##");
//
//		HttpUtil httpUtil = new HttpUtil();
//
//		try{
//			//#####################
//			// 4.API 통신 시작
//			//#####################
//
//			String authResultString = "";
//
//			authResultString = httpUtil.processHTTP(authMap, authUrl);
//
//			//############################################################
//			//5.API 통신결과 처리(***가맹점 개발수정***)
//			//############################################################
//			log.debug("## 승인 API 결과 ##");
//
//			String reAuthResult = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");
//
//			//log.debug("<pre>"+authResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</pre>");
//
//			Map<String, String> resultMap = ParseUtil.parseStringToMap(reAuthResult); //문자열을 MAP형식으로 파싱
//
//			log.debug("resultMap == " + resultMap);
//
//			/*************************  결제보안 강화 2016-05-18 START ****************************/
//			Map<String , String> secureMap = new HashMap<>();
//			secureMap.put("mid"		, mid);								//mid
//			secureMap.put("tstamp"	, timestamp);						//timestemp
//			secureMap.put("MOID"		, resultMap.get("MOID"));			//MOID
//			secureMap.put("TotPrice"	, resultMap.get("TotPrice"));		//TotPrice
//
//			// signature 데이터 생성
//			String secureSignature = SignatureUtil.makeSignatureAuth(secureMap);
//			/*************************  결제보안 강화 2016-05-18 END ****************************/
//
//			resultCode = resultMap.get("resultCode");
//			resultMsg = resultMap.get("resultMsg");
//
//			/******************************************
//			 * 승인 결과 코드 및 보안코드에 대한 검증
//			 ******************************************/
//			if((!INIPayConstants.APPROVE_RETURN_SUCCESS_RESULT_CODE.equals(resultCode) || !secureSignature.equals(resultMap.get("authSignature")) )
//					&& !secureSignature.equals(resultMap.get("authSignature"))
//					&& INIPayConstants.APPROVE_RETURN_SUCCESS_RESULT_CODE.equals(resultCode)){	//결제보안 강화 2016-05-18
//				//결제보안키가 다른 경우
//				//망취소
//				resultCode = "";
//				resultMsg = "데이터 위변조 체크 실패";
//				
//				throw new IllegalStateException("데이터 위변조 체크 실패");
//			}
//
//			/******************************************
//			 * 공통 변수 설정
//			 ******************************************/
//			result.setMid(mid);
//			result.setTid(resultMap.get("tid"));		//	거래번호
//			result.setPayMethod(resultMap.get("payMethod")); //결제방법(지불수단)
//			result.setTotPrice(resultMap.get("TotPrice"));		//결제완료금액
//			result.setMoid(resultMap.get("MOID"));	// 주문 번호
//			result.setApplDate(resultMap.get("applDate"));	//승인날짜
//			result.setApplTime(resultMap.get("applTime"));	//승인시간
//
//			String payMethod = resultMap.get("payMethod");
//
//			/******************************************
//			 * 결제 수단별 변수 설정
//			 ******************************************/
//			if(INIPayConstants.PAY_METHOD_VBANK.equals(payMethod)){ 	//가상계좌
//
//				result.setVactNum(resultMap.get("VACT_Num"));	//입금 계좌번호
//				result.setVactBankCode(resultMap.get("VACT_BankCode"));	//입금 은행코드
//				result.setVactBankName(resultMap.get("vactBankName"));	//입금 은행명
//				result.setVactName(resultMap.get("VACT_Name"));	//예금주 명
//				result.setVactInputName(resultMap.get("VACT_InputName"));	//송금자 명
//				result.setVactDate(resultMap.get("VACT_Date"));	//송금 일자
//				result.setVactTime(resultMap.get("VACT_Time"));	//송금 시간
//
//			}else if(INIPayConstants.PAY_METHOD_DIRECT_BANK.equals(payMethod)){ //실시간계좌이체
//
//				result.setAcctBankCode(resultMap.get("ACCT_BankCode"));	//은행코드
//				result.setCshrResultCode(resultMap.get("CSHR_ResultCode"));	//현금영수증 발급결과코드
//				result.setCshrType(resultMap.get("CSHR_Type"));	//현금영수증 발급구분코드
//
//			}else if(INIPayConstants.PAY_METHOD_I_DIRECT_BANK.equals(payMethod)){ //실시간계좌이체
//
//				result.setAcctBankCode(resultMap.get("ACCT_BankCode"));	//은행코드
//				result.setCshrResultCode(resultMap.get("CSHRResultCode"));	//현금영수증 발급결과코드
//				result.setCshrType(resultMap.get("CSHR_Type"));	//현금영수증 발급구분코드
//
//			}else if(INIPayConstants.PAY_METHOD_CARD_V.equals(payMethod) || INIPayConstants.PAY_METHOD_CARD.equals(payMethod)){ //신용카드
//
//				result.setCardNum(resultMap.get("CARD_Num"));	//카드번호
//				result.setApplNum(resultMap.get("applNum"));	//승인번호
//				result.setCardQuota(resultMap.get("CARD_Quota"));	//할부기간
//				result.setCardCode(resultMap.get("CARD_Code")); //카드 종류
//				result.setCardBankCode(resultMap.get("CARD_BankCode")); //카드 발급사
//
//		    }else{
//		    	resultCode = "";
//		    	resultMsg = "결제 수단 오류";
//		    	throw new IllegalStateException("결제 수단 오류");
//		    }
//
//		} catch (Exception ex) {
//
//			//#####################
//			// 망취소 API
//			//#####################
//			String netcancelResultString = "";
//			try {
//				netcancelResultString = httpUtil.processHTTP(authMap, netCancel); // 망취소 요청 API url(고정, 임의 세팅 금지)
//			} catch (Exception e) {
//				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//			}
//
//			log.error("## 망취소 API 결과 ##");
//
//			// 취소 결과 확인
//			log.error("<p>"+netcancelResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</p>");
//		}
//
//		result.setResultCode(resultCode);
//		result.setResultMsg(resultMsg);
//
//		return result;
//	}
//
//	/*
//	 * Mobile Web 승인
//	 * @see biz.itf.inicis.service.INIPayService#approveMobile(biz.itf.inicis.model.INIMobileCertification)
//	 */
//	@Override
//	public INIMobileApprove approveMobile(INIMobileCertification dto) {
//		//############################################
//		// 1. 변수 선언
//		//############################################
//		INIMobileApprove result = new INIMobileApprove();
//		String resultCode = "";
//		String resultMsg = "";
//
//		//############################################
//		// 2.전문 필드 값 설정(***가맹점 개발수정***)
//		//############################################
//		String authUrl 	= dto.getP_REQ_URL();
//		String tid = dto.getP_TID();
//		String mid = CryptoUtil.decryptAES(dto.getP_NOTI());
//
//		// 승인요청할 데이터
//		authUrl = authUrl + "?P_TID=" + tid + "&P_MID=" + mid;
//
//	    // Create an instance of HttpClient.
//	    HttpClient client = new HttpClient();
//
//	    // Create a method instance.
//	    GetMethod method = new GetMethod(authUrl);
//
//	    // Provide custom retry handler is necessary
//	    method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
//	    		new DefaultHttpMethodRetryHandler(3, false));
//	    method.addRequestHeader("Content-Type", "application/json; charset=utf-8");
//
//	    Map<String, String> resultMap = new HashMap<>();
//
//	    try{
//
//			// Execute the method.
//			int statusCode = client.executeMethod(method);
//
//			if (statusCode != HttpStatus.SC_OK) {
//				resultCode = "";
//				resultMsg = "통신 오류";
//				throw new IllegalStateException("통신 오류");
//			}
//
//			// Read the response body.
//			byte[] responseBody = method.getResponseBody();   //  승인결과 파싱
//			String[] values = new String(responseBody, StandardCharsets.UTF_8).split("&");
//
//			for( int x = 0; x < values.length; x++ ) {
//
//			// 승인결과를 파싱값 잘라 hashmap에 저장
//				int i = values[x].indexOf('=');
//				String key1 = values[x].substring(0, i);
//				String value1 = values[x].substring(i+1);
//				resultMap.put(key1, value1);
//			}
//
//			log.debug("resultMap == " + resultMap);
//
//			/******************************************
//			 * 공통 변수 설정
//			 ******************************************/
//			resultCode = resultMap.get("P_STATUS");
//			resultMsg = resultMap.get("P_RMESG1");
//
//			result.setMid(resultMap.get("P_MID"));	//  상점번호
//			result.setTid(resultMap.get("P_TID"));		//	거래번호
//			result.setPayMethod(resultMap.get("P_TYPE")); //결제방법(지불수단)
//			result.setApplDate(resultMap.get("P_AUTH_DT"));	//승인날짜
//			result.setMoid(resultMap.get("P_OID"));	// 주문 번호
//			result.setTotPrice(resultMap.get("P_AMT"));		//결제완료금액
////			resultMap.get("P_AMT");	//주문자명
////			resultMap.get("P_MNAME");	//가맹점 이름
////			resultMap.get("P_NOTI");	//주문정보에 입력한 값 반환
////			resultMap.get("P_NOTEURL");	//가맹점 전달 NOTI URL
////			resultMap.get("P_NEXT_URL");	//가맹점 전달 NEXT URL
////			resultMap.get("P_UNAME");	//주문자명
//
//
//			String payMethod = resultMap.get("P_TYPE");
//
//			log.debug("payMethod == " + payMethod);
//			/******************************************
//			 * 결제 수단별 변수 설정
//			 ******************************************/
//			if(INIPayConstants.MOBILE_PAY_METHOD_CARD.equals(payMethod)){ 	//신용카드
//
//				result.setCardNum(resultMap.get("P_CARD_NUM"));	//카드번호
//				result.setCardBankCode(resultMap.get("P_CARD_ISSUER_CODE")); //카드 발급사
//				result.setApplNum(resultMap.get("P_AUTH_NO"));	//승인번호
//				result.setCardCode(resultMap.get("P_FN_CD1")); //카드 종류
//				result.setCardQuota(resultMap.get("P_RMESG2"));	//할부기간
//
//			}else if(INIPayConstants.MOBILE_PAY_METHOD_BANK.equals(payMethod)){ //실시간 계좌이체
//
//				result.setBankCd(resultMap.get("P_FN_CD1"));	//은행코드
//				result.setAcctNo(resultMap.get("P_ACCT_NUM"));	//계좌번호
//
//			}else if(INIPayConstants.MOBILE_PAY_METHOD_VBANK.equals(payMethod)){ //가상계좌
//
//				result.setVactNum(resultMap.get("P_VACT_NUM"));	//입금 계좌번호
//				result.setVactBankCode(resultMap.get("P_VACT_BANK_CODE"));	//입금 은행코드
//				result.setVactName(resultMap.get("P_VACT_NAME"));	//예금주 명
//				result.setVactDate(resultMap.get("P_VACT_DATE"));	//송금 일자
//				result.setVactTime(resultMap.get("P_VACT_TIME"));	//송금 시간
//				result.setVactInputName(resultMap.get("P_UNAME")); //송금자명 (모바일에서는 별도의 리턴값이 존재하지 않으므로 주문자명으로 대체)
//		    }
//
//		} catch (Exception ex) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);
//
//		}
//
//		result.setResultCode(resultCode);
//		result.setResultMsg(resultMsg);
//
//
//		return result;
//	}
//
//
//
//	/*
//	 * 현금영수증 신청
//	 * @see biz.itf.inicis.service.INIRcptService#approveReceipt(biz.itf.inicis.model.INIRcptApproveRequest)
//	 */
//	@Override
//	public INIRcptApprove approveReceipt(INIRcptApproveRequest req) {
//		INIRcptApprove result = new INIRcptApprove();
//		log.debug(">>>>>>>>>>>>>>>>>>>>>>>req="+req.toString());
//		/**************************************
//		 * 1. INIpay 클래스의 인스턴스 생성 *
//		 **************************************/
//		INIpay50 inipay = new INIpay50();
//
//		/*********************
//		 * 2. 발급 정보 설정 *
//		 *********************/
//		inipay.SetField("inipayhome", this.bizConfig.getProperty("inipay.home.path"));  // 이니페이 홈디렉터리(상점수정 필요)
//		inipay.SetField("mid", this.bizConfig.getProperty("inipay.mid."+req.getStrId()));          // 상점아이디
//		inipay.SetField("admin", this.bizConfig.getProperty("inipay.key.password."+req.getStrId()));   // 키패스워드(상점아이디에 따라 변경)
//		  //***********************************************************************************************************
//		  //* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
//		  //* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
//		  //* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
//		  //* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
//		  //***********************************************************************************************************
//		inipay.SetField("type","receipt");                            // 고정
//		inipay.SetField("paymethod","CASH");                          // 고정(요청분류)
//		inipay.SetField("debug", "false");                             // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("crypto", "execure");						              // Extrus 암호화모듈 사용(고정)
//
//		inipay.SetField("currency", this.bizConfig.getProperty("inipay.currency."+req.getStrId()));     // 화폐단위 (고정)
//		inipay.SetField("goodname", req.getGoodsName());     // 상품명
//		inipay.SetField("price", req.getCrPrice().toString());        // 총 현금결제 금액
//		inipay.SetField("sup_price", req.getSupPrice().toString());   // 공급가액
//		inipay.SetField("tax", req.getTax().toString());               // 부가세
//		inipay.SetField("srvc_price", req.getSrvcPrice().toString()); // 봉사료
//		inipay.SetField("reg_num", req.getRegNum());       // 현금결제자 주민등록번호
//		inipay.SetField("useopt", req.getUseopt());         // 현금영수증 발행용도 ("0" - 소비자 소득공제용, "1" - 사업자 지출증빙용)
//
//		inipay.SetField("buyername", req.getBuyername());   // 구매자 성명
//		inipay.SetField("buyeremail", req.getBuyeremail()); // 구매자 이메일 주소
//		inipay.SetField("buyertel", req.getBuyertel());     // 구매자 전화번호
//
//		/****************
//		 * 3. 지불 요청 *
//		 ****************/
//		inipay.startAction();
//
//		/*****************************************************************
//		 * 4. 발급 결과                           	                 *
//		 ****************************************************************/
//		result.setResultCode(inipay.GetResult("ResultCode"));
//		result.setResultMsg(inipay.GetResult("ResultMsg"));
//		result.setTid(inipay.GetResult("tid"));
//		result.setPaymethod(inipay.GetResult("paymethod"));
//		result.setApplNum(inipay.GetResult("ApplNum"));
//		result.setApplDate(inipay.GetResult("ApplDate"));
//		result.setApplTime(inipay.GetResult("ApplTime"));
//		result.setCshrPrice(inipay.GetResult("CSHR_ApplPrice"));
//		result.setRsupPrice(inipay.GetResult("CSHR_SupplyPrice"));
//		result.setRtax(inipay.GetResult("CSHR_Tax"));
//		result.setRsrvcPrice(inipay.GetResult("CSHR_ServicePrice"));
//		result.setRshrType(inipay.GetResult("CSHR_Type"));
//
//		return result;
//	}
//
//	/*
//	 *  취소
//	 * @see biz.itf.inicis.service.InipayService#cancel(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
//	 */
//	@Override
//	public INIPayCancel cancel(String strId, String tid, String cancelReasonCd, String cancelReasonMsg) {
//		INIPayCancel result = new INIPayCancel();
//
//		/***************************************
//		 * 2. INIpay 클래스의 인스턴스 생성 *
//		 ***************************************/
//		INIpay inipay = new INIpay();
//
//		/*********************
//		 * 3. 취소 정보 설정 *
//		 *********************/
//	  inipay.SetField("inipayhome", this.bizConfig.getProperty("inipay.home.path"));  // 이니페이 홈디렉터리(상점수정 필요)
//	  inipay.SetField("type", "cancel");                            // 고정 (절대 수정 불가)
//	  inipay.SetField("debug", "true");                             // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//	  inipay.SetField("mid", this.bizConfig.getProperty("inipay.mid."+strId) );         // 상점아이디
//	  inipay.SetField("admin", this.bizConfig.getProperty("inipay.key.password." + strId));                             //상점 키패스워드 (비대칭키)
//	  inipay.SetField("cancelreason", cancelReasonCd);   // 현금영수증 취소코드
//	  //***********************************************************************************************************
//	  //* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
//	  //* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
//	  //* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
//	  //* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
//	  //***********************************************************************************************************
//	  inipay.SetField("tid", tid );         // 취소할 거래의 거래아이디
//	  inipay.SetField("cancelmsg", cancelReasonMsg );   // 취소사유
//	  inipay.SetField("crypto", "execure");						    // Extrus 암호화모듈 사용(고정)
//
//		/****************
//		 * 4. 취소 요청 *
//		 ****************/
//		inipay.startAction();
//
//		/****************************************************************
//		 * 5. 취소 결과
//		 *
//		 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 취소 성공)
//		 * 결과내용 : inipay.GetResult("ResultMsg") (취소결과에 대한 설명)
//		 * 취소날짜 : inipay.GetResult("CancelDate") (YYYYMMDD)
//		 * 취소시각 : inipay.GetResult("CancelTime") (HHMMSS)
//		 * 현금영수증 취소 승인번호 : inipay.GetResult("CSHR_CancelNum")
//		 * (현금영수증 발급 취소시에만 리턴됨)
//		 ****************************************************************/
//		result.setResultCode(inipay.GetResult("ResultCode"));
//		result.setResultMsg(inipay.GetResult("ResultMsg"));
//		result.setCancelDate(inipay.GetResult("CancelDate"));
//		result.setCancelTime(inipay.GetResult("CancelTime"));
//		result.setCshrCancelNum(inipay.GetResult("CSHR_CancelNum"));
//
//		return result;
//	}
//
//	/*
//	 * 부분 취소
//	 * @see biz.itf.inicis.service.INIPayService#cacelPart(java.lang.String, java.lang.String, java.lang.Long, java.lang.Long, java.lang.String)
//	 */
//	@Override
//	public INIPayPartCancel cancelPart(String strId, String orgTid, Long price, Long confirmPrice, String buyerEmail) {
//		INIPayPartCancel result = new INIPayPartCancel();
//
//		/***************************************
//		 * 2. INIpay 클래스의 인스턴스 생성                 *
//		 ***************************************/
//		INIpay50 inipay = new INIpay50();
//
//		/***********************
//		 * 3. 재승인 정보 설정 *
//		 ***********************/
//		inipay.SetField("inipayhome", this.bizConfig.getProperty("inipay.home.path") );				   // 이니페이 홈디렉터리(상점수정 필요)
//		inipay.SetField("type"         , "repay");							   // 고정 (절대 수정 불가)
//		inipay.SetField("debug"        , "true");								   // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("admin"        , this.bizConfig.getProperty("inipay.key.password." + strId));								   // 비대칭 사용키 키패스워드
//		inipay.SetField("mid"          , this.bizConfig.getProperty("inipay.mid." + strId));		   // 상점아이디
//		inipay.SetField("oldtid"       , orgTid);		   // 취소할 거래의 거래아이디
//		inipay.SetField("currency"     , this.bizConfig.getProperty("inipay.currency." + strId));	   // 화폐단위
//		inipay.SetField("price"        , price.toString());         // 취소금액
//		inipay.SetField("confirm_price", confirmPrice.toString()); // 승인요청금액
//		inipay.SetField("buyeremail"   , buyerEmail);    // 구매자 이메일 주소
//
//		inipay.SetField("no_acct"      , "");       // 국민은행 부분취소 환불계좌번호
//		inipay.SetField("nm_acct"      , "");       // 국민은행 부분취소 환불계좌주명
//		inipay.SetField("tax"			 , "");		    // 부가세
//		inipay.SetField("tax_free"     , "");       // 비과세
//
//		// ExecureCrypto_v1.0_jdk14.jar 모듈이 설치 되어 있어 있지 않은 상태라면
//		// 익스트러스 암복호화 모듈 설정을 주석 처리 해주시기 바랍니다.
//		inipay.SetField("crypto","execure");//익스트러스 암복호화 모듈 설정
//
//		/******************
//		 * 4. 재승인 요청 *
//		 ******************/
//		inipay.startAction();
//
//		/********************************************************************
//		 * 5. 재승인 결과                                                   *
//		 *                                                                  *
//		 * 신거래번호 : inipay.GetResult("TID")                             *
//		 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 부분취소성공)*
//		 * 결과내용 : inipay.GetResult("ResultMsg") (결과에 대한 설명)      *
//		 * 원거래 번호 : inipay.GetResult("PRTC_TID")                       *
//		 * 최종결제 금액 : inipay.GetResult("PRTC_Remains")                 *
//		 * 부분취소 금액 : inipay.GetResult("PRTC_Price")                   *
//		 * 부분취소,재승인 구분값 : inipay.GetResult("PRTC_Type")           *
//		 *                          ("0" : 재승인, "1" : 부분취소)          *
//		 * 부분취소 요청횟수 : inipay.GetResult("PRTC_Cnt")                 *
//		 ********************************************************************/
//		result.setResultCode(inipay.GetResult("ResultCode"));
//		result.setResultMsg(inipay.GetResult("ResultMsg"));
//		result.setTid(inipay.GetResult("TID"));
//		result.setPrtcTid(inipay.GetResult("PRTC_TID"));
//		result.setPrtcRemains(inipay.GetResult("PRTC_Remains"));
//		result.setPrtcPrice(inipay.GetResult("PRTC_Price"));
//		result.setPrtcType(inipay.GetResult("PRTC_Type"));
//		result.setPrtcCnt(inipay.GetResult("PRTC_Cnt"));
//
//		return result;
//	}
//
//	@Override
//	public INIPayCancel cancelVirtual(String strId, String tid, String cancelReasonMsg, String rfdAcctNo, String rfdBankCd, String rfdOoaNm ) {
//		INIPayCancel result = new INIPayCancel();
//
//		/***************************************
//		 * 2. INIpay41 클래스의 인스턴스 생성 *
//		 ***************************************/
//		INIpay50 inipay = new INIpay50();
//
//		/*********************
//		 * 3. 취소 정보 설정 *
//		 *********************/
//		inipay.SetField("inipayhome", 	this.bizConfig.getProperty("inipay.home.path"));              // 이니페이 홈디렉터리(상점수정 필요)
//		inipay.SetField("type", 			"refundvacct");                       // 고정 (절대 수정 불가)
//		inipay.SetField("debug", 		"true");                             // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("mid", 			this.bizConfig.getProperty("inipay.mid." + strId) );         // 상점아이디
//		inipay.SetField("admin", 		this.bizConfig.getProperty("inipay.key.password." + strId));		// 비대칭 사용키 키패스워드
//		inipay.SetField("tid", 			tid );         // 취소할 거래의 거래아이디
//		inipay.SetField("cancelmsg", 	cancelReasonMsg );   // 취소사유
//		inipay.SetField("crypto", 		"execure");							// Extrus 암호화모듈 사용(고정)
//
//		inipay.SetField("refundacctnum" , rfdAcctNo );     // 환불계좌번호
//		inipay.SetField("refundbankcode" , rfdBankCd );   // 환불계좌은행코드
//		inipay.SetField("refundacctname", rfdOoaNm );    // 환불계좌주명
//		inipay.SetField("refundflgremit", 	"");    // 펌뱅킹 사용여부(1:사용)
//
//		/****************
//		 * 4. 가상계좌 환불 요청 *
//		 ****************/
//		inipay.startAction();
//
//		/*********************************************************************
//		 * 5. 결과                                           	             *
//		 *                                                        	     *
//		 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 환불 성공)    *
//		 * 결과내용 : inipay.GetResult("ResultMsg") (결과에 대한 설명) 	     *
//		 * 취소날짜 : inipay.GetResult("CancelDate") (YYYYMMDD)              *
//		 * 취소시각 : inipay.GetResult("CancelTime") (HHMMSS)                *
//		     * 현금영수증관련 취소결과코드  : inipay.GetResult("CSHR_ResultCode")*
//		     * 현금영수증관련 취소결과메세지: inipay.GetResult("CSHR_ResurtMsg") *
//		     * 현금영수증관련 취소 승인번호	: inipay.GetResult("CSHR_CancelNum") *
//		     * 현금영수증관련 취소일자	: inipay.GetResult("CSHR_CancelDate")*
//		     * 현금영수증관련 취소시간	: inipay.GetResult("CSHR_CancelTime")*
//		 * (현금영수증관련 정보는 발급정보 존재시에만 리턴됨)                *
//		 *********************************************************************/
//		result.setResultCode(inipay.GetResult("ResultCode"));
//		result.setResultMsg(inipay.GetResult("ResultMsg"));
//		result.setCancelDate(inipay.GetResult("CancelDate"));
//		result.setCancelTime(inipay.GetResult("CancelTime"));
//		result.setCshrCancelNum(inipay.GetResult("CSHR_CancelNum"));
//		return result;
//	}
//
//	@Override
//	public INIPayPartCancel cancelPartVirtual(String strId, String orgTid, Long price, Long confirmPrice, String rfdAcctNo, String rfdBankCd, String rfdOoaNm) {
//		INIPayPartCancel result = new INIPayPartCancel();
//
//		/***************************************
//		 * 2. INIpay 클래스의 인스턴스 생성                 *
//		 ***************************************/
//		INIpay50 inipay = new INIpay50();
//
//		/***********************
//		 * 3. 재승인 정보 설정 *
//		 ***********************/
//		inipay.SetField("inipayhome", 		this.bizConfig.getProperty("inipay.home.path") );                       // 이니페이 홈디렉터리(상점수정 필요)
//		inipay.SetField("type"         , 		"repayvacct");                         // 고정 (절대 수정 불가)
//		//inipay.SetField("debug"      , 		"false");								  // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("debug"      , 		"true");								  // 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("mid", 				this.bizConfig.getProperty("inipay.mid." + strId) );         // 상점아이디
//		inipay.SetField("admin", 			this.bizConfig.getProperty("inipay.key.password." + strId));		// 비대칭 사용키 키패스워드
//		inipay.SetField("oldtid"       , 		orgTid);		  // 취소할 거래의 거래아이디
//		inipay.SetField("price"        , 		price.toString());        // 취소금액
//		inipay.SetField("confirm_price", 	confirmPrice.toString());// 승인요청금액
//		inipay.SetField("crypto",       		"execure");							  // Extrus 암호화모듈 사용(고정)
//
//
//		inipay.SetField("refundbankcode", rfdBankCd);   // 부분취소 은행코드
//		inipay.SetField("refundacctnum" , rfdAcctNo);    // 부분취소 환불계좌번호
//		inipay.SetField("refundacctname", rfdOoaNm);   // 부분취소 환불계좌주명
//
//		/******************
//		 * 4. 재승인 요청 *
//		 ******************/
//		inipay.startAction();
//
//		/********************************************************************
//		 * 5. 재승인 결과                                                   *
//		 *                                                                  *
//		 * 신거래번호 : inipay.GetResult("TID")                             *
//		 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 재승인 성공) *
//		 * 결과내용 : inipay.GetResult("ResultMsg") (재승인결과에 대한 설명)*
//		 * 원거래 번호 : inipay.GetResult("PRTC_TID")                       *
//		 * 최종결제 금액 : inipay.GetResult("PRTC_Remains")                 *
//		 * 부분취소 금액 : inipay.GetResult("PRTC_Price")                   *
//		 * 부분취소,재승인 구분값 : inipay.GetResult("PRTC_Type")           *
//		 *                          ("0" : 재승인, "1" : 부분취소)          *
//		 * 부분취소(재승인) 요청횟수 : inipay.GetResult("PRTC_Cnt")         *
//		 ********************************************************************/
//		result.setResultCode(inipay.GetResult("ResultCode"));
//		result.setResultMsg(inipay.GetResult("ResultMsg"));
//		result.setTid(inipay.GetResult("TID"));
//		result.setPrtcTid(inipay.GetResult("PRTC_TID"));
//		result.setPrtcPrice(inipay.GetResult("PRTC_Price"));
//		result.setPrtcRemains(inipay.GetResult("PRTC_Remains"));
//		result.setPrtcType(inipay.GetResult("PRTC_Type"));
//		result.setPrtcCnt(inipay.GetResult("PRTC_Cnt"));
//
//
//
//		return result;
//	}





}