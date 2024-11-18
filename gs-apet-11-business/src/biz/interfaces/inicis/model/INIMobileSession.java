package biz.interfaces.inicis.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIMobileSession.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay Mobile 연계를 위한 세션 정보
* </pre>
*/
@Data
public class INIMobileSession implements Serializable {

	private static final long serialVersionUID = 1L;

	
	/** 상점 아이디 */
	private String mid;
	
	/** 상점 명 */
	private String mnm;
	
	/** 결제 URL */
	private String payUrl;
	
	/** next url */
	private String nextUrl;
	
	/** noti url */
	private String notiUrl;

	/** return charset */
	private String	returnCharset;
	
	/** 복합 필드 */
	private String reserved;

	/** 가맹점 추가 필드 */
	private String noti;

	/*******************************
	 * 결제수단별 설정
	 *******************************/
	/*
	 * 신용카드
	 */
	/** 할부기간 */
	private String quotabase;

	/*
	 * 가상계좌
	 */
	/** 가상계좌 입금기한 일자 */
	private String vbankDate;
	
	/** 가상계좌 입금기한 시간(시분) */
	private String vbankTime;
}