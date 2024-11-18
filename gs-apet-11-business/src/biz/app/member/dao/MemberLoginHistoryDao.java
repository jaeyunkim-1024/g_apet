package biz.app.member.dao;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberLoginHistPO;
import biz.app.member.model.MemberLoginHistVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberLoginHistoryDao.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 로그인 이력 DAO
* </pre>
*/
@Repository
public class MemberLoginHistoryDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberLoginHistory.";
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberLoginHistoryDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 로그인 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertLoginHistory(MemberLoginHistPO po){
		return insert(BASE_DAO_PACKAGE + "insertLoginHistory", po);
	}
	
	public MemberLoginHistVO selectLoginHistory(Long mbrNo) {
		return selectOne(BASE_DAO_PACKAGE + "selectLoginHistory" , mbrNo);
	}
	
}
