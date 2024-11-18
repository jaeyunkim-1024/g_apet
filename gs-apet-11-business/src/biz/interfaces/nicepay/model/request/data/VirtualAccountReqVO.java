package biz.interfaces.nicepay.model.request.data;

import biz.interfaces.nicepay.model.request.RequestCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class VirtualAccountReqVO extends RequestCommonVO{
	private static final long serialVersionUID = 1L;
	//필수 항목 start
	
	/** 상점에서 부여한 주문번호(Unique하게 구성) */
	private String Moid;
	
	/** 결제금액 */
	private String Amt;
	
	/** 상품명 */
	private String GoodsName;
	
	/** 증빙구분(1: 소득공제, 2: 지출증빙) */
	private String CashReceiptType;
	
	/** 
	 * 현금영수증 발급번호
	 * CashReceiptType=1 인 경우 휴대폰번호
	 * CashReceiptType=2 인 경우 사업자번호
	 */
	private String ReceiptTypeNo;
	
	/** 은행코드 */
	private String BankCode;
	
	/** 가상계좌 입금 만료일
	 * 8자리 또는 12자리(YYYYMMDD 또는 YYYYMMDDHHMI)
	 * 지정하지 않을 경우, 계약된 기본 입금 기한일로 자동 처리됨.
	*/
	private String VbankExpDate;
	
	//필수 항목 end
	
	
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
	
	/**
	 * 해당 값 설정 시
	 * 각 값의 합이 Amt와 일치해야 함.
	 * (필드 사용 전 영업담당자 협의 필요)
	*/
	/** 별도 공급가액 설정 시 사용 */
	String SupplyAmt;
	/** 별도 부가세 설정 시 사용 */
	String GoodsVat;
	/** 별도 봉사료 설정 시 사용 */
	String ServiceAmt;
	/** 별도 면세금액 설정 시 사용 */
	String TaxFreeAmt;
}