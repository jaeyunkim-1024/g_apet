package biz.app.member.service;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.contents.dao.ReplyDao;
import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;
import biz.app.event.dao.FrontEventDao;
import biz.app.event.model.EventBaseVO;
import biz.app.event.service.EventService;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.login.model.SnsMemberInfoPO;
import biz.app.login.model.SnsMemberInfoSO;
import biz.app.login.model.SnsMemberInfoVO;
import biz.app.login.service.FrontLoginService;
import biz.app.member.dao.*;
import biz.app.member.model.*;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.pet.dao.PetDao;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.service.CouponService;
import biz.app.st.dao.StDao;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.dao.MenuDao;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.service.CodeService;
import biz.app.system.service.PrivacyCnctService;
import biz.app.tag.dao.TagDao;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.common.model.EmailSend;
import biz.common.model.EmailSendMap;
import biz.common.model.LmsSendPO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.NaverApiVO;
import framework.common.util.*;
import framework.common.util.security.PBKDF2PasswordEncoder;
import framework.front.constants.FrontConstants;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.DeserializationConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.member.service
 * - 파일명		: MemberServiceImpl.java
 * - 작성일		: 2017. 2. 1.
 * - 작성자		: snw
 * - 설명			: 회원 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class MemberServiceImpl implements MemberService {

	@Autowired private CacheService cacheService;

	@Autowired private MemberBaseDao memberBaseDao;

	@Autowired private MemberDao memberDao;

	@Autowired private MemberAddressService memberAddressService;

	@Autowired private MemberSavedMoneyDetailDao memberSavedMoneyDetailDao;

	@Autowired	private Properties bizConfig;

	@Autowired	private Properties webConfig;

	@Autowired	private BizService bizService;

	@Autowired	private MemberSavedMoneyService memberSavedMoneyService;

	@Autowired	private MemberCouponService memberCouponService;

	@Autowired	private PrivacyCnctService privacyCnctService;

	@Autowired	private FrontLoginService frontLoginService;

	@Autowired private StDao stDao;

	@Autowired private MenuDao menuDao;

	@Autowired private PetDao petDao;

	@Autowired private ReplyDao replyDao;

	@Autowired private TagDao tagDao;
	
	@Autowired private MemberSearchWordDao memberSearchWordDao;

	// PBKDF2
	@Autowired private PBKDF2PasswordEncoder passwordEncoder;
	
	@Autowired private PetraUtil PetraUtil;

 	@Autowired private PushService pushService;

	@Autowired private MemberCouponDao memberCouponDao;
	
	@Autowired private CouponService couponService;

	@Autowired private MemberLoginHistoryDao memberLoginHistoryDao;
	
	@Autowired private MemberLeaveService memberLeaveService;
	
	@Autowired private MemberBatchService memberBatchService;

	@Autowired private FrontEventDao frontEventDao;
	
	@Autowired private MemberDormantDao memberDormantDao;
	
	@Autowired private EventService eventService;
	
	@Autowired private CodeService codeService;

	@Autowired private MemberApiService memberApiService;
	
	/*
	 * 사이트별 회원 인증코드 중복 체크
	 * @see biz.app.member.service.MemberService#getMemberCertifyCdDuplicate(java.lang.Long, java.lang.String)
	 */
	@Override
	@Transactional(readOnly=true)
	@Deprecated
	public boolean getMemberCertifyCdDuplicate(Long stId, String ctfCd) {
		boolean result = true;

		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setStId(stId);
		mbso.setCtfCd(ctfCd);
		Integer memberCnt = this.memberBaseDao.getMemberBaseCnt(mbso);

		if(memberCnt.intValue() == 0){
			result = false;
		}

		return result;
	}

	/*
	 * 사이트별 회원 로그인 아이디 중복 체크
	 * @see biz.app.member.service.MemberService#getMemberLoginIdDuplicate(java.lang.Long, java.lang.String)
	 */
	@Override
	@Transactional(readOnly=true)
	public boolean getMemberLoginIdDuplicate(Long stId, String loginId) {
		boolean result = true;

		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setStId(stId);
		mbso.setLoginId(loginId);
		Integer loginIdCnt = this.memberBaseDao.getMemberBaseCnt(mbso);

		if(loginIdCnt.intValue() == 0){
			result = false;
		}

		return result;
	}


	/*
	 * 사이트별 회원 로그인 휴대폰번호/이메일/닉네임 중복 체크
	 * @see biz.app.member.service.MemberService#getMemberLoginIdDuplicate(java.lang.Long, java.lang.String)
	 */
	@Override
	@Transactional(readOnly=true)
	public boolean getMemberLoginDuplicate(MemberBaseSO mbso) {
		
		String memberStr = this.memberBaseDao.getMemberBaseCheckStr(mbso);
		
		if(StringUtil.isEmpty(memberStr) || StringUtil.equals(memberStr, "")) {
			return false;
		}else if(!StringUtil.isEmpty(mbso.getMbrNo())){
			String[] memberArr = memberStr.split(",");
			for(String m : memberArr) {
				if(StringUtil.equals(m, mbso.getMbrNo().toString())) return false;
			}
			return true;
		}else {
			return true;
		}
		
		
		/*boolean result = true;

		Integer loginIdCnt = this.memberBaseDao.getMemberBaseCnt(mbso);

		if(loginIdCnt.intValue() == 0){
			result = false;
		}

		return result;*/
	}



	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 신규 등록
	 * </pre>
	 * @param po MemberBasePO
	 * @param joinPathCd
	 * @return long mbrNo
	 */
	@Override
	public MemberBasePO insertMember(MemberBasePO po, MemberAddressPO apo, String joinPathCd) {

		log.debug("=====join member =====");
		/******************************
		 * 회원 기본정보 등록
		 ******************************/
		//회원 번호 생성
		Long mbrNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_BASE_SEQ);

		//미리 등록되어 있는 본인인증로그seq 넣을 변수 초기화
		//Long ctfLogNo = null;

		//이미지 등록
		/*if(!StringUtil.isEmpty(po.getPrflImg() ) && po.getJoinEnvCd() != null && !po.getJoinEnvCd().equals("APP")) {

			log.debug("filename1 : "+po.getPrflImg());
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			String filePath = ftpImgUtil.uploadFilePath(po.getPrflImg(), "/member/"+mbrNo);
			log.debug("filename : "+filePath);
			ftpImgUtil.upload(po.getPrflImg(), filePath);

			try {
				FileUtil.delete(po.getPrflImg()  );	// 복사된 이미지 삭제.. [temp]
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			po.setPrflImg(filePath);
		}
*/

		/* 핸드폰 중복체크 - 중복이면 먼저 있는 회원 상태 '중복'상태로 변경 */
		if(po.getMobile() != null && !po.getMobile().equals("")) {
			po.setMobile(bizService.twoWayEncrypt(po.getMobile()));
			checkMbrNoFromMobile(po.getMobile(),mbrNo);
		}
		//log.debug("mobile duplicated check : "+mobResult);

		/* 회원 정보 기본 설정*/
		po.setMbrNo(mbrNo);
		po.setSysRegrNo(mbrNo);
		po.setSysUpdrNo(mbrNo);
		po.setMbrStatCd(CommonConstants.MBR_STAT_10); //정상
		po.setMbrGrdCd(CommonConstants.MBR_GRD_40); //웰컴
		po.setMbrGbCd(CommonConstants.MBR_GB_CD_20); /// 첨에는 준회원으로

		//가입 환경 설정 -모바일웹,pc웹,안드앱,ios앱
		if(po.getJoinEnvCd() != null && po.getJoinEnvCd().equals("MO")) {
			po.setJoinEnvCd(CommonConstants.JOIN_ENV_WEB_MOB);
		}else if(po.getJoinEnvCd() != null && po.getJoinEnvCd().equals("PC")){
			po.setJoinEnvCd(CommonConstants.JOIN_ENV_WEB_PC);
		}else if(po.getJoinEnvCd() != null && po.getJoinEnvCd().equals("APP")){
			if(po.getDeviceTpCd() != null && po.getDeviceTpCd().equals("10")) {
				po.setJoinEnvCd(CommonConstants.JOIN_ENV_APP_ANDROID);
			}else if(po.getDeviceTpCd() != null && po.getDeviceTpCd().equals("20")) {
				po.setJoinEnvCd(CommonConstants.JOIN_ENV_APP_IOS);
			}
		}

		//인증정보 set
		/*if(SessionUtil.getAttribute(FrontConstants.SESSION_JOIN_MEMBER_CRTF) != null ) {
			JSONObject auth = (JSONObject)SessionUtil.getAttribute(FrontConstants.SESSION_JOIN_MEMBER_CRTF);

			String natinalCd  = auth.getString("RSLT_NTV_FRNR_CD");
			if(natinalCd.equals("L")) {
				natinalCd = "10";
			}else if(natinalCd.equals("F")) {
				natinalCd = "20";
			}
			po.setNtnGbCd(natinalCd);
			po.setCiCtfVal(auth.getString("CI"));
			po.setDiCtfVal(auth.getString("DI"));
			po.setMobileCd(auth.getString("TEL_COM_CD"));
			po.setCtfYn("Y");
			ctfLogNo = auth.getLong("LOG_NO");
		}
		SessionUtil.removeAttribute(FrontConstants.SESSION_JOIN_MEMBER_CRTF);*/

		SnsMemberInfoSO snsSo = null ;
		Object snsSession = SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);

		//CI코드 관련
		if(po.getCiCtfVal() == null || po.getCiCtfVal().equals("")) {
			//sns info세션에 CiCtfVal 있는지 확인
			if(snsSession !=null ) {
				snsSo = (SnsMemberInfoSO)snsSession;
				if(snsSo.getCiCtfVal() != null && !snsSo.getCiCtfVal().equals("")) {
					po.setCiCtfVal(snsSo.getCiCtfVal());
				}
			}
		}

		if(po.getCiCtfVal() != null && !po.getCiCtfVal().equals("")) {
			po.setCtfYn("Y"); 
		}

		po.setGdGbCd(po.getGdGbCd()!=null && po.getGdGbCd().equals("") ? null : po.getGdGbCd()); 
		po.setInfoRcvYn("Y"); 
		po.setJoinPathCd(joinPathCd);
		po.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		String nop = po.getPswd();
		po.setPswd(null);

		//암호화
		//if(po.getLoginId() != null && !po.getLoginId().equals("")) 	po.setLoginId(bizService.twoWayEncrypt(po.getLoginId()));
		if(po.getEmail() != null && !po.getEmail().equals("")) {
			po.setEmail(bizService.twoWayEncrypt(po.getEmail()));
		}
		if(po.getMbrNm() != null && !po.getMbrNm().equals("")) {
			po.setMbrNm(bizService.twoWayEncrypt(po.getMbrNm()));
		}
		if(po.getBirth() != null && !po.getBirth().equals("")) {
			po.setBirth(bizService.twoWayEncrypt(po.getBirth()));
		}
		if(po.getUpdrIp() != null && !po.getUpdrIp().equals("")) {
			po.setUpdrIp(bizService.twoWayEncrypt(po.getUpdrIp()));
		}

		//최초 가입 시에는 연동 안함
		po.setGsptStateCd(FrontConstants.GSPT_STATE_30);
		po.setGsptUseYn(FrontConstants.USE_YN_N);
		int result = this.memberBaseDao.insertMemberBase(po);

		if(result == 1){

			// 비밀번호 등록
			if(nop != null && !nop.equals("")) {
				updateMemberPassword(mbrNo, nop);
			}
			
			if(apo.getPostNoNew() != null && !"".equals(apo.getPostNoNew())) {

				//회원 주소록(배송지) 등록
				apo.setMbrNo(mbrNo);
				apo.setGbNm(bizConfig.getProperty("member.address.default.gb_nm"));
				apo.setAdrsNm(bizService.twoWayDecrypt(po.getMbrNm()));
				apo.setTel(po.getTel());
				apo.setMobile(bizService.twoWayDecrypt(po.getMobile()));
				apo.setDftYn("Y");
				apo.setSysRegrNo(mbrNo);
				apo.setSysUpdrNo(mbrNo);
				this.memberAddressService.insertMemberAddress(apo);
			}

			//sns 로그인인 경우 sns정보 등록
			if(po.getSnsYn() != null && po.getSnsYn().equals("Y") && snsSession != null ) {
				snsSo.setSnsStatCd(CommonConstants.SNS_STAT_10);
				snsSo.setSnsJoinYn("Y");
				snsSo.setMbrNo(mbrNo);
				snsSo.setSysRegrNo(mbrNo);

				/*if(snsSo.getSnsLnkCd().equals(FrontConstants.SNS_LNK_CD_40) && snsSo.getEmailApple() != null && !snsSo.getEmailApple().equals("")){
					snsSo.setEmail(snsSo.getEmailApple());
				}
*/
				log.debug("sns param : "+snsSo.getSysRegrNo());
				memberBaseDao.insertSnsMemberInfo(snsSo);

				//로그인 세션에 넣기 위해 추가
				po.setLoginPathCd(snsSo.getSnsLnkCd());
			}


			//본인인증 시 생긴 로그에 mbrNo 업데이트 하기
			/*if(ctfLogNo != null && ctfLogNo > 0) {
				MemberCertifiedLogPO certPo = new MemberCertifiedLogPO();
				certPo.setMbrNo(mbrNo);
				certPo.setSysRegrNo(mbrNo);
				certPo.setCtfLogNo(ctfLogNo);
				certPo.setCtfTpCd(FrontConstants.CTF_TP_JOIN);
				memberBaseDao.updateCertifiedLogMbrNo(certPo);
			}*/

			/* 사용자동의이력 등록*/
			Type typeList = new TypeToken<ArrayList<TermsRcvHistoryPO>>(){}.getType();
			List<TermsRcvHistoryPO> termsList = new Gson().fromJson(po.getTermsNo(), typeList);

			for(TermsRcvHistoryPO term : termsList) {
				Long termsHistNo = this.bizService.getSequence(CommonConstants.SEQUENCE_TERMS_RCV_HISTORY_SEQ);
				term.setTermsAgreeHistNo(termsHistNo);
				term.setMbrNo(po.getMbrNo());
				/*term.setEmail(po.getEmail());
				term.setName(po.getMbrNm());
				term.setEmail(po.getEmail());
				term.setMobile(po.getMobile());*/
				term.setSysRegrNo(mbrNo);
			}
			memberBaseDao.insertTermsRcvHistory(termsList);


			/* 회원등급이력 등록*/
			po.setMbrGrdCd(CommonConstants.MBR_GRD_40);
			int rslt = this.memberBaseDao.insertMemberGrade(po);
			if(rslt != 1){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			/* 회원가입 웰컴쿠폰,배송비쿠폰 발급*/
			CodeDetailVO codeVO = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_WELCOME);
			insertJoinCoupon(mbrNo, codeVO);
			CodeDetailVO delivCoupVO1 = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_WELCOMTR1);
			insertJoinCoupon(mbrNo, delivCoupVO1);
			CodeDetailVO delivCoupVO2 = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_WELCOMTR2);
			insertJoinCoupon(mbrNo, delivCoupVO2);
			CodeDetailVO delivCoupVO3 = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_WELCOMTR3);
			insertJoinCoupon(mbrNo, delivCoupVO3);
			
			/* 추천인 있는 경우 추천인 쿠폰 발급*/
			if(po.getRcomLoginId() != null && !po.getRcomLoginId().equals("")) {
				CodeDetailVO rcomCodeVo = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_LNK_REWARD);
				insertJoinCoupon(mbrNo, rcomCodeVo);
			}
			
			//신규 회원가입 이벤트 쿠폰 지급.20210805
			CodeDetailSO codeSo = new CodeDetailSO();
			codeSo.setGrpCd(CommonConstants.WELCOME_COUPON_EVENT);
			codeSo.setDtlCd(CommonConstants.WELCOME_COUPON_EVENT_10);
			CodeDetailVO codeEvtVO = codeService.getCodeDetail(codeSo);
			//CodeDetailVO codeEvtVO = this.cacheService.getCodeCache(CommonConstants.WELCOME_COUPON_EVENT, CommonConstants.WELCOME_COUPON_EVENT_10);		
			if(StringUtil.isNotEmpty(codeEvtVO) && codeEvtVO.getUseYn().equals("Y") && !codeEvtVO.getSysDelYn().equals("Y")) {
				insertWelcomeEventCoupon(codeEvtVO, mbrNo, "N");
			}
			//신규 회원가입 선착순 쿠폰지급 이벤트. 20210825			
			codeSo.setDtlCd(CommonConstants.WELCOME_COUPON_EVENT_20);
			CodeDetailVO codeLimitEvtVO = codeService.getCodeDetail(codeSo);
			if(StringUtil.isNotEmpty(codeLimitEvtVO) && codeLimitEvtVO.getUseYn().equals("Y") && !codeLimitEvtVO.getSysDelYn().equals("Y")) {
				insertWelcomeEventCoupon(codeLimitEvtVO, mbrNo, "Y");
			}
			//080수신처리
			/*MemberBasePO mkngpo = new MemberBasePO();
			mkngpo.setMbrNo(mbrNo);
			mkngpo.setMkngRcvYn(po.getMkngRcvYn());
			mkngpo.setMobile(bizService.twoWayDecrypt(po.getMobile()));
			updateMemberRcvYn(mkngpo);*/
			
			//마케팅 수신여부 찬성인 경우 쿠폰 발급
			if(po.getMkngRcvYn().equals("Y")) {
				CodeDetailVO mkngCode = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_MARKETING);
				insertJoinCoupon(mbrNo, mkngCode);
			}

			//이벤트 관련 진행 쿠폰 - 2021.05.14
			CodeDetailVO eventCode = cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON,CommonConstants.AUTO_ISU_COUPON_EVENT);
			if(StringUtil.equals(eventCode.getUseYn(),CommonConstants.USE_YN_Y)){
				try{
					//쿠폰 체크
					CouponSO cso = new CouponSO();
					Long cpNo = Long.parseLong(eventCode.getUsrDfn1Val().split(";")[0]);
					Integer repeatCnt = Integer.parseInt(eventCode.getUsrDfn1Val().split(";")[1]);
					cso.setCpNo(cpNo);
					CouponBaseVO coupon = couponService.getCouponBase(cso);

					Long cpAplStrtDtm = coupon.getAplStrtDtm().getTime();
					Long cpAplEndDtm = coupon.getAplEndDtm().getTime();
					Long nowTime = DateUtil.getTimestamp().getTime();

					//쿠폰 상태 및 쿠폰 다운로드 기간 체크
					if(		StringUtil.equals(coupon.getCpStatCd(),CommonConstants.CP_STAT_20) &&
							Long.compare(cpAplStrtDtm,nowTime) <= 0 && Long.compare(cpAplEndDtm,nowTime) >= 0
					){
						MemberCouponPO mpo = new MemberCouponPO();
						mpo.setCpNo(cpNo);
						mpo.setMbrNo(mbrNo);
						mpo.setIsuTpCd(CommonConstants.ISU_TP_10);
						memberCouponService.insertMemberCoupon(mpo,repeatCnt);
					}

				}catch(NumberFormatException nfe){
					log.error("#### Parse Error, Plz Checked usrDfn1Val Format required Number");
				}catch(NullPointerException npe){
					log.error("#### Parse Error, Plz Checked usrDfn1Val or Coupon  ,,,{}",npe.getMessage());
				}catch(ArrayIndexOutOfBoundsException ape){
					log.error("#### Parse Error, Plz Checked usrDfn1Val or Coupon ,,,{}",ape.getMessage());
				}catch(Exception e){
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
				}
			}
			return po;

		}else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}



		/*
		 * 가입 쿠폰 등록
		 */
		/* 데모 작업을 위해 로직 하드코딩
		Long cpNo = Long.valueOf(this.bizConfig.getProperty("member.coupon.Join.cpno"));

		MemberCouponPO mcpo = new MemberCouponPO();
		mcpo.setCpNo(cpNo);
		mcpo.setMbrNo(mbrNo);
		mcpo.setSysRegrNo(mbrNo);
		mcpo.setIsuTpCd(CommonConstants.ISU_TP_10);		// 발급유형  ISU_TP_10 : 시스템

		this.memberCouponService.insertMemberCoupon(mcpo);
		*/

		/*
		 * 가입 적립금 등록
		 */
		/* 데모 작업을 위해 로직 하드코딩
		MemberSavedMoneyPO mPo = new MemberSavedMoneyPO();
		mPo.setSvmnRsnCd(CommonConstants.SVMN_RSN_110);
		mPo.setMbrNo(mbrNo);
		mPo.setSaveAmt(Long.valueOf(this.bizConfig.getProperty("member.savedMoney.join.amt")));
		mPo.setVldDtm(DateUtil.addDay("yyyy-MM-dd ", Integer.valueOf(this.bizConfig.getProperty("member.savedMoney.join.period"))));
		mPo.setSysRegrNo(mbrNo);
		this.memberSavedMoneyService.insertMemberSavedMoney(mPo);
		*/
	}
	
	public void insertWelcomeEventCoupon(CodeDetailVO codeEvtVO, Long mbrNo, String limitYn) {
		try {
			//사용자정의1 : 쿠폰번호(1,2,3), 사용자정의2:이벤트시작일, 사용자정의3:이벤트종료일, 사용자정의4:이벤트번호 (not null: 이벤트기간 사용, null : 사용자정의2,3의 기간을 사용)
			//limitYn == Y 인 경우 사용자정의5 : 선착순 인원
			if(StringUtil.isNotEmpty(codeEvtVO.getUsrDfn1Val())) {
				Long evtSt = 0L;
				Long evtEd = 0L;
				Long nowDt = DateUtil.getTimestamp().getTime();					
				if(StringUtil.isNotEmpty(codeEvtVO.getUsrDfn4Val())) {
					Long eventNo = Long.valueOf(codeEvtVO.getUsrDfn4Val());
					EventBaseVO evtVo = eventService.getEventBase(eventNo);
					if(StringUtil.isNotEmpty(evtVo) && evtVo.getEventStatCd().equals(CommonConstants.EVENT_STAT_20)) {//이벤트상태코드 : 진행중							
						evtSt = evtVo.getAplStrtDtm().getTime();
						evtEd = evtVo.getAplEndDtm().getTime();						
					}					
				}else {//이벤트 번호가 없으면 사용자정의2,3의 기간 사용
					if(StringUtil.isNotEmpty(codeEvtVO.getUsrDfn2Val()) && StringUtil.isNotEmpty(codeEvtVO.getUsrDfn3Val())) {
						SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");							
						evtSt = format.parse(codeEvtVO.getUsrDfn2Val()).getTime();
						evtEd = format.parse(codeEvtVO.getUsrDfn3Val()).getTime();
					}												
				}					
				//현재가 이벤트 기간인지 확인
				if(evtSt != 0L && evtEd != 0L && Long.compare(evtSt, nowDt) <=0 && Long.compare(evtEd, nowDt) >= 0) {
					//오늘이 이벤트 기간에 포함된다면 쿠폰 발급					
					String[] cpNos = codeEvtVO.getUsrDfn1Val().replace(" ", "").split(",");
					for(int i = 0; i < cpNos.length; i++) {
						MemberCouponPO mpo = new MemberCouponPO();
						mpo.setCpNo(Long.parseLong(cpNos[i]));
						mpo.setMbrNo(mbrNo);
						mpo.setSysRegrNo(mbrNo);
						mpo.setIsuTpCd(CommonConstants.ISU_TP_10);
						if(limitYn.equals("Y")) {
							//선착순 이벤트의 경우 금일 선착순 쿠폰지급 현황 파악
							if(StringUtil.isNotEmpty(codeEvtVO.getUsrDfn5Val()) && codeEvtVO.getUsrDfn5Val().matches("[0-9]+")) {
								MemberCouponSO mso = new MemberCouponSO();
								mso.setCpNo(Long.parseLong(cpNos[i]));
								int cpnCnt = memberCouponDao.getWelcomeLimitCouponCount(mso);
								if(cpnCnt < Integer.parseInt(codeEvtVO.getUsrDfn5Val())) {
									memberCouponDao.insertWelcomeEventCoupon(mpo);								
								}
							}							
						}else {
							memberCouponDao.insertWelcomeEventCoupon(mpo);							
						}
					}					
				}
			}
			
		} catch (Exception e) {
			log.error("WELCOME_EVENT_COUPON EXCEPTION!!",e.getClass());
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 비밀번호 수정
	 * </pre>
	 * @param mbrNo
	 * @param newPswd
	 */
	@Override
	public void updateMemberPassword(Long mbrNo, String newPswd) {
		MemberBasePO po = new MemberBasePO();
		po.setMbrNo(mbrNo);
		po.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));

		try {
			// 암호화 방식 변경(DCG 동기화 처리)
			// po.setPswd(CryptoUtil.encryptSHA512(newPswd));
			//po.setPswd(CryptoUtil.encryptSHA256(CryptoUtil.encryptMD5(newPswd)));
			newPswd = newPswd.toLowerCase();
			po.setPswd(passwordEncoder.encode(newPswd));
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		po.setPswdInitYn(CommonConstants.COMM_YN_N);

		int result = this.memberBaseDao.updateMemberBasePassword(po);

		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 비밀번호 변경 이력
		po.setSysRegrNo(mbrNo);
		this.memberBaseDao.insertMemberPswdHist(po);
	}

	/*
	 * 회원 비밀번호 초기화
	 * @see biz.app.member.service.MemberService#updateMemberPasswordInit(java.lang.Long)
	 */
	@Override
	@Deprecated
	public void updateMemberPasswordInit(Long mbrNo, String sendMensCd) {

		/*
		 * 신규 비밀번호 생성
		 */
		String newPassword = String.valueOf(mbrNo.intValue()) + StringUtil.randomNumeric(8);

		/*
		 * 비밀번호 수정
		 */
		MemberBasePO po = new MemberBasePO();
		po.setMbrNo(mbrNo);

		try {
			// po.setPswd(CryptoUtil.encryptSHA512(newPassword));
			// po.setPswd(CryptoUtil.encryptSHA256(CryptoUtil.encryptMD5(newPassword)));
			po.setPswd(passwordEncoder.encode(newPassword));
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		po.setPswdInitYn(CommonConstants.COMM_YN_N);

		int result = this.memberBaseDao.updateMemberBasePassword(po);

		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else{

			// 이력등록 insertMemberBaseHistory
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(mbrNo);
			MemberBaseVO memberBase = this.memberBaseDao.getMemberBase(mbso);

			// 사이트 정보
			//StStdInfoVO stInfo =  this.stDao.getStStdInfo(po.getStId());
			StStdInfoVO stInfo =  this.stDao.getStStdInfo(memberBase.getStId());

			/*
			 * 비밀번호 찾기 EMAL 발송
			 */
			if(CommonConstants.SEND_PSWD_MEANS_CD_EMAIL.equals(sendMensCd)){
				EmailSend email = new EmailSend();
				email.setEmailTpCd(CommonConstants.EMAIL_TP_120);
				email.setReceiverEmail(memberBase.getEmail());
				email.setReceiverNm(memberBase.getMbrNm());
				email.setStId(memberBase.getStId());
				email.setMbrNo(memberBase.getMbrNo());
				email.setMap01(newPassword);
				email.setMap02(DateUtil.calDate("yyyy년 MM월 dd일 HH:mm"));
				email.setMap03(stInfo.getStNm());

				this.bizService.sendEmail(email, null);

			}else if(CommonConstants.SEND_PSWD_MEANS_CD_SMS.equals(sendMensCd)){
				/*
				 * 비밀번호 찾기 LMS 발송
				 */
				LmsSendPO lspo = new LmsSendPO();
				lspo.setSendPhone(stInfo.getCsTelNo());
				lspo.setReceiveName(memberBase.getMbrNm());
				lspo.setReceivePhone(memberBase.getMobile());

				CodeDetailVO smsTpVO = cacheService.getCodeCache(CommonConstants.SMS_TP, CommonConstants.SMS_TP_120);

				// LMS 제목 및 내용 설정
				String subject = smsTpVO.getUsrDfn2Val();
				String msg = smsTpVO.getUsrDfn3Val();

				subject = subject.replace(CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());

				msg = msg.replace(CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());
				msg = msg.replace(CommonConstants.SMS_MSG_ARG_TEMP_PSWD, newPassword);

				lspo.setSubject(subject);
				lspo.setMsg(msg);

				this.bizService.sendLms(lspo);

			}else{
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}

	/*
	 * 회원 기본 정보 수정
	 * @see biz.app.member.service.MemberService#updateMemberBase(biz.app.member.model.MemberBasePO)
	 */
	@Override
	public void updateMemberBase(MemberBasePO po) {
		Long mbrNo = po.getMbrNo();
		String newPswd = Optional.ofNullable(po.getNewPswd()).orElseGet(()->"");

		//회원 정보 정제
		if(StringUtil.isNotEmpty(Optional.ofNullable(po.getTel()).orElseGet(()->""))){
			po.setTel(po.getTel().replaceAll("-", ""));
		}
		if(StringUtil.isNotEmpty(Optional.ofNullable(po.getMobile()).orElseGet(()->""))){
			po.setMobile(po.getMobile().replaceAll("-", ""));
		}

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));

		//회원 정보 변경 이력
		if(memberBaseDao.updateMemberBase(po) == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		insertMemberBaseHistory(mbrNo);

		//비밀번호 변경
		if(StringUtil.isNotEmpty(newPswd)){
			updateMemberPassword(mbrNo,newPswd);
		}
	}

	@Override
	public void updateMemberStatCd(MemberBasePO po) {
		// 정상 -> 블랙 , 블랙 -> 정상 처리 로직 추가.2021-08-23
		if(!po.getDormantRlsYn().equals("Y")) {
			if(memberBaseDao.updateMemberBase(po) == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}else {
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(po.getMbrNo());
			MemberBasePO mbp = memberDormantDao.selectDormantMemberBase(so);
			
			if(StringUtil.isNotEmpty(mbp)) {
				// 회원정보 셋
				po.setStId(mbp.getStId());
				po.setPolicyNo(mbp.getPolicyNo());
				po.setMbrNm(mbp.getMbrNm());
				po.setPetLogUrl(mbp.getPetLogUrl());
				po.setRcomUrl(mbp.getRcomUrl());
				po.setMbrGbCd(mbp.getMbrGbCd());
				po.setMbrStatCd("10");
				po.setMbrGrdCd("40");
				po.setBirth(mbp.getBirth());
				po.setGdGbCd(mbp.getGdGbCd());
				po.setNtnGbCd(mbp.getNtnGbCd());
				po.setJoinDtm(mbp.getJoinDtm());
				po.setModDtm(mbp.getModDtm());
				po.setJoinPathCd(mbp.getJoinPathCd());
				po.setJoinEnvCd(mbp.getJoinEnvCd());
				po.setCtfYn(mbp.getCtfYn());
				po.setCiCtfVal(mbp.getCiCtfVal());
				po.setDiCtfVal(mbp.getDiCtfVal());
				po.setGsptNo(mbp.getGsptNo());
				po.setGsptUseYn(mbp.getGsptUseYn());
				po.setGsptStateCd(mbp.getGsptStateCd());
				po.setGsptStartDtm(mbp.getGsptStartDtm());
				po.setGsptStopDtm(mbp.getGsptStopDtm());
				po.setPetSchlYn(mbp.getPetSchlYn());
				po.setMktRcvYn(mbp.getMktRcvYn());
				po.setInfoRcvYn(mbp.getInfoRcvYn());
				po.setDeviceToken(mbp.getDeviceToken());
				po.setDeviceTpCd(mbp.getDeviceTpCd());
				po.setDffcMbrYn(mbp.getDffcMbrYn());
				po.setTel(mbp.getTel());
				po.setMobile(mbp.getMobile());
				po.setMobileCd(mbp.getMobileCd());
				po.setEmail(mbp.getEmail());
				po.setDormantAplDtm(mbp.getDormantAplDtm());
				po.setPetLogItrdc(mbp.getPetLogItrdc());
				po.setPrflImg(mbp.getPrflImg());
				po.setDlgtPetGbCd(mbp.getDlgtPetGbCd());
				po.setPetLogSrtUrl(mbp.getPetLogSrtUrl());
				po.setAlmRcvYn(mbp.getAlmRcvYn());
				po.setPstInfoAgrYn(mbp.getPstInfoAgrYn());
				po.setSysRegrNo(mbp.getSysRegrNo());
				po.setSysRegDtm(mbp.getSysRegDtm());
			
				if(memberBaseDao.updateMemberBase(po) == 0){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}else {
					MemberBizInfoPO mbipo = memberDormantDao.selectDormantMemberBizInfo(so);
					if(StringUtil.isNotEmpty(mbipo)) {
						memberBaseDao.updateMemberBizInfo(mbipo);
					}
					memberDormantDao.deleteDormantMemberBase(so);
					memberDormantDao.deleteDormantMemberBizInfo(so);
				}
			}
		}
		
		insertMemberBaseHistory(po.getMbrNo());
	}

	@Override
	public String updateMemberRcvYn(MemberBasePO po) {
		String mkngRcvYn = Optional.ofNullable(po.getMkngRcvYn()).orElseGet(()->"");
		Long mbrNo = po.getMbrNo();
		String mobile = Optional.ofNullable(po.getMobile()).orElseGet(()->"");
		po.setMobile(mobile);

		//마케팅 수신 여부 변경 일시 , 프로시저로 처리( 단건이면 상관 없으나, 배치처리 및 080 호출로 인해 서비스 따로 분리)
		if(StringUtil.isNotEmpty(mkngRcvYn)){
			MemberUnsubscribeVO result = updateMemberMarketingAgree(po);
			if(memberBaseDao.updateMemberRcvYn(po) == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			sendMarketingYnSms(mbrNo,mobile,mkngRcvYn);
		}
		//그 외의 여부 변경 시, WAS에서 단건 처리
		else{
			if(memberBaseDao.updateMemberRcvYn(po) == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		insertMemberBaseHistory(po.getMbrNo());
		return DateUtil.getTimestampToString(po.getSysUpdDtm(),CommonConstants.COMMON_DATE_FORMAT);
	}

	@Override
	public void sendMarketingYnSms(Long mbrNo, String mobile , String mkngRcvYn) {
		mobile = mobile.replaceAll("-","");
		String dtlCd = StringUtil.equals(mkngRcvYn,CommonConstants.COMM_YN_Y) ? CommonConstants.TMPL_MARKETING_Y : CommonConstants.TMPL_MARKETING_N;
		CodeDetailVO tmplCode = cacheService.getCodeCache(CommonConstants.TMPL_NO,dtlCd);
		Long tmplNo = Long.parseLong(tmplCode.getUsrDfn1Val());
		String sendType = tmplCode.getUsrDfn2Val();

		SsgMessageSendPO msg = new SsgMessageSendPO();
		msg.setFuserid(String.valueOf(mbrNo));
		PushSO pso = new PushSO();
		pso.setTmplNo(tmplNo);
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
		String tmplContents = pvo.getContents(); //템플릿 내용

		String yyyy = DateUtil.calDate("yyyy");
		String mm = DateUtil.calDate("MM");
		String dd = DateUtil.calDate("dd");

		tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_330,yyyy);
		tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_340,mm);
		tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_350,dd);

		msg.setFsubject(pvo.getSubject()); // 템플릿 제목 set
		msg.setFmessage(tmplContents);// 템플릿 내용 replace(데이터 바인딩)
		msg.setFdestine(mobile);
		msg.setSndTypeCd(sendType); // MMS/LMS/SMS
		msg.setMbrNo(mbrNo);
		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시

		bizService.sendMessage(msg);
	}

	/*
	 * 회원 적립금 율 조회
	 * @see biz.app.member.service.MemberService#getMemberSaveMoneyRate(java.lang.Long)
	 */
	@Override
	public Double getMemberSaveMoneyRate(Long mbrNo) {
		return this.memberBaseDao.getMemberSaveMoneyRate(mbrNo);
	}

	/*
	 * 회원 비밀번호 동일여부 체크
	 * @see biz.app.member.service.MemberService#checkMemberPassword(java.lang.Long, java.lang.String)
	 */
	@Override
	public boolean checkMemberPassword(Long mbrNo, String pswd) {
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(mbrNo);
		so.setPswd("pswd"); 
		so.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		MemberBaseVO member = Optional.ofNullable(memberBaseDao.getMemberBase(so)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER));
		return passwordEncoder.check(member.getPswd(),pswd.toLowerCase());
	}


	@Override
	public List<MemberBaseVO> pageMemberBase(MemberBaseSO so) {
		// 전화 번호 형식
		if(StringUtil.isNotBlank(so.getTel())){
			so.setTel(so.getTel().replaceAll("-", ""));
		}

		String birth = Optional.ofNullable(so.getBirth()).orElseGet(()->"");
		String mobile = Optional.ofNullable(so.getMobile()).orElseGet(()->"").replaceAll("-","");
		so.setBirth(birth);
		so.setMobile(mobile);

		List<MemberBaseVO> list = Optional.ofNullable(memberDao.pageMemberBase(so)).orElseGet(()->new ArrayList<>());
		List<MemberBaseVO> result = new ArrayList<MemberBaseVO>();
		list.forEach(vo->{
			if (StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_N)) {
				vo = maskingMemberInfo(vo);
			}
		});
		return list;
	}

	@Override
	public List<MemberBaseVO> listMemberGrid(MemberBaseSO so) {
		//핸드포 번호
		so.setMobile(Optional.ofNullable(so.getMobile()).orElseGet(()->"").replaceAll("-","").trim());

		//생일 일자
		so.setBirthStrtDtm(Optional.ofNullable(so.getBirthStrtDtm()).orElseGet(()->"").replaceAll("-",""));
		so.setBirthEndDtm(Optional.ofNullable(so.getBirthEndDtm()).orElseGet(()->"").replaceAll("-",""));

		//펫 로그 등록 태그 이름
		so.setPetLogTagNm(Optional.ofNullable(so.getPetLogTagNm()).orElseGet(()->"").trim());

		//관심 태그
	/*	String[] tagNos = Optional.ofNullable(so.getTagNos()).orElseGet(()->new String[]{});
		if(tagNos.length == 1 && StringUtil.equals(tagNos[0],"0")){
			so.setTagNos(null);
		}*/
		so.setSidx("MB.MBR_NO");
		so.setSord("DESC");
		Integer doramantAplDay = Optional.ofNullable(so.getDormantAplDay()).orElseGet(()->0);
		if(Integer.compare(doramantAplDay,0) != 0) {
			CodeDetailVO codeVO = cacheService.getCodeCache(CommonConstants.DORMANT_PERIOD, so.getDormantAplDay().toString());
			so.setDormantAplDay(Integer.parseInt(codeVO.getDtlNm()));
		}
		List<MemberBaseVO> list = new ArrayList<>();
		
		if(so.getIsExcelDown().equals("Y")){
			list = Optional.ofNullable(memberDao.listMemberExcelDown(so)).orElseGet(()->new ArrayList<>());
		}else{
			list = Optional.ofNullable(memberDao.listMemberGrid(so)).orElseGet(()->new ArrayList<>());
		}
		
		list.forEach(v->{
			v = maskingMemberInfo(v);
		});
		return list;
	}

	@Override
	public MemberBaseVO getMemberBaseInShort(MemberBaseSO so) {
		MemberBaseVO member = Optional.ofNullable(memberDao.getMemberBaseInShort(so)).orElseGet(()->new MemberBaseVO());

		if(Long.compare(0L,Optional.ofNullable(member.getMbrNo()).orElseGet(()->0L)) != 0){
			//복호화
			String prclAddr = Optional.ofNullable(member.getPrclAddr()).orElseGet(()->"");
			String roadAddr = Optional.ofNullable(member.getRoadAddr()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(roadAddr)){
				member.setMbrDftDlvrRoadAddress(member.getRoadAddr() + " " + member.getRoadDtlAddr());
			}
			if(StringUtil.isNotEmpty(prclAddr)){
				member.setMbrDftDlvrPrclAddress(member.getPrclAddr() + " " + member.getPrclDtlAddr());
			}

			/* 데이터 정제 */
			member = setDataFormat(member);

			if(StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_N)
					&& Long.compare(Optional.ofNullable(member.getMbrNo()).orElseGet(()->0L),0L) != 0
			){
				member = maskingMemberInfo(member);
			}else if(StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_Y)){
				String addr = StringUtil.isNotEmpty(roadAddr) ? roadAddr : prclAddr;
				if(StringUtil.isNotEmpty(addr)){
					member.setMaskingAddr(addr);
				}
			}
			member.setMaskingUnlock(so.getMaskingUnlock());

			member.setPetSimpleInfo(getMemberPetSimpleStrInfo(member.getMbrNo()));
			member.setTags(getMemberTagStrInfo(member.getMbrNo()));
		}else{
			member.setMbrNo(0L);
		}
		return member;
	}

	@Override
	@Transactional(readOnly = true)
	public MemberBaseVO getMemberBase(MemberBaseSO so) {
		return Optional.ofNullable(memberBaseDao.getMemberBase(so)).orElseGet(()->new MemberBaseVO());
	}

	@Override
	public MemberBaseVO getMemberBaseBO(MemberBaseSO so) {
		MemberBaseVO member = Optional.ofNullable(memberDao.getMemberBaseBO(so)).orElseGet(()->new MemberBaseVO());

		if(Long.compare(0L,Optional.ofNullable(member.getMbrNo()).orElseGet(()->0L)) != 0){
			String roadAddr = Optional.ofNullable(member.getRoadAddr()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(roadAddr)){
				member.setMbrDftDlvrRoadAddress(member.getRoadAddr() + " " + member.getRoadDtlAddr());
			}
			String prclAddr = Optional.ofNullable(member.getPrclAddr()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(prclAddr)){
				member.setMbrDftDlvrPrclAddress(member.getPrclAddr() + " " + member.getPrclDtlAddr());
			}

			/* 데이터 정제 */
			member = setDataFormat(member);

			if(StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_N)
					&& Long.compare(Optional.ofNullable(member.getMbrNo()).orElseGet(()->0L),0L) != 0
			){
				member = maskingMemberInfo(member);
			}else if(StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_Y)){
				String addr = StringUtil.isNotEmpty(roadAddr) ? roadAddr : prclAddr;
				if(StringUtil.isNotEmpty(addr)){
					member.setMaskingAddr(addr);
				}
			}
			member.setMaskingUnlock(so.getMaskingUnlock());
		}

		so.setMkngRcvYn(member.getMkngRcvYn());
		so.setInfoRcvYn(member.getInfoRcvYn());

		MemberBaseVO h1 = Optional.ofNullable(memberDao.getMkngRcvYnHistDtm(so)).orElseGet(()->new MemberBaseVO());
		MemberBaseVO h2 = Optional.ofNullable(memberDao.getInfoRcvYnHistDtm(so)).orElseGet(()->new MemberBaseVO());

		member.setMkngRcvYnHistDtm(Optional.ofNullable(h1.getMkngRcvYnHistDtm()).orElseGet(()->null));
		member.setInfoRcvYnHistDtm(Optional.ofNullable(h2.getInfoRcvYnHistDtm()).orElseGet(()->null));

		member.setPetSimpleInfo(getMemberPetSimpleStrInfo(so.getMbrNo()));
		member.setTags(getMemberTagStrInfo(so.getMbrNo()));

		return member;
	}

	@Override
	public  String getMemberPetSimpleStrInfo(Long mbrNo){
		//반려동물
		PetBaseSO pso = new PetBaseSO();
		pso.setMbrNo(mbrNo);
		List<PetBaseVO> petList = Optional.ofNullable(petDao.listPetBaseGroupByMbrNo(pso)).orElseGet(()->new ArrayList<PetBaseVO>());
		StringBuilder memberPet = new StringBuilder();
		int size = petList.size();
		for(int i=0; i<size; i+=1){
			PetBaseVO item = petList.get(i);
			memberPet.append(cacheService.getCodeName(AdminConstants.PET_GB,item.getPetGbCd()));
			memberPet.append("("+item.getCnt()+")");
			if(i != size - 1){
				memberPet.append(",");
			}
		}

		return memberPet.toString();
	}

	@Override
	public String getMemberTagStrInfo(Long mbrNo){
		//관심 태그
		StringBuilder tags = new StringBuilder();
		TagBaseSO tso = new TagBaseSO();
		tso.setMbrNo(mbrNo);
		List<TagBaseVO> tagList = Optional.ofNullable(tagDao.listTagBase(tso)).orElseGet(()->new ArrayList<TagBaseVO>());
		int size = tagList.size();
		for(int i=0; i<size; i+=1){
			TagBaseVO v = tagList.get(i);
			tags.append(v.getTagNm());
			if(i != size -1){
				tags.append(",");
			}
		}
		return tags.toString();
	}

	private MemberBaseVO setDataFormat(MemberBaseVO member){
		/* 데이터 정제 */
		String mobile = Optional.ofNullable(member.getMobile()).orElseGet(()->"")
				.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");

		member.setMobile(mobile);
		return member;
	}

	@Override
	public MemberBaseVO maskingMemberInfo(MemberBaseVO vo){
		//마스킹 처리
		vo.setMbrNm(MaskingUtil.getName(vo.getMbrNm()));
		vo.setEmail(MaskingUtil.getEmail(vo.getEmail()));
		vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
		vo.setLoginId(MaskingUtil.getId(vo.getLoginId()));
		if(StringUtil.isNotEmpty(Optional.ofNullable(vo.getBirth()).orElseGet(()->""))){
			if(StringUtil.equals(vo.getBirth(),"00000000")){
				vo.setBirth(null);
			}else{
				vo.setBirth(MaskingUtil.getBirth(vo.getBirth()));
			}
		}

		String prclAddr = Optional.ofNullable(vo.getMbrDftDlvrPrclAddress()).orElseGet(()->"");
		if(StringUtil.isNotEmpty(prclAddr)){
			vo.setMbrDftDlvrPrclAddress(prclAddr);
		}

		String roadAddr = Optional.ofNullable(vo.getMbrDftDlvrRoadAddress()).orElseGet(()->"");
		if(StringUtil.isNotEmpty(roadAddr)){
			vo.setMbrDftDlvrRoadAddress(roadAddr);
		}

		String addr = StringUtil.isNotEmpty(roadAddr) ? roadAddr : prclAddr;
		if(StringUtil.isNotEmpty(addr)){
			vo.setMaskingAddr(MaskingUtil.getAddress(addr,null));
		}

		return vo;
	}

	@Override
	public List<MemberAddressVO> listMemberAddress(MemberAddressSO so) {
		List<MemberAddressVO> list = memberDao.listMemberAddress(so);
		String maskingUnlock = so.getMaskingUnlock();
		if(list != null && !list.isEmpty()) {
			for(MemberAddressVO vo : list){
				vo.setPrclDtlAddr(bizService.twoWayDecrypt(vo.getPrclDtlAddr()));
				vo.setRoadDtlAddr(bizService.twoWayDecrypt(vo.getRoadDtlAddr()));
				vo.setEmail(bizService.twoWayDecrypt(vo.getEmail()));
				vo.setMobile(bizService.twoWayDecrypt(vo.getMobile()));
				vo.setAdrsNm(bizService.twoWayDecrypt(vo.getAdrsNm()));

				String mobile = StringUtil.phoneNumber(vo.getMobile().replaceAll("-",""));
				String prclAddr = vo.getPrclAddr() + " " + vo.getPrclDtlAddr();
				String roadAddr = vo.getRoadAddr() + " " + vo.getRoadDtlAddr();

				if(StringUtil.equals(maskingUnlock,CommonConstants.COMM_YN_N)){
					if(StringUtil.isNotEmpty(vo.getPostNoOld()) && vo.getPostNoOld().length() == 6){
						vo.setPostNoOld(vo.getPostNoOld().substring(0, 3) + "-" + vo.getPostNoOld().substring(3, 6));
					}

					vo.setMobile(MaskingUtil.getTelNo(mobile));

					String adrsNm = Optional.ofNullable(vo.getAdrsNm()).orElseGet(()->"");
					if(!StringUtil.isEmpty(adrsNm)){
						adrsNm = MaskingUtil.getName(adrsNm);
						if(adrsNm.indexOf(MaskingUtil.MASK_CHAR)==-1){
							adrsNm = adrsNm.substring(0,1) + MaskingUtil.MASK_CHAR + adrsNm.substring(2,adrsNm.length());
						}
						vo.setAdrsNm(adrsNm);
					}

					prclAddr = MaskingUtil.getAddress(vo.getPrclAddr(),vo.getPrclDtlAddr());
					roadAddr = MaskingUtil.getAddress(vo.getRoadAddr(),vo.getRoadDtlAddr());
					vo.setDtlPostNo(vo.getPostNoOld());
				}

				StringBuilder dtlAddr = new StringBuilder();
				dtlAddr.append("[지번])").append(prclAddr);
				dtlAddr.append("<br/>");
				dtlAddr.append("[도로명])").append(roadAddr);
				vo.setDtlAddr(dtlAddr.toString());
			}
		}
		return list;
	}

	@Override
	public MemberAddressVO getMemberAddress(MemberAddressSO so) {
		MemberAddressVO vo = memberDao.getMemberAddress(so);

		if(vo != null) {
			vo.setTel(StringUtil.phoneNumber(vo.getTel()));
			vo.setMobile(StringUtil.phoneNumber(vo.getMobile()));

			if(StringUtil.isNotEmpty(vo.getPostNoOld()) && vo.getPostNoOld().length() == 6){
				vo.setPostNoOld(vo.getPostNoOld().substring(0, 3) + "-" + vo.getPostNoOld().substring(3, 6));
			}
		}

		return vo;
	}


	@Override
	public void updateMemberHumanCancellation(MemberBasePO po) {
		if(po.getArrMbrNo() != null && po.getArrMbrNo().length > 0) {
			for(Long mbrNo : po.getArrMbrNo()){
				po.setMbrNo(mbrNo);
				int result = memberDao.updateMemberHumanCancellation(po);

				//이력 등록
				try {
					insertMemberBaseHistory(mbrNo);
				} catch (Exception e) {
					log.error("11.business.MemberServiceImpl.updateMemberHumanCancellation : {} ", mbrNo);
				}

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void updateMemberMbrGrdCd(MemberBasePO po) {
		if(po.getArrMbrNo() != null && po.getArrMbrNo().length > 0) {
			for(Long mbrNo : po.getArrMbrNo()){
				po.setMbrNo(mbrNo);
				int result = memberDao.updateMemberMbrGrdCd(po);

				//이력 등록
				try {
					insertMemberBaseHistory(mbrNo);
				} catch (Exception e) {
					log.error("11.business.MemberServiceImpl.updateMemberMbrGrdCd : {} ", mbrNo);
				}

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}


			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void saveMemberAddress(MemberAddressPO po) {
		// 휴대폰
		if(StringUtil.isNotBlank(po.getMobile())){
			po.setMobile(po.getMobile().replace("-", ""));
		}

		// 전화번호
		if(StringUtil.isNotBlank(po.getTel())){
			po.setTel(po.getTel().replace("-", ""));
		}

		// 구 우편번호
		if(StringUtil.isNotBlank(po.getPostNoOld())){
			po.setPostNoOld(po.getPostNoOld().replace("-", ""));
		}

		// 주소 상세
		po.setPrclDtlAddr(po.getRoadDtlAddr());

		MemberAddressSO so = new MemberAddressSO();
		so.setMbrNo(po.getMbrNo());
		so.setMbrDlvraNo(po.getMbrDlvraNo());
		MemberAddressVO vo = getMemberAddress(so);

		int result = 0;

		if(vo != null) {
			result = memberDao.updateMemberAddress(po);
		} else {
			result = memberDao.insertMemberAddress(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public String checkMemberLeave(Long mbrNo) {

		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(mbrNo);
		
		// 배송 중인 주문건 조회
		String rstYn = memberDao.checkInDelivery(so);
		if (CommonConstants.COMM_YN_Y.equals(rstYn)) {
			return "배송중인 상품이 있습니다. 배송완료 후 탈퇴 가능합니다.";
		}
		
		// 회수 중인 주문건 조회
		rstYn = memberDao.checkInReturn(so);
		if (CommonConstants.COMM_YN_Y.equals(rstYn)) {
			return "회수중인 상품이 있습니다. 회수완료 후 탈퇴 가능합니다.";
		}
		
		// 환불대기 중인 주문건 조회 -> 위의 회수중에 포함되어있기 때문에 의미없음.
		/*rstYn = memberDao.checkInRefund(so);
		if (CommonConstants.COMM_YN_Y.equals(rstYn)) {
			return "환불 대기중인 상품이 있습니다. 환불 대기완료 후 탈퇴 가능합니다.";
		}*/
		
		// 교환진행 중인 주문건 조회
		rstYn = memberDao.checkInExchange(so);
		if (CommonConstants.COMM_YN_Y.equals(rstYn)) {
			return "교환중인 상품이 있습니다. 교환완료 후 탈퇴 가능합니다.";
		}
		
		return "";
	}

	@Override
	public void deleteMember(MemberBasePO po) {
		//회원 탈퇴 EMAIL 발송
	/*	MemberBaseSO mbso = new MemberBaseSO();
		mbso.setMbrNo(po.getMbrNo());
		mbso.setStId(po.getStId());
		MemberBaseVO member = this.memberBaseDao.getMemberBase(mbso);

		EmailSend email = new EmailSend();
		email.setEmailTpCd(CommonConstants.EMAIL_TP_140);
		email.setReceiverEmail(member.getEmail());
		email.setReceiverNm(member.getMbrNm());
		email.setStId(member.getStId());
		email.setMbrNo(member.getMbrNo());
		bizService.sendEmail(email, null);*/

		//회원 탈퇴 SMS 발송
		/*StStdInfoVO stInfo =  this.stDao.getStStdInfo(po.getStId());
		SmsSendPO sspo = new SmsSendPO();
		sspo.setReceiveName(member.getMbrNm());
		sspo.setReceivePhone(member.getMobile());

		CodeDetailVO smsTpVO = cacheService.getCodeCache(CommonConstants.SMS_TP, CommonConstants.SMS_TP_140);
		String msg = smsTpVO.getUsrDfn2Val();
		msg = msg.replace(CommonConstants.SMS_MSG_ARG_MALL_NAME, stInfo.getStNm());
		sspo.setMsg(msg);
		sspo.setSysRegrNo(member.getMbrNo());
		sspo.setSendPhone(stInfo.getCsTelNo());
		bizService.sendSms(sspo);*/

		// ==== 탈퇴하는 회원이 네이버회원 연동이 되어 있는 경우 =======================================
		// todo lsm 회원연동 매핑 삭제를 위한 데이터 추출 후  네이버 API 호출 및  member_prtn_intlk 삭제
		NaverApiVO naVo = new NaverApiVO();
		naVo.setMbrNo(po.getMbrNo());
		naVo.setAffiliateMemberIdNo(String.valueOf(po.getMbrNo()));
		naVo.setSnsLnkCd("10");
		HashMap<String, Object> resultMap = memberBaseDao.checkInterlock(naVo);

		try{
			naVo.setInterlockMemberIdNo((String) resultMap.get("intlkId"));
			naVo.setAffiliateMemberIdNo(String.valueOf((Integer) resultMap.get("mbrNo")));
			naVo.setIntlkNo(Long.valueOf ((Integer)resultMap.get("intlkNo")));
			naVo.setSnsUuid((String) resultMap.get("snsUuid"));
		}catch (NullPointerException ne1){
			log.error("==> [ERROR]   : {}", ne1.getMessage());
		}

		// ==============================================================================

		// 회원기본의 회원번호, 상태(탈퇴) 로그인 아이디, 인증요청번호, 인증코드, 인증방법코드 만 남기고 다른정보는 전부 삭제한다.
		// 회원탈퇴일시, 재가입가능일자 저장
		if(memberDao.updateMemberLeave(po) == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 회원관심상품 삭제.
		memberDao.deleteMemberInterestGoods(po);

		// 회원로그인이력 삭제.
		memberDao.deleteMemberLoginHist(po);

		//회원 sns 정보 삭제
		memberDao.deleteSnsMemberInfo(po);

		//결제가 되어 진행중인 주문 혹은 예약 주문, 참여 중인 이벤트가 있어도, 사용자 선택에 따라 탈퇴 가능, 이후 데이터는 CS에서 처리

		// 회원배송지 삭제.
		memberDao.deleteMemberAddress(po);

		// 회원등급이력 삭제.
		memberDao.deleteMemberGradeHistory(po);

		// 회원등급포인트이력 삭제.
//		memberDao.deleteMemberGradePointHist(po);

		// 회원적립금 삭제.
		memberDao.deleteMemberSavedMoney(po);
		
		// 회원 난수쿠폰 삭제
		memberDao.deleteCouponIssue(po);

		// 회원쿠폰 삭제.
		memberDao.deleteMemberCoupon(po);

		// 회원 주문정보 비회원으로 update
		memberDao.updateMemberOrderLeave(po);
		
		// 회원 알림 수신 변경 이력 삭제
		memberDao.deleteMemberAlarmRcvHist(po);
		
		// 회원 동의 이력 삭제
		memberDao.deleteTermsRcvHistory(po);
		
		// 회원 인증 로그 삭제
		memberDao.deleteMemberCertifiedLog(po);
		
		// 회원 태그 맵핑 삭제
		memberDao.deleteMbrTagMap(po);
		
		// 회원 팔로우 맵 회원 삭제
		memberDao.deleteFollowMapMember(po);
		
		// 회원 팔로우 맵 태그 삭제
		memberDao.deleteFollowMapTag(po);
		
		// 회원 회사 정보 이력 삭제
		memberDao.deleteMemberBizStateHistory(po);
		
		// 회원 기본 이력 삭제
		memberDao.deleteMemberBaseHistory(po);
		
		// 회원 비밀번호 변경 이력 삭제
		memberDao.deleteMemberPswdHist(po);		
		
		// 회원 반려동물 질환 삭제
		memberDao.deletePetDa(po);
		
		// 회원 반려동물 예방접종 삭제
		memberDao.deletePetInclRecode(po);
		
		// 회원 반려동물 삭제
		memberDao.deletePetBase(po);

		// add by lsm : 네이버회원 연동 시 추가된 테이블의 정보가 있는 경우 삭제
		if(naVo.getIntlkNo() != null && naVo.getIntlkNo() > 0){
			memberBaseDao.deleteMemberPrtnIntlk(naVo);
			memberApiService.getNif0004(naVo);
		}

		/**
		 * 탈퇴시 분리보관
		 * 
		 * === MEMBER_BASE ===
		 * 1. 보관DB로 복사시 제외컬럼
		 * 	- MBR_NM		: 회원 명
		 * 	- NICK_NM		: 닉네임
		 * 	- BIRTH			: 생일정보
		 * 	- CI_CTF_VAL	: CI 인증값
		 * 	- PSWD			: 비밀번호
		 * 	- TEL			: 전화번호
		 * 	- MOBILE		: 모바일
		 * 	- EMAIL			: 이메일
		 * 	- RCOM_LOGIN_ID	: 추천인 ID
		 * 	- UPDR_IP		: 수정자 IP
		 * 
		 * 2. 원DB 보관컬럼
		 * 	- MBR_NO		: 회원 번호
		 *	- ST_ID			: 사이트 ID
		 * 	- MBR_STAT_CD	: 회원 상태 코드
		 *  - MBR_LEV_DTM	: 회원 탈퇴 일시
		 *  - SYS_UPDR_NO	: 시스템 수정자 번호
		 *  - SYS_UPD_DTM	: 시스템 수정 일시
		 * 
		 * === MEMBER_BIZ_INFO ===
		 * 1. 보관DB로 복사시 제외컬럼
		 * 	- EMAIL				: 대표 이메일
		 * 	- CEO_NM			: 대표자 명
		 * 	- BIZ_LIC_NO		: 사업자 등록 번호
		 * 	- BIZ_LIC_IMG_PATH	: 사업자 등록증
		 * 	- DLGT_NO			: 대표 번호
		 * 	- CHRG_NM			: 담당자 이름
		 * 	- CHRG_TEL			: 담당자 전화번호
		 * 	- CHRG_MOBILE		: 담당자 휴대폰
		 * 	- CHRG_EMAIL		: 담당자 이메일
		 * 	- ACCT_NO			: 계좌 번호
		 * 	- OOA_NM			: 예금주
		 * 
		 * 2. 원DB 보관컬럼
		 * 	- MBR_NO	: 회원 번호
		 * 	- BIZ_NO	: 회사 번호
		 * 
		 * === MEMBER_ADDRESS ===
		 * 1. 분리보관하지 않음
		 * 2. 원DB에서 로우 삭제
		 */

		try {
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(po.getMbrNo());
			
			MemberBaseVO mbVO = memberBaseDao.getMemberBase(so);
			MemberBizInfoVO mbiVO = memberBaseDao.getMemberBizInfo(so);
			
			org.codehaus.jackson.map.ObjectMapper mapper = new org.codehaus.jackson.map.ObjectMapper().configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			
			String mbVOStr = mapper.writeValueAsString(mbVO);
			MemberBasePO memberBasePO = mapper.readValue(mbVOStr, MemberBasePO.class);

			String mbiVOStr = mapper.writeValueAsString(mbiVO);
			MemberBizInfoPO memberBizInfoPO = mapper.readValue(mbiVOStr, MemberBizInfoPO.class);
			
			memberLeaveService.insertLeaveMemberBase(memberBasePO);
			if(memberBizInfoPO != null) memberLeaveService.insertLeaveMemberBizInfo(memberBizInfoPO);
			
			memberBatchService.updateMemberBaseForLeave(memberBasePO);
			if(memberBizInfoPO != null) memberBatchService.updateMemberBizInfoForLeave(memberBizInfoPO);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	/* 회원의 적립금 이력 조회
	 * @see biz.app.member.service.MemberService#pageMemberSavedMoneyHist(biz.app.member.model.MemberSavedMoneySO)
	 */
	@Override
	public List<MemberSavedMoneyVO> pageMemberSavedMoneyHist(MemberSavedMoneySO so) {
		return memberDao.pageMemberSavedMoneyHist(so);
	}

	/* 회원의 1개월 이내의 소멸예정 적립금 취득
	 * @see biz.app.member.service.MemberService#getLostExpectedMemberSavedMoney(java.lang.Integer)
	 */
	@Override
	public Long getLostExpectedMemberSavedMoney(Long mbrNo) {
		return memberDao.getLostExpectedMemberSavedMoney(mbrNo);
	}

	@Override
	public List<MemberSavedMoneyVO> pageMemberSavedMoney(MemberSavedMoneySO so) {
		return memberDao.pageMemberSavedMoney(so);
	}


	@Override
	public List<MemberSavedMoneyDetailVO> listMemberSavedMoneyDetail(MemberSavedMoneyDetailSO so) {
		return memberSavedMoneyDetailDao.listMemberSavedMoneyDetail(so);
	}


	/* 회원의 본인인증 정보 갱신
	 * @see biz.app.member.service.MemberService#updateMemberCertification(biz.app.member.model.MemberBasePO)
	 */
	@Override
	public void updateMemberCertification(MemberBasePO po) {

		int result = memberDao.updateMemberCertification(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else{


			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getMbrNo());
			//MemberBaseVO member = this.memberBaseDao.getMemberBase(mbso);

			//이메일 전송

//			EmailSendPO espo = new EmailSendPO();
//			espo.setAuthKey(BizConstants.BIZMAILER_AUTH_KEY_MEMBER_CERTIFICATION);
//			espo.setEmail(member.getEmail());
//			espo.setNm(member.getMbrNm());
//			espo.setMobile(member.getMobile());
//			espo.setMemo1(member.getLoginId());
//			espo.setSysRegrNo(member.getMbrNo());
//			this.bizService.sendEmail(espo);
		}
	}


	/*
	 * 미사용 회원 휴면처리  대상 목록
	 * @see biz.app.member.service.MemberService#listMemberBaseNoUseTart(java.lang.Integer)
	 */
	@Override
	public List<MemberBaseVO> listMemberBaseNoUseTart(Integer period) {
		return this.memberDao.listMemberBaseNoUseTart(period);
	}



	/*
	 * 관리자가 회원 적립금 차감
	 */
	@Override
	public void memberSavedMoneyRemove(MemberSavedMoneyPO po) {

		// 회원 기본 정보 가져오기
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setMbrNo(po.getMbrNo());
		MemberBaseVO member = this.memberBaseDao.getMemberBase(mbso);

		List<MemberSavedMoneyVO> saveMoneyList = null;

		//	사용가능한 회원적립금 목록 가져오기
		saveMoneyList = this.memberSavedMoneyService.listMemberSavedMoneyUsedPossible(member.getMbrNo(), po.getSaveAmt()); //차감할 금액

		log.debug("saveMoneyList: {} ", saveMoneyList );

		Long rmnSvmnAmt; // 잔여 적립금
		Long rmnSvmnUseAmt =  po.getSaveAmt() ; //적립금차감대상금액

		MemberSavedMoneyDetailPO msmdpo = null;


		if(saveMoneyList != null && !saveMoneyList.isEmpty()){

			for(MemberSavedMoneyVO memberSavedMoney : saveMoneyList) {

				/*
				 * 잔여 결제금액이 존재하는 경우에만 차감 처리
				 */
				if(rmnSvmnUseAmt > 0){
					if(rmnSvmnUseAmt > memberSavedMoney.getRmnAmt()){
						rmnSvmnAmt = memberSavedMoney.getRmnAmt();
					}else{
						rmnSvmnAmt = rmnSvmnUseAmt;
					}
					rmnSvmnUseAmt = rmnSvmnUseAmt - rmnSvmnAmt;

					msmdpo = new MemberSavedMoneyDetailPO();
					msmdpo.setMbrNo(memberSavedMoney.getMbrNo());
					msmdpo.setSvmnSeq(memberSavedMoney.getSvmnSeq());
					msmdpo.setSvmnPrcsCd(po.getSvmnPrcsCd());
					msmdpo.setSvmnPrcsRsnCd(po.getSvmnPrcsRsnCd());
					msmdpo.setEtcRsn(po.getEtcRsn());

					//msmdpo.setPayNo(payBase.getPayNo());
					msmdpo.setPrcsAmt(rmnSvmnAmt);

					this.memberSavedMoneyService.insertMemberSavedMoneyDetail(msmdpo);
				}
			}
			//차감가능한 적립금 없음
		}else{
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_SAVED_MONEY_REDUCE_NO_RMN_AMT);
		}

		//log.debug("saveMoneyDetailList.size() : {} ", saveMoneyDetailList.size());
		//log.debug("saveMoneyDetailList : {} ", saveMoneyDetailList);
		// 회원 적립금 사용내역 저장
//		if(saveMoneyDetailList != null && saveMoneyDetailList.size() > 0){
//			for(MemberSavedMoneyDetailPO detailPO : saveMoneyDetailList){
//				int additionCostCnt = this.insertMemberSavedMoneyDetail(detailPO);
//
//				if(additionCostCnt != 1){
//					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//				}
//
//			}
//		}
	}

	@Override
	public MemberMainVO getMemberMain() {
		return memberDao.getMemberMain();
	}

	@Override
	public List<MemberSavedMoneyVO> listMemberSavedMoneyHist(MemberSavedMoneySO so){
		return memberDao.listMemberSavedMoneyHist(so);
	}

	/*
	 * 환불 예정 금액
	 * @see biz.app.member.service.MemberService#getMemberRefundSchdAmt(biz.app.member.model.MemberBaseSO)
	 */
	@Override
	public Long getMemberRefundSchdAmt(MemberBaseSO so){
		return memberDao.getMemberRefundSchdAmt(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.member.service
	 * - 파일명      : MemberServiceImpl.java
	 * - 작성일      : 2017. 4. 25.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      : 사용자 이력 히스토리
	 * </pre>
	 */
	@Override
	public List<MemberBaseVO> listMemberBaseHistory(MemberBaseSO so) {
		//log.debug("★★★★★★★★★ : {} ", so.toString());
		List<MemberBaseVO> list = memberDao.listMemberBaseHistory(so);
		if(list != null && !list.isEmpty()) {
			for(MemberBaseVO vo : list){
				vo.setTel(StringUtil.phoneNumber(vo.getTel()));
				vo.setMobile(StringUtil.phoneNumber(vo.getMobile()));
				if(StringUtil.isNotBlank(vo.getBirth())&& vo.getBirth().length() == 8){
					vo.setBirth(vo.getBirth().substring(0, 4) + "-" + vo.getBirth().substring(4, 6) + "-" + vo.getBirth().substring(6, 8));
				}
			}
		}
		return list;


	}

	@Override
	public void insertMemberBaseHistory(Long mbrNo ) {
		// 이력등록
		MemberBasePO po  = new MemberBasePO();
		po.setMbrNo(mbrNo);
		po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));

		if(memberBaseDao.insertMemberBaseHistory(po) == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/*
	 *  회원번호 목록 조회
	 * @see biz.app.member.service.MemberService#listMemberBaseNo(biz.app.member.model.MemberBaseSO)
	 */
	@Override
	public List<Long> listMemberBaseNo(MemberBaseSO so) {
		return this.memberBaseDao.listMemberBaseNo(so);
	}


	/**
	 *
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.member.service
	 * - 파일명      : MemberServiceImpl.java
	 * - 작성일      : 2017. 7. 25.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      :비밀번호 초기화
	 * </pre>
	 */
	@Override
	public void memberPasswordUpdate(MemberBasePO po) {
		String orignalPassword = null;
		try {
			orignalPassword = StringUtil.temporaryPassword(8); //실제 사용할거
			//po.setPswd(CryptoUtil.encryptSHA256(CryptoUtil.encryptMD5(orignalPassword)));
			po.setPswd(passwordEncoder.encode(orignalPassword));
			po.setPswdInitYn(CommonConstants.COMM_YN_Y );
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		int result = memberBaseDao.updateMemberBasePassword(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		//이메일 SMS 전송
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(po.getMbrNo() );
		MemberBaseVO vo = memberBaseDao.getMemberBase(so);

		Long stId = vo.getStId();
		StStdInfoVO stInfo = this.stDao.getStStdInfo(stId);
		String stNm = stInfo.getStNm();

		EmailSend email = new EmailSend();
		email.setReceiverNm(vo.getMbrNm());
		email.setReceiverEmail(vo.getEmail());
		email.setMbrNo(vo.getMbrNo());
		email.setStId(stId);
		email.setEmailTpCd(CommonConstants.EMAIL_TP_120);
		email.setMap01(orignalPassword);
		email.setMap02(DateUtil.getTimestampToString( DateUtil.getTimestamp()   , "yyyy-MM-dd HH:mm"));

		List<EmailSendMap> mapList = new  ArrayList<>();

		this.bizService.sendEmail(email,mapList);

		CodeDetailVO title = cacheService.getCodeCache(AdminConstants.SMS_TP, AdminConstants.SMS_TP_120);
		String subject = title.getUsrDfn2Val();    // 제목
		String msg = title.getUsrDfn3Val();    // 내용
		subject = subject.replace(CommonConstants.SMS_TITLE_ARG_MALL_NAME, stNm);

		msg = msg.replace(CommonConstants.SMS_MSG_ARG_MALL_NAME,  stNm);
		msg = msg.replace(CommonConstants.SMS_MSG_ARG_TEMP_PSWD,  orignalPassword);

		LmsSendPO lmsPO = new LmsSendPO();
		lmsPO.setSendPhone(stInfo.getCsTelNo());
		lmsPO.setReceivePhone( vo.getMobile()  );
		lmsPO.setReceiveName(   vo.getMbrNm() );
		lmsPO.setSubject(subject);
		lmsPO.setMsg(msg);
		bizService.sendLms(lmsPO);

	}

	/*
	 * 탈퇴 회원 상세 조회
	 * @see biz.app.member.service.MemberService#getMemberBase(java.lang.Long)
	 */
	@Override
	public MemberBaseVO getLeaveMemberBase(MemberBaseSO so) {
		return memberBaseDao.getLeaveMemberBase(so);
	}
	/*
	 * 휴면회원 복원
	 * @see biz.app.member.service.MemberService#saveMemberNoUse(java.lang.Integer)
	 */
	@Override
	public void saveMemberUse(Long mbrNo) {
		this.memberDao.saveMemberUse(mbrNo);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: 이지희
	 * - 설명		:  본인인증코드로 멤버번호 조회
	 * </pre>
	 */
	@Override
	public Long getMbrNo(String ctfCd){
		return this.memberDao.getMbrNo(ctfCd);
	}

	@Override
	public List<MemberBaseVO> listMemberMdnChangeHistory(MemberBaseSO so) {
		List<MemberBaseVO> list = Optional.ofNullable(memberBaseDao.listMemberMdnChangeHistory(so)).orElseGet(()->new ArrayList<MemberBaseVO>());
		list.forEach(vo->{
			vo = setDataFormat(vo);
			if(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N)){
				vo = maskingMemberInfo(vo);
			}
		});
		return list;
	}

	@Override
	public List<ContentsReplyVO> listMemberReply(ContentsReplySO so) {
		return replyDao.listMemberReply(so);
	}

	@Override
	public List<MemberBaseVO> listRecommandedList(MemberBaseSO so) {
		return Optional.ofNullable(memberBaseDao.listRecommandedList(so)).orElseGet(()->new ArrayList<MemberBaseVO>());
	}

	@Override
	public List<MemberBaseVO> listRecommandingList(MemberBaseSO so) {
		return Optional.ofNullable(memberBaseDao.listRecommandingList(so)).orElseGet(()->new ArrayList<MemberBaseVO>());
	}

	//회원목록(팝업) - 최신결제일자 순
	@Override
	public List<MemberBaseVO> listPopupMemberBase(MemberBaseSO so) {
		// 휴대폰 번호 형식
		if(StringUtil.isNotBlank(so.getMobile())){
			so.setMobile(so.getMobile().replaceAll("-", ""));
		}

		List<MemberBaseVO> list = memberDao.listPopupMemberBase(so);

		return memberDao.listPopupMemberBase(so);
	}

	//sns로그인시 기존 등록된 sns회원인지 체크
	@Override
	public MemberBaseVO getExistingSnsMemberCheck(SnsMemberInfoSO so) {
		return memberDao.getExistingSnsMemberCheck(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 01. 15.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 시 기존 회원인가 체크(SnsMemberInfoSO)
	 * </pre>
	 * @param so
	 */
	@Override
	public MemberBaseVO getExistingMemberCheck(SnsMemberInfoSO so) {
		return memberBaseDao.getExistingMemberCheck(so);
	}


	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 19.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 핸드폰 번호 같은 기존회원 체크
	 * </pre>
	 * @param mobile
	 * @param mbrNo
	 * @return
	 */
	@Override
	public int checkMbrNoFromMobile(String mobile, Long mbrNo) {
		MemberBaseSO so = new MemberBaseSO();
		so.setMobile(mobile);
		List<Long> originMbrNos = memberBaseDao.getMbrNoFromMemberInfo(so);
		//같은 핸드폰번호 갖고 있는 회원 있다면
		if(originMbrNos != null && originMbrNos.size() > 0) {

			int updateResult = 0;
			for(Long orgMbrNo : originMbrNos) {
				if(!orgMbrNo.equals(mbrNo)) {
					
					MemberBasePO po = new MemberBasePO();
					po.setMbrNo(orgMbrNo);
					po.setMbrStatCd(CommonConstants.MBR_STAT_40);
					po.setSysUpdrNo(mbrNo);
					
					//중복상태로 회원 상태 변경
					updateResult +=  memberBaseDao.updateMemberBase(po);
					//회원변경이력 추가
					insertMemberBaseHistory(orgMbrNo);
				}
				
			}
			return updateResult;
		}else {
			return 0;
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberServiceImpl.java
	 * - 작성일		: 2021. 1. 26.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 추천인 아이디 체크
	 * </pre>
	 * @param  so 암호화된 로그인 id 갖고있는 so
	 * @return
	 */
	@Override
	public String checkRcomLoginId(MemberBaseSO so) {
		return  memberBaseDao.getRcomURLFromMemberInfo(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명			: sns 계정 정보 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int insertSnsMemberInfo(SnsMemberInfoSO so) {
		return memberBaseDao.insertSnsMemberInfo(so);
	}

	@Override
	public int deleteSnsMemberInfo(SnsMemberInfoPO po) {
		return memberBaseDao.deleteSnsMemberInfo(po);
	}

	@Override
	public void upSertSnsMemberInfo(SnsMemberInfoPO po) {
		memberBaseDao.upSertSnsMemberInfo(po);
	}

	@Override
	public Map<Long, MemberBaseVO> listMemberOrderInfo(MemberBaseSO so) {
		return null;
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 태그정보 매핑
	 * </pre>
	 * @param  list List<MbrTagMapPO>
	 * @return
	 */
	@Override
	public int insertMbrTagMap(List<MbrTagMapPO> list) {
		return memberBaseDao.insertMbrTagMap(list);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 02. 03.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 인증 이력 저장
	 * </pre>
	 * @param po MemberCertifiedLogPO
	 * @return
	 */
	@Override
	public int insertCertifiedLog(MemberCertifiedLogPO po) {
		return memberBaseDao.insertCertifiedLog(po);
	}


	@Override
	public List<TagBaseVO> listMemberTagFollow(TagBaseSO so) {
		return Optional.ofNullable(memberDao.listMemberTagFollow(so)).orElseGet(()->new ArrayList<>());
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.08.
	 * - 작성자		: 이지희
	 * - 설명			: 비번 변경 시 그 전 비번과 비교 위해 조회
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	@Override
	public List<String> listBeforePswd(String mbrNo) {
		return memberBaseDao.listBeforePswd(mbrNo);
	}

	@Override
	public List<GoodsBaseVO> listMemberGoodsIoList(GoodsBaseSO so) {
		List<GoodsBaseVO> list = new ArrayList<GoodsBaseVO>();
		if(Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0L) != 0){
			list = Optional.ofNullable(memberDao.listMemberGoodsIoList(so)).orElseGet(()-> new ArrayList<GoodsBaseVO>());
		}
		return list;
	}

	@Override
	public List<ContentsReplyVO> listMemberReportList(MemberBaseSO so) {
		return Optional.ofNullable(memberDao.listMemberReportList(so)).orElseGet(()->new ArrayList<ContentsReplyVO>());
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.09.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 GSR연동 정보 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int updateMemberBaseGspt(MemberBasePO po) {
		return memberBaseDao.updateMemberBaseGspt(po);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.16.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 등급 로그 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int insertMemberGrade(MemberBasePO po) {
		return memberBaseDao.insertMemberGrade(po);
	}


	@Override
	public MemberBaseSO encryptMemberBase(MemberBaseSO so) {
		MemberBaseSO result = (MemberBaseSO)(encryptMemberBase(so,new TypeReference<MemberBaseSO>(){}));
		result.setSidx(Optional.ofNullable(so.getSidx()).orElseGet(()->""));
		result.setSord(Optional.ofNullable(so.getSord()).orElseGet(()->"asc"));
		result.setSort(Optional.ofNullable(so.getSort()).orElseGet(()->""));
		result.setOrder(Optional.ofNullable(so.getOrder()).orElseGet(()->"asc"));
		result.setPage(Optional.ofNullable(so.getPage()).orElseGet(()->1));
		result.setRows(Optional.ofNullable(so.getRows()).orElseGet(()->50));
		result.setTotalCount(Optional.ofNullable(so.getTotalCount()).orElseGet(()->50));
		return result;
	}

	@Override
	public MemberBasePO encryptMemberBase(MemberBasePO po) {
		return (MemberBasePO)(encryptMemberBase(po,new TypeReference<MemberBasePO>(){}));
	}

	@Override
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
	@Override
	public MemberBaseVO decryptMemberBase(MemberBaseSO so) {
		return decryptMemberBase(memberBaseDao.getMemberBase(encryptMemberBase(so)));
	}

	private Object encryptMemberBase(Object target, TypeReference type){
		Object result;
		try {
			Map<String,Object> convertMap = new ObjectMapper().convertValue(target,Map.class);

			String mbrNm = Optional.ofNullable(convertMap.get("mbrNm")).orElseGet(()->"").toString();
			String loginId = Optional.ofNullable(convertMap.get("loginId")).orElseGet(()->"").toString();
			//String nickNm = Optional.ofNullable(convertMap.get("nickNm")).orElseGet(()->"").toString();
			String birth = Optional.ofNullable(convertMap.get("birth")).orElseGet(()->"").toString();
			String mobile = Optional.ofNullable(convertMap.get("mobile")).orElseGet(()->"").toString().replaceAll("-","");
			String email = Optional.ofNullable(convertMap.get("email")).orElseGet(()->"").toString();

			convertMap.replace("mbrNm" , StringUtil.isNotEmpty(mbrNm) ? bizService.twoWayEncrypt(mbrNm) : mbrNm);
			convertMap.replace("loginId" , StringUtil.isNotEmpty(loginId) ? bizService.twoWayEncrypt(loginId) : loginId);
			//convertMap.replace("nickNm" , StringUtil.isNotEmpty(nickNm) ? bizService.twoWayEncrypt(nickNm) : nickNm);
			convertMap.replace("birth" , StringUtil.isNotEmpty(birth) ? bizService.twoWayEncrypt(birth) : birth);
			convertMap.replace("mobile" , StringUtil.isNotEmpty(mobile) ? bizService.twoWayEncrypt(mobile) : mobile);
			convertMap.replace("email" , StringUtil.isNotEmpty(email) ? bizService.twoWayEncrypt(email) : email);

			result = new ObjectMapper().convertValue(convertMap,type);
		}catch (Exception e){
			result = new ObjectMapper().convertValue(target,type);
		}
		return result;
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

		convertMap.replace("mbrNm" , StringUtil.isNotEmpty(mbrNm) ? PetraUtil.twoWayDecrypt(mbrNm, userId, clientIp) : mbrNm);
		convertMap.replace("loginId" , StringUtil.isNotEmpty(loginId) ? PetraUtil.twoWayDecrypt(loginId, userId, clientIp) : loginId);
		convertMap.replace("birth" , StringUtil.isNotEmpty(birth) ? PetraUtil.twoWayDecrypt(birth, userId, clientIp) : birth);
		convertMap.replace("mobile" , StringUtil.isNotEmpty(mobile) ? PetraUtil.twoWayDecrypt(mobile, userId, clientIp) : mobile);
		convertMap.replace("email" , StringUtil.isNotEmpty(email) ? PetraUtil.twoWayDecrypt(email, userId, clientIp) : email);

		result = new ObjectMapper().convertValue(convertMap,type);

		return result;
	}

	@Override
	@Transactional(readOnly = true)
	public Map<String, SnsMemberInfoVO> getMemberSnsLoginYn(Long mbrNo) {
		Map<String,SnsMemberInfoVO> result = new HashMap<>();
		List<SnsMemberInfoVO> list = Optional.ofNullable(memberDao.getMemberSnsLoginYn(mbrNo)).orElseGet(()->new ArrayList<SnsMemberInfoVO>());
		Map<String,SnsMemberInfoVO> SnsMemberInfoMap = new HashMap<String,SnsMemberInfoVO>();
		for(SnsMemberInfoVO v : list){
			SnsMemberInfoMap.put(v.getSnsLnkCd(),v);
		}

		List<CodeDetailVO> codeList = Optional.ofNullable(cacheService.listCodeCache(FrontConstants.SNS_LNK_CD,null,null,null,null,null))
				.orElseGet(()->new ArrayList<>());
		for(CodeDetailVO code : codeList){
			String key = code.getDtlCd();
			result.put(key,SnsMemberInfoMap.containsKey(key) ? SnsMemberInfoMap.get(key) : new SnsMemberInfoVO());
		}

		return result;
	}

	@Override
	public MemberBaseVO updateMemberInfo(MemberBasePO po, String[] memberTags) {
		String encY = bizService.oneWayEncrypt(CommonConstants.COMM_YN_Y);
		String encN = bizService.oneWayEncrypt(CommonConstants.COMM_YN_N);

		MemberBaseVO result = new MemberBaseVO();
		Long mbrNo = po.getMbrNo();
		po.setCtfYn(StringUtil.isEmpty(Optional.ofNullable(po.getCiCtfVal()).orElseGet(()->"")) ? FrontConstants.COMM_YN_N : FrontConstants.COMM_YN_Y);

		//회원 기본 정보 수정
		po = encryptMemberBase(po);
		String orgMobile = bizService.twoWayEncrypt(po.getOrgMobile());
		//프로필 이미지 수정
		//이미지 등록
		String prflImg = Optional.ofNullable(po.getPrflImg()).orElseGet(()->"");
		String orgPrflImg = Optional.ofNullable(po.getOrgPrflImg()).orElseGet(()->"");
		String uploadPath = null;
		String deviceGb = po.getDeviceGb();

		//프로필 사진 변경 시
		if(!StringUtil.isEmpty(prflImg) && !StringUtil.equals(prflImg,orgPrflImg)) {
			//앱이 아닐 때만, FTP를 서버 전송, 앱일 경우 앞단에서 APP-INTERFACE JS FUNC 호출
			if(!StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30)){
				FtpImgUtil ftpImgUtil = new FtpImgUtil();
				uploadPath = ftpImgUtil.uploadFilePath(prflImg,FrontConstants.MBR_IMG_PATH + FileUtil.SEPARATOR + String.valueOf(mbrNo));

				log.error("prflImg @orgFileStr : {}",prflImg);
				log.error("uploadPath @newFileStr : {}",uploadPath);
				ftpImgUtil.upload(prflImg,uploadPath);	// 원본 이미지 FTP 복사
				po.setPrflImg(uploadPath);

				//Session set
				framework.front.model.Session session = FrontSessionUtil.getSession();
				session.setPrflImg(uploadPath);
				FrontSessionUtil.setSession(session);
			}else{
				uploadPath = FrontConstants.MBR_IMG_PATH + FileUtil.SEPARATOR + String.valueOf(mbrNo);
				po.setPrflImg("");
			}
		}
		//휴대폰 번호 변경시 혹은 점유 인증 완료 시
		String otpYn = Optional.ofNullable(CookieSessionUtil.getCookie("cyn")).orElseGet(()->encN);
		if(!StringUtil.isEmpty(po.getMobile()) &&  (!StringUtil.equals(po.getMobile(),orgMobile) || StringUtil.equals(otpYn,encY))){
			checkMbrNoFromMobile(po.getMobile(),mbrNo);
			po.setMbrStatCd(FrontConstants.MBR_STAT_10);
		}

		//유효성 확인
		Map<String,Long> validateMap = memberBaseDao.validateCheckMemberInfoWhenUpdate(po);
		Long nickNmCnt = validateMap.get("NICK_NM_CNT");
		Long emailCnt = validateMap.get("EMAIL_CNT");
		Long mobileCnt = validateMap.get("MOBILE_CNT");

		if(Long.compare(nickNmCnt,0L) > 0){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_DUPLICATION_NICK_NM);
		}
		if(Long.compare(emailCnt,0L) > 0){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_DUPLICATION_EMAIL);
		}
		if(Long.compare(mobileCnt,0L) > 0){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_DUPLICATION_MOBILE);
		}
		
		//회원 정보 수정
		String newPswd = Optional.ofNullable(po.getNewPswd()).orElseGet(()->"");
		//회원 정보 정제
		if(StringUtil.isNotEmpty(Optional.ofNullable(po.getTel()).orElseGet(()->""))){
			po.setTel(po.getTel().replaceAll("-", ""));
		}
		if(StringUtil.isNotEmpty(Optional.ofNullable(po.getMobile()).orElseGet(()->""))){
			po.setMobile(po.getMobile().replaceAll("-", ""));
		}
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
		//회원 정보 변경 이력
		if(memberBaseDao.updateMemberBase(po) == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		//비밀번호 변경
		if(StringUtil.isNotEmpty(newPswd)){
			updateMemberPassword(mbrNo,newPswd);
		}

		//앱이 아닐때만 insertMemberBaseHistory, 앱일 때는 경로 update하면서 이력 남김
		if(!StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30)){
			insertMemberBaseHistory(mbrNo);
		}

		if(memberTags.length != 0){
			//회원 태그정보
			memberBaseDao.deleteMbrTagMap(mbrNo);
			List<MbrTagMapPO> insertTagList = new ArrayList<>();
			for(String tagNo : memberTags){
				MbrTagMapPO t = new MbrTagMapPO();
				t.setTagNo(tagNo);
				t.setMbrNo(mbrNo);
				t.setSysRegrNo(mbrNo);
				t.setSysUpdrNo(mbrNo);
				insertTagList.add(t);
			}
			memberBaseDao.insertMbrTagMap(insertTagList);
		}

		//준회원 인증 했을 시, 인증 로그 저장
		String certYn = Optional.ofNullable(CookieSessionUtil.getCookie("cyn")).orElseGet(()->CommonConstants.COMM_YN_N);
		if(StringUtil.equals(certYn,encY)){
			MemberCertifiedLogPO certpo = new MemberCertifiedLogPO();
			String ctfKey = bizService.twoWayDecrypt(CookieSessionUtil.getCookie("ck"));
			Long ctfLogNo = bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_CERTIFIED_LOG_SEQ);

			certpo.setCtfKey(ctfKey);
			certpo.setCtfLogNo(ctfLogNo);
			certpo.setCtfMtdCd(FrontConstants.CTF_MTD_OTP);
			certpo.setCtfTpCd(FrontConstants.CTF_TP_UPD_MOB);
			certpo.setCtfRstCd(FrontConstants.CERT_OK);
			certpo.setCtfKey(CookieSessionUtil.getCookie("ck"));
			certpo.setMbrNo(mbrNo);
			certpo.setSysRegrNo(mbrNo);
			insertCertifiedLog(certpo);
		}

		result.setPrflImg(uploadPath);
		return result;
	}

	@Override
	public List<MemberBaseVO> selectPetsbeMig() {
		return memberBaseDao.selectPetsbeMig();
	}

	@Override
	public void updatePetsbeMig(List<MemberBaseVO> list) {
		memberBaseDao.updatePetsbeMig(list);
	}


	@Override
	public List<MemberBaseVO> listFollowerMe(MemberBaseSO so) {
		List<MemberBaseVO> list = Optional.ofNullable(memberDao.listFollowerMe(so)).orElseGet(()->new ArrayList<MemberBaseVO>());
		List<MemberBaseVO> result = new ArrayList<>();
		for(MemberBaseVO vo : list){
			vo = decryptMemberBase(vo);
			if(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N)){
				vo = maskingMemberInfo(vo);
			}
			result.add(vo);
		}
		return result;
	}

	@Override
	public List<MemberBaseVO> listImFollowing(MemberBaseSO so) {
		List<MemberBaseVO> list = Optional.ofNullable(memberDao.listImFollowing(so)).orElseGet(()->new ArrayList<MemberBaseVO>());
		List<MemberBaseVO> result = new ArrayList<>();
		for(MemberBaseVO vo : list){
			vo = decryptMemberBase(vo);
			if(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N)){
				vo = maskingMemberInfo(vo);
			}
			result.add(vo);
		}
		return result;
	}


	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.24.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 쿠폰 발급
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public Long insertJoinCoupon(Long mbrNo, CodeDetailVO codeVO) {
		Long result = 0L;
		
		if(codeVO.getUseYn().equals("Y")) {
			MemberCouponPO mcPo = new MemberCouponPO();
			mcPo.setCpNo(Long.parseLong(codeVO.getUsrDfn1Val()));
			mcPo.setMbrNo(mbrNo);
			mcPo.setSysRegrNo(mbrNo);
			mcPo.setIsuTpCd(CommonConstants.ISU_TP_10);
			try {
				result = memberCouponService.insertMemberCoupon(mcPo);
			}catch(CustomException cep) {
				log.error(cep.getMessage());
			}
		}
		return result;
	}

	@Override
	public int updateAlmRcvYn(MemberBaseVO vo) {
		return memberDao.updateAlmRcvYn(vo);
	}

	@Override
	public MemberUnsubscribeVO updateMemberMarketingAgree(MemberBasePO po) {
		return updateMemberMarketingAgree(po.getMkngRcvYn(),Optional.ofNullable(po.getMobileArr()).orElseGet(()->new String[]{po.getMobile()}),po.getChgActrCd());
	}

	@Override
	public MemberUnsubscribeVO updateMemberMarketingAgree(String mkngRcvYn, String mobile , String chgActrCd) {
		if(StringUtil.isNotEmpty(mobile)){
			return updateMemberMarketingAgree(mkngRcvYn,new String[]{mobile},chgActrCd);
		}else{
			log.debug("#### MOBILE IS NULL ####");
			return new MemberUnsubscribeVO();
		}
	}

	//핸드폰 번호 -> 암호화 된 값 X, 마스킹  X
	@Override
	public MemberUnsubscribeVO updateMemberMarketingAgree(String mkngRcvYn, String[] mobileArr,String chgActrCd) {
		//응답 값
		MemberUnsubscribeVO result = new MemberUnsubscribeVO();
		result.setMkngRcvYn(mkngRcvYn);

		List<MemberUnsubscribeVO> apiResponse = new ArrayList<MemberUnsubscribeVO>();

		//핸드폰 번호 확인
		int size = mobileArr.length;
		//마케팅 수신여부 변경 일 때
		result.setTotalCnt(size);
		switch (mkngRcvYn){
			//마케팅 수신 여부 -> 동의 시 , NAVER 080 수신 거부 시스템에서 삭제
			case CommonConstants.COMM_YN_Y :
				apiResponse = bizService.deleteUnsubscribes(mobileArr);
				result.setUpdateCnt(apiResponse.size());
				result.setFailCnt(size - apiResponse.size());
				break;
			//마케팅 수신 여부 -> 미동의 시, NAVER 080 수신 거부 시스템에 등록
			case CommonConstants.COMM_YN_N :
				apiResponse = bizService.registUnsubscribes(mobileArr);
				result.setUpdateCnt(apiResponse.size());
				result.setFailCnt(size - apiResponse.size());
				break;
			default:  result.setFailCnt(size); break;
		}
		
//		if(apiResponse.size()>0){
			List<String> mobileList = new ArrayList<String>();
//			for(MemberUnsubscribeVO v : apiResponse){
//				String m = v.getMobile();
//				mobileList.add(m);
//			}
			mobileList = Arrays.asList(mobileArr);
			MemberBasePO po = new MemberBasePO();
			po.setMkngRcvYn(mkngRcvYn);
			po.setChgActrCd(chgActrCd);
			po.setMobileArr(mobileList.toArray(new String[mobileList.size()]));

			try{
				memberDao.callProcedureMarketingChange(po);
			}catch(Exception e){
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
				switch (mkngRcvYn){
					case CommonConstants.COMM_YN_Y :
						apiResponse = bizService.registUnsubscribes(mobileArr);
						break;
					case CommonConstants.COMM_YN_N :
						apiResponse = bizService.deleteUnsubscribes(mobileArr);
						break;
					default: break;
				}
				result.setUpdateCnt(0);
				result.setFailCnt(0);
			}
//		}
		return result;
	}

	@Override
	public List<MemberBaseVO> getNickNameList(String nickNm) {
		return memberDao.getNickNameList(nickNm);
	}
	
	@Override
	public MemberBaseVO getMentionInfo(String nickNm) {
		return memberDao.getMentionInfo(nickNm);
	}

	@Override
	public int insertMemberSearchWord(MemberSearchWordPO po) {
		return memberSearchWordDao.insertMemberSearchWord(po);
	}

	@Override
	public List<MemberSearchWordVO> listMemberSearchWord(MemberSearchWordSO so) {
		return memberSearchWordDao.listMemberSearchWord(so);
	}

	@Override
	public int deleteMemberSearchWord(MemberSearchWordPO po) {
		return memberSearchWordDao.deleteMemberSearchWord(po);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: 이지희
	 * - 설명			: 내 정보 관리 > 비밀번호 존재 유무 확인
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	@Override
	public String isPswdForUpdate(Long mbrNo) {
		return memberBaseDao.isPswdForUpdate(mbrNo); 
	}

	@Override
	public PrsnPaySaveInfoVO getMemberPaySaveInfo(Long mbrNo) {
		return memberDao.getMemberPaySaveInfo(mbrNo);
	}

	@Override
	public PrsnCardBillingInfoVO getMemberCardBillInfo(Long mbrNo) {
		return memberDao.getMemberCardBillInfo(mbrNo);
	}

	/*@Override
	public void updateMemberCardBillInfo(PrsnCardBillingInfoPO po) {
		return memberDao.updateMemberCardBillInfo(po);
	}

	@Override
	public void updateMemberPaySaveInfo(PrsnPaySaveInfoPO po) {
		return memberDao.updateMemberPaySaveInfo(po);
	}*/

	@Override
	public List<PrsnCardBillingInfoVO> listMemberCardBillingInfo(MemberBaseSO so) {
		so.setRows(Optional.ofNullable(so.getRows()).orElseGet(()->9999));
		so.setSidx(Optional.ofNullable(so.getSidx()).orElseGet(()->"PCBI.DFLT_YN DESC,	PCBI.SYS_REG_DTM"));
		so.setSord(Optional.ofNullable(so.getSord()).orElseGet(()->"DESC"));

		List<PrsnCardBillingInfoVO> list = Optional.ofNullable(memberDao.listMemberCardBillingInfo(so)).orElseGet(()->new ArrayList<>());
		return list;
	}
	
	@Override
	public List<SktmpCardInfoVO> listMemberSktmpCardInfo(MemberBaseSO so) {
		List<SktmpCardInfoVO> list = Optional.ofNullable(memberDao.listMemberSktmpCardInfo(so)).orElseGet(()->new ArrayList<>());
		
		return list;
	}

	@Override
	public String getMemberBaseNickNmInJoin(MemberBaseSO so) {
		return Optional.ofNullable(memberBaseDao.getMemberBaseNickNmInJoin(so)).orElseGet(()->"");
	}

	@Override
	public void updateRcomUrl(MemberBasePO po) {
		memberBaseDao.updateRcomUrl(po);
	}

	@Override
	public int updateMemberBaseTermsYn(MemberBasePO po) {
		int result = 0;
		
		if(po.getTermsCd().equals(CommonConstants.TERMS_GB_ABP_MEM_LOCATION_INFO)) {
			po.setPstInfoAgrYn(po.getAgreeYn());
		} else if(po.getTermsCd().equals(CommonConstants.TERMS_GB_ABP_MEM_MARKETING)) {
			po.setMkngRcvYn(po.getAgreeYn());
		}
		
		// 마케팅 수신 동의일경우
		if(po.getTermsCd().equals(CommonConstants.TERMS_GB_ABP_MEM_MARKETING)) {
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(po.getMbrNo());
			MemberBaseVO vo = memberBaseDao.getMemberBase(so);
			
			// 약관 상세 sms 발송(템플릿 사용)
			SsgMessageSendPO msg = new SsgMessageSendPO();
			// 1. SMS / LMS
			msg.setFuserid(String.valueOf(po.getMbrNo()));
			
			PushSO pso = new PushSO();
			// TODO 조은지 : 동의(102), 거부(103) 임시 하드코딩
			Long tmplNo = po.getMkngRcvYn().equals(CommonConstants.COMM_YN_Y) ? 102L : 103L;
			pso.setTmplNo(tmplNo);
			
			PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
			//String message2 = pvo.getContents().replace(CommonConstants.PUSH_TMPL_VRBL_280, DateUtil.calDate("yyyy년 MM월 dd일")); //템플릿 내용
			
			String todayDate = DateUtil.calDate("yyyy-MM-dd");
			
			String message2 = pvo.getContents().replace(CommonConstants.PUSH_TMPL_VRBL_330, todayDate.split("-")[0]).replace(CommonConstants.PUSH_TMPL_VRBL_340, todayDate.split("-")[1]).replace(CommonConstants.PUSH_TMPL_VRBL_350, todayDate.split("-")[2]);
			
			msg.setFsubject(pvo.getSubject()); // 템플릿 제목 set
			msg.setFmessage(message2);// 템플릿 내용 replace(데이터 바인딩)
			msg.setFdestine(bizService.twoWayDecrypt(vo.getMobile()));	// 수신자번호
			msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
			msg.setMbrNo(po.getMbrNo());
			msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
			
			bizService.sendMessage(msg);
			
			/**
			 * 마케팅 수신 동의시 쿠폰 발급
			 * 마케팅 쿠폰은 한번만 발급
			 * 두번째 동의시 쿠폰발급 없이 동의처리 -> 때문에 insertMemberCoupon 서비스 사용불가, 필요한 부분만 발췌
			 */
			if(po.getMkngRcvYn().equals(CommonConstants.COMM_YN_Y)) {
				// 마케팅 수신 동의 쿠폰 공통코드 조회
				// 사용자 정의1값이 쿠폰 시퀀스임
				CodeDetailVO codeVO = cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_MARKETING);
				Long cpNo = Long.valueOf(codeVO.getUsrDfn1Val());
				
				MemberCouponPO mcPO = new MemberCouponPO();
				mcPO.setMbrNo(po.getMbrNo());
				mcPO.setCpNo(cpNo);
				result = memberCouponDao.getMemberCouponCnt(mcPO);

				if(result == 0) {
					CouponSO cso = new CouponSO();
					cso.setCpNo(cpNo);
					CouponBaseVO coupon = Optional.ofNullable(couponService.getCoupon(cso)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA)); // 쿠폰이 존재하지 않습니다.
					
					if(CommonConstants.CP_STAT_20.equals(coupon.getCpStatCd())){
						long today = System.currentTimeMillis();
						long aplStrtDtm = coupon.getAplStrtDtm().getTime();
						long aplEndDtm = coupon.getAplEndDtm().getTime();
						
						if(aplStrtDtm<=today && today<=aplEndDtm){ // 적용시작일시
							// 유효기간코드 10: 발급일, 20: 일자지정  , 사용시작일시와 사용종료일시 세팅
							if(CommonConstants.VLD_PRD_10.equals(coupon.getVldPrdCd())){
								String ss = DateUtil.getNowDate()+" 00:00:00";
								Timestamp strtd = DateUtil.getTimestamp(ss, "yyyyMMdd 00:00:00") ;
								mcPO.setUseStrtDtm(strtd);
	
								String e = DateUtil.addDays(DateUtil.getNowDate(), coupon.getVldPrdDay().intValue())+" 23:59:59" ;
								Timestamp endd = DateUtil.getTimestamp(e, "yyyyMMdd HH:mm:ss");
	
								mcPO.setUseEndDtm(endd);
	
							}else{
								mcPO.setUseStrtDtm(coupon.getVldPrdStrtDtm());
								mcPO.setUseEndDtm(coupon.getVldPrdEndDtm());
							}
						}
						mcPO.setIsuTpCd(CommonConstants.ISU_TP_10);	
						mcPO.setSysRegrNo(po.getMbrNo());
						mcPO.setUseYn(CommonConstants.USE_YN_N);
						memberCouponDao.insertMemberCoupon(mcPO);
					}
				}
			}
			
			// 회원 마케팅 동의 이력 테이블 insert
			po.setSysRegrNo(po.getMbrNo());
			memberBaseDao.insertMemberMarketingAgreeHist(po);
		}
		
		// 회원 테이블에 마케팅수신, 위치정보수신 여부 업데이트		
		po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
		result = memberBaseDao.updateMemberBaseTermsYn(po); 
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		insertMemberBaseHistory(po.getMbrNo());
		
		return result;
	}

	@Override
	public Integer getTagCntMember(Long mbrNo) {
		return memberBaseDao.getTagCntMember(mbrNo); 
	}

	@Override
	public PrsnCardBillingInfoVO getBillCardInfo(PrsnCardBillingInfoPO pcbipo) {

		return memberDao.getBillCardInfo(pcbipo);
	}

	@Override
	public void sendCertLms(Long mbrNo, String mobile,String ctfKey) {
		SsgMessageSendPO msg = new SsgMessageSendPO();
		msg.setFuserid(String.valueOf(mbrNo));

		PushSO pso = new PushSO();
		pso.setTmplNo(CommonConstants.MEMBER_CERT_TMPL_NO);
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
		String contents = StringUtil.replaceAll(pvo.getContents(),CommonConstants.PUSH_TMPL_VRBL_301,ctfKey); //템플릿 내용

		msg.setFmessage(contents);// 템플릿 내용 replace(데이터 바인딩)
		msg.setFdestine(mobile.replaceAll("-",""));
		msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
		msg.setMbrNo(mbrNo);
		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
		
		int result = bizService.sendMessage(msg);
		if(result == 0){
			log.error("##### FAILED SEND LMS");
		}
	}

	@Override
	public MemberBaseVO checkIsAlreadyCertification(MemberBaseSO so) {
		return Optional.ofNullable(memberBaseDao.checkIsAlreadyCertification(so)).orElseGet(()->new MemberBaseVO());
	}

	@Override
	public MemberLoginHistVO selectLoginHistory(Long mbrNo) {
		return memberLoginHistoryDao.selectLoginHistory(mbrNo); 
	}

	@Override
	public String updateMemberSession(framework.front.model.Session session, String deviceToken, String deviceTpCd) {
				
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		so.setPswd("pswd"); 
		MemberBaseVO vo = memberBaseDao.getMemberBase(so);
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String env = bizConfig.getProperty("envmt.gb");
		if(!StringUtil.isEmpty(session.getEnv()) && StringUtil.equals(env, session.getEnv())) {
			
			//로그인 회원 상태 체크
			if(vo == null || vo.getMbrNo() == null  ||(
					!StringUtil.isEmpty(session.getLoginId()) && StringUtil.equals(session.getLoginId(), bizService.twoWayDecrypt(vo.getLoginId()))
					&& !vo.getMbrStatCd().equals(FrontConstants.MBR_STAT_10) && !vo.getMbrStatCd().equals(FrontConstants.MBR_STAT_40))  ) { // 탈퇴인 경우 or 데이터 없는 경우
				SessionUtil.setAttribute(FrontConstants.SESSION_LOGIN_MBR_NO, session.getMbrNo());
				
				return "/logout?returnUrl=/indexLogin";
			}
			else {
				vo.setLoginPathCd(Optional.ofNullable(session.getLoginPathCd()).orElseGet(()->FrontConstants.LOGIN_PATH_ABOUTPET));
				
				// modify 2021.06.24 세션 업데이트 시 session에 keepYn이 있을 경우 vo에 keepYn 셋팅
				if(session.getKeepYn() != null && !"".equals(session.getKeepYn())) {
					vo.setKeepYn("Y");
				}
				
				if(!StringUtil.isEmpty(deviceToken) && !StringUtil.equals(deviceToken, "") && !StringUtil.isEmpty(deviceTpCd)) {
					vo.setDeviceToken(deviceToken);
					vo.setDeviceTpCd(deviceTpCd); 
					frontLoginService.saveLoginSession(vo, null);
				}else {
					frontLoginService.saveLoginSession(vo, "justSave"); 
				}
			}
		}else {
			SessionUtil.setAttribute(FrontConstants.SESSION_LOGIN_MBR_NO, session.getMbrNo());
			return "/logout?returnUrl=/indexLogin";
		}
		return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
	}
	
	

	@Override
	public void deletePrsnSavePayInfo(Long mbrNo){

		int result = memberDao.deletePrsnSavePayInfo(mbrNo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	@Override
	public int getDuplicateChcekWhenBlur(MemberBaseSO so) {
		return memberDao.getDuplicateChcekWhenBlur(so);
	}
	
	@Override
	public int emailUpdate(MemberBasePO po) {
		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setEmail(bizService.twoWayEncrypt(po.getEmail()));
		
		int result = memberBaseDao.emailUpdate(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		memberBaseDao.insertMemberBaseHistory(po);
		
		return result;
	}
	
	@Override
	public List<MemberBaseVO> memberPhoneList(MemberBaseSO so) {
		return memberDao.memberBasePhoneList(so);
	}

	@Override
	public int memberExistenceCheck(MemberBaseVO vo) {
		return memberDao.getMemberExistence(vo);
	}
}