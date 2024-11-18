package biz.app.claim.service;

import biz.app.claim.model.ClaimBaseVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.service
* - 파일명		: ClaimBaseService.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 클레임 기본 서비스 Interface
* </pre>
*/
public interface ClaimBaseService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimBaseService.java
	* - 작성일		: 2017. 4. 7.
	* - 작성자		: snw
	* - 설명			: 클레임 기본 상세 조회
	* </pre>
	* @param clmNo
	* @return
	*/
	public ClaimBaseVO getClaimBase(String clmNo);
}