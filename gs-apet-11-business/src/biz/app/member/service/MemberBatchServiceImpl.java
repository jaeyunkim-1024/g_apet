package biz.app.member.service;

import biz.app.member.dao.MemberBatchDao;
import biz.app.member.model.*;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.service.CouponService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Slf4j
@Service
@Transactional
public class MemberBatchServiceImpl implements MemberBatchService {

	@Autowired private MemberBatchDao memberBatchDao;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private CouponService couponService;

	@Autowired	private Properties webConfig;

	@Autowired private PetraUtil PetraUtil;



	public MemberBaseVO decryptMemberBase(MemberBaseVO vo) {
		String userId = null;
		if(StringUtils.equals(CommonConstants.PROJECT_GB_ADMIN, webConfig.getProperty("project.gb"))) {
			Session session = AdminSessionUtil.getSession();
			if (session == null) {
				userId = "NonLoginUser";
			} else {
				userId = String.valueOf(session.getUsrNo());
			}
		} else if (StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))){
			userId = String.valueOf(CommonConstants.COMMON_BATCH_USR_NO);
		}else {
			userId = String.valueOf(FrontSessionUtil.getSession().getMbrNo());
		}

		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return (MemberBaseVO)(decryptMemberBase(vo,new TypeReference<MemberBaseVO>(){},userId,clientIp));
	}

	private Object decryptMemberBase(Object target, TypeReference type,String userId,String clientIp){
		Object result;
		Map<String,Object> convertMap = new ObjectMapper().convertValue(target,Map.class);

		String mbrNm = Optional.ofNullable(convertMap.get("mbrNm")).orElseGet(()->"").toString();
		String loginId = Optional.ofNullable(convertMap.get("loginId")).orElseGet(()->"").toString();
		//String nickNm = Optional.ofNullable(convertMap.get("nickNm")).orElseGet(()->"").toString();
		String birth = Optional.ofNullable(convertMap.get("birth")).orElseGet(()->"").toString();
		String mobile = Optional.ofNullable(convertMap.get("mobile")).orElseGet(()->"").toString();
		String email = Optional.ofNullable(convertMap.get("email")).orElseGet(()->"").toString();

		try{
			convertMap.replace("mbrNm" , StringUtil.isNotEmpty(mbrNm) ? PetraUtil.twoWayDecryptByThrow(mbrNm, userId, clientIp) : mbrNm);
		}catch(Exception e){
			log.error("[ "+e.getMessage()+" ]  mbrNm - : {}", mbrNm);
			convertMap.replace("mbrNm" , mbrNm);
		}

		try{
			convertMap.replace("loginId" , StringUtil.isNotEmpty(loginId) ? PetraUtil.twoWayDecryptByThrow(loginId, userId, clientIp) : loginId);
		}catch(Exception e){
			log.error("[ "+e.getMessage()+" ]  loginId - : {}", loginId);
			convertMap.replace("loginId" , loginId);
		}

		try{
			convertMap.replace("birth" , StringUtil.isNotEmpty(birth) ? PetraUtil.twoWayDecryptByThrow(birth, userId, clientIp) : birth);
		}catch(Exception e){
			log.error("[ "+e.getMessage()+" ]  birth - : {}", birth);
			convertMap.replace("birth" , birth);
		}

		try{
			convertMap.replace("mobile" , StringUtil.isNotEmpty(mobile) ? PetraUtil.twoWayDecryptByThrow(mobile, userId, clientIp) : mobile);
		}catch(Exception e){
			log.error("[ "+e.getMessage()+" ]  mobile - : {}", mobile);
			convertMap.replace("mobile" , mobile);
		}

		try{
			convertMap.replace("email" , StringUtil.isNotEmpty(email) ? PetraUtil.twoWayDecryptByThrow(email, userId, clientIp) : email);
		}catch(Exception e){
			log.error("[ "+e.getMessage()+" ]  email - : {}", email);
			convertMap.replace("email" , email);
		}

		result = new ObjectMapper().convertValue(convertMap,type);

		return result;
	}
	
	@Override
	public List<MemberBaseVO> listMemberBaseForBirthdayBatch() {
		List<MemberBaseVO> voList = memberBatchDao.listMemberBaseForBirthdayBatch();
		List<MemberBaseVO> returnVOList = new ArrayList<MemberBaseVO>();

		String nowDate = DateUtil.getNowDate();
		for(MemberBaseVO vo : voList) {
			vo = decryptMemberBase(vo);

			if(vo.getBirth() != null && !"".equals(vo.getBirth())){
				String nowDay = nowDate.substring(nowDate.length()-4, nowDate.length());
				String birthDayAWeekAgo = DateUtil.addDay(vo.getBirth(), "yyyyMMdd", -6);
				String birthAWeekAgo = birthDayAWeekAgo.substring(birthDayAWeekAgo.length()-4, birthDayAWeekAgo.length());

				if(nowDay.equals(birthAWeekAgo)) {
					returnVOList.add(vo);
				}
			}
		}
		
		return returnVOList;
	}
	
	@Override
	public List<MemberBaseVO> listMemberBaseForDomantAlarmBatch() {
		List<MemberBaseVO> voList = memberBatchDao.listMemberBaseForDomantAlarmBatch();
		List<MemberBaseVO> returnVOList = new ArrayList<MemberBaseVO>();
		
		for(MemberBaseVO vo : voList) {
			vo = decryptMemberBase(vo);	
			
			returnVOList.add(vo);
		}
		
		return returnVOList;
	}
	
	@Override
	public List<MemberBaseVO> listMemberBaseForDormantOrLeave(String batchGb) {
		return memberBatchDao.listMemberBaseForDormantOrLeave(batchGb);
	}
	
	@Override
	public List<MemberBizInfoVO> listMemberBizInfoForDormantOrLeave(String batchGb) {
		return memberBatchDao.listMemberBizInfoForDormantOrLeave(batchGb);
	}
	
	@Override
	public List<MemberAddressVO> listMemberAddressForDormantOrLeave(String batchGb) {
		return memberBatchDao.listMemberAddressForDormantOrLeave(batchGb);
	}
	
	@Override
	public int updateMemberBaseForDormant(List<MemberBasePO> listMemberBasePO) {
		return memberBatchDao.updateMemberBaseForDormant(listMemberBasePO);
	}
	
	@Override
	public int updateMemberBizInfoForDormant(List<MemberBizInfoPO> listMemberBizInfoPO) {
		return memberBatchDao.updateMemberBizInfoForDormant(listMemberBizInfoPO);
	}
	
	@Override
	public int deleteMemberAddressForDormant(List<MemberAddressPO> listMemberAddressPO) {
		return memberBatchDao.deleteMemberAddressForDormant(listMemberAddressPO);
	}
	
	@Override
	public int updateMemberBaseForLeave(List<MemberBasePO> listMemberBasePO) {
		return memberBatchDao.updateMemberBaseForLeave(listMemberBasePO);
	}
	
	@Override
	public int updateMemberBizInfoForLeave(List<MemberBizInfoPO> listMemberBizInfoPO) {
		return memberBatchDao.updateMemberBizInfoForLeave(listMemberBizInfoPO);
	}
	
	@Override
	public int deleteMemberAddressForLeave(List<MemberAddressPO> listMemberAddressPO) {
		return memberBatchDao.deleteMemberAddressForLeave(listMemberAddressPO);
	}
	
	@Override
	public int updateMemberBaseForLeave(MemberBasePO po) {
		return memberBatchDao.updateMemberBaseForLeave(po);
	}
	
	@Override
	public int updateMemberBizInfoForLeave(MemberBizInfoPO po) {
		return memberBatchDao.updateMemberBizInfoForLeave(po);
	}
	

	@Override
	public List<MemberCouponVO> listMemberCouponExpire(Integer expire) {
		return memberBatchDao.listMemberCouponExpire(expire);
	} 

	@Override
	public int insertMemberGrdCoupon(MemberCouponPO po, List<Long> cpNos) {
		int result = memberBatchDao.insertMemberGrdCoupon(po);
		//TO-DO :: LMS 발송
		for(Long cpNo : cpNos){
			CouponSO s = new CouponSO();
			s.setCpNo(cpNo);
			CouponBaseVO c = couponService.getCoupon(s);

			//쿠폰 발급 안내 메세지 여부 확인
			if(StringUtil.equals(c.getMsgSndYn(),CommonConstants.COMM_YN_Y)){
				String mbrNosStr = po.getMbrNos();
				log.error("------------>##### Target MbrNos : {}",mbrNosStr);
				if(StringUtil.isNotEmpty(mbrNosStr)){
					String[] mbrNos = mbrNosStr.split(",");
					for(String ms : mbrNos){
						MemberCouponVO sendCoupon = new MemberCouponVO();
						sendCoupon.setCpNm(c.getCpNm());
						memberCouponService.memberCouponResInsertLmsSend(Long.parseLong(ms),sendCoupon);
					}
				}
			}
		}
		return result;
	}

	@Override
	public int updateMemberGrade(Map<String, String> map) {
		return memberBatchDao.updateMemberGrade(map);
	}
	
	@Override
	public List<MemberCouponVO> listCouponIsuStbBatch() {
		return memberBatchDao.listCouponIsuStbBatch();
	}
	
}
