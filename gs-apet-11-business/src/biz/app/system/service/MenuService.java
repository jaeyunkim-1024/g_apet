package biz.app.system.service;

import biz.app.system.model.*;

import java.util.List;


/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface MenuService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 트리 목록
	 * </pre>
	 * @return
	 */
	public List<MenuTreeVO> listMenuTree(MenuSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public MenuBaseVO getMenuBase(MenuSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 저장(등록,수정)
	 * </pre>
	 * @param po
	 */
	public void saveMenuBase(MenuBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteMenuBase(MenuBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MenuActionVO> listMenuAction(MenuActionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public MenuActionVO getMenuAction(MenuActionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 저장(등록, 수정)
	 * </pre>
	 * @param po
	 */
	public void saveMenuAction(MenuActionPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 기능 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteMenuAction(MenuActionPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 목록
	 * </pre>
	 * @return
	 */
	public List<MenuBaseVO> listCommonMenu(Long usrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 메뉴 권한 목록 트리
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MenuTreeVO> listMenuAuthTree(MenuSO so);

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MenuService.java
	 * - 작성일		: 2018. 8. 3.
	 * - 작성자		: valueFactory
	 * - 설명		: 선택한 메뉴의 제일 상위 메뉴 번호 조회
	 * </pre>
	 * @param menuUrl - 메뉴 URL
	 * @return
	 */
	public MenuBaseVO getMastMenuNo(String menuUrl);
}