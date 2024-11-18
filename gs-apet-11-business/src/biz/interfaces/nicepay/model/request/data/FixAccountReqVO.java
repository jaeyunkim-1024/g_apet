package biz.interfaces.nicepay.model.request.data;

import biz.interfaces.nicepay.model.request.RequestCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class FixAccountReqVO extends RequestCommonVO{
	private static final long serialVersionUID = 1L;
	//필수 항목 start
	
	/** 상점에서 부여한 주문번호(Unique하게 구성) */
	private String Moid;
	
	/** 결제금액 */
	private String Amt;
	
	/** 은행코드 */
	private String VbankBankCode;
	
	/** 입금계좌번호 */
	private String VbankNum;
	
	/** 입금 예금주명 */
	private String VbankAccountName;
	
	/** 입금 만료 시간  6자리(HHMISS) ex) 180000*/
	private String VbankExpDate;
	
	/** 입금 마감시간. 6자리(HHMISS) ex) 180000 */
	private String VbankExpTime;
	
	/** 증빙구분(1: 소득공제, 2: 지출증빙) */
	private String ReceiptType;
	
	//필수 항목 end
	
	/** 
	 * 현금영수증 발급번호
	 * CashReceiptType=1 인 경우 휴대폰번호
	 * CashReceiptType=2 인 경우 사업자번호
	 */
	private String ReceiptTypeNo;
	
	/** 0: 일반거래(Default), 1: 에스크로거래 */
	private String TransType;
	
	/**
	 * 휴대폰번호 또는 사업자번호(‘-‘ 없이 숫자만 입력)
	 * TransType이 1(에스크로거래)인 경우 필수
	 */
	String BuyerAuthNum;
	
	/** 구매자 이름 */
	String BuyerName;
	/** 구매자 이메일주소 */
	String BuyerEmail;
	/** 구매자 전화번호, ‘-‘ 없이 숫자만 입력 */
	String BuyerTel;
}