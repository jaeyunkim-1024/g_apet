package biz.app.claim.service;

import biz.app.claim.model.ClaimRegist;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.service
* - 파일명		: ClaimSendService.java
* - 작성일		: 2017. 6. 30.
* - 작성자		: Administrator
* - 설명			: 클레임 전송 서비스
* </pre>
*/
public interface ClaimSendService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimSendService.java
	* - 작성일		: 2017. 6. 30.
	* - 작성자		: Administrator
	* - 설명			: 클레임 접수 메일 및 Sms 전송
	* </pre>
	* @param ordNo
	*/
	public void sendClaimAccept(String clmNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.claim.service
	 * - 작성일		: 2021. 03. 22.
	 * - 작성자		: JinHong
	 * - 설명		: 클레임 접수 - 티켓 사건 추가
	 * </pre>
	 * @param clmRegist
	 */
	public void sendAddTicketIncident(ClaimRegist clmRegist);
	
}
