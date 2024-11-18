package biz.app.claim.service.interfaces.ob;

import biz.app.claim.model.interfaces.ob.ObClaimBasePO;
import biz.app.claim.model.interfaces.ob.ObClaimResponsePO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.claim.service.interfaces.ob
* - 파일명	: ObClaimService.java
* - 작성일	: 2017. 10. 13.
* - 작성자	: schoi
* - 설명		: Outbound API 클레임 서비스
* </pre>
*/

public interface ObClaimService {
	
	/****************************
	 * Outbound API 주문 클레임 이력 정보
	 ****************************/
	public void insertObClaimBase(ObClaimBasePO obClaimBasePO);	
	
	/****************************
	 * Outbound API 이력 상세 정보
	 ****************************/
	public void insertObClaimHistory(ObClaimBasePO obClaimBasePO);
	
	/****************************
	 * Outbound API Response 이력 상세 정보
	 ****************************/
	public void insertObClaimResponse(ObClaimResponsePO obClaimResponsePO);
	
}
