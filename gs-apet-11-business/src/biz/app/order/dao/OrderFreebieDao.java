package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderFreebiePO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderFreebieDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 주문 사은품 DAO
* </pre>
*/
@Repository
@Deprecated
public class OrderFreebieDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderFreebie.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderCommonDao.java
	 * - 작성일	: 2016. 7. 5.
	 * - 작성자	: snw
	 * - 설명		: 사은품 등록
	 * </pre>
	 * @param freebiePO
	 * @return
	 */
	public int insertOrderFreebie( OrderFreebiePO freebiePO ) {
		return insert( BASE_DAO_PACKAGE + "insertOrderFreebie", freebiePO );
	}
	
}
