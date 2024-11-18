package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.member.model.MemberBizInfoVO;
import framework.common.dao.DormantAbstractDao;

@Repository
public class MemberDormantDao extends DormantAbstractDao {
	
	private static final String BASE_DAO_PACKAGE = "dormant.";

	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2021.2. 04.
	* - 작성자		: 이지희
	* - 설명			: 분리보관 된 휴면회원 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberBasePO selectDormantMemberBase(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectDormantMemberBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.2. 04.
	 * - 작성자		: 이지희
	 * - 설명			: 분리보관 된 휴면회원 정보 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteDormantMemberBase(MemberBaseSO so) {
		return delete(BASE_DAO_PACKAGE + "deleteDormantMemberBase", so);
	}
	
	public void deleteDormantMemberBizInfo(MemberBaseSO so) {
		delete(BASE_DAO_PACKAGE + "deleteDormantMemberBizInfo", so);
	}
	
	public List<MemberBaseVO> listDormantMemberBase() {
		return selectList(BASE_DAO_PACKAGE + "listDormantMemberBase");
	}
	
	public int insertDormantMemberBaseForBatch(List<MemberBasePO> listMemberBaseForDormant) {
		return insert(BASE_DAO_PACKAGE + "insertDormantMemberBaseForBatch", listMemberBaseForDormant);
	}
	
	public int insertDormantMemberBizInfoForBatch(List<MemberBizInfoPO> listMemberBizInfoForDormant) {
		return insert(BASE_DAO_PACKAGE + "insertDormantMemberBizInfoForBatch", listMemberBizInfoForDormant);
	}
	
	public int insertDormantMemberAddressForBatch(List<MemberAddressPO> listMemberAddressForDormant) {
		return insert(BASE_DAO_PACKAGE + "insertDormantMemberAddressForBatch", listMemberAddressForDormant);
	}

	public MemberBizInfoPO selectDormantMemberBizInfo(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectDormantMemberBizInfo", so);
	}	
}
