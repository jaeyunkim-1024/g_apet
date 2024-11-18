package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBizInfoPO;
import framework.common.dao.DormantAbstractDao;
import framework.common.dao.LeaveAbstractDao;

@Repository
public class MemberLeaveDao extends DormantAbstractDao {

	private static final String BASE_DAO_PACKAGE = "leave.";


	public int insertLeaveMemberBaseForBatch(List<MemberBasePO> listMemberBaseForLeave) {
		return insert(BASE_DAO_PACKAGE + "insertLeaveMemberBaseForBatch", listMemberBaseForLeave);
	}
	
	public int insertLeaveMemberBizInfoForBatch(List<MemberBizInfoPO> listMemberBizInfoForLeave) {
		return insert(BASE_DAO_PACKAGE + "insertLeaveMemberBizInfoForBatch", listMemberBizInfoForLeave);
	}
	
	public int insertLeaveMemberBase(MemberBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertLeaveMemberBase", po);
	}
	
	public int insertLeaveMemberBizInfo(MemberBizInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertLeaveMemberBizInfo", po);
	}
}
