package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIRcptApprove.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 현금영수증 승인 Object
* </pre>
*/
@Data
public class INIRcptApprove {

	/** 결과 코드 */
	private String 	resultCode;

	/** 결과 메세지 */
	private String 	resultMsg;

	/** 지불방법 */
	private String	paymethod;
	
	/** 거래번호 */
	private String 	tid;

	/** 승인 번호 */
	private  String 	applNum;
	
	/** 승인날짜 : YYYYMMDD */
	private String 	applDate;
	
	/** 승인시각 : HHMMSS */
	private  String 	applTime;
	
	/** 총 결제 금액 */
	private  String 	cshrPrice;
	
	/** 공급가 */
	private String 	rsupPrice;
	
	/** 부가세 */
	private String 	rtax;
	
	/** 봉사료 */
	private  String 	rsrvcPrice;
	
	/** 현금영수증 사용구분 */
	private String 	rshrType;
}
