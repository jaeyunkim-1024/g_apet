package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.PetLogMgmtVO;
import biz.app.member.model.MemberBaseVO;
import biz.app.contents.model.PetLogMgmtPO;
import biz.app.contents.model.PetLogMgmtSO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>펫로그 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class PetLogMgmtDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "petLogMgmt.";
		
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetLogDao.java
	 * - 작성일		: 2020. 12. 16.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return 
	 */
	public List<PetLogMgmtVO> pagePetLog(PetLogMgmtSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pagePetLog", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PetLogDao.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: valueFactory
	* - 설명			: 펫로그 전시상태 일괄 수정
	* </pre>
	* @param GoodsBasePO
	* @return
	*/
	public int updatePetLogStat (PetLogMgmtPO po ) {
		return update(BASE_DAO_PACKAGE + "updatePetLogStat", po );
	}
		
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetLogDao.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 신고 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return 
	 */
	public List<PetLogMgmtVO> pagePetLogReport(PetLogMgmtSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pagePetLogReport", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetLogDao.java
	 * - 작성일		: 2021. 3. 9.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 등록자 정보 조회
	 * </pre>
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return 
	 */
	public MemberBaseVO selectPetLogRegrInfo(PetLogMgmtSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectPetLogRegrInfo", so);
	}

	
}
