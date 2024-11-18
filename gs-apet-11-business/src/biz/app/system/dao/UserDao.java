package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.AuthorityVO;
import biz.app.system.model.UserAuthHistSO;
import biz.app.system.model.UserAuthHistVO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.model.UserLoginHistVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class UserDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserBaseVO> pageUser(UserBaseSO so) {
		return selectListPage("user.pageUser", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public UserBaseVO getUser(UserBaseSO so) {
		return (UserBaseVO) selectOne("user.getUser", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 아이디 중복 체크
	 * </pre>
	 * @param loginId
	 * @return
	 */
	public int getUserIdCheck(String loginId) {
		return (int) selectOne("user.getUserIdCheck", loginId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertUser(UserBasePO po) {
		return insert("user.insertUser", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updatePasswordUser(UserBasePO po) {
		return update("user.updatePasswordUser", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 권한 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertUserAuthMap(UserBasePO po) {
		return insert("user.insertUserAuthMap", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 권한 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteUserAuthMap(UserBasePO po) {
		return delete("user.deleteUserAuthMap", po);
	}

	public int updateInfoUser(UserBasePO po) {
		return update("user.updateInfoUser", po);
	}

	public List<UserLoginHistVO> pageUserLogin(UserBaseSO so) {
		return selectListPage("user.pageUserLogin", so);
	}

	public int updateUser(UserBasePO po) {
		return update("user.updateUser", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 관리자 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserBaseVO> getUserList(UserBaseSO so) {
		return selectList("user.getUserList", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 권한 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> listAuth(UserBaseSO so) {
		return selectList("user.listAuth", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 17
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertUserAuthHist(UserBasePO po) {
		return insert("user.insertUserAuthHist", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 17
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 상태 이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertUserStausHist(UserBasePO po) {
		return insert("user.insertUserStausHist", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 17
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 권한 매핑 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<UserBaseVO> getUserAuthMapList(UserBaseSO so) {
		return selectList("user.getUserAuthMapList", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 21
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 권한 메뉴 리스트
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<UserBaseVO> getUserAuthMenuList(UserBaseSO so) {
		return selectList("user.getUserAuthMenuList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 24
	 * - 작성자		: 이지희
	 * - 설명		:  로그인 시 세션에 저장할 auth 리스트
	 * </pre>
	 * @param UserBaseSO so
	 * @return List<AuthorityVO>
	 */
	public List<AuthorityVO> selectAuthNoListForSession(UserBaseSO so) {
		return selectList("user.selectAuthNoListForSession", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 24
	 * - 작성자		: 이지희
	 * - 설명		: 비밀번호 변경  최근 2개 이력
	 * </pre>
	 * @param UserBaseSO so
	 * @return List<String>
	 */
	public List<String> selectPswdHist(UserBaseSO so){
		return selectList("user.selectPswdHist", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 24
	 * - 작성자		: 이지희
	 * - 설명		: 비밀번호 변경화면에서 비밀번호 변경
	 * </pre>
	 * @param UserBasePO po
	 * @return 
	 */
	public Integer updateNewPswd(UserBasePO po){
		return update("user.updateNewPswd", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 24
	 * - 작성자		: 이지희
	 * - 설명		: 비밀번호 변경화면에서 비밀번호 변경 시 이력 등록
	 * </pre>
	 * @param UserBasePO po
	 * @return 
	 */
	public Integer insertPswdHist(UserBasePO po){
		return insert("user.insertPswdHist", po);
	}

	public int userCompanyDupChk(UserBaseSO so) {
		return (int) selectOne("user.userCompanyDupChk", so);
	}
	
	/**
	 * <pre>
	 * - Method 명	: userAuthHistGrid
	 * - 작성일		: 2020.04.07.
	 * - 작성자		: CJA
	 * - 설명		: 사용자 접근 권한 그리드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserAuthHistVO> userAuthHistGrid(UserAuthHistSO so) {
		return selectListPage("userAuthHist.userAuthHistGrid", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageBanner
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 접근 권한 이력 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserAuthHistVO> pageUserAuthHist(UserAuthHistSO so) {
		return selectListPage("userAuthHist.pageUserAuthHist", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: updateUserState
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: 이지희
	 * - 설명		: 사용자 상태 변경
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer updateUserState(UserBasePO po) {
		return update("user.updateUserState", po);
	}
}
