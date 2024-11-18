package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIStdApprove.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 승인정보 Object
* </pre>
*/
@Data
public class INIStdApprove {

	/** 결과코드 */
	private String 	resultCode;
	
	/** 결과 메세지 */
	private String 	resultMsg;

	/**************************
	 * 공통 변수
	 **************************/
	/** 가맹점 아이디 */
	private String	mid;
	
	/** 거래 번호 */
	private String 	tid;
	
	/** 지불 수단 */
	private String 	payMethod;
	
	/** 결제 완료 금액 */
	private String 	totPrice;
	
	/** 주문 번호 */
	private String 	moid;
	
	/** 숭인 일자 */
	private String 	applDate;
	
	/** 승인 시간 */
	private String 	applTime;
	
	/**************************
	 * 신용 카드
	 **************************/	
	/** 카드 종류 */
	private String 	cardCode;
	
	/** 카드 발급사 */
	private String 	cardBankCode;
	
	/** 카드번호 */
	private String	cardNum;
	
	/** 승인 번호 */
	private String 	applNum;
	
	/** 카드 할부 기간 */
	private String	cardQuota;
	
	/**************************
	 * 가상 계좌
	 **************************/	
	/** 입금 계좌 번호 */
	private String 	vactNum;

	/** 입금 은행코드 */
	private String 	vactBankCode;
	
	/** 입금 은행명 */
	private String 	vactBankName;
	
	/** 예금주 명 */
	private String 	vactName;
	
	/** 송금자 명 */
	private String 	vactInputName;
	
	/** 송금 일자 */
	private String	vactDate;
	
	/** 송금 시간 */
	private String	vactTime;
	
	/**************************
	 * 실시간 계좌이체
	 **************************/	
	/** 은행코드 */
	private String 	acctBankCode;

	/** 현금영수증 발급결과코드 */
	private String 	cshrResultCode;
	
	/** 현금영수증 발급구분코드 */
	private String 	cshrType;
	
}
