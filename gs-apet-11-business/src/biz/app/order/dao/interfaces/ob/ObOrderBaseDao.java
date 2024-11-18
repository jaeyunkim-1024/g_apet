package biz.app.order.dao.interfaces.ob;

import org.springframework.stereotype.Repository;

import biz.app.order.model.interfaces.ob.ObOrderBasePO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao.interfaces.ob
* - 파일명		: ObOrderBaseDao.java
* - 작성일		: 2017. 9. 18.
* - 작성자		: kimdp
* - 설명			: Outbound API ObOrderBaseDao
* </pre>
*/
@Repository
public class ObOrderBaseDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "oborderbase.";

	public int insertObOrderBase( ObOrderBasePO obOrderBasePO ) {
		return insert( BASE_DAO_PACKAGE + "insertObOrderBase", obOrderBasePO );
	}	
}
