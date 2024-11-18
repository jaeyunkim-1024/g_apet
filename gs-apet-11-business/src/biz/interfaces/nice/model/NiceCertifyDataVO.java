package biz.interfaces.nice.model;

import java.io.Serializable;

import lombok.Data;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.common.model
* - 파일명		: NiceCertifyDataVO.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Nice 인증 데이터
* </pre>
*/
@Data
public class NiceCertifyDataVO implements Serializable{

	private static final long serialVersionUID = 1L;

	private boolean	rtnCode;	// 체크 결과 코드
	private String 	rtnMsg;	// 체크 결과 메세지
	private String	authType;	//인증수단
	private String	reqNo;		// 요청번호
	private String	name;		// 인증 고객 실명
	private String	dupInfo;	// 증복가입 확인 정보(DI)
	private String	colInfo;	// 연계정보(CI)
	private String	genderCode;	// 성별코드(0:여성, 1:남성)
	private String	birthDate;	// 생년월일(YYYYMMDD)
	private String	nationalInfo;	//국적정보(0:내국인, 1:외국인)
	
	private String	errorCode;	// CheckPlus에서 사용하는 에러코드
}