package biz.app.system.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import biz.app.appweb.model.PushSO;
import biz.app.login.service.AdminLoginService;
import biz.app.st.dao.StDao;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.dao.UserDao;
import biz.app.system.model.AuthorityVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.UserAuthHistSO;
import biz.app.system.model.UserAuthHistVO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.model.UserLoginHistVO;
import biz.common.model.EmailSend;
import biz.common.model.EmailSendMap;
import biz.common.model.LmsSendPO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.twc.model.CounslorPO;
import biz.twc.service.TwcService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.common.util.security.PBKDF2PasswordEncoder;
import lombok.extern.slf4j.Slf4j;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Slf4j
@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private AdminLoginService adminLoginService;

	@Autowired private BizService bizService;

	@Autowired 	private CacheService cacheService;

	@Autowired private StDao stDao;

	@Autowired private Properties bizConfig;
	
	@Autowired private TwcService twcService;
	

	// PBKDF2
	@Autowired private PBKDF2PasswordEncoder passwordEncoder;

	@Override
	@Transactional(readOnly=true)
	public List<UserBaseVO> pageUser(UserBaseSO so) {
		List<UserBaseVO> list = userDao.pageUser(so);
		if(list != null && !list.isEmpty()) {
			for(UserBaseVO vo : list) {
				vo.setFax(StringUtil.phoneNumber(vo.getFax()));
				vo.setTel(StringUtil.phoneNumber(vo.getTel()));
				vo.setMobile(StringUtil.phoneNumber(vo.getMobile()));
			}
		}

		return list;
	}

	@Override
	@Transactional(readOnly=true)
	public UserBaseVO getUser(UserBaseSO so) {
		UserBaseVO vo = userDao.getUser(so);
		
		vo.setUsrGbNm(cacheService.getCodeName(CommonConstants.USR_GB, vo.getUsrGbCd()));
		vo.setUsrStatNm(cacheService.getCodeName(CommonConstants.USR_STAT, vo.getUsrStatCd()));
		/*if(vo != null) {
			vo.setFax(StringUtil.phoneNumber(vo.getFax()));
			vo.setTel(StringUtil.phoneNumber(vo.getTel()));
			vo.setMobile(StringUtil.phoneNumber(vo.getMobile()));
		}*/
		return vo;
	}

	@Override
	public void insertUser(UserBasePO po) {
		int cnt = userDao.getUserIdCheck(po.getLoginId());

		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_USER_DUPLICATION_FAIL);
		}

		// 사용자 번호가 9로 시작하는 9자리 기준이기 때문에 SEQUENCE_USR_DEFAULT_SEQ 내역을 추가
		//Long usrNo = CommonConstants.SEQUENCE_USR_DEFAULT_SEQ + this.bizService.getSequence(CommonConstants.SEQUENCE_USER_BASE_SEQ);
		
		// 2017. 12. 26. sequence 시작 숫자를 900000000 로 설정
		Long usrNo = this.bizService.getSequence(CommonConstants.SEQUENCE_USER_BASE_SEQ);
		po.setUsrNo(usrNo);

		/*
		 * 데이터 설정
		 */

		// 전화번호
		if(StringUtil.isNotBlank(po.getTel())){
			po.setTel(po.getTel().replace("-", ""));
		}

		// 휴대폰
		if(StringUtil.isNotBlank(po.getMobile())){
			po.setMobile(po.getMobile().replace("-", ""));
		}

		// 사용자 등록
		int result = userDao.insertUser(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 사용자 상태 이력 등록
		result = userDao.insertUserStausHist(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}	
		
		for(int intIndex = 0; intIndex < po.getAuthorityPOList().size(); intIndex++){
			Long authNo = po.getAuthorityPOList().get(intIndex);
			po.setAuthNo(authNo);
			
			// 사용자 권한 매핑 등록	
			result = userDao.insertUserAuthMap(po);
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}	
			
			// 사용자 권한 이력 등록
			result = userDao.insertUserAuthHist(po);
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		// TWC 상담원 가입정보 발송 API
		if(po.getUsrGbCd().equals(CommonConstants.USR_GB_1050)) {
			CounslorPO cPO = new CounslorPO();
			cPO.setApiKey(bizConfig.getProperty("counsel.api.key"));
			cPO.setBrandId(5339L);
			cPO.setLoginId(po.getLoginId());
			cPO.setName(po.getUsrNm());
			cPO.setPassword("");
			cPO.setRetryPassword("");
			cPO.setEmail(po.getEmail());
			cPO.setPhoneNumber(po.getMobile());
			
			twcService.sendCounselorInfo(cPO);
		}
	}

	@Override
	public void updateUser(UserBasePO po) {
		
		if(po.getLastLoginDtmStr() != null) {
			po.setLastLoginDtm(DateUtil.getTimestamp(po.getLastLoginDtmStr(), "yyyy-MM-dd HH:mm:ss"));
		}

		// 팩스
		if(StringUtil.isNotBlank(po.getFax())){
			po.setFax(po.getFax().replace("-", ""));
		}

		// 전화번호
		if(StringUtil.isNotBlank(po.getTel())){
			po.setTel(po.getTel().replace("-", ""));
		}

		// 휴대폰
		if(StringUtil.isNotBlank(po.getMobile())){
			po.setMobile(po.getMobile().replace("-", ""));
		}
		
		int result = 0;

		UserBaseSO so = new UserBaseSO();
		so.setUsrNo(po.getUsrNo());
		
		// 사용자 상태 이력 등록
		UserBaseVO vo = userDao.getUser(so);
		if(!vo.getUsrStatCd().equals(po.getUsrStatCd())){
			result = userDao.insertUserStausHist(po);
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}	
		}
		
		// 사용불가 -> 사용으로 상태 변경시 최종로그인일시 업데이트
		if(vo.getUsrStatCd().equals(CommonConstants.USR_STAT_40) && po.getUsrStatCd().equals(CommonConstants.USR_STAT_20)) {
			po.setLastLoginDtm(DateUtil.getTimestamp());
		}

		// 사용자 수정
		result = userDao.updateUser(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 사용자 권한 정보 조회
		List<UserBaseVO> listVo = this.getUserAuthMapList(so);
		int cnt = 0;

		// 사용자 권한 매핑 데이터 삭제
		userDao.deleteUserAuthMap(po);
		
		// 기존의 권한 매핑 데이터와 넘어온 권한데이터를 비교 후, 추가/변경된 권한만 권한 이력 테이블에 로우 단위로 삽입
		for(int intIndex = 0; intIndex < po.getAuthorityPOList().size(); intIndex++){
			//cnt = 0;
			Long authNo = po.getAuthorityPOList().get(intIndex);
			po.setAuthNo(authNo);
			
			// 사용자 권한 매핑 등록
			result = userDao.insertUserAuthMap(po);
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}	
			
			for(int intIndex1 = 0; intIndex1 < listVo.size(); intIndex1++){
				if(po.getAuthNo() == listVo.get(intIndex1).getAuthNo()) {
					break;
				} else {
					if(intIndex1 == (listVo.size()-1)) {
						// 사용자 권한 이력 등록
						result = userDao.insertUserAuthHist(po);
						if(result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}	
					}
				}
				//cnt++;
			}
		}
	}

	@Override
	@Transactional(readOnly=true)
	public int getUserIdCheck(String loginId) {
		return userDao.getUserIdCheck(loginId);
	}

	@Override
	public void updateUserInfo(UserBasePO po) {
		po.setUsrNo(AdminSessionUtil.getSession().getUsrNo());
		
		/*	비밀번호 변경 시 비밀번호 변경 화면으로 이동처리 할거라 주석 - 201228 이지희
		if(StringUtil.isNotBlank(po.getPswd())) {
			
			
			 * UserBaseSO so = new UserBaseSO();
				so.setLoginId(po.getLoginId());
				
				UserBaseVO userVO = adminLoginService.getUser(so);
				
				if (passwordEncoder.check(userVO.getPswd(), po.getPswd())) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_PSWD_UPDATE_ERROR);
				} 
				
			try {
				// 암호화 방식 변경(DCG 동기화 처리)
				// 보안진단 처리 - 주석으로 된 시스템 주요 정보 삭제

			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			
		}

		// 팩스
		if(StringUtil.isNotBlank(po.getFax())){
			po.setFax(po.getFax().replace("-", ""));
		}

		// 전화번호
		if(StringUtil.isNotBlank(po.getTel())){
			po.setTel(po.getTel().replace("-", ""));
		}

		// 휴대폰
		if(StringUtil.isNotBlank(po.getMobile())){
			po.setMobile(po.getMobile().replace("-", ""));
		}*/

		int result = userDao.updateInfoUser(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		adminLoginService.getSessionRefresh(AdminSessionUtil.getSession().getLoginId());
	}

	@Override
	@Transactional(readOnly=true)
	public List<UserLoginHistVO> pageUserLogin(UserBaseSO so) {
		return userDao.pageUserLogin(so);
	}

	@Override
	public void updatePasswordUser(UserBasePO po) {
		String orignalPassword = null;
		//초기화 여부 Y
		po.setPswdInitYn(CommonConstants.COMM_YN_Y);
		try {

			orignalPassword = StringUtil.temporaryPassword(8); //실제 사용할거

			// 암호화 방식 변경(DCG 동기화 처리)
			// po.setPswd(CryptoUtil.encryptSHA512(orignalPassword));
			// po.setPswd(CryptoUtil.encryptSHA256(CryptoUtil.encryptMD5(orignalPassword)));
			//po.setPswd(passwordEncoder.encode(orignalPassword));
			po.setPswd("");

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		int result = userDao.updatePasswordUser(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		SsgMessageSendPO msg = new SsgMessageSendPO();
		msg.setFuserid(String.valueOf(po.getUsrNo()));

		PushSO pso = new PushSO();
		pso.setTmplNo(1L);
		msg.setFmessage("【AboutPet】\n 관리자시스템에서 사용자님의 비밀번호가 초기화되었습니다. “비밀번호찾기” 메뉴에서 새 비밀번호를 설정 후 이용해주세요.");
		msg.setFdestine(po.getMobile());
		msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
		msg.setMbrNo(po.getUsrNo());
		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
		
		bizService.sendMessage(msg);
	}

	@Override
	public List<UserBaseVO> getUserList(UserBaseSO so) {
		return userDao.getUserList(so);
	}

	@Override
	public void updatePassword(UserBasePO po) {
		try {
			po.setPswd(passwordEncoder.encode(po.getPswd()));
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//log.error(e.getMessage(), e);
			log.error("Exception when encode", e.getClass());
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		if(!AdminSessionUtil.isAdminSession()) {
			po.setSysRegrNo(Long.valueOf(0));
			po.setSysUpdrNo(Long.valueOf(0));
		}
		
		int result = userDao.updatePasswordUser(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 * 
	 * @param newPassword
	 * @return
	 */
	public String getDemoPasswd(String newPassword) {
		return passwordEncoder.encode(newPassword);
	}

	@Override
	public List<AuthorityVO> listAuth(UserBaseSO so) {
		return userDao.listAuth(so);
	}

	@Override
	public List<UserBaseVO> getUserAuthMapList(UserBaseSO so) {
		return userDao.getUserAuthMapList(so);
	}

	@Override
	public List<UserBaseVO> getUserAuthMenuList(UserBaseSO so) {
		return userDao.getUserAuthMenuList(so);
	}

	@Override
	public List<String> selectPswdHist(UserBaseSO so) {
		return userDao.selectPswdHist(so);
	}

	@Transactional
	@Override
	public Integer updateNewPswd(UserBasePO po) {
		int resultUd = userDao.updateNewPswd(po);
		int resultHist = userDao.insertPswdHist(po);
		
		return resultUd+resultHist;
	}

	@Override
	public int userCompanyDupChk(UserBaseSO so) {
		return userDao.userCompanyDupChk(so);
	}

	@Override
	public List<UserAuthHistVO> userAuthHistGrid(UserAuthHistSO so) {
		return userDao.userAuthHistGrid(so);
	}

	@Override
	public List<UserAuthHistVO> pageUserAuthHist(UserAuthHistSO so) {
		return userDao.pageUserAuthHist(so);
	}
	
	
}