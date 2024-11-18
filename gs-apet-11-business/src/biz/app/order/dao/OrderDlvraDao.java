package biz.app.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderDlvraDao.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 배송지 DAO
* </pre>
*/
@Repository
public class OrderDlvraDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderDlvra.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDlvraDao.java
	* - 작성일		: 2017. 1. 23.
	* - 작성자		: snw
	* - 설명			: 주문 배송지 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertOrderDlvra( OrderDlvraPO po ) {
		if(po.getTel() != null && !"".equals(po.getTel())){
			po.setTel(po.getTel().replaceAll("-", ""));
		}
		if(po.getMobile() != null && !"".equals(po.getMobile())){
			po.setMobile(po.getMobile().replaceAll("-", ""));
		}		
		if(po.getPostNoOld() != null && !"".equals(po.getPostNoOld())){
			po.setPostNoOld(po.getPostNoOld().replaceAll("-", ""));
		}		
		return insert( BASE_DAO_PACKAGE + "insertOrderDlvra", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDlvraDao.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: Administrator
	* - 설명			: 주문 배송지 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDlvraVO> listOrderDlvra(OrderDlvraSO so) {
		return selectList(BASE_DAO_PACKAGE + "listOrderDlvra", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDlvraDao.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문 배송지 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public OrderDlvraVO getOrderDlvra(OrderDlvraSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getOrderDlvra", so);
	}
	
}
