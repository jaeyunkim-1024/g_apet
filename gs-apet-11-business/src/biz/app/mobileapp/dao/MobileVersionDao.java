package biz.app.mobileapp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.mobileapp.model.MobileVersionAppVO;
import biz.app.mobileapp.model.MobileVersionPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;
import framework.common.dao.MainAbstractDao;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.mobileapp.dao
 * - 파일명		: MobileVersionDao.java
 * - 작성일		: 2017. 05. 11.
 * - 작성자		: wyjeong
 * - 설명			: APP 버전관리 DAO
 * </pre>
 */
@Repository
public class MobileVersionDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "mobileapp.";
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MobileVersionVO> pageMobileVersion(MobileVersionSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMobileVersion", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileVersionVO getMobileVersion(MobileVersionSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMobileVersion", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 앱 버전 존재여부 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer checkMobileVersion(MobileVersionSO so) {
		return selectOne(BASE_DAO_PACKAGE + "checkMobileVersion", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMobileVersion(MobileVersionPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMobileVersion", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateMobileVersion(MobileVersionPO po) {
		return update(BASE_DAO_PACKAGE + "updateMobileVersion", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteMobileVersion(MobileVersionPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMobileVersion", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2017. 05. 16.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 정보 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MobileVersionVO> listAppVersion(MobileVersionSO so) {
		return selectList(BASE_DAO_PACKAGE + "listAppVersion", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionDao.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: lds
	 * - 설명			: APP 버전관리 등록 시 이전버전 중 업데이트 일시가 오늘보다 큰것들 현재 날짜로 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateBeforeVersionMarketRegDtmToday(MobileVersionPO po) {
		return insert(BASE_DAO_PACKAGE + "updateBeforeVersionMarketRegDtmToday", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: DSLEE
	 * - 설명			: APP 최신버전 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileVersionAppVO selectNewMobileVersionInfo(MobileVersionSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectNewMobileVersionInfo", so);
	}
}