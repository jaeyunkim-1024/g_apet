package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIPayCancel.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 승인 취소 정보 Object
* </pre>
*/
@Data
public class INIPayCancel {

	/** 결과코드 */
	private String 	resultCode;
	
	/** 결과 메세지 */
	private String 	resultMsg;

	/** 취소일자 : YYYYMMDD */
	private String 	cancelDate;

	/** 취소 시간 : HHMMSS */
	private String 	cancelTime;

	/** 현금영수증 취소 승인 번호 : 현금영수증 발급 취소시에만 리턴됨 */
	private String cshrCancelNum;
	
}
