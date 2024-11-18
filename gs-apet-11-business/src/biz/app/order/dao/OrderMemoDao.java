package biz.app.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderMemoPO;
import biz.app.order.model.OrderMemoSO;
import biz.app.order.model.OrderMemoVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderMemoDao.java
* - 작성일		: 2017. 1. 11.
* - 작성자		: snw
* - 설명			: 주문 메모 DAO
* </pre>
*/
@Repository
public class OrderMemoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderMemo.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoDao.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderMemoVO> listOrderMemo ( OrderMemoSO so){
		return selectList(BASE_DAO_PACKAGE + "listOrderMemo", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoDao.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 등록
	* </pre>
	* @param orderMemoPO
	* @return
	*/
	public int insertOrderMemo( OrderMemoPO orderMemoPO ) {
		return insert( BASE_DAO_PACKAGE + "insertOrderMemo", orderMemoPO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoDao.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 수정
	* </pre>
	* @param orderMemoPO
	* @return
	*/
	public int updateOrderMemo( OrderMemoPO orderMemoPO ) {
		return insert( BASE_DAO_PACKAGE + "updateOrderMemo", orderMemoPO );
	}

}
