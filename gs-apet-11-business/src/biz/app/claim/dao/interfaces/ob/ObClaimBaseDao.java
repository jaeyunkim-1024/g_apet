package biz.app.claim.dao.interfaces.ob;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.interfaces.ob.ObClaimBasePO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.dao.interfaces.ob
* - 파일명		: ObClaimBaseDao.java
* - 작성일		: 2017. 10. 19.
* - 작성자		: kimdp
* - 설명			: Outbound API ObClaimBaseDao
* </pre>
*/
@Repository
public class ObClaimBaseDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "obclaimbase.";

	public int insertObClaimBase( ObClaimBasePO obClaimBasePO ) {
		return insert( BASE_DAO_PACKAGE + "insertObClaimBase", obClaimBasePO );
	}	
}