package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberSavedMoneyDetailPO;
import biz.app.member.model.MemberSavedMoneyDetailSO;
import biz.app.member.model.MemberSavedMoneyDetailVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.dao
* - 파일명		: MemberSavedMoneyDetailDao.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 적립금 내역 DAO
* </pre>
*/
@Repository
public class MemberSavedMoneyDetailDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberSavedMoneyDetail.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDetailDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 내역 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberSavedMoneyDetail(MemberSavedMoneyDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberSavedMoneyDetail", po);
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyDetailDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 내역 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<MemberSavedMoneyDetailVO> listMemberSavedMoneyDetail(MemberSavedMoneyDetailSO so) {
		if(so.getSidx() == null || "".equals(so.getSidx())){
			so.setSidx("MSMD.SVMN_SEQ");
		}
		if(so.getSord() == null || "".equals(so.getSord())){
			so.setSord("ASC");
		}
		return selectList(BASE_DAO_PACKAGE + "listMemberSavedMoneyDetail", so);
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
}
