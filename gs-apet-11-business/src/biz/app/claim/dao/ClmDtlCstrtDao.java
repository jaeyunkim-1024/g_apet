package biz.app.claim.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.order.model.interfaces.CisOrderReturnCmdVO;
import biz.app.order.model.interfaces.CisOrderReturnStateChgVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.dao
* - 파일명		: ClmDtlCstrtDao.java
* - 작성일		: 2021. 02. 15.
* - 작성자		: kek01
* - 설명			: 클레임 상세 구성 DAO
* </pre>
*/
@Repository
public class ClmDtlCstrtDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "clmDtlCstrt.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.claim.dao
	* - 파일명		: ClmDtlCstrtDao.java
	* - 작성일		: 2021. 02. 15.
	* - 작성자		: kek01
	* - 설명		    : 클레임 상세 구성 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateClmDtlCstrt(ClmDtlCstrtPO po){
		return update(BASE_DAO_PACKAGE + "updateClmDtlCstrt", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.claim.dao
	* - 파일명		: ClmDtlCstrtDao.java
	* - 작성일		: 2021. 3. 9.
	* - 작성자		: pse
	* - 설명			: 클레임 상세 구성 리스트 조회
	* </pre>
	* @param po
	* @return
	*/
	public List<ClmDtlCstrtPO> listClmDtlCstrt(ClaimDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "listClmDtlCstrt", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.order.dao
	* - 파일명		: ClmDtlCstrtDao.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: kek01
	* - 설명			: CIS 회수지시 대상 조회 (클레임 반품접수, 클레임 교환회수접수 대상)
	* </pre>
	* @return
	*/
	public List<CisOrderReturnCmdVO> listClmDtlCstrtForSendCis() {
		return selectList(BASE_DAO_PACKAGE + "listClmDtlCstrtForSendCis", "");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.order.dao
	 * - 파일명		: ClmDtlCstrtDao.java
	 * - 작성일		: 2021. 3. 12.
	 * - 작성자		: kek01
	 * - 설명		: CIS 회수 상태 변경 대상 조회 (클레임 반품, 클레임 교환회수 대상)
	 * </pre>
	 * @return
	 */
	public List<CisOrderReturnStateChgVO> listClmDtlCstrtForChkCisDlvrStateChg() {
		return selectList(BASE_DAO_PACKAGE + "listClmDtlCstrtForChkCisDlvrStateChg", "");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.claim.dao
	 * - 작성일		: 2021. 03. 12.
	 * - 작성자		: JinHong
	 * - 설명		: 클레임 상세 구성 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertClmDtlCstrt(ClmDtlCstrtPO po){
		return insert(BASE_DAO_PACKAGE + "insertClmDtlCstrt", po);
	}
	
}
