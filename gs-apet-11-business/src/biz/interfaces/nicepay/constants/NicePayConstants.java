package biz.interfaces.nicepay.constants;

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
public class NicePayConstants {

	/** MID_GB - 인증결제,실시간계좌이체,가상계좌,휴대폰소액결제 */
	public static final String MID_GB_CERTIFY = "C";
	/** MID_GB - 카카오페이,PAYCO, 네이버페이 */
	public static final String MID_GB_SIMPLE = "S";
	/** MID_GB - 빌링 결제 */
	public static final String MID_GB_BILLING = "B";
	/** MID_GB - 고정계좌 */
	public static final String MID_GB_FIX_ACCOUNT = "F";
	
	/***************************
	 * 일반 코드 정의
	 ***************************/
	
	/** 지불 수단 */
	/** 지불 수단 : 신용카드 */
	public static final String PAY_MEANS_01 = "01";
	/** 지불 수단 : 계좌이체 */
	public static final String PAY_MEANS_02 = "02";
	/** 지불 수단 : 가상계좌 */
	public static final String PAY_MEANS_03 = "03";
	/** 지불 수단 : 현금영수증 */
	public static final String PAY_MEANS_04 = "04";
	/** 지불 수단 : 휴대폰 */
	@Deprecated
	public static final String PAY_MEANS_05 = "05";
	/** 지불 수단 : SSG 머니 */
	@Deprecated
	public static final String PAY_MEANS_21 = "21";
	
	/** 매체 구분 */
	/** 매체 구분 : 고정 */
	public static final String MDA_GB_01 = "01";
	
	
	/** 현금영수증 발급 코드 : 소득공제용 */
	public static final String RECEIPT_TYPE_1 = "1";
	/** 현금영수증 발급 코드 : 지출증빙용 */
	public static final String RECEIPT_TYPE_2 = "2";
	
	
	/** 부분취소 코드: 전체 취소 */
	public static final String PART_CANCEL_CODE_0 = "0";
	/** 부분취소 코드: 부분 취소 */
	public static final String PART_CANCEL_CODE_1 = "1";
	
	/** 결제 수단 코드: 신용카드 */
	public static final String PAY_METHOD_CARD = "CARD";
	/** 결제 수단 코드: 계좌이체 */
	public static final String PAY_METHOD_BANK = "BANK";
	/** 결제 수단 코드: 가상계좌 */
	public static final String PAY_METHOD_VBANK = "VBANK";
	/** 결제 수단 코드: 핸드폰 */
	public static final String PAY_METHOD_CELLPHONE = "CELLPHONE";

	/** 승인 취소 사유 코드 : CS 취소 */
	public static final String CANCEL_MSG_CS = "CS 취소";
	
	/** 승인 취소 사유 코드 : 환불 */
	public static final String CANCEL_MSG_REFUND = "환불";
	
	/** 은행 코드 : 국민은행*/
	public static final String BANK_004 = "004";
	/** 은행 코드 : 기업은행*/
	public static final String BANK_003 = "003";
	/** 은행 코드 : 신한은행*/
	public static final String BANK_088 = "088";
	/** 은행 코드 : 우리은행*/
	public static final String BANK_020 = "020";
	/** 은행 코드 : 하나은행*/
	public static final String BANK_081 = "081";
	
	/***************************
	 * 성공 코드 정의
	 ***************************/
	/** 예금주 성명 조회,, */
	public static final String COMMON_SUCCESS_CODE = "0000";
	
	/** 현금영수증 발급 요청 */
	public static final String CASH_RECEIPT_SUCCESS_CODE = "7001";
	
	/** 승인 취소 */
	public static final String CANCEL_PROCESS_SUCCESS_CODE = "2001";
	
	/** 가상계좌 승인 취소 */
	public static final String VIRTUAL_CANCEL_PROCESS_SUCCESS_CODE = "2211";
	
	/** 고정계좌 과오납 등록 */
	public static final String FIX_ACCOUNT_SUCCESS_CODE = "4120";
	
}