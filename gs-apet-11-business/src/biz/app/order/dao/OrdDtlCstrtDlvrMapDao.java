package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrdDtlCstrtDlvrMapPO;
import biz.app.order.model.OrdDtlCstrtDlvrMapSO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrdDtlCstrtDlvrMapDao.java
* - 작성일		: 2021. 02. 10.
* - 작성자		: kek01
* - 설명			: 주문 상세 구성 배송 매핑 DAO
* </pre>
*/
@Repository
public class OrdDtlCstrtDlvrMapDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "ordDtlCstrtDlvrMap.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.order.dao
	* - 파일명		: OrdDtlCstrtDlvrMapDao.java
	* - 작성일		: 2021. 02. 10.
	* - 작성자		: kek01
	* - 설명		    : 주문 상세 구성 배송 매핑 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertOrdDtlCstrtDlvrMap(OrdDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "insertOrdDtlCstrtDlvrMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명		: biz.app.order.dao
	 * - 파일명		: OrdDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: kek01
	 * - 설명		    : 주문 상세 구성 배송 매핑 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertOrdDtlCstrtDlvrMapByOrdNo(OrdDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "insertOrdDtlCstrtDlvrMapByOrdNo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명		: biz.app.order.dao
	 * - 파일명		: OrdDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: kek01
	 * - 설명		: 주문 상세 구성 배송 매핑 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertOrdDtlCstrtDlvrMapByDlvrNo(OrdDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "insertOrdDtlCstrtDlvrMapByDlvrNo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.order.dao
	 * - 파일명		: OrdDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: kek01
	 * - 설명		: 주문 상세 구성 배송 매핑 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateOrdDtlCstrtDlvrMap(OrdDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "updateOrdDtlCstrtDlvrMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.order.dao
	 * - 파일명		: OrdDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 04. 05.
	 * - 작성자		: kek01
	 * - 설명		: 배송번호가 동일한 주문(클레임)상세에 매핑된 경우, 매핑된 카운트 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer getDlvrNoUseCount(OrdDtlCstrtDlvrMapSO so) {
		return (Integer) selectOne(BASE_DAO_PACKAGE + "getDlvrNoUseCount", so);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: OrdDtlCstrtDlvrMapDao.java
	* - 작성일	: 2021. 8. 5.
	* - 작성자 	: valfac
	* - 설명 		: 배송지시시 중복으로 등록된 데이터 삭제(대표배송번호 외 삭제)
	* </pre>
	*
	* @param po
	* @return
	*/
	public int deleteOrdDtlCstrtDlvrMap(OrdDtlCstrtDlvrMapPO po){
		return delete(BASE_DAO_PACKAGE + "deleteOrdDtlCstrtDlvrMap", po);
	}
	
}
