package biz.interfaces.cis.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.interfaces.cis.model.CisIfLogPO;
import biz.interfaces.cis.model.CisIfLogSO;
import biz.interfaces.cis.model.CisIfLogVO;
import framework.common.dao.MainAbstractDao;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.interfaces.cis.dao
* - 파일명		: CisIfLogDao.java
* - 작성일		: 2021. 1. 15.
* - 작성자		: kek01
* - 설명			: CisIfLog DAO
* </pre>
*/

@Repository
public class CisIfLogDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "cisIfLog.";
	
	/**
	 * CIS IF Log 등록
	 * @param po
	 * @return
	 */
	public int insertCisIfLog(CisIfLogPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCisIfLog", po);
	}
	
	/**
	 * CIS IF Log 등록
	 * @param po
	 * @return
	 */
	public int insertCisIfLogOne(CisIfLogPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCisIfLogOne", po);
	}
	
	/**
	 * CIS IF Log 수정
	 * @param po
	 * @return
	 */
	public int updateCisIfLog(CisIfLogPO po) {
		return insert(BASE_DAO_PACKAGE + "updateCisIfLog", po);
	}
	
	/**
	 * CIS IF Log 삭제
	 * @param po
	 * @return
	 */
	public int deleteCisIfLog(CisIfLogPO po) {
		return insert(BASE_DAO_PACKAGE + "deleteCisIfLog", po);
	}
	
	/**
	 * CIS IF Log 조회
	 * @param so
	 * @return
	 */
	public List<CisIfLogVO> pageCisIfLogList(CisIfLogSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCisIfLogList", so );
	}
	
}