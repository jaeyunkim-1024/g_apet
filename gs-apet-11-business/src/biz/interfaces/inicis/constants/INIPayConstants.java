package biz.interfaces.inicis.constants;

import framework.common.util.FileUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.constants
* - 파일명		: InipayConstants.java
* - 작성일		: 2017. 4. 19.
* - 작성자		: Administrator
* - 설명			: INIpay 상수 정의
* </pre>
*/
public class INIPayConstants {

	/*****************************
	 * 요청 결제 수단 : PC
	 ****************************/
	/** 신용카드 */
	public static final String GO_PAY_METHOD_CARD = "Card";
	/** 실시간 계좌이체 */
	public static final String GO_PAY_METHOD_DIRECT_BANK = "DirectBank";
	/** 가상계좌 */
	public static final String GO_PAY_METHOD_VBANK = "VBank";

	/*****************************
	 * 요청 결제 수단 : MOBILE
	 ****************************/
	/** 신용카드 */
	public static final String GO_MOBILE_PAY_METHOD_CARD = "wcard";
	/** 실시간 계좌이체 */
	public static final String GO_MOBILE_PAY_METHOD_BANK = "bank";
	/** 가상계좌 */
	public static final String GO_MOBILE_PAY_METHOD_VBANK = "vbank";

	
	/*****************************
	 * 승인 결제 수단 : PC
	 ****************************/
	/** 신용카드(ISP) */
	public static final String PAY_METHOD_CARD_V = "VCard";
	/** 신용카드(안심클릭) */
	public static final String PAY_METHOD_CARD = "Card";
	/** 실시간 계좌이체(K계좌이체) */
	public static final String PAY_METHOD_DIRECT_BANK = "DirectBank";
	/** 실시간 계좌이체(I계좌이체) */
	public static final String PAY_METHOD_I_DIRECT_BANK = "iDirectBank";
	/** 가상계좌 */
	public static final String PAY_METHOD_VBANK = "VBank";

	/*****************************
	 * 승인 결제 수단 : MOBILE
	 ****************************/
	/** 신용카드(ISP,안심클릭,국민앱카드,케이페이) */
	public static final String MOBILE_PAY_METHOD_CARD = "CARD";
	/** 계좌이체 */
	public static final String MOBILE_PAY_METHOD_BANK = "BANK";
	/** 가상계좌 */
	public static final String MOBILE_PAY_METHOD_VBANK = "VBANK";
	
	/***************************
	 * 결과 코드 정의
	 ***************************/
	/** 인증 성공 코드 : PC */
	public static final String CERITFICATION_RETURN_SUCCESS_RESULT_CODE = "0000";
	/** 승인 성공 코드 */
	public static final String APPROVE_RETURN_SUCCESS_RESULT_CODE = "0000";

	/** 인증 성공 코드 : MOBILE */
	public static final String CERITFICATION_MOBILE_RETURN_SUCCESS_RESULT_CODE = "00";
	/** 승인 성공 코드 : MOBILE */
	public static final String APPROVE_MOBILE_RETURN_SUCCESS_RESULT_CODE = "00";

	/** 취소 성공 코드 */
	public static final String CANCEL_RETURN_SUCCESS_RESULT_CODE = "00";
	
	/** 결과 수신 성공 코드 */
	public static final String RECEIVE_RESULT_OK = "OK";
	/** 결과 수신 실패 코드 */
	public static final String RECEIVE_RESULT_FAIL = "FAIL";
	
	/** 현금영수증 승인 성공 코드 */
	public static final String CASH_RECEIPT_APPROVE_RETURN_SUCCESS_RESULT_CODE = "00";

	/** 카드 기 취소인 경우 */
	public static final String CARD_MSG_CODE_ALREADY_CANCEL = "500626";

	/** 가상계좌 기 취소 인 경우 */
	public static final String VBANK_MSG_CODE_ALREADY_CANCEL = "504626";
	
	/***************************
	 * 일반 코드 정의
	 ***************************/
	/*
	 * 현금영수증 발급 코드 : CSHR_TYPE
	 */
	/** 현금영수증 발급 코드 : 소득공제용 */
	public static final String CSHR_TYPE_0 = "0";
	/** 현금영수증 발급 코드 : 지출증빙용 */
	public static final String CSHR_TYPE_1 = "1";
	
	/*
	 * 취소 사유 코드 : CACNEL_REASON_CODE
	 */
	/** 취소 사유 코드 : 거래취소 */
	public static final String CACNEL_REASON_CODE_1 = "1";
	/** 취소 사유 코드 : 오류 */
	public static final String CACNEL_REASON_CODE_2 = "2";
	/** 취소 사유 코드 : 기타사항 */
	public static final String CACNEL_REASON_CODE_3 = "3";
	
	/*
	 * 부분취소,재승인 구분 값
	 */
	/** 부분 취소,재승인 구분값 : 재승인 */
	public static final String PART_CANCEL_TYPE_0 = "0";
	/** 부분 취소,재승인 구분값 : 부분취소 */
	public static final String PART_CANCEL_TYPE_1 = "1";
	
	/*
	 * 수신 로그파일 명
	 */
	/** 수신 유형 : 모바일 Noti */
	public static final String	RECEIVE_TYPE_NOTI_FILE_NAME = "noti_input_";
	/** 수신 유형 : 가상계좌 입금통보 */
	public static final String	RECEIVE_TYPE_VACCT_FILE_NAME = "vacctinput_";
	
}