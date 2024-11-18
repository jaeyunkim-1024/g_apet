package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberSavedMoneyPO;
import biz.app.member.model.MemberSavedMoneySO;
import biz.app.member.model.MemberSavedMoneyVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.dao
* - 파일명		: MemberSavedMoneyDao.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 적립금 DAO
* </pre>
*/
@Repository
public class MemberSavedMoneyDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberSavedMoney.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberSavedMoney(MemberSavedMoneyPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberSavedMoney", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 잔여 금액 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberSavedMoneyRmnAmt(MemberSavedMoneyPO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberSavedMoneyRmnAmt", po);
	}	
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberSavedMoneyVO getMemberSavedMoney(MemberSavedMoneySO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberSavedMoney", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<MemberSavedMoneyVO> listMemberSavedMoney(MemberSavedMoneySO so) {
		return selectList(BASE_DAO_PACKAGE +  "listMemberSavedMoney", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDao.java
	* - 작성일		: 2017. 2. 2.
	* - 작성자		: snw
	* - 설명			: 회원의 사용 가능한 적립금 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<MemberSavedMoneyVO> listMemberSavedMoneyUsedPossible(MemberSavedMoneySO so) {
		return selectList(BASE_DAO_PACKAGE + "listMemberSavedMoneyUsedPossible", so);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
