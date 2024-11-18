package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIMobileCertification.java
* - 작성일		: 2017. 4. 27.
* - 작성자		: Administrator
* - 설명			: INIpay Mobile 인증정보 Object
* </pre>
*/
@Data
public class INIMobileCertification {

	/** 결과코드 */
	private String	P_STATUS;
	
	/** 결과 메세지 */
	private String 	P_RMESG1;
	
	/** 인증거래번호 */
	private String	P_TID;
	
	/** 승인요청 Url */
	private String	P_REQ_URL;
	
	/** 기타주문정보 : 가맹점 결제모듈 호출시 설정값 그대로 리턴 */
	private String	P_NOTI;
	
}
