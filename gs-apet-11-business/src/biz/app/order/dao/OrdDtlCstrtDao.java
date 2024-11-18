package biz.app.order.dao;

import biz.app.order.model.OrdDtlCstrtPO;
import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.interfaces.CisOrderDeliveryCmdVO;
import biz.app.order.model.interfaces.CisOrderDeliveryStateChgVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrdDtlCstrtDao.java
* - 작성일		: 2021. 02. 01.
* - 작성자		: kek01
* - 설명			: 주문 상세 구성 DAO
* </pre>
*/
@Repository
public class OrdDtlCstrtDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "ordDtlCstrt.";

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 상세 구성 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrdDtlCstrtVO> listOrdDtlCstrt(OrderDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "listOrdDtlCstrt", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.order.dao
	* - 파일명		: OrdDtlCstrtDao.java
	* - 작성일		: 2021. 02. 01.
	* - 작성자		: kek01
	* - 설명		    : 주문 상세 구성 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateOrdDtlCstrt(OrdDtlCstrtPO po){
		return update(BASE_DAO_PACKAGE + "updateOrdDtlCstrt", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.order.dao
	* - 파일명		: OrdDtlCstrtDao.java
	* - 작성일		: 2021. 2. 2.
	* - 작성자		: kek01
	* - 설명			: CIS 배송지시 대상 주문상세내역 조회 (주문배송 + 클레임교환배송 대상)
	* </pre>
	* @return
	*/
	public List<CisOrderDeliveryCmdVO> listOrdDtlCstrtForSendCis(OrdDtlCstrtPO po) {
		return selectList(BASE_DAO_PACKAGE + "listOrdDtlCstrtForSendCis", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.order.dao
	 * - 파일명		: OrdDtlCstrtDao.java
	 * - 작성일		: 2021. 2. 17.
	 * - 작성자		: kek01
	 * - 설명		: CIS 배송상태 변경 대상 주문상세내역 조회 (주문배송 + 클레임교환배송 대상)
	 * </pre>
	 * @return
	 */
	public List<CisOrderDeliveryStateChgVO> listOrdDtlCstrtForChkCisDlvrStateChg() {
		return selectList(BASE_DAO_PACKAGE + "listOrdDtlCstrtForChkCisDlvrStateChg", "");
	}

	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listOrdDtlCstrtForOrder
	 * - 작성일		: 2021. 03. 28.
	 * - 작성자		: sorce
	 * - 설명			: 주문시 세트상품 리스트 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<OrdDtlCstrtVO> listOrdDtlCstrtForOrder(OrdDtlCstrtPO po) {
		return selectList(BASE_DAO_PACKAGE + "listOrdDtlCstrtForOrder", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.order.dao
	 * - 파일명		: OrdDtlCstrtDao.java
	 * - 작성일		: 2021. 3. 4.
	 * - 작성자		: valfac
	 * - 설명		: 주문상세구성 저장
	 * </pre>
	 * @return
	 */
	public int insertOrdDtlCstrt( OrdDtlCstrtVO vo ) {
		return insert( BASE_DAO_PACKAGE + "insertOrdDtlCstrt", vo);
	}
}
