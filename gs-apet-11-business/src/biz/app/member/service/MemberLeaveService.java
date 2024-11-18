package biz.app.member.service;

import java.util.List;

import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBizInfoPO;

/**
 * <pre>
 * - 프로젝트명	: 
 * - 패키지명		: biz.app.member.service
 * - 파일명		: MemberLeaveService.java
 * - 작성일		: 2021. 4. 12.
 * - 작성자		: 조은지
 * - 설명			: 회원 탈퇴 서비스 
 * </pre>
 */
public interface MemberLeaveService {

	public int insertLeaveMemberBaseForBatch(List<MemberBasePO> listMemberBaseForLeave);
	
	public int insertLeaveMemberBizInfoForBatch(List<MemberBizInfoPO> listMemberBizInfoForLeave);
	
	public int insertLeaveMemberBase(MemberBasePO po);
	
	public int insertLeaveMemberBizInfo(MemberBizInfoPO po);
}
