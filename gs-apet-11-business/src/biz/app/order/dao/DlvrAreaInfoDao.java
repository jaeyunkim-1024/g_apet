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
 * - 파일명		: DlvrAreaInfoDao.java
 * - 작성일		: 2021. 04. 20.
 * - 작성자		: JinHong
 * - 설명		: 배송 권역 정보 DAO
 * </pre>
 */
@Repository
public class DlvrAreaInfoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "dlvrAreaInfo.";
	
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
	 * - 작성일		: 2021. 04. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDlvrAreaInfo(OrderDlvrAreaPO po){
		return insert(BASE_DAO_PACKAGE + "insertDlvrAreaInfo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 04. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 매핑 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDlvrAreaPostMap(OrderDlvrAreaPO po){
		return insert(BASE_DAO_PACKAGE + "insertDlvrAreaPostMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 04. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 배치용 삭제
	 * </pre>
	 * @return
	 */
	public int deleteDlvrAreaPostMapForBatch(){
		return delete(BASE_DAO_PACKAGE + "deleteDlvrAreaPostMapForBatch");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 04. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 권역 매핑 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDlvrAreaPostMap(OrderDlvrAreaPO po){
		return update(BASE_DAO_PACKAGE + "updateDlvrAreaPostMap", po);
	}
}
