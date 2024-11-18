package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.MenuActionPO;
import biz.app.system.model.MenuActionSO;
import biz.app.system.model.MenuActionVO;
import biz.app.system.model.MenuBasePO;
import biz.app.system.model.MenuBaseVO;
import biz.app.system.model.MenuSO;
import biz.app.system.model.MenuTreeVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class MenuDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 목록 트리
	 * </pre>
	 * @return
	 */
	public List<MenuTreeVO> listMenuTree(MenuSO so) {
		return selectList("menu.listMenuTree",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public MenuBaseVO getMenuBase(MenuSO so) {
		return (MenuBaseVO) selectOne("menu.getMenuBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getCheckMenuBase(MenuSO so) {
		return (int) selectOne("menu.getCheckMenuBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMenuBase(MenuBasePO po) {
		return insert("menu.insertMenuBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateMenuBase(MenuBasePO po) {
		return update("menu.updateMenuBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteMenuBase(MenuBasePO po) {
		return delete("menu.deleteMenuBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 권한 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteMenuAuth(MenuBasePO po) {
		return delete("menu.deleteMenuAuth", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MenuActionVO> listMenuAction(MenuActionSO so) {
		return selectList("menu.listMenuAction", so);
	}

	public MenuActionVO listMenuActionByUrlAndActGbCd(MenuActionSO so) {
		return selectOne("menu.listMenuActionByUrlAndActGbCd", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public MenuActionVO getMenuAction(MenuActionSO so) {
		return (MenuActionVO) selectOne("menu.getMenuAction", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 상위 메뉴 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getCheckMenuAction(MenuActionSO so) {
		return (int) selectOne("menu.getCheckMenuAction", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메인 화면 등록 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getCheckMainMenuAction(MenuActionSO so) {
		return (int) selectOne("menu.getCheckMainMenuAction", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMenuAction(MenuActionPO po) {
		return insert("menu.insertMenuAction", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateMenuAction(MenuActionPO po) {
		return update("menu.updateMenuAction", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteMenuAction(MenuActionPO po) {
		return delete("menu.deleteMenuAction", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 메뉴 목록
	 * </pre>
	 * @return
	 */
	public List<MenuBaseVO> listCommonMenu(Long usrNo) {
		return selectList("menu.listCommonMenu", usrNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 권한 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MenuTreeVO> listMenuAuthTree(MenuSO so) {
		return selectList("menu.listMenuAuthTree", so);
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2018. 8. 3.
	 * - 작성자		: valueFactory
	 * - 설명		: 선택한 메뉴의 제일 상위 메뉴 번호 조회
	 * </pre>
	 * @return
	 */
	public MenuBaseVO getMastMenuNo(String menuUrl) {
		return selectOne("menu.getMastMenuNo", menuUrl);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuDao.java
	 * - 작성일		: 2021. 8. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 모든 메뉴 권한 조회
	 * </pre>
	 * @return
	 */
	public CodeDetailVO getMenuUserAuth(CodeDetailSO so) {
		return selectOne("menu.getMenuUserAuth", so);
	}
	
}
