package biz.app.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderDlvrAreaPO;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business	
 * - 패키지명	: biz.app.order.dao
 * - 파일명		: OrderDlvrAreaDao.java
 * - 작성일		: 2021. 03. 01.
 * - 작성자		: JinHong
 * - 설명		: 주문 배송 권역 DAO
 * </pre>
 */
@Repository
public class OrderDlvrAreaDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderDlvrArea.";
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 02.
	 * - 작성자		: JinHong
	 * - 설명		: +2일 휴무일 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDlvrAreaVO> listDlvrAreaClsdDt(OrderDlvrAreaSO so){
		return selectList(BASE_DAO_PACKAGE + "listDlvrAreaClsdDt", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 02.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 정보
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderDlvrAreaVO getDlvrAreaInfo(OrderDlvrAreaSO so){
		return selectOne(BASE_DAO_PACKAGE + "getDlvrAreaInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 04.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 권역 매핑 삭제 - 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteOrderDlvrAreaMap(OrderDlvrAreaPO po){
		return update(BASE_DAO_PACKAGE + "deleteOrderDlvrAreaMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 07.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 정보 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDlvrAreaVO> listDlvrAreaInfo(OrderDlvrAreaSO so){ 
		return selectList(BASE_DAO_PACKAGE + "listDlvrAreaInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 04. 07.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 배송 권역 매핑 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertOrderDlvrAreaMap(OrderDlvrAreaPO po){
		return insert(BASE_DAO_PACKAGE + "insertOrderDlvrAreaMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 04. 08.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 배송 권역 매핑 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderDlvrAreaVO getOrdDlvrAreaInfo(OrderDlvrAreaSO so){
		return selectOne(BASE_DAO_PACKAGE + "getOrdDlvrAreaInfo", so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 설명		: 휴무일 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderDlvrAreaVO dlvrAreaClsdDt(OrderDlvrAreaSO so){
		return selectOne(BASE_DAO_PACKAGE + "dlvrAreaClsdDt", so);
	}	
}
