package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderDetailStatusHistPO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderDetailStatusHistDao.java
* - 작성일		: 2017. 1. 13.
* - 작성자		: snw
* - 설명			: 주문 상세 상태 이력 DAO
* </pre>
*/
@Repository
public class OrderDetailStatusHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderDetailStatusHist.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailStatusHistDao.java
	* - 작성일		: 2017. 1. 13.
	* - 작성자		: snw
	* - 설명			: 주문 상세 상태 이력 등록
	* </pre>
	* @param orderDetailStatusHistPO
	* @return
	*/
	public int insertOrderDetailStatusHist( OrderDetailStatusHistPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertOrderDetailStatusHist", po);
	}
}
