package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.AuthorityPO;
import biz.app.system.model.AuthoritySO;
import biz.app.system.model.AuthorityVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class AuthDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 페이지
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> pageAuth(AuthoritySO so) {
		return selectListPage("auth.pageAuth", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 목록
	 * </pre>
	 * @return
	 */
	public List<AuthorityVO> listAuth() {
		return selectList("auth.listAuth");
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public AuthorityVO getAuth(AuthoritySO so) {
		return (AuthorityVO) selectOne("auth.getAuth", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertAuth(AuthorityPO po) {
		return insert("auth.insertAuth", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateAuth(AuthorityPO po) {
		return update("auth.updateAuth", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteAuth(AuthorityPO po) {
		return delete("auth.deleteAuth", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 삭제 체크
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer getCheckAuthDelete(AuthorityPO po) {
		return (Integer) selectOne("auth.getCheckAuthDelete", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMenuAuth(AuthorityPO po) {
		return insert("auth.insertMenuAuth", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteMenuAuth(AuthorityPO po) {
		return delete("auth.deleteMenuAuth", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> listAuthMenu(AuthoritySO so) {
		return selectList("auth.listAuthMenu", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthDao.java
	 * - 작성일		: 2020. 12. 28.
	 * - 작성자		: 이지희
	 * - 설명		: 사용자 권한 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> listUserAuth(AuthoritySO so) {
		return selectList("auth.listUserAuth", so);
	}

}
