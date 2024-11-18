package biz.app.member.service;

import biz.app.member.model.*;

import java.util.List;
import java.util.Map;

public interface MemberBatchService {

	public List<MemberBaseVO> listMemberBaseForBirthdayBatch();

	public List<MemberBaseVO> listMemberBaseForDomantAlarmBatch();

	public List<MemberBaseVO> listMemberBaseForDormantOrLeave(String batchGb);
	
	public List<MemberBizInfoVO> listMemberBizInfoForDormantOrLeave(String batchGb);
	
	public List<MemberAddressVO> listMemberAddressForDormantOrLeave(String batchGb);
	
	public int updateMemberBaseForDormant(List<MemberBasePO> listMemberBasePO);
	
	public int updateMemberBizInfoForDormant(List<MemberBizInfoPO> listMemberBizInfoPO);
	
	public int deleteMemberAddressForDormant(List<MemberAddressPO> listMemberAddressPO);
	
	public int updateMemberBaseForLeave(List<MemberBasePO> listMemberBasePO);
	
	public int updateMemberBizInfoForLeave(List<MemberBizInfoPO> listMemberBizInfoPO);
	
	public int deleteMemberAddressForLeave(List<MemberAddressPO> listMemberAddressPO);
	
	public int updateMemberBaseForLeave(MemberBasePO po);
	
	public int updateMemberBizInfoForLeave(MemberBizInfoPO po);
	
	
	//회원 쿠폰 관련 배치

	//만료기간이 N일 남은 쿠폰 가져오기
	public List<MemberCouponVO> listMemberCouponExpire(Integer expire);

	//회원 등급 쿠폰
	public int insertMemberGrdCoupon(MemberCouponPO po, List<Long> cpNos);
	
	//회원 등급 배치
	public int updateMemberGrade(Map<String, String> map);

	//회원 쿠폰 발급 대기 대상 발급 처리
	public List<MemberCouponVO> listCouponIsuStbBatch();
}
