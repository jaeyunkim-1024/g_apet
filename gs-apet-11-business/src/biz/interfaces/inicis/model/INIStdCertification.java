package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIStdCertification.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 웹표준 인증정보 Object
* </pre>
*/
@Data
public class INIStdCertification {

	/** 결과코드 */
	private String 	resultCode;
	
	/** 결과 메세지 */
	private String 	resultMsg;
	
	/** 가맹점 아이디 */
	private String	mid;
	
	/** 가맹점 주문번호 */
	private String 	orderNumber;
	
	/** 인증 검증 토큰 */
	private String 	authToken;
	
	/** 승인 요청 URL */
	private String 	authUrl;
	
	/** 망취소 요청 URL */
	private String 	netCancelUrl;
	
	/** 문자 셋 */
	private String 	charset;
	
	/** 가맹점 관리 데이터*/
	private String 	merchantData;
}
