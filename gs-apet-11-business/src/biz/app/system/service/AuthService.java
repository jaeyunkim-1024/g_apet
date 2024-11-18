package biz.app.system.service;

import java.util.List;

import biz.app.system.model.AuthorityPO;
import biz.app.system.model.AuthoritySO;
import biz.app.system.model.AuthorityVO;


/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface AuthService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 목록 페이지
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> pageAuth(AuthoritySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 목록 리스트
	 * </pre>
	 * @return
	 */
	public List<AuthorityVO> listAuth();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public AuthorityVO getAuth(AuthoritySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 저장
	 * </pre>
	 * @param po
	 */
	public void saveAuth(AuthorityPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 삭제
	 * </pre>
	 * @param so
	 */
	public void deleteAuth(AuthorityPO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 메뉴 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> listAuthMenu(AuthoritySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: AuthService.java
	 * - 작성일		: 2020. 12. 28.
	 * - 작성자		: 이지희
	 * - 설명		: 사용자 권한 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> listUserAuth(AuthoritySO so);

}