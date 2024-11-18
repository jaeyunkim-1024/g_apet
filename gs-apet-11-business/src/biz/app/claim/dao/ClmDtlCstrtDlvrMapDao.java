package biz.app.claim.dao;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.ClmDtlCstrtDlvrMapPO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.dao
* - 파일명		: ClmDtlCstrtDlvrMapDao.java
* - 작성일		: 2021. 02. 15.
* - 작성자		: kek01
* - 설명			: 클레임 상세 구성 배송 매핑 DAO
* </pre>
*/
@Repository
public class ClmDtlCstrtDlvrMapDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "clmDtlCstrtDlvrMap.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.claim.dao
	* - 파일명		: ClmDtlCstrtDlvrMapDao.java
	* - 작성일		: 2021. 02. 15.
	* - 작성자		: kek01
	* - 설명		    : 클레임 상세 구성 배송 매핑 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertClmDtlCstrtDlvrMap(ClmDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "insertClmDtlCstrtDlvrMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.claim.dao
	 * - 파일명		: ClmDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: kek01
	 * - 설명		: 클레임 상세 구성 배송 매핑 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertClmDtlCstrtDlvrMapByClmNo(ClmDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "insertClmDtlCstrtDlvrMapByClmNo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.claim.dao
	 * - 파일명		: ClmDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: kek01
	 * - 설명		: 클레임 상세 구성 배송 매핑 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertClmDtlCstrtDlvrMapByDlvrNo(ClmDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "insertClmDtlCstrtDlvrMapByDlvrNo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.claim.dao
	 * - 파일명		: ClmDtlCstrtDlvrMapDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: kek01
	 * - 설명		: 클레임 상세 구성 배송 매핑 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateClmDtlCstrtDlvrMap(ClmDtlCstrtDlvrMapPO po){
		return update(BASE_DAO_PACKAGE + "updateClmDtlCstrtDlvrMap", po);
	}
}
