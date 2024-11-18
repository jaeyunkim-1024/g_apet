package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.GsPntHistVO;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrdSavePntSO;
import biz.app.order.model.OrdSavePntVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.dao
 * - 파일명		: OrdSavePntDao.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: JinHong
 * - 설명		: 주문 적립 포인트 DAO
 * </pre>
 */
@Repository
public class OrdSavePntDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "ordSavePnt.";

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: JinHong
	 * - 설명		: GS 포인트 이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertGsPntHist( OrdSavePntPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertGsPntHist", po );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 적립 포인트 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertOrdSavePntInfo( OrdSavePntPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertOrdSavePntInfo", po );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 적립 포인트 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateOrdSavePntInfo( OrdSavePntPO po ) {
		return update( BASE_DAO_PACKAGE + "updateOrdSavePntInfo", po );
	}
	
	
	public OrdSavePntVO getOrdSavePntInfo( OrdSavePntSO so ) {
		return selectOne( BASE_DAO_PACKAGE + "getOrdSavePntInfo", so );
	}
	
	public GsPntHistVO getSavePntHist( OrdSavePntSO so ) {
		return selectOne( BASE_DAO_PACKAGE + "getSavePntHist", so );
	}
}
