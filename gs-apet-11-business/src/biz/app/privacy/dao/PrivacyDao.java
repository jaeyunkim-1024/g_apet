package biz.app.privacy.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.privacy.model.PrivacyPolicyPO;
import biz.app.privacy.model.PrivacyPolicySO;
import biz.app.privacy.model.PrivacyPolicyVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.privacy.dao
* - 파일명		: PrivacyDao.java
* - 작성일		: 2017. 1. 16.
* - 작성자		: hongjun
* - 설명		: 개인정보처리방침 DAO
* </pre>
*/
@Repository
public class PrivacyDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "privacy.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Common area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyDao.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명		: 개인정보처리방침 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public PrivacyPolicyVO getSt(PrivacyPolicySO so){
		return selectOne(BASE_DAO_PACKAGE + "getPrivacy", so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyDao.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertPrivacyPolicy (PrivacyPolicyPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertPrivacyPolicy", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyDao.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 조회 [BO]
	* </pre>
	* @param bndNo
	* @return
	*/
	public PrivacyPolicyVO getPrivacyPolicy (Integer policyNo ) {
		return (PrivacyPolicyVO)selectOne(BASE_DAO_PACKAGE + "getPrivacyPolicy", policyNo );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PrivacyDao.java
	 * - 작성일		: 2017. 1. 16.
	 * - 작성자		: hongjun
	 * - 설명			: 최신 개인정보처리방침 단건 조회
	 * </pre>
	 * @param bndNo
	 * @return
	 */
	public PrivacyPolicyVO getNewPrivacyPolicy () {
		return (PrivacyPolicyVO)selectOne(BASE_DAO_PACKAGE + "getNewPrivacyPolicy");
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyDao.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<PrivacyPolicyVO> pagePrivacyPolicy (PrivacyPolicySO so ) {
		return selectListPage(BASE_DAO_PACKAGE + "pagePrivacyPolicy", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PrivacyDao.java
	* - 작성일		: 2017. 1. 16.
	* - 작성자		: hongjun
	* - 설명			: 개인정보처리방침 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updatePrivacyPolicy (PrivacyPolicyPO po ) {
		return update(BASE_DAO_PACKAGE + "updatePrivacyPolicy", po );
	}


}
