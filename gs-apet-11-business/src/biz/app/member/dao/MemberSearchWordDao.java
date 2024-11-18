package biz.app.member.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import biz.app.login.model.SnsMemberInfoPO;
import org.springframework.stereotype.Repository;

import biz.app.login.model.SnsMemberInfoSO;
import biz.app.member.model.MbrTagMapPO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCertifiedLogPO;
import biz.app.member.model.MemberSearchWordPO;
import biz.app.member.model.MemberSearchWordSO;
import biz.app.member.model.MemberSearchWordVO;
import biz.app.member.model.TermsRcvHistoryPO;
import framework.common.constants.CommonConstants;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberSearchWordDao.java
* - 작성일		: 2021. 03. 09.
* - 작성자		: KKB
* - 설명		: 회원 검색어 DAO
* </pre>
*/
@Repository
public class MemberSearchWordDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberSearchWord.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSearchWordDao.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		: KKB
	* - 설명		: 회원 검색어 등록
	* </pre>
	* @param MemberSearchWordPO po
	* @return int
	*/
	public int insertMemberSearchWord(MemberSearchWordPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberSearchWord", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSearchWordDao.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		: KKB
	* - 설명		: 회원 검색어 리스트
	* </pre>
	* @param Long mbrNo
	* @return List<MemberSearchWordVO>
	*/
	public List<MemberSearchWordVO> listMemberSearchWord(MemberSearchWordSO so) {
		return selectList(BASE_DAO_PACKAGE + "listMemberSearchWord", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSearchWordDao.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		: KKB
	* - 설명		: 회원 검색어 삭제
	* </pre>
	* @param Long mbrNo
	* @return int
	*/
	public int deleteMemberSearchWord(MemberSearchWordPO po){
		return delete(BASE_DAO_PACKAGE + "deleteMemberSearchWord", po);
	}
}
