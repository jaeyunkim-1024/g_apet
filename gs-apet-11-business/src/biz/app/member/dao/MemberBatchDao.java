package biz.app.member.dao;

import java.util.List;
import java.util.Map;

import biz.app.member.model.*;
import org.springframework.stereotype.Repository;

import framework.common.dao.MainAbstractDao;

@Repository
public class MemberBatchDao extends MainAbstractDao{
	
	private static final String BASE_DAO_PACKAGE = "memberBatch.";
	
	
	public List<MemberBaseVO> listMemberBaseForBirthdayBatch() {
		return selectList(BASE_DAO_PACKAGE + "listMemberBaseForBirthdayBatch");
	}
	
	public List<MemberBaseVO> listMemberBaseForDomantAlarmBatch() {
		return selectList(BASE_DAO_PACKAGE + "listMemberBaseForDomantAlarmBatch");
	}
	
	public List<MemberBaseVO> listMemberBaseForDormantOrLeave(String batchGb) {
		return selectList(BASE_DAO_PACKAGE + "listMemberBaseForDormantOrLeave", batchGb);
	}
	
	public List<MemberBizInfoVO> listMemberBizInfoForDormantOrLeave(String batchGb) {
		return selectList(BASE_DAO_PACKAGE + "listMemberBizInfoForDormantOrLeave", batchGb);
	}
	
	public List<MemberAddressVO> listMemberAddressForDormantOrLeave(String batchGb) {
		return selectList(BASE_DAO_PACKAGE + "listMemberAddressForDormantOrLeave", batchGb);
	}
	
	public int updateMemberBaseForDormant(List<MemberBasePO> listMemberBasePO) {
		return update(BASE_DAO_PACKAGE + "updateMemberBaseForDormant", listMemberBasePO);
	}
	
	public int updateMemberBizInfoForDormant(List<MemberBizInfoPO> listMemberBizInfoPO) {
		return update(BASE_DAO_PACKAGE + "updateMemberBizInfoForDormant", listMemberBizInfoPO);
	}
	
	public int deleteMemberAddressForDormant(List<MemberAddressPO> listMemberAddressPO) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberAddressForDormant", listMemberAddressPO);
	}
	
	public int updateMemberBaseForLeave(List<MemberBasePO> listMemberBasePO) {
		return update(BASE_DAO_PACKAGE + "updateListMemberBaseForLeave", listMemberBasePO);
	}
	
	public int updateMemberBizInfoForLeave(List<MemberBizInfoPO> listMemberBizInfoPO) {
		return update(BASE_DAO_PACKAGE + "updateListMemberBizInfoForLeave", listMemberBizInfoPO);
	}
	
	public int deleteMemberAddressForLeave(List<MemberAddressPO> listMemberAddressPO) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberAddressForLeave", listMemberAddressPO);
	}
	
	public int updateMemberBaseForLeave(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBaseForLeave", po);
	}
	
	public int updateMemberBizInfoForLeave(MemberBizInfoPO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBizInfoForLeave", po);
	}

	public List<MemberCouponVO> listMemberCouponExpire(Integer expire){
		return selectList(BASE_DAO_PACKAGE + "listMemberCouponExpire", expire);
	}

	public int insertMemberGrdCoupon(MemberCouponPO po){
		return insert(BASE_DAO_PACKAGE+"insertMemberGrdCoupon",po);
	}
	
	public int updateMemberGrade(Map<String, String> map) {
		return update(BASE_DAO_PACKAGE+"updateMemberGrade",map);
	}
	
	public List<MemberCouponVO> listCouponIsuStbBatch() {
		return selectList(BASE_DAO_PACKAGE + "listCouponIsuStbBatch");
	}
}
