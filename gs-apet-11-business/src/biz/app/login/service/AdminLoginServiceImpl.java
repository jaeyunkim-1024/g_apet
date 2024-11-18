package biz.app.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.login.dao.AdminLoginDao;
import biz.app.login.model.UserLoginHistPO;
import biz.app.system.dao.UserDao;
import biz.app.system.model.AuthorityVO;
import biz.app.system.model.UserAgreeInfoPO;
import biz.app.system.model.UserAgreeInfoVO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.RequestUtil;
import framework.common.util.SessionUtil;
import framework.common.util.security.PBKDF2PasswordEncoder;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AdminLoginServiceImpl implements AdminLoginService {
	protected final Logger logger = LoggerFactory.getLogger(AdminLoginServiceImpl.class);

	@Autowired
	private AdminLoginDao adminLoginDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private HttpServletRequest request;

	// PBKDF2
	@Autowired 
	private PBKDF2PasswordEncoder passwordEncoder;

	
	@Transactional
	@Override
	public Map<String, Object> getLoginCheck(String id, String pwd) {

		UserBaseSO so = new UserBaseSO();
		so.setLoginId(id);
		so.setPswd(pwd);

		Map<String, Object> result = new HashMap<>();

		result = this.getUserWithCheck(so);
		UserBaseVO user = (UserBaseVO) result.get("user");

		if(result.get("exCode") != null) return result;

		if(user != null && user.getUsrGrpCd().equals(CommonConstants.USR_GRP_20)) {
			int userAgreeInfoCnt = (int) result.get("userAgreeInfoCnt");
			if(user.getLastLoginDtm() == null && userAgreeInfoCnt == 0) { 
				result.put("exCode", AdminConstants.PO_USER_FIRST_LOGIN);
				return result;
			}
		}
		
		//비밀번호 변경 이력이 3개월 이상
		if("Y".equals(user.getPswdChgSchdYn())) {
			result.put("exCode", ExceptionConstants.ERROR_CODE_PSWD_HIST_FAIL);
			return result;
		}
		
		try {
			UserLoginHistPO po = new UserLoginHistPO();
			po.setUsrNo(user.getUsrNo());
			po.setSysRegrNo(user.getUsrNo());
			po.setLoginIp(RequestUtil.getClientIp());
			
			//로그인 이력 추가
			adminLoginDao.insertUserLoginHist(po);
			
			UserBasePO usrPo = new UserBasePO();
			usrPo.setLoginId(id);
			// 실패횟수 초기화, 최종로그인날짜 업뎃
			adminLoginDao.updateUserLogin(usrPo);
			
			//권한리스트 조회 
			so.setUsrNo(user.getUsrNo());
			List<AuthorityVO> authList = userDao.selectAuthNoListForSession(so);
			List<Long> listAuth = new ArrayList<Long>();
			for(AuthorityVO auth : authList) {
				listAuth.add(auth.getAuthNo());
			}

			// 로그인 세션 생성
			Session session = new Session();
			session.setSessionId(SessionUtil.getSessionId());
			session.setUsrNo(user.getUsrNo());
			session.setLoginId(user.getLoginId());
			session.setUsrNm(user.getUsrNm());
			session.setUsrStatCd(user.getUsrStatCd());
			session.setCompNo(user.getCompNo());
			session.setCompNm(user.getCompNm());
			session.setCompStatCd(user.getCompStatCd());
			session.setUsrGrpCd(user.getUsrGrpCd());
			session.setAuthNos(listAuth);
			session.setUsrGbCd(user.getUsrGbCd());
			session.setUpCompNo(user.getUpCompNo());
			session.setUpCompNm(user.getUpCompNm());
			session.setCtiId(user.getCtiId());
			session.setCtiExtNo(user.getCtiExtNo());
			session.setMdUsrNo(user.getMdUsrNo());
			session.setLastLoginDtm(usrPo.getLastLoginDtm());
			AdminSessionUtil.setSession(session);
			
		}catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("[AdminLoginServiceImpl] error : ", e.getClass()); 
			result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_QUERY_UPDATE);
			return result;
		}
		
	
		return result;
	}


	@Override
	public void getSessionRefresh(String id) {
		UserBaseSO so = new UserBaseSO();
		so.setLoginId(id);
		UserBaseVO user = adminLoginDao.getUser(so);

		// 로그인 세션 생성
		Session session = new Session();
		session.setSessionId(SessionUtil.getSessionId());
		session.setUsrNo(user.getUsrNo());
		session.setLoginId(user.getLoginId());
		session.setUsrNm(user.getUsrNm());
		session.setUsrStatCd(user.getUsrStatCd());
		session.setCompNo(user.getCompNo());
		session.setCompNm(user.getCompNm());
		session.setCompStatCd(user.getCompStatCd());
		session.setUsrGrpCd(user.getUsrGrpCd());
		session.setAuthNo(user.getAuthNo());
		session.setUsrGbCd(user.getUsrGbCd());
		session.setCtiId(user.getCtiId());
		session.setCtiExtNo(user.getCtiExtNo());
		session.setMdUsrNo(user.getMdUsrNo());

		AdminSessionUtil.setSession(session);
	}

	@Override
	public UserBaseVO getUser(UserBaseSO so) {
		return adminLoginDao.getUser(so);
	}

	@Override
	public Map<String, Object> getUserWithCheck(UserBaseSO so) {
		Map<String, Object> result = new HashMap<>();
		
		UserBaseVO user = adminLoginDao.getUser(so);
		
		result.put("user", user);

		// PO 사용자일경우 약관동의 여부 체크
		if(user != null && user.getUsrGrpCd().equals(CommonConstants.USR_GRP_20)) {
			so.setUsrNo(user.getUsrNo());
			List<UserAgreeInfoVO> userAgreeInfoList = adminLoginDao.selectUserAgreeInfoList(so);
			result.put("userAgreeInfoCnt", userAgreeInfoList.size());	
		}
		
		try {
			if(user != null && so.getPswd() != null) { //pwd null아닌 경우 추가201223 - 비밀번호 변경시에는 체크 안하려고
				
				Long loginFailCnt = user.getLoginFailCnt() == null ? 0L : user.getLoginFailCnt();
				
				if(CommonConstants.USR_STAT_20.equals(user.getUsrStatCd()) && (user.getPswd() == null || user.getPswd().isEmpty())){ //최초로그인인 경우
					if(user.getUsrGrpCd().equals(CommonConstants.USR_GRP_20)) {
						result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_PO_FIRST);
					} else {
						result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_BO_FIRST);	
					}
					return result;
				/*}else if(CommonConstants.USR_STAT_10.equals(user.getUsrStatCd())){
					result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_STATUS_FAIL);
					return result;*/
				} else if(!CommonConstants.COMP_STAT_20.equals(user.getCompStatCd())){
					result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_COMPANY_STATUS_FAIL);
					return result;
				} else if(loginFailCnt >= 5 ) { //비밀번호 5번 오류
						result.put("exCode", ExceptionConstants.ERROR_CODE_BO_PW_FAIL_CNT);
						return result;
				} else {
					if (!passwordEncoder.check(user.getPswd(), so.getPswd())) {
						// 에러 카운트 증가
						adminLoginDao.updateUserFailCnt(so.getLoginId());
						result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_PW_FAIL);
						return result;
						
					}else {
						
						//비밀번호 초기화 된 경우
						if("Y".equals(user.getPswdInitYn()) && user.getPswd() == null) { //& CommonConstants.USR_STAT_10.equals(user.getUsrStatCd()) &
							result.put("exCode", ExceptionConstants.ERROR_CODE_BO_PW_RESET_FAIL_CNT);
							return result;
						}
						
						UserBasePO po = new UserBasePO();
						po.setUsrNo(user.getUsrNo()); 
						po.setSysUpdrNo(user.getUsrNo()); 
						
						//if (CommonConstants.USR_STAT_40.equals(user.getUsrStatCd()) ||"Y".equals(user.getLoginAMonthYn()))
						if (CommonConstants.USR_STAT_40.equals(user.getUsrStatCd()))
						{	//로그인한지 30일지난경우 잠금처리 
							/*if(!CommonConstants.USR_STAT_40.equals(user.getUsrStatCd())) {
								po.setUsrStatCd(CommonConstants.USR_STAT_40);
								userDao.updateUserState(po);
							}*/
							result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_STATUS_QSC);
							return result;
						}
						
						if (CommonConstants.USR_STAT_30.equals(user.getUsrStatCd()) || "Y".equals(user.getValidYn())) 
						{	//유효기간이 지난경우 잠금처리
							if(!CommonConstants.USR_STAT_30.equals(user.getUsrStatCd())) {
								po.setUsrStatCd(CommonConstants.USR_STAT_30);
								userDao.updateUserState(po);
							}
							result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_STATUS_LOCK);
							return result;
						}
						
					}
				}
			} else if(user == null && so.getPswd() != null) {
				// 사용자가 계정이 없음
				result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_ID_FAIL);
				return result;
			}
		} catch (Exception e) {
			// 기본 오류
			logger.error(e.getLocalizedMessage()); 
			result.put("exCode", ExceptionConstants.ERROR_CODE_DEFAULT);
			return result;
		}

		result.put("S", "success");
		
		return result;
	}

	@Override
	public int insertUserAgreeInfo(UserBaseSO userSO, UserAgreeInfoPO po) {		
		UserBaseVO user = adminLoginDao.getUser(userSO);
		po.setUsrNo(user.getUsrNo());
		po.setSysRegrNo(user.getUsrNo());
		
		int result = adminLoginDao.insertUserAgreeInfo(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}
}
