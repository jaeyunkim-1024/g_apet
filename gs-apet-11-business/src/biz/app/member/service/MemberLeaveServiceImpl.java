package biz.app.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.dao.MemberLeaveDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBizInfoPO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 
 * - 패키지명		: biz.app.member.service
 * - 파일명		: MemberLeaveServiceImpl.java
 * - 작성일		: 2021. 4. 12.
 * - 작성자		: 조은지
 * - 설명			: 회원 탈퇴 서비스 
 * </pre>
 */
@Slf4j
@Service
@Transactional(value="dormantTransactionManager")
public class MemberLeaveServiceImpl implements MemberLeaveService {
	@Autowired MemberLeaveDao leaveDao;

	
	@Override
	public int insertLeaveMemberBaseForBatch(List<MemberBasePO> listMemberBaseForLeave) {
		return leaveDao.insertLeaveMemberBaseForBatch(listMemberBaseForLeave);
	}
	
	@Override
	public int insertLeaveMemberBizInfoForBatch(List<MemberBizInfoPO> listMemberBizInfoForLeave) {
		return leaveDao.insertLeaveMemberBizInfoForBatch(listMemberBizInfoForLeave);
	}
	
	@Override
	public int insertLeaveMemberBase(MemberBasePO po) {
		return leaveDao.insertLeaveMemberBase(po);
	}

	@Override
	public int insertLeaveMemberBizInfo(MemberBizInfoPO po) {
		return leaveDao.insertLeaveMemberBizInfo(po);
	}
}
