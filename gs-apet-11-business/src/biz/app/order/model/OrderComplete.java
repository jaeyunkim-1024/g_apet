package biz.app.order.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayBaseComplete.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 결제 완료 정보
* </pre>
*/
@Data
public class OrderComplete  implements Serializable{

	private static final long serialVersionUID = 1L;

	/** 일련번호 */
	private Long	payNo;
	
	/** 회원번호 */
	private Long 	mbrNo;

	/** 주문 번호 */
	private String 	ordNo;
	
	/** 결제 수단 */
	private String 	payMeansCd;

	/** 카드사코드 */
	private String 	cardcCd;

	/** 카드 번호 */
	private String 	cardNo;

	/** 할부개월수 */
	private String halbu;

	/** 무이자여부 */
	private String cardInterest;
	/** jsonString */
	private String lnkRspsRst;
	
	/******************************
	 * 지출 증빙 자료
	 ******************************/
	/*
	 * 현금 영수증
	 */
	/** 사용 구분 코드 */
	private String	useGbCd;
	
	/** 개인 휴대폰 번호 */
	private String 	isuMeansNoPhn;

	/** 사업자 등록번호 */
	private String 	isuMeansNoBiz;

	/********************************
	 * 결제 정보
	 ********************************/

	/** 전체 결제 금액 : 실결제 총금액 */
	private Long 	payAmt;

	/** 상점 아이디 */
	private String	strId;
	
	/*
	 * INIpay 결제정보
	 */
	/** Web Standard 인증 정보 */ 
	private String inipayStdCertifyInfo;

	/** Web Mobile 인증 정보 */ 
	private String inipayMobileCertifyInfo;

	/*
	 *  가상 계좌
	 */
	/** 계좌 정보 번호  */
	private Long acctInfoNo;	
	
	/** 입금자명  */
	private String dpstrNm;
	private String dpstSchdDt;
	private String dpstSchdAmt;
	private String vbankBankCode;

	private String authResultCode;
	private String authResultMsg;
	private String nextAppURL;
	private String txTid;
	private String tid;
	private String authToken;
	private String payMethod;
	private String goodsName;
	private String mid;
	private String moid;
	private Long amt;
	private String reqReserved;
	private String authCode;
	private String authDate;
	private String resultCode;
	private String resultMsg;
	private String cardCode;
	private String cardQuota;
	private String bankCode;
	private String bankName;
	private String rcpType;
	private String rcptTID;
	private String rcptAuthCode;
	private String vbankBankName;
	private String vbankNum;
	private String vbankExpDate;
	private String vbankExpTime;

	private String defaultPayMethodSaveYn;

	private String gsptNo;

	//사용안함
	private Long svmnUseAmt;
	
	private Long useGsPoint;

	private String cashRctGbCd;

	private String cashRctGbVal;

	private String prsnCardBillNo;
	
	private String cashReceiptType;
	
	private String receiptTypeNo;
}
