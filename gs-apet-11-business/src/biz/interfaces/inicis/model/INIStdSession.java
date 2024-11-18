package biz.interfaces.inicis.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIStdSession.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 연계를 위한 세션 정보
* </pre>
*/
@Data
public class INIStdSession implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 스크립트 경로 */
	private String scrtPth;
	
	/** 버전 */
	private String version;
	
	/** 상점 아이디 */
	private String mid;

	/** 인증 시간 */
	private String	timestamp;
	
	/** signKey를 해시값으로 변경 한 값 */
	private String mkey;
	
	/** 결제 단위 */
	private String currency;
	
	/** return charset */
	private String	returnCharset;
	
	/** return url */
	private String returnUrl;

	/** close url */
	private String closeUrl;
	
	/** signature */
	private String signature;
	
	/** 결제 수단 */
	private String gopaymethod;

	/** 추가 요청 필드 */
	private String	acceptmethod;
	
	/********************************
	 * 결제 수단별 추가 정보
	 ********************************/
	/*
	 * Card
	 */
	/** 할부 개월 수 */
	private String cardQuotaBase	;

	/** 가맹점 부담 무이자 */
	private String cardNointerest;
}