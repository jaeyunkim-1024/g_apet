package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.ChnlStdInfoPO;
import biz.app.system.model.ChnlStdInfoSO;
import biz.app.system.model.ChnlStdInfoVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.system.dao
* - 파일명		: ChnlStdInfoDao.java
* - 작성일		: 2017. 2. 22.
* - 작성자		: honjung
* - 설명		:
* </pre>
*/
@Repository
public class ChnlStdInfoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "chnlStdInfo.";
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoDao.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ChnlStdInfoVO> pageChnlStdInfo(ChnlStdInfoSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageChnlStdInfo", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ChnlStdInfoDao.java
	* - 작성일		: 2017. 6. 30.
	* - 작성자		: Administrator
	* - 설명			: 채널 기준 정보 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public ChnlStdInfoVO getChnlStdInfo(Long chnlId){
		return selectOne(BASE_DAO_PACKAGE + "getChnlStdInfo", chnlId);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoDao.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 등록
	 * </pre>
	 * @param po
	 */
	public int insertChnlStdInfo(ChnlStdInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertChnlStdInfo", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoDao.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 수정
	 * </pre>
	 * @param po
	 */
	public int updateChnlStdInfo(ChnlStdInfoPO po) {
		return update(BASE_DAO_PACKAGE + "updateChnlStdInfo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoDao.java
	 * - 작성일		: 2017. 2. 1.
	 * - 작성자		: honjung
	 * - 설명		: 채널 기준 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */	
	public int deleteChnlStdInfo(ChnlStdInfoPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteChnlStdInfo", po);
	}
}
