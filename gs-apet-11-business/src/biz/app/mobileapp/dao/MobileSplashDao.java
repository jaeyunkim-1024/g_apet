package biz.app.mobileapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.mobileapp.model.MobileSplashPO;
import biz.app.mobileapp.model.MobileSplashSO;
import biz.app.mobileapp.model.MobileSplashVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.mobileapp.dao
* - 파일명		: MobileSplashDao.java
* - 작성일		: 2017. 08. 14.
* - 작성자		: wyjeong
* - 설명		: 모바일 앱 Splash DAO
* </pre>
*/
@Repository
public class MobileSplashDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "mobileapp.";
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashDao.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MobileSplashVO> pageMobileSplash(MobileSplashSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMobileSplash", so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashDao.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileSplashVO getMobileSplash(MobileSplashSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMobileSplash", so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashDao.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMobileSplash(MobileSplashPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMobileSplash", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashDao.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updatePrevSplash(MobileSplashPO po) {
		return update(BASE_DAO_PACKAGE + "updatePrevSplash", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashDao.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateMobileSplash(MobileSplashPO po) {
		return update(BASE_DAO_PACKAGE + "updateMobileSplash", po);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashDao.java
	 * - 작성일		: updateMobileSplash
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteMobileSplash(MobileSplashPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMobileSplash", po);
	}
}
