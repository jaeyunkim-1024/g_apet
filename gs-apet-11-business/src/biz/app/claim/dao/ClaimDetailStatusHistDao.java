package biz.app.claim.dao;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.ClaimDetailStatusHistPO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.dao
* - 파일명		: ClaimDetailStatusHistDao.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 클레임 상세 상태 이력 DAO
* </pre>
*/
@Repository
public class ClaimDetailStatusHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "claimDetailStatusHist.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailStatusHistDao.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 변경 이력 저장
	* </pre>
	* @param po
	* @return
	*/
	public int insertClaimDetailStatusHist( ClaimDetailStatusHistPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertClaimDetailStatusHist", po );
	}
	
}
