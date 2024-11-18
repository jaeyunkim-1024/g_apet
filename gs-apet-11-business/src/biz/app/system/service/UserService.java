package biz.app.system.service;

import java.util.List;

import biz.app.system.model.AuthorityVO;
import biz.app.system.model.UserAuthHistSO;
import biz.app.system.model.UserAuthHistVO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.model.UserLoginHistVO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface UserService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserBaseVO> pageUser(UserBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public UserBaseVO getUser(UserBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 등록
	 * </pre>
	 * @param po
	 */
	public void insertUser(UserBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 수정
	 * </pre>
	 * @param po
	 */
	public void updateUser(UserBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 ID 체크
	 * </pre>
	 * @param loginId
	 * @return
	 */
	public int getUserIdCheck(String loginId);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 정보 변경
	 * </pre>
	 * @param po
	 */
	public void updateUserInfo(UserBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 로그인 이력
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserLoginHistVO> pageUserLogin(UserBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: UserService.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 회원 비밀번호 수정(초기화)
	* </pre>
	* @param po
	*/
	public void updatePasswordUser(UserBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserBaseVO> getUserList(UserBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2020. 3. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 비밀번호 변경
	 * </pre>
	 * @param so
	 * @return
	 */
	public void updatePassword(UserBasePO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2020.7.8
	* - 작성자		: ljy
	* - 설명		:  Test method
	* </pre>
	* @param mbrNo
	*/	
	public String getDemoPasswd(String newPassword);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 권한 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<AuthorityVO> listAuth(UserBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: 조은지
	 * - 설명		: 사용자 권한 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserBaseVO> getUserAuthMapList(UserBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: 조은지
	 * - 설명		: 사용자 권한 메뉴리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserBaseVO> getUserAuthMenuList(UserBaseSO so);
	
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
	public List<String> selectPswdHist(UserBaseSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2020. 12. 24
	 * - 작성자		: 이지희
	 * - 설명		: 비밀번호 변경화면에서 변경
	 * </pre>
	 * @param UserBasePO po
	 * @return 
	 */
	public Integer updateNewPswd(UserBasePO po);
	
	public int userCompanyDupChk(UserBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: UserDao.java
	 * - 작성일		: 2021. 01. 13
	 * - 작성자		: 이지희
	 * - 설명		: 사용자 접근 권한 그리드
	 * </pre>
	 * @param so
	 * @return 
	 */
	public List<UserAuthHistVO> userAuthHistGrid(UserAuthHistSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 접근 권한 이력 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<UserAuthHistVO> pageUserAuthHist(UserAuthHistSO so);
	
}