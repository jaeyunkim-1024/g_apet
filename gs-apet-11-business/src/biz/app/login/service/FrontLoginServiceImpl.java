package biz.app.login.service;

import biz.app.cart.service.CartService;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDtlInqrHistPO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.dao.MemberDao;
import biz.app.member.dao.MemberLoginHistoryDao;
import biz.app.member.model.*;
import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.PushTokenPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.*;
import framework.common.util.security.PBKDF2PasswordEncoder;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.annotation.Nullable;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.login.service
* - 파일명		: FrontLoginServiceImpl.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: Front 로그인 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("frontLoginService")
public class FrontLoginServiceImpl implements FrontLoginService {

	@Autowired private Properties webConfig;
	
	@Autowired private CacheService cacheService;

	@Autowired private HttpServletRequest request;

	@Autowired private MemberDao memberDao;

	@Autowired private MemberBaseDao memberBaseDao;
	
	@Autowired private MemberLoginHistoryDao memberLoginHistoryDao;
	
	@Autowired private CartService cartService;
	
	@Autowired private BizService bizService;
	
	@Autowired private MemberService memberService;
	
	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;
	
	@Autowired
	private SearchApiUtil searchApiUtil;

	// PBKDF2
	@Autowired private PBKDF2PasswordEncoder passwordEncoder;
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2021. 1. 21.
	* - 작성자		: 이지희
	* - 설명		: 회원 로그인 체크
	* </pre>
	* @param loginId
	* @param password
	* @param loginPathCd
	* @return
	* @throws Exception
	*/
	@Override
	public Map<String, Object> checkLogin(MemberBaseVO checkVo) {
		
		Map<String, Object> result = new HashMap<>();
		
		MemberBaseSO po = new MemberBaseSO();
		po.setLoginId(bizService.twoWayEncrypt(checkVo.getLoginId()));
		po.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		po.setPswd("pswd"); //getMemberBase 차별화둬서 태그 갯수 갖고오려고
		
		MemberBaseVO member = this.memberBaseDao.getMemberBase(po);
		
		if(member == null){
			result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_ID_FAIL);
			return result;
		}
		
