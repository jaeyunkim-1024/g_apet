package front.web.view.join.controller;

import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.appweb.service.TermsService;
import biz.app.login.model.SnsMemberInfoSO;
import biz.app.login.service.FrontLoginService;
import biz.app.member.model.*;
import biz.app.member.service.MemberService;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.gsr.service.GsrService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.util.*;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Nullable;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.PrivateKey;
import java.util.*;

/**
 * <pre>
 * - 프로젝트명	: 31.front.web
 * - 패키지명	: front.web.view.join.controller
 * - 파일명		: JoinController.java
 * - 작성일		: 2016. 3. 2.
 * - 작성자		: snw
 * - 설명		: 회원가입 Controller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("join")
public class JoinController {

	//private static final String[] NAVIGATION_JOIN_CERTIFICATION = {"회원가입","본인인증"};
	private static final String[] NAVIGATION_JOIN_TERMS = {"회원가입","약관동의"};
	private static final String[] NAVIGATION_JOIN_INPUT = {"회원가입","회원정보입력"};
	private static final String[] NAVIGATION_JOIN_RESULT = {"회원가입","회원가입완료"};


	@Autowired private CacheService cacheService;

	@Autowired private MessageSourceAccessor message;

	@Autowired private MemberService memberService;

	@Autowired private Properties webConfig;

	@Autowired private BizService bizService;

	@Autowired private TermsService termsService;

	@Autowired private FrontLoginService frontLoginService;

	@Autowired private GsrService gsrService;

	//@Autowired private Properties bizConfig;
	
	@Autowired private TagService tagService;


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 18.
	 * - 작성자		: 이지희
	 * - 설명		: 약관동의 화면(신규회원가입 첫 화면 or sns로그인 기존회원 아닌 경우 정보입력 전)
	 * </pre>
	 * @param map
	 * @param view
	 * @param rcomCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexTerms")
	public String indexTerms(ModelMap map, ViewBase view, Session session, String rcomCode, String header){
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		//SessionUtil.removeAttribute(FrontConstants.SESSION_JOIN_MEMBER_CRTF); //본인인증 제거로 인한 주석처리
		
		//헤더의 '회원가입'을 통해서 들어온 경우 데이터 꼬임 방지 - sns회원가입이든 일반 회원가입이든 여기로 오기 떄문
		if(header != null && header.equals("Y")) {
			SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		}
		
		view.setNavigation(NAVIGATION_JOIN_TERMS);

		//약관조회 - GSR관련포함(신규회원가입, sns회원가입 CI있는경우) / GSR포함x(sns회원가입 CI없는 경우)
		List<TermsVO> termsList;

		String osType = "";
		if(view.getOs().equals(CommonConstants.DEVICE_TYPE))  {osType =  CommonConstants.POC_WEB;}
		else {osType=view.getOs();}

		TermsSO so = new TermsSO();
		so.setPocGbCd(osType);
		
		termsList = this.termsService.listTermsForMemberJoin(so);
		SnsMemberInfoSO snsInfo = (SnsMemberInfoSO) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		
		map.put("terms", termsList) ;

		//sns회원가입인지 기본정회원가입인지 구분
		if(snsInfo == null || snsInfo.getSnsUuid() == null) {
			snsInfo = new SnsMemberInfoSO();
		}
		map.put("snsInfo",snsInfo);
		map.put("view", view);
		map.put("session", session);

		//추천인 코드 들어온 경우
		if(rcomCode == null) {
			rcomCode = "";
		}
		
		String snsRcom = CookieSessionUtil.getCookie(FrontConstants.SESSION_INVITE_SNS);
		
		if(!(snsRcom == null || StringUtil.equals(snsRcom, ""))) {
			rcomCode = snsRcom;
		}
		
		map.put("rcomCode", rcomCode);

		return  TilesView.layout("join", new String[]{ "indexTerms"});
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명		: 회원정보입력 화면
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @param terms
	 * @param termsCheckYn
	 * @param snsYn
	 * @param authJson
	 * @param rcomCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexJoin")
	public String indexJoin(ModelMap map, ViewBase view, Session session,  TermsVO terms, String termsCheckYn,  String snsYn, String authJson, String rcomCode, HttpServletResponse response){
		//기본 정회원가입인 경우 : 약관동의, 본인인증 후 여기로 / sns회원가입인 경우 : 약관동의 후 여기로
		Cookie cookie = new Cookie(FrontConstants.SESSION_INVITE_SNS, null);
		cookie.setMaxAge(0);
		response.addCookie(cookie); 
	      
		log.debug("-===============indexJoin==============");
		view.setNavigation(NAVIGATION_JOIN_INPUT);

		String viewUrl =  TilesView.layout("join",new String[] { "indexJoin" });

		//약관동의가 없는경우
		if(termsCheckYn == null || !"Y".equals(termsCheckYn) )
		{
			view.setNavigation(NAVIGATION_JOIN_TERMS);
			map.put("view", view);
			return  TilesView.redirect(new String[]{"indexLogin"});
		}

		
		//sns회원가입 시
		if(snsYn!=null && snsYn.equals("Y") && SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO) != null )
		{
			SnsMemberInfoSO snsSo = (SnsMemberInfoSO)SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
			if(snsSo.getMobile() != null && !snsSo.getMobile().equals("")) 	{snsSo.setMobile(bizService.twoWayDecrypt(snsSo.getMobile()));}
			
			if(snsSo.getEmail() != null && !snsSo.getEmail().equals("")) {
				String decEmail = bizService.twoWayDecrypt(snsSo.getEmail());
				snsSo.setEmail(decEmail);
				if(!snsSo.getSnsLnkCd().equals(CommonConstants.SNS_LNK_CD_10)) {snsSo.setLoginId(decEmail);}  
				
			}
			if(snsSo.getMbrNm() !=null && !snsSo.getMbrNm().equals("")) 	{snsSo.setMbrNm(bizService.twoWayDecrypt(snsSo.getMbrNm()));}

			map.put("data", snsSo );
		}
		//else
		//{//일반 정회원 가입 시 - 인증된 정보를 바탕

			//MemberBasePO mb = new MemberBasePO();

			//인증정보 없는경우 로그인 메인페이지로 이동 
			/*if(authJson == null || "".equals(authJson) )
			{
				view.setNavigation(NAVIGATION_JOIN_TERMS);
				map.put("view", view);
				return  TilesView.redirect(new String[]{"indexLogin"});
			}

			String authJsonRpl =  StringEscapeUtils.unescapeXml(authJson);
			JSONObject auth = new JSONObject(authJsonRpl);
			String mbrNm = auth.getString("RSLT_NAME");
			String mobile = auth.getString("TEL_NO");

			SnsMemberInfoSO checkSo = new SnsMemberInfoSO();
			String mbrNmEnc = bizService.twoWayEncrypt(mbrNm);
			String mobileEnc = bizService.twoWayEncrypt(mobile);
			checkSo.setMobile(mobileEnc);
			checkSo.setMbrNm(mbrNmEnc);
			
			checkSo.setCiCtfVal(auth.getString("CI"));

			//기존회원이면 기존회원안내 화면으로 보내기
			MemberBaseVO exsMember =  memberService.getExistingMemberCheck(checkSo);
			if(exsMember != null && exsMember.getMbrNo() != null) {
				//임시! 
				exsMember.setLoginId(MaskingUtil.getId(bizService.twoWayDecrypt(exsMember.getLoginId())));
				SessionUtil.setAttribute("existMember", exsMember);
				return  TilesView.redirect(new String[] { "join","indexExistMember" });
			}

			mb.setMbrNm(mbrNm);
			mb.setMobile(mobile);
			String gender  = auth.getString("RSLT_SEX_CD");
			if(gender.equals("F")) {gender = "20";}
			else if(gender.equals("M")) {gender = "10";}
			mb.setGender(gender);
			mb.setBirth( auth.getString("RSLT_BIRTHDAY"));

			SessionUtil.setAttribute(FrontConstants.SESSION_JOIN_MEMBER_CRTF, auth); 
			log.debug("after auth  : {}",mb);
			map.put("data", mb);*/
		//}

		/*map.put("emailAddrCdList", this.cacheService.listCodeCache(CommonConstants.EMAIL_ADDR, null, null, null, null, null));*/
		map.put("view", view);
		map.put("session", session);
		String strTermsNo = terms.getTermsNos().replace("&quot;", "");
		map.put("termsNo", strTermsNo);
		map.put("pstInfoAgrYn", terms.getPstInfoAgrYn());
		map.put("mkngRcvYn", terms.getMkngRcvYn());
		map.put("snsYn", snsYn);
		map.put("rcomCode", rcomCode);

		return viewUrl;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 로그인 아이디 중복 체크
	 * </pre>
	 * @param loginId 암호화된 id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="getLoginIdDuplicate", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap getLoginIdDuplicate(@RequestParam String loginId){
		String resultCode = null;
		String resultMsg = null;

		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		boolean result = memberService.getMemberLoginIdDuplicate(stId, loginId);

		if(!result){
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			resultMsg = message.getMessage("front.web.class.join.login_id.duplicate.success");
		}else{
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
			resultMsg = message.getMessage("front.web.class.join.login_id.duplicate.fail");
		}

		ModelMap map = new ModelMap();

		map.put(CommonConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.put(CommonConstants.CONTROLLER_RESULT_MSG, resultMsg);

		return  map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 로그인 이메일 중복 체크
	 * </pre>
	 * @param email 암호화된 email
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="getLoginEmailDuplicate", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap getLoginEmailDuplicate(@RequestParam String email) {
		String resultCode = null;
		String resultMsg = null;

		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		//Long mbrNo = session.getMbrNo();
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setStId(stId);
		mbso.setEmail(email);
		boolean result = memberService.getMemberLoginDuplicate(mbso);

		if (!result) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			resultMsg = message.getMessage("front.web.class.join.login_email.duplicate.success");
		} else {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
			resultMsg = message.getMessage("front.web.class.join.login_email.duplicate.fail");
		}

		ModelMap map = new ModelMap();

		map.put(CommonConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.put(CommonConstants.CONTROLLER_RESULT_MSG, resultMsg);

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2017. 3. 20.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 로그인 휴대폰번호 중복 체크
	 * </pre>
	 * @param mobile 암호화된 휴대폰번호
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="getLoginMobileDuplicate", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap getLoginMobileDuplicate(@RequestParam String mobile) {
		String resultCode = null;
		String resultMsg = null;

		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		//Long mbrNo = session.getMbrNo();
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setStId(stId);
		mbso.setMobile(mobile.replace("-",  ""));
		boolean result = memberService.getMemberLoginDuplicate(mbso);

		if (!result) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			resultMsg = message.getMessage("front.web.class.join.login_mobile.duplicate.success");
		} else {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
			resultMsg = message.getMessage("front.web.class.join.login_mobile.duplicate.fail");
		}

		ModelMap map = new ModelMap();

		map.put(CommonConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.put(CommonConstants.CONTROLLER_RESULT_MSG, resultMsg);

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 가입 처리
	 * </pre>
	 * @param po
	 * @param apo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="insertMember", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap insertMember(MemberBasePO po, MemberAddressPO apo, HttpServletRequest request, @Nullable String test){
		ModelMap map = new ModelMap();
		if(!StringUtil.isEmpty(po.getMobile())) po.setMobile(po.getMobile().replace("-",  ""));
		po.setNickNm(po.getNickNm().replace(" ", ""));

		//아이디 중복 체크
		Map<String,Object> idDuplMap = getLoginIdDuplicate(bizService.twoWayEncrypt(po.getLoginId()));
		if(!idDuplMap.get(CommonConstants.CONTROLLER_RESULT_CODE).equals(CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS)) {
			map.put("returnCode", "duplicatedId");
			return map;
		}

		//닉네임 중복체크
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setStId( Long.valueOf(this.webConfig.getProperty("site.id")));
		mbso.setNickNm(po.getNickNm() );

		boolean nickNmDuplMap = memberService.getMemberLoginDuplicate(mbso);
		if(nickNmDuplMap) {
			map.put("returnCode", "duplicatedNickNm");
			return map;
		}
		
		//금지어체크
		TagBaseSO tagso = new TagBaseSO();
		List<TagBaseVO> taglist = tagService.unmatchedGrid(tagso);
		for(TagBaseVO banTag : taglist) {
			if(po.getLoginId().indexOf(banTag.getTagNm()) > -1) {
				map.put("returnCode", "banWord");
				return map;
			}
			if(po.getNickNm().indexOf(banTag.getTagNm()) > -1) {
				map.put("returnCode", "banWord");
				return map;
			}
			
		}
				
		//SNS로그인 시 회원여부 체크
		SnsMemberInfoSO snsSo = (SnsMemberInfoSO) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		if( SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO) != null ) {
			String snsEmail = snsSo.getEmail();
			
			if(snsSo.getSnsLnkCd().equals(CommonConstants.SNS_LNK_CD_40)) {
				po.setEmail(po.getLoginId()); 
				//암호화
				snsSo.setEmail(po.getEmail() != null?  bizService.twoWayEncrypt(po.getEmail()):null);
				//snsSo.setMbrNm(po.getMbrNm() != null?  bizService.twoWayEncrypt(po.getMbrNm()):null);
				//snsSo.setMobile(po.getMobile() != null?  bizService.twoWayEncrypt(po.getMobile()):null);
			}else {
				//암호화
				snsSo.setEmail(po.getEmail() != null?  bizService.twoWayEncrypt(po.getEmail()):null);
				snsSo.setMbrNm(po.getMbrNm() != null?  bizService.twoWayEncrypt(po.getMbrNm()):null);
				snsSo.setMobile(po.getMobile() != null?  bizService.twoWayEncrypt(po.getMobile()):null);
			}
				
				MemberBaseVO exsMember =  memberService.getExistingMemberCheck(snsSo);
				

				//sns정보일치하는 기존 일반회원이 있다면 계정연동
				if(exsMember != null && exsMember.getMbrNo() != null) {
					
					//계정연동 로그인 화면으로 이동.
					snsSo.setMbrNo(exsMember.getMbrNo());
					snsSo.setLoginId(bizService.twoWayDecrypt(exsMember.getLoginId()));
					snsSo.setEmail(snsEmail);
					SessionUtil.setAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO, snsSo);

					//복호화처리 
					/*if(snsSo.getMobile() != null && !snsSo.getMobile().equals("")) {bizService.twoWayDecrypt(snsSo.getMobile());}
					if(snsSo.getEmail() != null && !snsSo.getEmail().equals("")) 	{bizService.twoWayDecrypt(snsSo.getEmail());}
					if(snsSo.getMbrNm() !=null && !snsSo.getMbrNm().equals("")) 	{bizService.twoWayDecrypt(snsSo.getMbrNm());}*/

					map.put("returnCode", "connectSns");
					return map;
				}

			//}
		}else {
			//기존회원이면 기존회원안내 화면으로 보내기 - 다시 체크
			SnsMemberInfoSO checkSo = new SnsMemberInfoSO();
			//String mbrNmEnc = bizService.twoWayEncrypt(po.getMbrNm());
			String mobileEnc = bizService.twoWayEncrypt(po.getMobile());
			String emailEnc = bizService.twoWayEncrypt(po.getEmail());
			checkSo.setMobile(mobileEnc);
			//checkSo.setMbrNm(mbrNmEnc);
			checkSo.setEmail(emailEnc); //체크추가
			
			//checkSo.setCiCtfVal(auth.getString("CI"));
			MemberBaseVO exsMember =  memberService.getExistingMemberCheck(checkSo);
			if(exsMember != null && exsMember.getMbrNo() != null) {
				exsMember.setLoginId(MaskingUtil.getId(bizService.twoWayDecrypt(exsMember.getLoginId())));
				SessionUtil.setAttribute("existMember", exsMember);
				map.put("returnCode", "existMember");
				return map;
			}
		}

		//이메일 중복체크
		/*po.setEmail(po.getEmail() != null?  bizService.twoWayEncrypt(po.getEmail()):null);
		Map<String,Object> emailDuplMap = getLoginEmailDuplicate(po.getEmail());
		if(!emailDuplMap.get(FrontWebConstants.CONTROLLER_RESULT_CODE).equals(CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS)) {
			map.put("returnCode", "duplicatedEmail");
			return map;
		}
*/
		//추천인 등록 
		//추천인 url로 들어온 경우
		if(po.getRcomCode() != null && !po.getRcomCode().equals("")) {
			po.setRcomLoginId(po.getRcomCode());
		}
		
		
		if(po.getRcomLoginId() != null && !po.getRcomLoginId().equals(""))
		{ 
			MemberBaseSO rcomSo = new MemberBaseSO();
			rcomSo.setRcomLoginId(po.getRcomLoginId());
			//추천인 코드 체크
			String rcomCode = memberService.checkRcomLoginId(rcomSo);
			if(rcomCode != null) {
				po.setRcomLoginId(rcomCode);
			}
			else {
				map.put("returnCode", "notMatchRcomId");
				return map;
			}
		}
		
		po.setLoginId(po.getLoginId() != null?  bizService.twoWayEncrypt(po.getLoginId()):null);
		po.setUpdrIp(RequestUtil.getClientIp());

		String joinPathCd = "30";
		if(snsSo != null && (snsSo.getSnsLnkCd() != null || !StringUtil.equals(snsSo.getSnsLnkCd(), ""))){
			if(StringUtil.equals(snsSo.getSnsLnkCd(), CommonConstants.SNS_LNK_CD_10)){
				// 네이버 40
				joinPathCd = "40";
			}else if(StringUtil.equals(snsSo.getSnsLnkCd(), CommonConstants.SNS_LNK_CD_20)){
				// 카카오 70
				joinPathCd = "70";
			}else if(StringUtil.equals(snsSo.getSnsLnkCd(), CommonConstants.SNS_LNK_CD_30)){
				// 구글 60
				joinPathCd = "60";
			}else if(StringUtil.equals(snsSo.getSnsLnkCd(), CommonConstants.SNS_LNK_CD_40)){
				// 애플 50
				joinPathCd = "50";
			}
		}

		//insert 진행
		MemberBasePO finParamPO = this.memberService.insertMember(po, apo, joinPathCd);

		//이후에 쓸 내용 세션 다시 세팅 - snsYn, loginID, mbrNo
		Map<String,Object> memberMap = new HashMap<String, Object>();
		memberMap.put("snsYn", po.getSnsYn());
		memberMap.put("loginId", po.getLoginId());
		memberMap.put("mbrNo", finParamPO.getMbrNo());
		SessionUtil.setAttribute(FrontConstants.SESSION_JOIN_MEMBER_INFO, memberMap);

		SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);

		//로그인 처리위한 vo 미리 설정
		MemberBaseVO loginVo = new MemberBaseVO();
		loginVo.setMbrNo(po.getMbrNo());
		loginVo.setMbrNm(po.getMbrNm());
		loginVo.setLoginId(po.getLoginId());
		loginVo.setMbrGbCd(po.getMbrGbCd());
		loginVo.setMbrGrdCd(po.getMbrGrdCd());
		loginVo.setCtfYn(po.getCtfYn());
		loginVo.setNickNm(po.getNickNm());
		loginVo.setPrflImg(finParamPO.getPrflImg()); 
		loginVo.setInfoRcvYn(CommonConstants.USE_YN_Y); 
		if(po.getDeviceToken() != null && !po.getDeviceToken().equals("")) {
			loginVo.setDeviceToken(po.getDeviceToken());
			loginVo.setDeviceTpCd(po.getDeviceTpCd()); 
		}
		loginVo.setLoginPathCd(finParamPO.getLoginPathCd() == null ? CommonConstants.LOGIN_PATH_ABOUTPET : finParamPO.getLoginPathCd());

		/*//ci있는경우 gsr연동하기 (연동하고 정보 update-회원)
		if(finParamPO.getCiCtfVal() != null && !finParamPO.getCiCtfVal().equals("")) {
			MemberBaseVO gsVo = gsrService.saveGsrMember(finParamPO); //gsr에 회원여부 체크해서 insert
			//memberService.insertMemberBaseHistory(finParamPO.getMbrNo());	//이력 쌓기

			map.put("separateNotiMsg", gsVo.getSeparateNotiMsg());//gsr휴면해제 처리 알림
		}*/
		
		/* 회원기본이력 등록*/
		if(po.getDeviceToken() == null || po.getDeviceToken().equals("")) memberService.insertMemberBaseHistory(po.getMbrNo());

		//로그인 처리
		log.debug("insertMemberLogin : {}",loginVo); 
		if(test == null ) {frontLoginService.saveLoginSession(loginVo,null);}


		map.put("mbrNo", finParamPO.getMbrNo());
		map.put("returnCode", CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS);
		return map;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 가입 처리
	 * </pre>
	 * @param po
	 * @param po
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="insertMemberPrflInApp", method=RequestMethod.POST)
	@ResponseBody
	public String insertMemberPrflInApp(MemberBasePO po){
		log.debug("prflInsertApp : {}",po); 
		try {
			memberService.updateMemberBase(po);
			
			Session session = FrontSessionUtil.getSession();
			session.setPrflImg(po.getPrflImg()); 
			FrontSessionUtil.setSession(session); 
			
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//log.error(e.getMessage());
			log.error("insertMemberPrflInApp exception!", e.getClass());
			return "";
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 회원가입완료 화면
	 * </pre>
	 * @param map
	 * @param isPBHR
	 * @param view
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexResult")
	public String indexResult(ModelMap map, String isPBHR, ViewBase view, Session session){

		SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);

		view.setNavigation(NAVIGATION_JOIN_RESULT);

		String viewUrl = "";

		//sns회원가입 아닌경우는 로그인 처리!

		view.setNavigation(NAVIGATION_JOIN_TERMS);
		map.put("view", view);
		map.put("session", session);
		
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		map.put("joinPath", memberService.getMemberBase(so).getJoinPathCd());
		
		if(isPBHR != null ) {map.put("isPBHR", isPBHR);}
		viewUrl = TilesView.layout("join",new String[] { "indexResult" });

		return viewUrl;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 21.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 본인인증 후 이미 있는 회원 정보면 기존회원안내
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexExistMember")
	public String indexExistMember(ModelMap map, ViewBase view, Session session) {
		map.put("view", view);
		map.put("session", session);
		map.put("existMember", SessionUtil.getAttribute("existMember"));
		SessionUtil.removeAttribute("existMember");
		return  TilesView.layout("join",new String[] { "indexExistMember" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 18.
	 * - 작성자		: 이지희
	 * - 설명		: sns회원이 기존회원 정보와 일치할 경우 연동하는 화면
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="connectSns")
	public String connectSns(ModelMap map,ViewBase view, Session session) {
		map.put("view", view);
		map.put("session", session);
		SnsMemberInfoSO sns = (SnsMemberInfoSO) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		//sns.setLoginId(MaskingUtil.getId(sns.getLoginId())); 
		map.put("snsLnkCd", sns.getSnsLnkCd() ) ;
		map.put("maskingId", MaskingUtil.getId(sns.getLoginId()) ) ;
		if(SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL)!=null) {
			map.put("returnUrl", SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL));
			SessionUtil.removeAttribute(FrontConstants.SESSION_LOGIN_RETURN_URL); 
		}
		
		//for decrypt password in script
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		map.put("RSAModulus", publKeyMap.get("RSAModulus"));
		map.put("RSAExponent", publKeyMap.get("RSAExponent"));
		
		
		return  TilesView.layout("join",new String[] { "connectSns" });
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명		: sns계정을 기존회원 계정으로 연동
	 * </pre>
	 * @param po
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="connectSnsMember", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap connectSnsMember(MemberBaseVO po){

		SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_CONNECT_DORMANT); 
		ModelMap map = new ModelMap();
		String resultCode = "";
		String resultMsg = "";
		
		//복호화
		PrivateKey privateKey = (PrivateKey)SessionUtil.getAttribute("_RSA_WEB_KEY_");
		if(privateKey == null) {
			map.addAttribute(CommonConstants.CONTROLLER_RESULT_CODE, "keyError");
			return map;
		}
		String uid = RSAUtil.decryptRas(privateKey, po.getLoginId());
		String pwd = RSAUtil.decryptRas(privateKey, po.getPswd());
		po.setLoginId(uid);
		po.setPswd(pwd); 
		
		SnsMemberInfoSO sns = (SnsMemberInfoSO) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		//미리 세션에 저장해둔 어바웃펫 계정과 아이디 다르다면 return
		if(sns.getLoginId() != null && sns.getLoginId().equals(po.getLoginId())) {

			//계정 유효성 체크 & 로그인
			po.setLoginPathCd(sns.getSnsLnkCd());
			Map<String, Object> result = this.frontLoginService.checkLogin(po);

			resultCode = result.get("exCode") == null ? null : String.valueOf(result.get("exCode"));

			sns.setMbrNo(Long.parseLong(result.get("mbrNo").toString()));
			sns.setSnsJoinYn("N");
			sns.setSnsStatCd(CommonConstants.SNS_STAT_10);
			sns.setSysRegrNo(sns.getMbrNo());

			map.addAttribute("mbrNo", result.get("mbrNo"));
			
			if(StringUtil.isNotBlank(resultCode) && !StringUtil.equals( ExceptionConstants.ERROR_CODE_LOGIN_DUPLICATE_PHONE, resultCode)) { //유효성 체크 걸린 경우
				resultMsg = message.getMessage("business.exception." + resultCode);
				if(StringUtil.equals(resultCode, ExceptionConstants.ERROR_CODE_LOGIN_SLEEP)) {
					SessionUtil.setAttribute(FrontConstants.SESSION_SNS_CONNECT_DORMANT, sns); 
				}
			} else {
				String resultCodeDup = resultCode;
				//SnsMemberInfoSO so = (SnsMemberInfoSO) SessionUtil.getAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
				if(result.get("mbrNo") != null) {

					//sns 정보 insert
					int insertResult = memberService.insertSnsMemberInfo(sns);
					if(insertResult > 0 ) {
						//resultCode = AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS;
						SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
						map.addAttribute("snsStatCd",sns.getSnsStatCd());
					}

					//하루 펫츠비 기존 회원인데 최초 로그인인 경우
					if(result.get("PBHR") != null) {
						resultCode = "PBHR";
					}
					else
					{ //성공인 경우
						resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
						//가입정보 추가
						map.addAttribute(CommonConstants.JOIN_PATH , result.get(CommonConstants.JOIN_PATH));
						//태그정보 없다면 태그 선택 페이지로
						if(result.get("tags") != null && result.get("tags").equals("no_tag")) {
							map.addAttribute("tags",result.get("tags"));
						}
						//펫로그 회원정보
						map.addAttribute("petLog", result.get("petLog")); 
					}

				}
				
				//중복인 경우
				if(StringUtil.equals( ExceptionConstants.ERROR_CODE_LOGIN_DUPLICATE_PHONE, resultCodeDup)) {
					resultCode = resultCodeDup;
					resultMsg = message.getMessage("business.exception." + resultCodeDup);
				}
			}
			log.debug(">>>>>>>>>결과="+resultCode);


		}else {
			//아이디 틀리면
			resultCode = "notMatch";
		}
		map.addAttribute(CommonConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.addAttribute(CommonConstants.CONTROLLER_RESULT_MSG, resultMsg);
		return map;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 시 관심태그 입력화면
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexTag")
	public String indexTag(ModelMap map,ViewBase view, Session session, String returnUrl, @Nullable String isPBHR) {
		
		Integer tagCnt =  memberService.getTagCntMember(session.getMbrNo());
		if(tagCnt != null && tagCnt > 0 ) {
			session.setTagYn("Y");
			FrontSessionUtil.setSession(session);
			
			log.debug("tagSessionCheck : {}",FrontSessionUtil.getSession()); 
			return "redirect:/";
		}
		
		map.put("view", view);
		map.put("returnUrl", returnUrl);
		if(isPBHR != null) {map.put("isPBHR", isPBHR);}
		map.put("tagList", cacheService.listCodeCache(CommonConstants.INT_TAG_INFO_CD, true, null, null, null, null, null));

		return  TilesView.layout("join",new String[] { "indexTag" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: JoinController.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 시 관심태그 매핑하기
	 * </pre>
	 * @param tagArray
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="insertTagInfo", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap insertTagInfo(@RequestParam String tagArray, Session session){
		ModelMap model = new ModelMap();
		log.debug("############ : "+tagArray);

		Map<String,Object> map = (HashMap<String, Object>) SessionUtil.getAttribute(FrontConstants.SESSION_JOIN_MEMBER_INFO);
		Long mbrNo;
		//회원가입시 말고도 로그인 시에도 태그 정보 없으면 태그 저장해야해서 아래 추가 210205 leejh
		if(map ==null || map.get("mbrNo") == null) {
			//Session session = FrontSessionUtil.getSession();
			mbrNo = session.getMbrNo();
		}else {
			mbrNo = Long.parseLong(map.get("mbrNo").toString());
		}
		SessionUtil.removeAttribute(FrontConstants.SESSION_JOIN_MEMBER_INFO);

		List<MbrTagMapPO> list = new ArrayList<>();
		String[] tags = tagArray.split(",");
		for(String tag : tags) {
			MbrTagMapPO po = new MbrTagMapPO();
			po.setTagNo(tag);
			po.setMbrNo(mbrNo);
			po.setSysRegrNo(mbrNo);
			po.setSysUpdrNo(mbrNo);
			list.add(po);
		}

		int result = memberService.insertMbrTagMap(list);
		if(result > 0) {
			model.put("mbrNo", mbrNo);
			model.put(CommonConstants.CONTROLLER_RESULT_CODE, CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS);
			session.setTagYn("Y"); 
			FrontSessionUtil.setSession(session); 
		}else {
			model.put(CommonConstants.CONTROLLER_RESULT_CODE, CommonConstants.CONTROLLER_RESULT_CODE_FAIL);
		}

		return model;
	}

	@RequestMapping(value="insertTestFoData")
	public String insertTestFoData(HttpServletRequest request, String count) {
		//LOAD_FO_0001 ~ LOAD_BO_2000
		for(int i = 0 ; i<Integer.parseInt(count) ; i++) {
			String idCnt = String.format("%04d", i+1);
			String loginId = "LOAD_FO_"+idCnt;
			
			MemberBasePO po = new MemberBasePO();
			po.setMbrNm("TEST계정");
			po.setNickNm(loginId);
			po.setLoginId(loginId);
			po.setBirth("20000101");
			po.setGdGbCd("20");
			po.setJoinEnvCd("PC");
			
			String mobile = "0100000"+idCnt;
			po.setMobile(mobile);
			po.setEmail("test"+i+"@test.test"); 
			po.setPswd("admin12#$");
			po.setSnsYn("N");
			po.setMkngRcvYn("Y");
			po.setDeviceTpCd("DEVICE_TYPE");
			po.setTermsNo("[{termsNo:50,rcvYn:Y},{termsNo:48,rcvYn:Y},{termsNo:46,rcvYn:Y},{termsNo:40,rcvYn:Y},{termsNo:44,rcvYn:Y},{termsNo:42,rcvYn:Y},{termsNo:22,rcvYn:Y},{termsNo:18,rcvYn:Y},{termsNo:19,rcvYn:Y},{termsNo:24,rcvYn:Y}]");
			
			MemberAddressPO apo = new MemberAddressPO();
			apo.setMobile(mobile);
			apo.setPrclAddr("서울특별시 광진구 화양동 31-5");
			apo.setRoadAddr("서울특별시 광진구 화양동 31-5");
			apo.setRoadDtlAddr("101호");
			apo.setPostNoNew("05013");
			
			insertMember(po, apo, request , "test" );
		}
		return "/indexLogin";
	}
}