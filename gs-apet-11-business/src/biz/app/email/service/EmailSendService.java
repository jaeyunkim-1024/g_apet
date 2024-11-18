package biz.app.email.service;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.service
* - 파일명		: EmailSendService.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 서비스 Interface
* </pre>
*/
@Deprecated
public interface EmailSendService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryService.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 예정 키 목록 조회
	* </pre>
	* @return
	*/
	public List<Long> listEmailSendHistoryReq();
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendService.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 처리
	* </pre>
	* @param histNo
	*/
	public void sendDcgEmail(Long histNo);
}