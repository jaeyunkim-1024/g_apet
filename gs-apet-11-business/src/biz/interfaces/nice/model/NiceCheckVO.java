package biz.interfaces.nice.model;

import java.io.Serializable;

import lombok.Data;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.common.model
* - 파일명		: NiceCheckVO.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Nice 체크 VO
* </pre>
*/
@Data
public class NiceCheckVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String 	encData;	// 암호화 된 데이타
	private boolean	rtnCode;	// 체크 결과 코드
	private String 	rtnMsg;	// 체크 결과 메세지
	
	private String	paramR1;
	private String	paramR2;
	private String	paramR3;
}