		result.put("mbrNo", member.getMbrNo());
		
		
		//하루 펫츠비 기존 회원인데 최조 로그인인 경우 - 가입경로 어바웃펫 아니고 로그인기록 없고 
		MemberLoginHistVO loginHist = this.memberLoginHistoryDao.selectLoginHistory(member.getMbrNo());
		if(member.getJoinPathCd()!=null && !member.getJoinPathCd().equals(FrontConstants.JOIN_PATH_30) && StringUtil.isEmpty(loginHist)) {
			SessionUtil.setAttribute(FrontConstants.SESSION_UPDATE_HRPB, member);
			result.put("PBHR", "PBHR");
			return result;
		}
		
		
		if(member.getPswd() == null || member.getPswd().equals("")) {
			result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_PW_FAIL);
			return result;
		}
		
		//비밀번호 틀린 경우
		if (!passwordEncoder.check(member.getPswd(), checkVo.getPswd().toLowerCase())) {
			
			if(member.getLoginFailCnt() != null && member.getLoginFailCnt() >= 4) {
				result.put("exCode", ExceptionConstants.ERROR_CODE_FO_PW_FAIL_CNT);
			}else {
				result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_PW_FAIL);
			}
			//로그인 실패수 증가 처리
			MemberBasePO upo = new MemberBasePO();
			upo.setMbrNo(member.getMbrNo());
			this.memberDao.updateMemberLoginFailCnt(upo);
			return result;
		}

		//로그인 조건 체크
		String validResult = this.checkLoginInfo(member);
		if(!validResult.equals(CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS)&& !validResult.equals("notag")) {
			result.put("exCode", validResult);
			return result;
		}
		
		//어바웃펫 회원인지 하루,펫츠비 회원인지
		result.put(FrontConstants.JOIN_PATH , member.getJoinPathCd());

		//GS 연동 해제 최초 1번만
		result.put("gsptStateCd",member.getGsptStateCd());
		result.put("gsptUseYn",member.getGsptUseYn());
		
		//펫로그회원인 경우 추가
		result.put("petLog", member.getBizNo() == null ? null : member.getBizNo());
		
		//세선저장- 로그인처리
		if(Objects.isNull(result.get("exCode"))) {
			member.setLoginPathCd(checkVo.getLoginPathCd());
			member.setKeepYn(checkVo.getKeepYn()); 
			
			if(checkVo.getDeviceToken() != null && !checkVo.getDeviceToken().equals("")) {
				member.setDeviceToken(checkVo.getDeviceToken());
				member.setDeviceTpCd(checkVo.getDeviceTpCd()); 
			}else {
				member.setDeviceToken(null);
				member.setDeviceTpCd(null);
			}
			this.saveLoginSession(member,null);
		}
		
		//태그 여부 조회
		if(member.getTags() == null || Integer.parseInt(member.getTags()) < 1) {
			result.put("tags" ,"no_tag");
		}
		
		
		return result;
	}
	
	
	/** 로그인 정보 유효성체크*/
	@Override
	public String checkLoginInfo(MemberBaseVO member) {
		try {
			
			if(CommonConstants.MBR_STAT_30.equals(member.getMbrStatCd())){		//휴면상태
				/*httpSession.removeAttribute(FrontConstants.SESSION_MEMBER_MBR_NO);
				httpSession.setAttribute(FrontConstants.SESSION_MEMBER_MBR_NO, member.getMbrNo());*/
				return ExceptionConstants.ERROR_CODE_LOGIN_SLEEP;
			}else if(CommonConstants.MBR_STAT_40.equals(member.getMbrStatCd())){	//중복
				return ExceptionConstants.ERROR_CODE_LOGIN_DUPLICATE_PHONE;
			}else if(CommonConstants.MBR_STAT_70.equals(member.getMbrStatCd())){	//정지
				return ExceptionConstants.ERROR_CODE_LOGIN_STOP;
			/*}else if(CommonConstants.MBR_STAT_80.equals(member.getMbrStatCd())){	//부당거래정지
				return ExceptionConstants.ERROR_CODE_LOGIN_UNFAIR_TRADE;*/
			}else{
				if(!CommonConstants.MBR_STAT_10.equals(member.getMbrStatCd())){
					return ExceptionConstants.ERROR_CODE_LOGIN_STATUS_FAIL;
				}
			}
			
			if(member.getLoginFailCnt() != null && member.getLoginFailCnt() >= 5) {
				return ExceptionConstants.ERROR_CODE_FO_PW_FAIL_CNT;
			}
			
			if("Y".equals(member.getPswdInitYn())) {
				return ExceptionConstants.ERROR_CODE_FO_PW_RESET_FAIL_CNT;
			}
			
			//태그 여부 조회 -- sns 로그인 시에도 체크하려고 추가 210216
			if(member.getTags() == null || Integer.parseInt(member.getTags()) < 1) {
				return "notag";
			}
			
			// if(!CryptoUtil.encryptSHA512(pswd).equals(member.getPswd())){
			// if (!CryptoUtil.encryptSHA256(CryptoUtil.encryptMD5(pswd)).equals(member.getPswd())) {
			// if (!passwordEncoder.encode(pswd).equals(member.getPswd())) {
			
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}catch(Exception e){
			return ExceptionConstants.ERROR_CODE_DEFAULT;
		}
	}
	
	/** 로그인 세션 추가 */
	@Override
	public Session saveLoginSession(MemberBaseVO member, @Nullable String justSave ) {
			log.debug("saveLoginSEssion : {}",member);
		
			saveRecentGoodsOfMbrNo(member.getMbrNo());

			Session session = FrontSessionUtil.getSession();
			
			//펫로그 회원 여부
			session.setBizNo(member.getBizNo()); 

			session.setPetLogUrl(member.getPetLogUrl()); 
			session.setMbrNo(member.getMbrNo());
			session.setMbrNm(member.getMbrNm() == null ? null : bizService.twoWayDecrypt(member.getMbrNm()));
			session.setLoginId(bizService.twoWayDecrypt(member.getLoginId()));
			session.setMbrGbCd(member.getMbrGbCd());
			session.setMbrGrdCd(member.getMbrGrdCd());
			if(member.getKeepYn() !=null && member.getKeepYn().equals("Y")) {session.setKeepYn(member.getLoginId());} 
			if(member.getMbrGbCd() !=null && member.getMbrGbCd().equals(FrontConstants.MBR_GB_CD_10)) {session.setGsptNo(member.getGsptNo());}
			session.setCertifyYn(member.getCtfYn());	//본인인증여부
			session.setPetGbCd(member.getPetGbCd()); //대표 펫 구분 코드 추가
			session.setNickNm(member.getNickNm()); 
			
			//등급 정보 추가 210216
			CodeDetailVO grdCd = cacheService.getCodeCache(CommonConstants.MBR_GRD_CD, member.getMbrGrdCd());
			session.setAccurateRate(grdCd.getUsrDfn3Val());
			session.setAccurateValidity(grdCd.getUsrDfn5Val()); 
			
			session.setLoginPathCd(member.getLoginPathCd()); //로그인 경로 - 네이버, 카카오, 구글, 애플, 어바웃펫
			session.setPetNos(member.getPetNos());  //반려동물 목록 추가
			session.setTagYn(member.getTags() == null ? "N" : "Y");
			session.setAlmRcvYn(member.getAlmRcvYn()); //알림 수신여부
			session.setInfoRcvYn(member.getInfoRcvYn());  // 정보성 수신 동의 여부
			session.setPrflImg(member.getPrflImg()); //프로필 이미지 추가
			
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			Properties bizConfig = (Properties) wContext.getBean("bizConfig");
			String envGb = bizConfig.getProperty("envmt.gb");
			session.setEnv(envGb);
			session.setExpire(FrontSessionUtil.getSession().getExpire());
			
			// 위치 정보 동의 여부 추가
			session.setPstInfoAgrYn(member.getPstInfoAgrYn());

			//마이그
			session.setMigMemno(Optional.ofNullable(member.getMigMemno()).orElseGet(()->-1L));

			log.debug("session : {}",session) ;
			FrontSessionUtil.setSession(session);
			
			if(justSave == null) {
				/******************************
				 * 장바구니 변경 :(비회원 > 회원)
				 ******************************/
				Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
				this.cartService.updateCartInfo(stId, session.getSessionId(), session.getMbrNo());
				
				setLoginInfo(session,member);
			}
			return session;
			
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2020. 02. 05.
	* - 작성자		: 이지희
	* - 설명		: 회원 로그인 아이디 찾기 (이메일)
	* </pre>
	* @param mbrNm
	* @param email
	* @throws Exception
	*/
	@Override
	public MemberBaseVO getMemberLoginIdEmail(MemberBaseSO so) {

		MemberBasePO po = new MemberBasePO();
		so.setPswd("pswd"); 
		MemberBaseVO member = this.memberBaseDao.getMemberBase(so);
		if(member == null){
			return null;
		}else{
			
			Long ctfLogNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_CERTIFIED_LOG_SEQ);
			MemberCertifiedLogPO certpo = new MemberCertifiedLogPO();
			certpo.setCtfLogNo(ctfLogNo);
			certpo.setCtfMtdCd(FrontConstants.CTF_MTD_EMAIL);
			certpo.setCtfTpCd(FrontConstants.CTF_TP_FIND_PWD);
			
			certpo.setCtfRstCd("B000") ;// 임시 - 본인인증 따라하기
			certpo.setMbrNo(member.getMbrNo());  
			certpo.setSysRegrNo(member.getMbrNo());
			
			memberBaseDao.insertCertifiedLog(certpo);
			
			String rtnLoginId = bizService.twoWayDecrypt(member.getLoginId());
			//String rtnMbrNm = bizService.twoWayDecrypt(member.getMbrNm());
			member.setLoginId(rtnLoginId);
			member.setMbrNm(member.getMbrNm() == null ? null : MaskingUtil.getName(bizService.twoWayDecrypt(member.getMbrNm())));  
		}
		
		return member;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: FrontLoginService.java
	* - 작성일		: 2020. 02. 05.
	* - 작성자		: 이지희
	* - 설명		: 회원 로그인 아이디/비번 찾기 (본인인증)
	* </pre>
	* @param authJson
	* @throws Exception
	*/
	@Override
	public MemberBaseVO getMemberIdPswdMobile(String authJson, String loginId) {
		
		MemberBaseVO returnMem = new MemberBaseVO();
		MemberBasePO po = new MemberBasePO();

		//인증값에서 값 추출
		String authJsonRpl = authJson.replaceAll("&quot;", "\"");
		JSONObject auth = new JSONObject(authJsonRpl);
		
		//String mbrNm = bizService.twoWayEncrypt( auth.getString("RSLT_NAME"));
		String mobile = bizService.twoWayEncrypt(auth.getString("TEL_NO"));
		
		MemberBaseSO so = new MemberBaseSO();
		//so.setMbrNm(mbrNm);
		so.setMobile(mobile);
		if(loginId != null) {so.setLoginId(bizService.twoWayEncrypt(loginId));} 
		
		so.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));

		so.setPswd("pswd"); 
		MemberBaseVO member = this.memberBaseDao.getMemberBase(so);
		
		//인증로그 회원번호 update 위한 초기화
		MemberCertifiedLogPO certPo = new MemberCertifiedLogPO();
		certPo.setCtfLogNo( auth.getLong("LOG_NO")); 

		if(member == null){
			//회원 아닌경우는 인증 로그 삭제하기
			memberBaseDao.deleteCertifiedLogNotMem(certPo);
			return null;
		}else{
			
			//인증정보 회원에 update
			String gender = auth.getString("RSLT_SEX_CD");
			if(gender.equals("F")) {gender = "20";}
			else if(gender.equals("M")) {gender = "10";}
			String birth = bizService.twoWayEncrypt(auth.getString("RSLT_BIRTHDAY"));
			
			po.setMbrNo(member.getMbrNo()); 
			po.setCiCtfVal(auth.getString("CI"));
			po.setDiCtfVal(auth.getString("DI"));
			String mbrNm = bizService.twoWayEncrypt( auth.getString("RSLT_NAME"));
			po.setMbrNm(mbrNm);
			po.setMobileCd(auth.getString("TEL_COM_CD"));
			po.setCtfYn("Y"); 
			po.setBirth(birth);
			po.setGdGbCd(gender);
			String natinalCd  = auth.getString("RSLT_NTV_FRNR_CD");
			if(natinalCd.equals("L")) {natinalCd = "10";}
			else if(natinalCd.equals("F")) {natinalCd = "20";}
			po.setNtnGbCd(natinalCd); 
			po.setUpdrIp(RequestUtil.getClientIp());
			//po.setMbrStatCd(FrontConstants.MBR_STAT_10); 
			po.setSysUpdrNo(po.getMbrNo()); 
			//멤버상태 정상으로 update
			memberService.updateMemberBase(po);
			
			//인증로그 회원번호 update
			certPo.setMbrNo(po.getMbrNo());
			certPo.setSysRegrNo(po.getMbrNo());
			certPo.setCtfTpCd(FrontConstants.CTF_TP_FIND_PWD); //아디 변경으로 변경필요.
			memberBaseDao.updateCertifiedLogMbrNo(certPo);
		
			String rtnLoginId = bizService.twoWayDecrypt(member.getLoginId());
			//String rtnMbrNm = bizService.twoWayDecrypt(member.getMbrNm());
			returnMem.setLoginId(MaskingUtil.getId(rtnLoginId));
			returnMem.setMbrNm( MaskingUtil.getName( auth.getString("RSLT_NAME")));  
			returnMem.setMbrNo(member.getMbrNo()); 
		
			
		}
		return returnMem;
		 
	}

	/*
	 * 회원 비밀번호 찾기 (이메일로 전송)
	 * @see biz.app.login.service.FrontLoginService#getMemberPasswordEmail(java.lang.String, java.lang.String)
	 */
	@Override
	@Deprecated
	public void getMemberPasswordEmail(String loginId, String email) {
		MemberBaseSO so = new MemberBaseSO();
		so.setLoginId(loginId);
		so.setEmail(email);
		
		so.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		
		MemberBaseVO memberList = this.memberBaseDao.getMemberBase(so);

		if(memberList == null){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER);
		}else{
				//비밀번호 초기화
				this.memberService.updateMemberPasswordInit(memberList.getMbrNo(), CommonConstants.SEND_PSWD_MEANS_CD_EMAIL);
				
				//이력 등록
				try {
					memberService.insertMemberBaseHistory(memberList.getMbrNo());
				} catch (Exception e) {
					log.error("11.business.FrontLoginServiceImpl.getMemberPasswordEmail : {} ", memberList.getMbrNo());
				}
		}
	}

	/*
	 * 회원 비밀번호 찾기 (휴대폰 전송)
	 * @see biz.app.login.service.FrontLoginService#getMemberPasswordMobile(java.lang.String, java.lang.String)
	 */
	@Override
	@Deprecated
	public void getMemberPasswordMobile(String loginId, String mobile) {
		MemberBaseSO so = new MemberBaseSO();
		so.setLoginId(loginId);
		so.setMobile(mobile);
		
		so.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		
		MemberBaseVO memberList = this.memberBaseDao.getMemberBase(so);

		if(memberList == null){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER);
		}else{
		
			//비밀번호 초기화
			this.memberService.updateMemberPasswordInit(memberList.getMbrNo(), CommonConstants.SEND_PSWD_MEANS_CD_SMS);
			
			//이력 등록
			try {
				memberService.insertMemberBaseHistory(memberList.getMbrNo());
			} catch (Exception e) {
				log.error("11.business.FrontLoginServiceImpl.getMemberPasswordEmail : {} ", memberList.getMbrNo());
			}
		}
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: FrontLoginService.java
	 * - 작성일		: 2021. 03. 05.
	 * - 작성자		: 이지희
	 * - 설명		:  검색엔진 api에 관심태그로그 등록 
	 * </pre>
	 * @param mbrNo
	 * @param tagNo
	 * @return
	 */		
	@Override
	public String setTagAction(Map<String,String> requestParam) throws Exception {
		//Map<String,String> requestParam = new HashMap<String,String>();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime = format.format(new Date());
        
        requestParam.put("SECTION", "member");
        requestParam.put("ACTION", "change");
        requestParam.put("LITD", "");
        requestParam.put("LTTD", "");
        requestParam.put("PRCL_ADDR", "");
        requestParam.put("ROAD_ADDR", "");
        requestParam.put("POST_NO_NEW", "");
        requestParam.put("TIMESTAMP", nowTime);
        
        String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_ACTION, requestParam);
        //log.debug("tag action log result : {}",res); 
        if(res != null) {
        	ObjectMapper objectMapper = new ObjectMapper();
        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
        		return FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
        	}
		}

		return FrontConstants.CONTROLLER_RESULT_CODE_FAIL;
	}
	
	@Override
	public int updateInfoRcvYn(MemberBasePO po) {
		po.setSysUpdrNo(po.getMbrNo());
		po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
		
		int result = memberBaseDao.updateInfoRcvYn(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		Session session = FrontSessionUtil.getSession();
		session.setInfoRcvYn(po.getInfoRcvYn());
		FrontSessionUtil.setSession(session);
		
		memberService.insertMemberBaseHistory(po.getMbrNo());
		
		return result;
	}
	
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: FrontLoginServiceImpl.java
	 * - 작성일		: 2021. 03. 30.
	 * - 작성자		: 이지희
	 * - 설명		:  로그인 시 로그인이력등록, 최근로그인일시 업데이트
	 * </pre>
	 * @param member
	 * @param session
	 * @return
	 */	
	public void setLoginInfo(Session session, MemberBaseVO member) {
		
		// 로그인 이력 등록
		MemberLoginHistPO lhpo = new MemberLoginHistPO();
		lhpo.setMbrNo(session.getMbrNo());
		lhpo.setLoginIp(RequestUtil.getClientIp());
		lhpo.setSysRegrNo(session.getMbrNo());
		lhpo.setLoginPathCd(member.getLoginPathCd()); 
		this.memberLoginHistoryDao.insertLoginHistory(lhpo);
		
		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		
		// 최종 로그인 일시 업데이트 & 디바이스 토큰 업뎃
		MemberBasePO muo = new MemberBasePO();
		muo.setStId(stId);
		muo.setMbrNo(session.getMbrNo());
		if(member.getDeviceToken() != null && !member.getDeviceToken().equals("")) {
			
			String originToken = memberBaseDao.getMemberDeviceToken(session.getMbrNo());
			if(originToken == null || !originToken.equals(member.getDeviceToken() )) {
				
				muo.setDeviceToken(member.getDeviceToken());
				muo.setDeviceTpCd(member.getDeviceTpCd()); 
				log.debug("loginTokenCheck :  {}",muo); 
				
				//디바이스 토큰 삭제&등록 api호출
				PushTokenPO tokenPo = new PushTokenPO();
				tokenPo.setUserId(session.getMbrNo().toString());
				bizService.deleteDeviceToken(tokenPo);
				
				String deviceType = "";
				if(member.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
					deviceType = CommonConstants.PUSH_TYPE_ANDROID;
				}else if(member.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)){
					deviceType = CommonConstants.PUSH_TYPE_IOS;
				}
				tokenPo.setDeviceType(deviceType);
				tokenPo.setDeviceToken(member.getDeviceToken()); 
				tokenPo.setIsAdAgreement(true);
				tokenPo.setIsNightAdAgreement(true);
				tokenPo.setIsNotificationAgreement(true); 
				log.debug("deviceTokenAPi : {}",tokenPo); 
				
				bizService.insertDeviceToken(tokenPo);
			}
		}
		this.memberBaseDao.updateMemberBaseLastLoginDtm(muo);
		if(muo.getDeviceToken()!=null) memberBaseDao.insertMemberBaseHistory(muo);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: FrontLoginServiceImpl.java
	 * - 작성일		: 2021. 03. 10.
	 * - 작성자		: 이지희
	 * - 설명		:  비로그인 시 최근 본 상품 쿠키 값 db에 저장
	 * </pre>
	 * @param mbrNo
	 * @return
	 */	
	public void saveRecentGoodsOfMbrNo(Long mbrNo) {		
		// 7일이전 데이터 삭제
		GoodsDtlInqrHistSO gdihso = new GoodsDtlInqrHistSO();
		gdihso.setMbrNo(mbrNo);
		goodsDtlInqrHistService.deleteOldGoodsDtlInqrHist(gdihso);
		
		// 상품 쿠키값 DB 저장
	   List<GoodsBaseVO> listCookie = getRcntGoodsFromCookie();
	   if(listCookie != null) {
		   goodsDtlInqrHistService.setGoodsDtlInqrHist(mbrNo, listCookie);
	   }
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: FrontLoginServiceImpl.java
	 * - 작성일		: 2021. 03. 10.
	 * - 작성자		: valfac
	 * - 설명		:  최근 본 상품 쿠키 리스트 반환
	 * </pre>
	 * @return
	 */	
	@Override
	public List<GoodsBaseVO> getRcntGoodsFromCookie() {		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		try {
		   String recentGoods = CookieSessionUtil.getCookieValueDecURI(envGb+FrontConstants.COOKIE_RECENT_GOODS);
		   if(StringUtil.isNotBlank(recentGoods)){
			   com.fasterxml.jackson.databind.ObjectMapper jacksonMapper =  new com.fasterxml.jackson.databind.ObjectMapper();
			   return Arrays.asList(jacksonMapper.readValue(recentGoods, GoodsBaseVO[].class));
			}
		   	return null;
		} catch (Exception e) {	   
			return null;
		}
	}
}