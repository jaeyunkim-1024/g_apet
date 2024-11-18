package biz.app.login.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import framework.front.model.Session;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.login.service
* - 파일명		: FrontLoginService.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: Front 로그인 서비스 Interface
* </pre>
*/
public interface FrontLoginService {
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2021. 1. 21.
	* - 작성자		: 이지희
	* - 설명		: 회원 로그인 체크
	*             1:정상, -1:회원정보 없음, -2:비밀번호오류, -3: 휴면회원, -4:사용자상태오류
	* </pre>
	* @param loginId
	* @param password
	* @param loginPathCd
	* @param deviceTpCd
	* @param deviceToken
	* @return
	* @throws Exception
	*/
	Map<String, Object> checkLogin(MemberBaseVO checkVo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2020. 02. 05.
	* - 작성자		: 이지희
	* - 설명		: 회원 로그인 아이디 찾기 (이메일)
	* </pre>
	* @param mbrNm
	* @param email
	* @throws Exception
	*/
	MemberBaseVO getMemberLoginIdEmail(MemberBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2020. 02. 05.
	* - 작성자		: 이지희
	* - 설명		: 회원 로그인 아이디/비번 찾기 (본인인증)
	* </pre>
	* @param authJson
	* @param loginId
	* @throws Exception
	*/
	MemberBaseVO getMemberIdPswdMobile(String authJson, String loginId);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: snw
	* - 설명		: 회원 비밀번호 찾기 (이메일로 전송)
	* </pre>
	* @param loginId
	* @param email
	* @throws Exception
	*/
	void getMemberPasswordEmail(String loginId, String email);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: snw
	* - 설명		: 회원 비밀번호 찾기 (휴대폰 전송)
	* </pre>
	* @param loginId
	* @param mobile
	* @throws Exception
	*/
	void getMemberPasswordMobile(String loginId, String mobile);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2021. 2. 1.
	* - 작성자		: 이지희
	* - 설명		: 로그인 회원 정보 유효한지 체크
	* </pre>
	* @param memberBaseVO member
	*/
	public String checkLoginInfo(MemberBaseVO member);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: FrontLoginService.java
	 * - 작성일		: 2021. 03. 05.
	 * - 작성자		: 이지희
	 * - 설명		:  검색엔진 api에 관심태그로그 등록 
	 * </pre>
	 * @param mbrNo
	 * @param tagNo
	 * @return
	 */		
	public String setTagAction(Map<String,String> paramMap) throws Exception;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: FrontLoginServiceImpl.java
	 * - 작성일		: 2021. 03. 30.
	 * - 작성자		: 이지희
	 * - 설명		:  로그인 시 로그인이력등록, 최근로그인일시 업데이트
	 * </pre>
	 * @param member
	 * @param session
	 * @return
	 */	
	public void setLoginInfo(Session session, MemberBaseVO member);

	//임시로그인 용
	public Session saveLoginSession(MemberBaseVO member, @Nullable String justSave);
	
	public int updateInfoRcvYn(MemberBasePO po);
	
	public List<GoodsBaseVO> getRcntGoodsFromCookie();
}