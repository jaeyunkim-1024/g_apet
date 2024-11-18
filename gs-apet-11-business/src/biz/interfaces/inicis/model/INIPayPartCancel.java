package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIPayPartCancel.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 부분 취소 정보 Object
* </pre>
*/
@Data
public class INIPayPartCancel {

	/** 결과코드 */
	private String 	resultCode;
	
	/** 결과 메세지 */
	private String 	resultMsg;
	
	/** 거래 번호 */
	private String	tid;
	
	/** 원 거래 번호 */
	private String	prtcTid;

	/** 최종 결제 금액 */
	private String 	prtcRemains;

	/** 부분 취소 금액 */
	private String	prtcPrice;
	
	/** 부분 취소 , 재송인 구분 값 */
	private String	prtcType;
	
	/** 부분 취소 요청 횟수 */
	private String	prtcCnt;
}
