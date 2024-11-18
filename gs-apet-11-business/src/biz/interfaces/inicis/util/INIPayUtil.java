package biz.interfaces.inicis.util;

import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.util
* - 파일명		: InipayUtil.java
* - 작성일		: 2017. 4. 19.
* - 작성자		: snw
* - 설명			: INIpay 연관 Util
* </pre>
*/
@Slf4j
public class INIPayUtil {

	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: AgsUtil.java
//	* - 작성일		: 2017. 2. 6.
//	* - 작성자		: snw
//	* - 설명			: INIPay Web Standard 모듈 Session
//	* </pre>
//	* @param domain
//	* @return
//	*/
//	public static INIStdSession getStdSession(String domain, String ordNo, String payAmt, String payMeansCd){
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//		Properties webConfig = (Properties)wContext.getBean("webConfig");
//		Properties bizConfig = (Properties)wContext.getBean("bizConfig");
//		
//		INIStdSession session = new INIStdSession();
//
//		String strId = webConfig.getProperty("inipay.str.id");
//		
//		/******************************
//		 * 기본 정보 생성
//		 ******************************/
//		session.setScrtPth(bizConfig.getProperty("inipay.std.script.path"));
//		session.setVersion(webConfig.getProperty("inipay.version"));
//		session.setMid(bizConfig.getProperty("inipay.mid." + strId));
//		session.setTimestamp(SignatureUtil.getTimestamp());
//		session.setCurrency(bizConfig.getProperty("inipay.currency." +strId));
//		try {
//			session.setMkey(SignatureUtil.hash(bizConfig.getProperty("inipay.sign.key." + strId), "SHA-256"));
//		} catch (Exception e) {
//			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//		}
//		
//		session.setReturnCharset(webConfig.getProperty("inipay.return.charset"));
//		session.setReturnUrl(domain + webConfig.getProperty("inipay.return.url"));
//		session.setCloseUrl(domain + webConfig.getProperty("inipay.close.url"));
//		
//		/******************************
//		 * signature 생성
//		 ******************************/
//		String signature = null;
//		Map<String, String> signParam = new HashMap<>();
//
//		signParam.put("oid",		ordNo); 							// 필수
//		signParam.put("price", 		payAmt);							// 필수
//		signParam.put("timestamp",	session.getTimestamp());		// 필수
//	
//		try {
//			signature = SignatureUtil.makeSignature(signParam);
//		} catch (Exception e) {
//			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//		}
//		
//		session.setSignature(signature);
//		
//		/******************************
//		 * 결제 수단별 추가 정보
//		 ******************************/
//		String acceptmethod = "popreturn";
//
//		/*
//		 * 신용카드
//		 */
//		if(CommonConstants.PAY_MEANS_10.equals(payMeansCd)){
//			session.setGopaymethod(INIPayConstants.GO_PAY_METHOD_CARD);
//			/*
//			 * 50,000원 이상일 경우에만 무이자 사용 설정
//			 */
//			if(Integer.parseInt(payAmt) > 50000){
//				session.setCardQuotaBase(webConfig.getProperty("inipay.card.quota.base"));
//				session.setCardNointerest(webConfig.getProperty("inipay.card.nointerest"));
//			}
//			
//			/*
//			 * 추가 요청 필드 설정
//			 */
//			String cardPointYn = webConfig.getProperty("inipay.card.acceptmethod.point.yn");	// 카드 포인트 사용 가능 여부
//			String belowYn = webConfig.getProperty("inipay.card.acceptmethod.below1000.yn");		// 1000원이하 결제 가능 여부
//			
//			if(cardPointYn != null && "Y".equals(cardPointYn)){
//				acceptmethod +=":cardpoint";
//			}
//			if(belowYn != null && "Y".equals(belowYn)){
//				acceptmethod +=":below1000";
//			}
//			
//			
//			
//		/*
//		 * 계좌이체	
//		 */
//		}else if(CommonConstants.PAY_MEANS_20.equals(payMeansCd)){
//			session.setGopaymethod(INIPayConstants.GO_PAY_METHOD_DIRECT_BANK);
//			
//			/*
//			 * 추가 요청 필드 설정
//			 */
//			String receiptYn = webConfig.getProperty("inipay.bank.acceptmethod.receipt.yn");
//			
//			if(receiptYn != null && "N".equals(receiptYn)){
//				acceptmethod +=":no_receipt";
//
//			}
//			
//
//		/*
//		 * 가상계좌
//		 */
//		}else if(CommonConstants.PAY_MEANS_30.equals(payMeansCd)){
//			session.setGopaymethod(INIPayConstants.GO_PAY_METHOD_VBANK);
//			
//			/*
//			 * 추가 요청 필드 설정
//			 */
//			String receiptYn = webConfig.getProperty("inipay.vbank.acceptmethod.receipt.yn");
//			
//			if(receiptYn != null && "Y".equals(receiptYn)){
//				acceptmethod +=":va_receipt";
//			}	
//			
//			/*
//			 * 입금 기한 일자 설정
//			 */
//			acceptmethod += ":vbank("+PayUtil.getSchdDt()+")";
//			
//		}else{
//			throw new CustomException(ExceptionConstants.ERROR_ORDER_PAY_MEAN);
//		}
//		
//		session.setAcceptmethod(acceptmethod);
//		
//		return session;
//	}
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayUtil.java
//	* - 작성일		: 2017. 4. 25.
//	* - 작성자		: Administrator
//	* - 설명			: INIPay Mobile 모듈 Session
//	* </pre>
//	* @param domain
//	* @param ordNo
//	* @param payAmt
//	* @param payMeansCd
//	* @return
//	*/
//	public static INIMobileSession getMobileSession(String domain, String ordNo, String payAmt, String payMeansCd){
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//		Properties webConfig = (Properties)wContext.getBean("webConfig");
//		Properties bizConfig = (Properties)wContext.getBean("bizConfig");
//		
//		INIMobileSession session = new INIMobileSession();
//
//		String strId = webConfig.getProperty("inipay.str.id");
//
//		/******************************
//		 * 기본 정보 생성
//		 ******************************/
//		// 상점 아이디
//		session.setMid(bizConfig.getProperty("inipay.mid." + strId));
//		// 상점 명
//		session.setMnm(bizConfig.getProperty("inipay.mnm." + strId));
//		
//		session.setNotiUrl(bizConfig.getProperty("inipay.noti.url"));
//		session.setNextUrl(domain + webConfig.getProperty("inipay.next.url"));
//		// 리턴 시 문자셋
//		session.setReturnCharset(webConfig.getProperty("inipay.return.charset"));
//		session.setNoti(CryptoUtil.encryptAES(bizConfig.getProperty("inipay.mid." + strId)));
//		
//		/******************************
//		 * 결제 수단별 추가 정보
//		 ******************************/
//		String payUrl = webConfig.getProperty("inipay.pay.url");	//결제 URL
//		String reserved = "auth_charset=utf8";	//복합필드
//		
//		/*
//		 * 신용카드
//		 */
//		if(CommonConstants.PAY_MEANS_10.equals(payMeansCd)){
//			payUrl += INIPayConstants.GO_MOBILE_PAY_METHOD_CARD;
//			
//			/*
//			 * 50,000원 이상 무이자 가능 설정
//			 */
//			if(Integer.parseInt(payAmt) > 50000){
//				session.setQuotabase(webConfig.getProperty("inipay.card.quota.base"));
//			}
//			
//			/*
//			 * 복합필드 설정
//			 */
//			reserved += "&" + webConfig.getProperty("inipay.card.reserved.default");
//			
//			String cpYn = webConfig.getProperty("inipay.card.reserved.point.yn");	// 카드 포인트 사용 가능 여부
//			String below1000 = webConfig.getProperty("inipay.card.reserved.below1000.yn");	// 1000원이하 결제 가능 여부
//			String nointerest = webConfig.getProperty("inipay.card.nointerest");	//가맹점 무이자 할부 정책
//			String kpay = webConfig.getProperty("inipay.card.reserved.kpay.disable.yn");	// Kpay 비노출 여부
//			
//			if(cpYn != null && !"".equals(cpYn)){
//				reserved += "&cp_yn=" + cpYn;
//			}
//
//			if(below1000 != null && !"".equals(below1000)){
//				reserved += "&below1000=" + below1000;
//			}
//			
//			if(nointerest != null && !"".equals(nointerest)){
//				reserved += "&merc_noint=Y&noint_quota=" + nointerest;
//			}
//
//			if(kpay != null && !"".equals(kpay)){
//				reserved += "&disable_kpay=" + kpay;
//			}
//
//
//		/*
//		 * 계좌이체	
//		 */
//		}else if(CommonConstants.PAY_MEANS_20.equals(payMeansCd)){
//			payUrl += INIPayConstants.GO_MOBILE_PAY_METHOD_BANK;
//
//			/*
//			 * 복합필드 설정
//			 */
//			String receiptYn = webConfig.getProperty("inipay.bank.reserved.receipt.yn");	// 현금영수증 발급 여부
//
//			// 2Trasaction으로 진행하기 위한 설정
//			reserved += "&twotrs_bank=Y";
//					
//			if(receiptYn != null && !"".equals(receiptYn)){
//				reserved += "&bank_receipt=" + receiptYn;
//			}
//			
//		/*
//		 * 가상계좌
//		 */
//		}else if(CommonConstants.PAY_MEANS_30.equals(payMeansCd)){
//			payUrl += INIPayConstants.GO_MOBILE_PAY_METHOD_VBANK;
//			
//			/*
//			 * 가상계좌 입금 기한 설정
//			 */
//			session.setVbankDate(PayUtil.getSchdDt());
//			session.setVbankTime("0000");
//			
//			/*
//			 * 복합필드 설정
//			 */
//			String receiptYn = webConfig.getProperty("inipay.vbank.reserved.receipt.yn");	// 현금영수증 발급 여부
//
//			if(receiptYn != null && !"".equals(receiptYn)){
//				reserved += "&vbank_receipt=" + receiptYn;
//			}
//
//		}else{
//			throw new CustomException(ExceptionConstants.ERROR_ORDER_PAY_MEAN);
//		}
//		
//		session.setPayUrl(payUrl + "/");
//		session.setReserved(reserved);
//		
//		return session;
//	}
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: PayUtil.java
//	* - 작성일		: 2017. 4. 26.
//	* - 작성자		: Administrator
//	* - 설명			: 카드 영수증 URL
//	* </pre>
//	* @return
//	*/
//	public static String getCardReceiptUrl(String tid){
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//		Properties bizConfig = (Properties)wContext.getBean("bizConfig");
//
//		return  bizConfig.getProperty("inipay.receipt.card.url") + tid;
//	}
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: PayUtil.java
//	* - 작성일		: 2017. 4. 26.
//	* - 작성자		: Administrator
//	* - 설명			: 현금 영수증 URL
//	* </pre>
//	* @param tid
//	* @return
//	*/
//	public static String getCashReceiptUrl(String tid){
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//		Properties bizConfig = (Properties)wContext.getBean("bizConfig");
//
//		return bizConfig.getProperty("inipay.receipt.cash.url") + tid;
//	}	
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayUtil.java
//	* - 작성일		: 2017. 4. 27.
//	* - 작성자		: Administrator
//	* - 설명			: 웹표준 인증내역 Object를 String으로 변환
//	* </pre>
//	* @param obj
//	* @return
//	*/
//	public static String getStdCertificationToString(INIStdCertification obj){
//		StringBuilder result = new StringBuilder();
//		
//		Class cls = obj.getClass();
//		
//		Field[] fieldList = cls.getDeclaredFields();
//
//		for(int i=0; i < fieldList.length ; i++){
//			fieldList[i].setAccessible(true);
//
//			if(i > 0){
//				result.append("^");
//			}
//			String param_name = fieldList[i].getName();
//			String param_value = "";
//
//			try {
//				if(fieldList[i].get(obj) != null && !"".equals(fieldList[i].get(obj))){
//					param_value = String.valueOf(fieldList[i].get(obj));
//				}else{
//					param_value = "";
//				}
//			} catch (Exception e) {
//				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//			}
//
//			result.append(param_name).append("@").append(param_value);
//			
//		}
//
//		log.debug(">>>>>>>>>>>>approve Str = " + result.toString());
//		
//		return CryptoUtil.encryptAES(result.toString());
//	}
//	
//
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayUtil.java
//	* - 작성일		: 2017. 4. 27.
//	* - 작성자		: Administrator
//	* - 설명			:  웹표준 인증내역 String을 Object로 변환
//	* </pre>
//	* @param str
//	* @return
//	*/
//	public static INIStdCertification getStringToStdCertification(String str){
//		
//		str = CryptoUtil.decryptAES(str);
//		
//		INIStdCertification dto = new INIStdCertification();
//		
//		Class cls = dto.getClass();
//		
//		Field[] fieldList = cls.getDeclaredFields();
//		
//		String[] strList = str.split("\\^");
//
//		for(int i=0; i < fieldList.length ; i++){
//			fieldList[i].setAccessible(true);
//			
//			for(String s : strList){
//				String[] strObj = s.split("\\@");
//				
//				String paramName = strObj[0];
//				String paramValue = "";
//				if(strObj.length > 1){
//					paramValue = strObj[1];
//				}
//				if(fieldList[i].getName().equals(paramName)){
//					try{
//						if(!"".equals(paramValue)){
//							if(fieldList[i].getType() == Long.class){
//								fieldList[i].set(dto, Long.valueOf(paramValue));
//							}else if(fieldList[i].getType() == String.class){
//								fieldList[i].set(dto, paramValue);
//							}
//						}
//					}catch (Exception e){
//						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//					}
//				}
//				
//			}
//			
//		}
//		
//		log.debug(">>>>>>>>>>>>approve Dto = " + dto.toString());
//		
//		return dto;
//	}
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayUtil.java
//	* - 작성일		: 2017. 4. 27.
//	* - 작성자		: Administrator
//	* - 설명			: 모바일 인증내역을 String으로 변환
//	* </pre>
//	* @param obj
//	* @return
//	*/
//	public static String getMobileCertificationToString(INIMobileCertification obj){
//		StringBuilder result = new StringBuilder();
//		
//		Class cls = obj.getClass();
//		
//		Field[] fieldList = cls.getDeclaredFields();
//
//		for(int i=0; i < fieldList.length ; i++){
//			fieldList[i].setAccessible(true);
//
//			if(i > 0){
//				result.append("^");
//			}
//			String param_name = fieldList[i].getName();
//			String param_value = "";
//
//			try {
//				if(fieldList[i].get(obj) != null && !"".equals(fieldList[i].get(obj))){
//					param_value = String.valueOf(fieldList[i].get(obj));
//				}else{
//					param_value = "";
//				}
//			} catch (Exception e) {
//				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//			}
//
//			result.append(param_name).append("@").append(param_value);
//			
//		}
//
//		log.debug(">>>>>>>>>>>>approve Str = " + result.toString());
//		
//		return CryptoUtil.encryptAES(result.toString());
//	}
//	
//
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayUtil.java
//	* - 작성일		: 2017. 4. 27.
//	* - 작성자		: Administrator
//	* - 설명			:  Mobile 인증내역 String을 Object로 변환
//	* </pre>
//	* @param str
//	* @return
//	*/
//	public static INIMobileCertification getStringToMobileCertification(String str){
//		
//		str = CryptoUtil.decryptAES(str);
//		
//		INIMobileCertification dto = new INIMobileCertification();
//		
//		Class cls = dto.getClass();
//		
//		Field[] fieldList = cls.getDeclaredFields();
//		
//		String[] strList = str.split("\\^");
//
//		for(int i=0; i < fieldList.length ; i++){
//			fieldList[i].setAccessible(true);
//			
//			for(String s : strList){
//				String[] strObj = s.split("\\@");
//				
//				String paramName = strObj[0];
//				String paramValue = "";
//				if(strObj.length > 1){
//					paramValue = strObj[1];
//				}
//				if(fieldList[i].getName().equals(paramName)){
//					try{
//						if(!"".equals(paramValue)){
//							if(fieldList[i].getType() == Long.class){
//								fieldList[i].set(dto, Long.valueOf(paramValue));
//							}else if(fieldList[i].getType() == String.class){
//								fieldList[i].set(dto, paramValue);
//							}
//						}
//					}catch (Exception e){
//						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//					}
//				}
//				
//			}
//			
//		}
//		
//		log.debug(">>>>>>>>>>>>approve Dto = " + dto.toString());
//		
//		return dto;
//	}
//	
//
//
//    /**
//    * <pre>
//    * - 프로젝트명	: 11.business
//    * - 파일명		: INIPayUtil.java
//    * - 작성일		: 2017. 5. 15.
//    * - 작성자		: Administrator
//    * - 설명			: INIPay Log 생성
//    * </pre>
//    * @param fileName
//    * @param obj
//    */
//    public static void writeLog(String fileName, Object obj) {
//    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//		Properties bizConfig = (Properties)wContext.getBean("bizConfig");
//		
//		String file_path = bizConfig.getProperty("inipay.home.path");
//		 String date = DateUtil.getNowDate();
//        String time = DateUtil.getNowDateTime();
//        try (FileWriter file2 = new FileWriter(file_path + File.separator + fileName + date +".log", true);){
//        	File file = new File(file_path);
//        	
//   			if(!file.createNewFile()) {
//   				log.error("Fail to create of file");
//   			}
//
//	        file2.write("\n************************************************\n");
//	        file2.write("PageCall time : " 	+ time);
//
//	        Class<?> cls = obj.getClass();
//			
//			Field[] fieldList = cls.getDeclaredFields();
//			
//			for(int i=0; i < fieldList.length ; i++){
//				fieldList[i].setAccessible(true);
//				
//				String param_name = fieldList[i].getName();
//				String param_value = "";
//
//				if(fieldList[i].get(obj) != null && !"".equals(fieldList[i].get(obj))){
//					param_value = String.valueOf(fieldList[i].get(obj));
//				}else{
//					param_value = "";
//				}
//
//				file2.write("\n " + param_name + " : " 	+ param_value);
//
//			}
//			
//	        file2.write("\n************************************************\n");
//	        file2.flush();
//		} catch (Exception e) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//		}
//
//    }
    
}
