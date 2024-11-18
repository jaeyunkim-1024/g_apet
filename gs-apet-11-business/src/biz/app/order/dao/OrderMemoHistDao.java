package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderMemoHistPO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderMemoHistDao.java
* - 작성일		: 2017. 1. 11.
* - 작성자		: snw
* - 설명			: 주문 메모 이력 DAO
* </pre>
*/
@Repository
public class OrderMemoHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderMemoHist.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoHistDao.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertOrderMemoHist( OrderMemoHistPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertOrderMemoHist", po );
	}

}
