package biz.app.order.dao.interfaces.ob;

import org.springframework.stereotype.Repository;

import biz.app.order.model.interfaces.ob.ObApiBasePO;
import biz.app.order.model.interfaces.ob.ObOrderHistoryPO;
import biz.app.order.model.interfaces.ob.ObOrderResponsePO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.order.dao.interfaces.ob
* - 파일명	: ObOrderHistDao.java
* - 작성일	: 2017. 9. 18.
* - 작성자	: schoi
* - 설명		: Outbound API ObOrderHistDao
* </pre>
*/
@Repository
public class ObOrderHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "oborderhist.";

	/****************************
	 * Outbound API 이력 정보
	 ****************************/
	public int insertObApiBase( ObApiBasePO obApiBasePO ) {
		return insert( BASE_DAO_PACKAGE + "insertObApiBase", obApiBasePO );
	}
	
	/****************************
	 * Outbound API 주문 이력 상세 정보
	 ****************************/
	public int insertObOrderHistory( ObOrderHistoryPO obOrderHistoryPO ) {
		return insert( BASE_DAO_PACKAGE + "insertObOrderHistory", obOrderHistoryPO );
	}
	
	/****************************
	 * Outbound API 주문 Response
	 ****************************/
	public int insertObOrderResponse( ObOrderResponsePO obOrderResponsePO ) {
		return insert( BASE_DAO_PACKAGE + "insertObOrderResponse", obOrderResponsePO );
	}

}
