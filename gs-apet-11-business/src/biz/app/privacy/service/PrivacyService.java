package biz.app.privacy.service;

import java.util.List;

import biz.app.privacy.model.PrivacyPolicyPO;
import biz.app.privacy.model.PrivacyPolicySO;
import biz.app.privacy.model.PrivacyPolicyVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.privacy.service
* - 파일명		: PrivacyService.java
* - 작성일		: 2017. 1. 16.
* - 작성자		: hongjun
* - 설명		: 개인정보처리방침 서비스 Interface
* </pre>
*/
public interface PrivacyService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Common area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyService.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명		: 개인정보처리방침 단건 조회
	* </pre>
	* @param policyNo
	* @return
	* @throws Exception
	*/
	PrivacyPolicyVO getPrivacy(Integer policyNo);

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyService.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 등록
	* </pre>
	* @param po
	* @return
	*/
	public Long insertPrivacy (PrivacyPolicyPO privacyPolicyPO);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyService.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 조회 [BO]
	* </pre>
	* @param policyNo
	* @return
	*/
	public PrivacyPolicyVO getPrivacyPolicy (Integer policyNo);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: PrivacyService.java
	 * - 작성일		: 2017. 1. 16.
	 * - 작성자		: hongjun
	 * - 설명			: 최신 개인정보 취급방침 단건 조회
	 * </pre>
	 * @param policyNo
	 * @return
	 */
	public PrivacyPolicyVO getNewPrivacyPolicy ();


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyService.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<PrivacyPolicyVO> pagePrivacyPolicy (PrivacyPolicySO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyService.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 수정
	* </pre>
	* @param privacyPolicyPO
	* @return
	*/
	public Long updatePrivacyPolicy (PrivacyPolicyPO privacyPolicyPO);
}