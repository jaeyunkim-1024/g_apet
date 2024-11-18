package biz.app.claim.dao.interfaces.ob;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.interfaces.ob.ObClaimBasePO;
import biz.app.claim.model.interfaces.ob.ObClaimResponsePO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.claim.dao.interfaces.ob
* - 파일명	: ObClaimHistDao.java
* - 작성일	: 2017. 10. 13.
* - 작성자	: schoi
* - 설명		: Outbound API ObClaimHistDao
* </pre>
*/
@Repository
public class ObClaimHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "obclaimhist.";
	
	/****************************
	 * Outbound API 클레임 이력 상세 정보
	 ****************************/
	public int insertObClaimHistory( ObClaimBasePO obClaimBasePO ) {
		return insert( BASE_DAO_PACKAGE + "insertObClaimHistory", obClaimBasePO );
	}
	
	/****************************
	 * Outbound API 클레임 Response
	 ****************************/
	public int insertObClaimResponse( ObClaimResponsePO obClaimResponsePO ) {
		return insert( BASE_DAO_PACKAGE + "insertObClaimResponse", obClaimResponsePO );
	}

}
