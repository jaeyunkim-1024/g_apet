package biz.interfaces.nice.model;

import java.io.Serializable;

import lombok.Data;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.common.model
* - 파일명		: NiceCertifyVO.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Nice 인증 기본 정보
* </pre>
*/
@Data
public class NiceCertifyVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String 	authType;	// 인증 유형
	private String 	encData;	// 암호화 된 데이타
	private String	paramR1;
	private String	paramR2;
	private String	paramR3;
	
}