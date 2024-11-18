package front.web.view.mypage.controller;

import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.SeoService;
import biz.app.login.model.SnsMemberInfoPO;
import biz.app.login.service.FrontLoginService;
import biz.app.member.model.*;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberService;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.nice.model.NiceCertifyDataVO;
import biz.interfaces.nice.model.NiceCertifyVO;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.*;
import framework.common.util.security.PBKDF2PasswordEncoder;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.util.ImagePathUtil;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;

import java.security.PrivateKey;
import java.util.*;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-31-front
 * - 패키지명	: front.web.view.mypage.controller
 * - 파일명		: MyInfoController.java
 * - 작성일		: 2016. 3. 2.
 * - 작성자		: snw
 * - 설명		: 나의 회원정보 Controller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("mypage/info")
public class MyInfoController {

	@Autowired private CacheService cacheService;

	@Autowired private MessageSourceAccessor message;

	@Autowired private MemberService memberService;

	@Autowired private MemberAddressService memberAddressService;

	@Autowired private TagService tagService;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private Properties webConfig;

	@Autowired private PBKDF2PasswordEncoder passwordEncoder;

	@Autowired	private BizService bizService;

	@Autowired	private FrontLoginService frontLoginService;
	
	@Autowired private NhnShortUrlUtil nhnShortUrlUtil;
	
	@Autowired private SeoService seoService;

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 정보 관리 - 비밀번호 확인
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value="indexManageCheck" , method={RequestMethod.GET , RequestMethod.POST})
	public String indexManageCheck(Model model, Session session, ViewBase view,String returnUrl,String redirectUrl) {
		// 비밀번호 여부 확인 후, 없으면 비밀번호 설정 페이지로 . 있으면 비밀번호 확인 페이지로
		String pswdCheck = memberService.isPswdForUpdate(session.getMbrNo());
		if(pswdCheck == null || pswdCheck.equals("")) {
			
			redirectUrl = Optional.ofNullable(redirectUrl).orElseGet(()->"/indexManageDetail");
			return TilesView.redirect(new String[]{"mypage","info","indexPswdSet?returnUrl="+redirectUrl});
		}else {
			redirectUrl = Optional.ofNullable(redirectUrl).orElseGet(()->"indexManageDetail");
			
			view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
			model.addAttribute("session", session);
			model.addAttribute("view", view);
			model.addAttribute(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_INFO_MANAGE);
			model.addAttribute("returnUrl",returnUrl);
			model.addAttribute("redirectUrl",redirectUrl);
			
			Map<String,String> publKeyMap = RSAUtil.createPublicKey();
			model.addAttribute("RSAModulus", publKeyMap.get("RSAModulus"));
			model.addAttribute("RSAExponent", publKeyMap.get("RSAExponent"));
			
			return TilesView.mypage(new String[] { "info", "indexManageCheck" });
		}
	}


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 정보 관리 - 비밀번호 확인
	 * </pre>
	* @param session
	* @param pswd
	* @param type
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@ResponseBody
	@RequestMapping(value="checkMemberPassword", method=RequestMethod.POST)
	public ModelMap checkMemberPassword(Session session, String pswd) {
		String resultCode = null;
		String type = FrontWebConstants.PSWD_CHECK_TYPE_INFO;
		ModelMap map = new ModelMap();
		
		PrivateKey privateKey = (PrivateKey)SessionUtil.getAttribute("_RSA_WEB_KEY_");
		if(privateKey == null) {
			map.addAttribute(FrontConstants.CONTROLLER_RESULT_CODE, "keyError");
			return map;
		}
		
		pswd = RSAUtil.decryptRas(privateKey, pswd);
		
		resultCode = memberService.checkMemberPassword(session.getMbrNo(), pswd) ? FrontWebConstants.CONTROLLER_RESULT_CODE_SUCCESS : FrontWebConstants.CONTROLLER_RESULT_CODE_FAIL;
		// 성공시 세션에 비밀번호 체크 시각 설정
		if(FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS.equals(resultCode)) {
			SessionUtil.setSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO, System.currentTimeMillis());
		}
		String checkCode = makeMyInfoCode(session, type);
		map.put("type",type);
		map.put("checkCode", checkCode);
		map.put(FrontWebConstants.CONTROLLER_RESULT_CODE, resultCode);
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 정보 관리 - 회원정보 변경 ( url 직접 치고 들어올 시 )
	 * </pre>
	 * @param session
	 * @param Model
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="indexManageDetail" , method=RequestMethod.GET)
	public String indexManageDetail(Model model, Session session, ViewBase view, String returnUrl){
		returnUrl = Optional.ofNullable(returnUrl).orElseGet(()->"/");
		model.addAttribute("checkCode",Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString());
		return indexManageCheck(model,session,view,returnUrl,"/mypage/info/indexManageDetail");
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 회원정보 관리 상세 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param checkCode
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="indexManageDetail" , method=RequestMethod.POST)
	public String indexManageDetail(Model model, Session session, ViewBase view, String checkCode, String type,HttpServletRequest request) {
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		//비밀번호 체크 확인 (10초 이내 값만 성공)
		Long pswdCheckedDtm = (Long) SessionUtil.getSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO);
		Long nowDtm =System.currentTimeMillis();
		SessionUtil.removeSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO);
		if( pswdCheckedDtm == null || (nowDtm - pswdCheckedDtm) > 10000 ) {
			return "redirect:/mypage/info/indexManageDetail";
		}
		
		String newCheckCode = "";
		
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
	    if(flashMap != null){
	    	checkCode= flashMap.get("checkCode").toString();
	    	type= flashMap.get("type").toString();
	    }
	    
		
		String connectCheckCode = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_CHECK_CODE)).orElseGet(()->"").toString();
		if(StringUtil.isEmpty(connectCheckCode)){
			if(StringUtil.isEmpty(type) || StringUtil.isEmpty(checkCode)){
				return indexManageCheck(model,session,view,"/tv/home",request.getRequestURI());
			}
			newCheckCode = makeMyInfoCode(session, type);
			if(!StringUtil.equals(newCheckCode,checkCode)){
				return indexManageCheck(model,session,view,"/tv/home",request.getRequestURI());
			}
		}

		//회원 정보
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setMbrNo(session.getMbrNo());
		MemberBaseVO member =  memberService.getMemberBase(mbso);
		String prflImg = Optional.ofNullable(member.getPrflImg()).orElseGet(()->"");
		model.addAttribute("prflNm",StringUtil.isEmpty(prflImg) ? "" : prflImg.replace(FrontConstants.MBR_IMG_PATH + FileUtil.SEPARATOR + session.getMbrNo() + FileUtil.SEPARATOR,""));
		member = memberService.decryptMemberBase(member);
		String email = Optional.ofNullable(member.getEmail()).orElseGet(()->"");
		if(StringUtil.isNotEmpty(email)){
			String[] emailInfo = member.getEmail().split("@");
			member.setEmailId(emailInfo[0]);
			member.setEmailAddr(emailInfo[1]);
		}

		//회원 주소지 정보
		/*MemberAddressVO addr = memberAddressService.getMemberAddressDefault(session.getMbrNo());
		model.addAttribute("addr",addr);*/

		//회원 태그
		model.addAttribute("memberTags", Optional.ofNullable(member.getTags()).orElseGet(()->""));
		//관심 태그
		model.addAttribute("interestTag",cacheService.listCodeCache(CommonConstants.INT_TAG_INFO_CD, true, null, null, null, null, null));
		//로그인 경로
		model.addAttribute("loginPathCdNm",cacheService.getCodeName(FrontConstants.LOGIN_PATH_CD,session.getLoginPathCd()));

		//소셜 로그인 연동 확인
		model.addAttribute("session", session);
		model.addAttribute("snsInfo",memberService.getMemberSnsLoginYn(session.getMbrNo()));
		model.addAttribute("mbrNo",member.getMbrNo());
		model.addAttribute("view", view);
		model.addAttribute("vo", member);
		model.addAttribute("type",type);
		model.addAttribute("checkCode",checkCode);
		model.addAttribute(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_INFO_MANAGE);
		
		//sns 연동 후, 들어올 때
		String connectSnsLnkCd = Optional.ofNullable(SessionUtil.getAttribute(FrontWebConstants.SESSION_SNS_LNK_CD_KEY)).orElseGet(()->"").toString();
		if(StringUtil.isNotEmpty(connectSnsLnkCd)){
			model.addAttribute(FrontWebConstants.SESSION_SNS_LNK_CD_KEY,connectSnsLnkCd);
			String[] sessionKey = new String[]{FrontWebConstants.SESSION_CHECK_CODE,FrontWebConstants.SESSION_SNS_LNK_CD_KEY,FrontWebConstants.SESSION_SNS_CONNECT_MEMBER};
			for(String key : sessionKey){
				try{
					SessionUtil.removeAttribute(key);
				}catch(NullPointerException npe){}
			}
		}
		return TilesView.mypage(new String[] { "info", "indexManageDetail" });
	}

	@RequestMapping(value="/sns-connect" , method = RequestMethod.GET)
	public String snsConnectList(Session session,Model model){
		model.addAttribute("snsInfo",memberService.getMemberSnsLoginYn(session.getMbrNo()));
		model.addAttribute("mbrNo",session.getMbrNo());
		return TilesView.mypage(new String[] { "info", "indexSnsConnectList" });
	}

	@ResponseBody
	@RequestMapping(value="/ci-check" , method = RequestMethod.POST)
	public Map<String,String> ciCheck(String ciCtfVal,String mbrNm){
		Long mbrNo = FrontSessionUtil.getSession().getMbrNo();
		Map<String,String> result = new HashMap<String,String>();
		MemberBaseSO orgSo = new MemberBaseSO();
		orgSo.setMbrNo(mbrNo);
		MemberBaseVO org = memberService.getMemberBase(orgSo);
		String mbrGbCd = org.getMbrGbCd();

		String orgCiCtfVal = Optional.ofNullable(org.getCiCtfVal()).orElseGet(()->"");

		try{
			//CASE 1 :준회원 일 때 , 이전에 연동한 회원이  존재 -> 알림 띄우고, 인증 한 회원으로 로그인 하라는 alert 노출
			if(StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_20)){
				MemberBaseSO so = new MemberBaseSO();
				so.setMbrNo(mbrNo);
				so.setCiCtfVal(ciCtfVal);
				so.setMbrGbCd(FrontConstants.MBR_GB_CD_10);
				MemberBaseVO orgVo = memberService.checkIsAlreadyCertification(so);
				String orgMbrNm = Optional.ofNullable(orgVo.getMbrNm()).orElseGet(()->"");
				String orgLoginId = Optional.ofNullable(orgVo.getLoginId()).orElseGet(()->"");
				if(StringUtil.isNotEmpty(orgLoginId) && StringUtil.isNotEmpty(orgMbrNm)){
					String orgLoginId_dec = bizService.twoWayDecrypt(orgLoginId);
					String orgLoginId_dec_masking = MaskingUtil.getId(orgLoginId_dec);

					String orgMbrNm_dec = bizService.twoWayDecrypt(orgMbrNm);
					String orgMbrNm_dec_masking = MaskingUtil.getName(orgMbrNm_dec);
					throw new CustomException(ExceptionConstants.ERROR_IS_ALREADY_INTEGRATE_MSG,new String[]{orgMbrNm_dec_masking,orgLoginId_dec_masking});
				}
			}

			//CASE 2 : 기존에 인증한 CI 값 존재 시, MEMBER_BASE 의 CI값과 비교
			if(StringUtil.isNotEmpty(orgCiCtfVal) && !StringUtil.equals(ciCtfVal,orgCiCtfVal)){
				//회원과 휴대폰 명의가 동일해야 이용이 가능합니다.
				throw new CustomException(ExceptionConstants.ERROR_MEMBER_NOT_EQUAL_MBR_NM);
			}


			String encEmail = org.getEmail();
			String decEmail = bizService.twoWayDecrypt(encEmail);

			result.put("mkngRcvYn",org.getMkngRcvYn());
			result.put("resultCode",FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS);
			result.put("email",decEmail);
		}catch(CustomException cep){
			result.put("resultCode",cep.getExCode());
			if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_IS_ALREADY_INTEGRATE_MSG)){
				result.put("resultMsg",message.getMessage("business.exception."+cep.getExCode(),cep.getParams()));
			}else{
				result.put("resultMsg",message.getMessage("business.exception."+cep.getExCode()));
			}
		}
		return result;
	}
	
	
	//2021.04.29 -> 내 정보 관리 -> 복사하기 시, 링크 아닌 초대코드로 변경
	//사용 안함 , 다른곳에서 쓰일 있기에 컨트롤러는 살려놓음.
	@ResponseBody
	@RequestMapping(value="/getLinkShortUrl",method=RequestMethod.GET)
	public String getLinkShortUrl(String rcomCd){
		String rcomUrl = "";
		try{
			Long mbrNo = FrontSessionUtil.getSession().getMbrNo();
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(mbrNo);
			MemberBaseVO member = memberService.getMemberBase(so);
			rcomUrl = nhnShortUrlUtil.getInviteUrl(rcomCd,null);

			MemberBasePO po = new MemberBasePO();
			po.setRcomUrl(rcomUrl);
			po.setMbrNo(mbrNo);
			memberService.updateRcomUrl(po);
		}catch(Exception e){
			log.error(e.getMessage());
		}

		return rcomUrl;
	}

	@ResponseBody
	@RequestMapping(value="/getNickNmInJoin",method = RequestMethod.GET)
	public String getNickNmInJoin(){
		Long mbrNo = FrontSessionUtil.getSession().getMbrNo();
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(mbrNo);
		return memberService.getMemberBaseNickNmInJoin(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 02. 21.
	 * - 작성자		: 김재윤
	 * - 설명		: 회원 정보 수정
	 * </pre>
	 * @param session
	 * @param po
	 * @param emailId
	 * @param emailAddr
	 * @param pswd
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="updateMemberInfo", method=RequestMethod.POST)
	@ResponseBody
	public Map updateMemberInfo(MemberBasePO po, String[] memberTags,ViewBase view) {
		Session session = FrontSessionUtil.getSession();
		Map<String,String> resultMap = new HashMap<String,String>();
		String resultMsg = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		String uploadImgPath = "";
		Long mbrNo = session.getMbrNo();
		/*apo.setMbrNo(mbrNo);
		apo.setSysUpdrNo(mbrNo);*/
		po.setMbrNo(mbrNo);
		po.setSysUpdrNo(mbrNo);

		try{
			//파일 확장자
			String prflImg = Optional.ofNullable(po.getPrflImg()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(prflImg)){
				String fileExe = FilenameUtils.getExtension(prflImg);
				if(fileExe.toLowerCase().indexOf("gif")>-1){
					throw new CustomException(ExceptionConstants.ERROR_MEMBER_IN_VALID_PRFL_IMG);
				}
			}

			po.setDeviceGb(view.getDeviceGb());
			memberTags = Optional.ofNullable(memberTags).orElseGet(()->new String[]{});
			MemberBaseVO m = memberService.updateMemberInfo(po,memberTags);
			uploadImgPath = m.getPrflImg();

			session.setPrflImg(Optional.ofNullable(uploadImgPath).orElseGet(()->po.getOrgPrflImg()));
			session.setNickNm(po.getNickNm());
			FrontSessionUtil.setSession(session);
		}catch(CustomException cep){
			log.error("###### updateMemberInfo Fail #####");
			resultMsg = message.getMessage("business.exception."+cep.getExCode());
			resultMap.put("resultCode",cep.getExCode());
		}

		resultMap.put("resultMsg",resultMsg);
		resultMap.put("uploadImgPath",uploadImgPath);
		return resultMap;
	}

	@LoginCheck
	@RequestMapping(value="onFileUploadCallBack", method=RequestMethod.POST)
	@ResponseBody
	public String onFileUploadCallBack(String prflImg,String fileExe){
		if(fileExe.toLowerCase().indexOf("gif")>-1){
			return message.getMessage("business.exception."+ExceptionConstants.ERROR_MEMBER_IN_VALID_PRFL_IMG);
		}
		String resultMsg = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		Session session = FrontSessionUtil.getSession();
		Long mbrNo = session.getMbrNo();
		MemberBasePO po = new MemberBasePO();
		po.setPrflImg(prflImg);
		po.setMbrNo(mbrNo);
		try{
			memberService.updateMemberBase(po);
			session.setMbrNo(mbrNo);
			session.setPrflImg(prflImg);
			FrontSessionUtil.setSession(session);
		}catch(CustomException cep){
			resultMsg = message.getMessage("business.exception."+cep.getExCode());
		}
		return resultMsg;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: 김재윤
	 * - 설명		: 회원탈퇴 안내 화면
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="indexLeaveGuide" , method=RequestMethod.POST)
	public String indexLeaveGuidePost(Model model, Session session, ViewBase view,String checkCode) {
		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("mbrLevRsnCd",cacheService.listCodeCache(FrontConstants.MBR_LEV_RSN,true,null,null,null,null,null));
		model.addAttribute("checkCode",checkCode);
		model.addAttribute("type",FrontWebConstants.PSWD_CHECK_TYPE_INFO);
		model.addAttribute("mbrLevRsnCdList",cacheService.listCodeCache(FrontConstants.MBR_LEV_RSN,true,null,null,null,null,null));
		model.addAttribute("view",view);
		model.addAttribute("session",session);
		return TilesView.mypage(new String[] { "info", "indexLeaveGuide" });
	}
	@LoginCheck
	@RequestMapping(value="indexLeaveGuide" , method=RequestMethod.GET)
	public String indexLeaveGuideGet(Model model, Session session, ViewBase view) {
		return indexManageCheck(model,session,view,"/mypage/info/indexManageDetail","/mypage/info/indexLeaveGuide");
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2016. 5. 17.
	 * - 작성자		: jangjy
	 * - 설명		: 회원탈퇴 신청
	 * </pre>
	 * @param session
	 * @param mbrLevRsnCd : 회원 탈퇴 사유 코드
	 * @param mbrLevContent : 회원 탈퇴 내용
	 * @return
	 */
	@LoginCheck
	@ResponseBody
	@RequestMapping(value="deleteMember", method=RequestMethod.POST)
	public Map deleteMember(MemberBasePO po , String checkCode,Session session) {
		String resultCode = null;
		String resultMsg = null;
		String mbrLevRsnCd = Optional.ofNullable(po.getMbrLevRsnCd()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT));
		String mbrLevContent = Optional.ofNullable(po.getMbrLevContent()).orElseGet(()->"");

		/**
		 * 탈퇴 금지 조건
		 * - 배송 중인 주문 건 존재한 경우
		 * - 회수 중인 주문 건 존재한 경우
		 * - 환불대기 중인 주문 건 존재한 경우
		 * - 교환 중인 주문 건 존재한 경우
		 */
		resultMsg = this.memberService.checkMemberLeave(session.getMbrNo());

		if (StringUtil.isEmpty(resultMsg)) {
			/**
			 * 회원의 탈퇴
			 * - 회원탈퇴 시 회원기본의 회원번호, 상태(탈퇴) 로그인 아이디만 남기고 다른정보는 전부 삭제한다.
			 * - 삭제대상 테이블 : 회원기본(가 항목 제외), 회원배송지, 회원등급이력, 회원등급포인트이력, 회원적립금, 회원쿠폰, 회원관심상품, 회원로그인이력, 회원예치금, 회원예치금요청
			 */
			po.setMbrNo(session.getMbrNo());
			po.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
			memberService.deleteMember(po);
			//이력 등록
			//memberService.insertMemberBaseHistory(session.getMbrNo());

			//세션 삭제
			FrontSessionUtil.removeSession();
			resultCode = FrontWebConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		} else {
			resultCode = FrontWebConstants.CONTROLLER_RESULT_CODE_FAIL;
		}

		Map<String,String> map = new HashMap<String,String>();
		map.put(FrontWebConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.put(FrontWebConstants.CONTROLLER_RESULT_MSG, resultMsg);

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 비밀번호를 거쳐서 들어가는 루트에 대한 체크 코드 생성
	 * </pre>
	 * @param session
	 * @param type
	 * @return
	 * @throws Exception
	 */
	private String makeMyInfoCode(Session session, String type){
		try {
			return CryptoUtil.encryptMD5(session.getSessionId() + String.valueOf(session.getMbrNo().intValue()) + type);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2016. 7. 13.
	 * - 작성자		: jangjy
	 * - 설명		: 회원인증 레이어 팝업 호출
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @return
	 */
	@RequestMapping(value="popupCertification")
	public String popupCertification(ModelMap map, ViewBase view, Session session) {

		view.setTitle(message.getMessage("front.web.view.member.certification.popup.title"));
		map.put("view", view);

		return TilesView.popup(new String[] { "mypage", "info", "popupCertification" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2016. 7. 13.
	 * - 작성자		: jangjy
	 * - 설명		: 회원인증하기
	 * </pre>
	 * @param session
	 * @param so
	 * @param po
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="memberCertification", method=RequestMethod.POST)
	public ModelMap memberCertification(Session session, NiceCertifyVO certify) {

		String resultCode = null;
		String resultMsg = null;

		NiceCertifyDataVO data = null;

//		if ("10".equals(certify.getAuthType())) {
//			data = niceIpinService.getCertifyData(certify.getEncData(), certify.getParamR1(), certify.getParamR2(),
//					certify.getParamR3(), session.getSessionId());
//		} else {
//			data = niceCheckPlusService.getCertifyData(certify.getEncData(), certify.getParamR1(), certify.getParamR2(),
//					certify.getParamR3(), session.getSessionId());
//		}

		// 체크 결과 코드
		if (data.isRtnCode()) {
			// 회원 인증코드 중복 체크 true:중복됨, false:중복되지 않음
			Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
			/*if (memberService.getMemberCertifyCdDuplicate(stId, data.getDupInfo())) {
				throw new CustomException(ExceptionConstants.ERROR_MEMBER_DUPLICATION_FAIL);

			} else {*/  //==============210201 이거 쓰는 분들 있으시면 위에 주석처리한 CI값 중복 체크해야하는지 체크하고 수정해서 사용할 것!!아래도 쿼리 수정해야함.
			// 회원정보 업데이트
			MemberBasePO po = new MemberBasePO();
			po.setMbrNo(session.getMbrNo());
			po.setCtfCd(data.getDupInfo()); 		// 인증 코드
			po.setCtfMtdCd(data.getAuthType()); 	// 인증 방법 코드
			po.setCtfReqNo(data.getReqNo()); 		// 인증 요청 번호
			po.setMbrNm(data.getName()); 			// 인증 고객 실명
			po.setGdGbCd(data.getGenderCode());		// 성별코드(0:여성, 1:남성)
			po.setBirth(data.getBirthDate()); 		// 생년월일(YYYYMMDD)
			po.setNtnGbCd(data.getNationalInfo()); 	// 국적정보(0:내국인, 1:외국인)

			this.memberService.updateMemberCertification(po);


			//이력 등록
			try {
				memberService.insertMemberBaseHistory(session.getMbrNo());
			} catch (Exception e) {
				log.error("gs-apet-31-front.mobile.MyInfoController.memberCertification : {} ", session.getMbrNo());
			}

			resultCode = FrontWebConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			//}
		} else {
			resultCode = FrontWebConstants.CONTROLLER_RESULT_CODE_FAIL;
			resultMsg = data.getRtnMsg();
		}

		ModelMap map = new ModelMap();
		map.put(FrontWebConstants.CONTROLLER_RESULT_CODE, resultCode);
		map.put(FrontWebConstants.CONTROLLER_RESULT_MSG, resultMsg);
		return map;
	}

	@RequestMapping(value="indexInterestTagPop" , method = RequestMethod.GET)
	public String indexInterestTagPop(Model model){
		//model.addAttribute("intTags",cacheService.listCodeCache(FrontConstants.INT_TAG_INFO_CD,true,null,null,null,null,null));
		return TilesView.mypage(new String[] { "include", "indexInterestTagPop" });
	}


	@ResponseBody
	@RequestMapping(value="disconnect" , method=RequestMethod.POST)
	public String disconnect(SnsMemberInfoPO po){
		Long mbrNo = FrontSessionUtil.getSession().getMbrNo();
		if(Long.compare(mbrNo,0L) == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_SESSION);
		}
		po.setMbrNo(mbrNo);
		String resultCode = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		if(memberService.deleteSnsMemberInfo(po) == 0){
			resultCode = FrontConstants.CONTROLLER_RESULT_CODE_FAIL;
		}
		return resultCode;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 사용 쿠폰
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping("/coupon")
	public String myCoupon(Model model,Session session,ViewBase view,@RequestParam(value="t",required = false)String tab){
		MemberCouponSO so = getMyCouponSearchCondition(session);
		so.setPage(1);
		//사용 가능 쿠폰
		List<MemberCouponVO> listMemberCoupon = memberCouponService.listMemberCoupon(so);
		listMemberCoupon.forEach(v->{
			String nt = v.getNotice();
			nt = StringEscapeUtils.unescapeHtml(nt);
			if(StringUtil.isEmpty(nt)){
				v.setNotice(null);
			}else{
				nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
				if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
					v.setNotice(null);
				}else{
					String[] nts = nt.split("<br>");
					v.setNotice(nt);
					v.setNotices(nts);
				}
			}
		});
		model.addAttribute("listMemberCoupon",listMemberCoupon);
		model.addAttribute("listMemberCouponSize",listMemberCoupon.size());
		model.addAttribute("mp",1);
		model.addAttribute("mt",so.getTotalPageCount());
		model.addAttribute("totalCnt",memberCouponService.getMemberCouponCountMyPage(so));

		//사용 완료 쿠폰
		List<MemberCouponVO> listMemberUsedCoupon = memberCouponService.listMemberUsedCoupon(so);
		if(!listMemberUsedCoupon.isEmpty()){
			listMemberUsedCoupon.forEach(v->{
				String nt = v.getNotice();
				nt = StringEscapeUtils.unescapeHtml(nt);
				log.info("\n{}",nt);
				if(StringUtil.isEmpty(nt)){
					v.setNotice(null);
				}else{
					nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
					if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
						v.setNotice(null);
					}else{
						String[] nts = nt.split("<br>");
						v.setNotice(nt);
						v.setNotices(nts);
					}
				}
			});
		}
		model.addAttribute("listMemberUsedCoupon",listMemberUsedCoupon);
		model.addAttribute("listMemberUsedCouponSize",listMemberUsedCoupon.size());
		model.addAttribute("up",1);
		model.addAttribute("ut",so.getTotalPageCount());

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("view",view);
		model.addAttribute("session",session);
		model.addAttribute("id",tab);
		return TilesView.mypage(new String[]{"info","indexMyCoupon"});
	}

	@RequestMapping(value="/go-coupon")
	public String myCouponInLmsUrl(Model model,@RequestParam(value="t") String encMbrNo){
		String mbrNoStr = bizService.twoWayDecrypt(encMbrNo);
		Long mbrNo = Long.parseLong(mbrNoStr);
		MemberBaseSO mso = new MemberBaseSO();
		mso.setMbrNo(mbrNo);
		MemberBaseVO vo = memberService.getMemberBase(mso);
		frontLoginService.saveLoginSession(vo,null);
		String goUrl = "/mypage/info/coupon";
		model.addAttribute("goUrl",goUrl);
		return TilesView.mypage(new String[]{"info","indexGoMyCoupon"});
	}

	@RequestMapping(value="/paging/my-coupon" , method=RequestMethod.GET)
	public String pagingMyCoupon(Model model,Session session,ViewBase view,Integer page,Integer totalPageCount){
		MemberCouponSO so = getMyCouponSearchCondition(session);
		so.setPage(page);
		//사용 가능 쿠폰
		List<MemberCouponVO> listMemberCoupon = memberCouponService.listMemberCoupon(so);
		listMemberCoupon.stream().forEach(v->{
			String nt = v.getNotice();
			nt = StringEscapeUtils.unescapeHtml(nt);
			nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
			if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
				v.setNotice(null);
			}else{
				String[] nts = nt.split("<br>");
				v.setNotice(nt);
				v.setNotices(nts);
			}
		});
		model.addAttribute("listMemberCoupon",listMemberCoupon);
		model.addAttribute("listMemberCouponSize",listMemberCoupon.size());

		return TilesView.mypage(new String[]{"info","paging/myCouponBody"});
	}

	@RequestMapping(value="/paging/my-use-coupon", method=RequestMethod.GET)
	public String pagingUsedMyCoupon(Model model,Session session,ViewBase view,Integer page,Integer totalPageCount){
		MemberCouponSO so = getMyCouponSearchCondition(session);
		so.setPage(page);
		//사용 완료 쿠폰
		List<MemberCouponVO> listMemberUsedCoupon = memberCouponService.listMemberUsedCoupon(so);
		listMemberUsedCoupon.stream().forEach(v->{
			String nt = v.getNotice();
			nt = StringEscapeUtils.unescapeHtml(nt);
			nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
			if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
				v.setNotice(null);
			}else{
				String[] nts = nt.split("<br>");
				v.setNotice(nt);
				v.setNotices(nts);
			}
		});
		model.addAttribute("listMemberUsedCoupon",listMemberUsedCoupon);
		model.addAttribute("listMemberUsedCouponSize",listMemberUsedCoupon.size());

		return TilesView.mypage(new String[]{"info","paging/myUsedCouponBody"});
	}

	private MemberCouponSO getMyCouponSearchCondition(Session session){
		Long mbrNo = session.getMbrNo();
		MemberCouponSO so = new MemberCouponSO();
		so.setMbrNo(mbrNo);
		so.setRows(20);
		return so;
	}

	@ResponseBody
	@LoginCheck
	@RequestMapping(value="/registIsuSrlNo")
	public String registIsuSrlNo(MemberCouponPO po,Session session){
		String result = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		String isuSrlNo = Optional.ofNullable(po.getIsuSrlNo()).orElseGet(()->"");
		
		//쿠폰 길이 유효성
		if(isuSrlNo.length() < 1 || isuSrlNo.length() > 20){
			return message.getMessage("business.exception."+ExceptionConstants.ERROR_COUPON_NO_DATA);
		}

		po.setMbrNo(session.getMbrNo());
		po.setIsuTpCd(FrontConstants.ISU_TP_20);
		try{
			memberCouponService.insertMemberCoupon(po);
		}catch(CustomException cep){
			result = message.getMessage("business.exception."+cep.getExCode());
		}

		return result;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: 이지희
	 * - 설명		: 친구초대하기 화면
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping("indexInvitePage")
	public String indexInvitePage(Model model, Session session, ViewBase view) {

		//회원 정보
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setMbrNo(session.getMbrNo());
		MemberBaseVO member =  memberService.getMemberBase(mbso);

		//rcomurl 없는 경우는 생성하여 update
		if(member.getRcomUrl() == null || member.getRcomUrl().equals("")) {
//			String rcomUrl = nhnShortUrlUtil.getInviteUrl(member.getRcomCd(),null);
			String rcomUrl = nhnShortUrlUtil.getUrl(view.getStDomain()+"/mypage/info/inviteShare?frdRcomKey="+member.getRcomCd());
			
			model.addAttribute("linkUrl",rcomUrl);

			MemberBasePO po = new MemberBasePO();
			po.setMbrNo(session.getMbrNo());
			po.setRcomUrl(rcomUrl);
			memberService.updateMemberBase(po); 
		}else {
			model.addAttribute("linkUrl",member.getRcomUrl());
		}
		
		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("view", view);
		model.addAttribute("rcomCode",member.getRcomCd());
		model.addAttribute("view",view);
		model.addAttribute("session",session);

		return TilesView.mypage(new String[]{"info", "indexInvitePage"} );
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: 이지희
	 * - 설명		: 마이페이지 > 비밀번호 설정 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param checkCode
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="indexPswdSet" , method=RequestMethod.GET)
	public String indexPswdSet(Model model, Session session, ViewBase view, String returnUrl ) {

		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = memberService.getMemberBase(so);
		vo.setMobile(bizService.twoWayDecrypt(vo.getMobile()));
		vo.setLoginId(bizService.twoWayDecrypt(vo.getLoginId()));
		vo.setBirth(bizService.twoWayDecrypt(vo.getBirth()));

		String type = FrontWebConstants.PSWD_CHECK_TYPE_INFO;
		String checkCode = makeMyInfoCode(session, type);
		model.addAttribute("type",type);
		model.addAttribute("checkCode", checkCode);

		model.addAttribute("memberId", vo.getLoginId());
		model.addAttribute("session",session);
		model.addAttribute("returnUrl", returnUrl);
		SessionUtil.setAttribute("setPswdMbrNo", vo.getMbrNo()); 
		
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		model.addAttribute("RSAModulus", publKeyMap.get("RSAModulus"));
		model.addAttribute("RSAExponent", publKeyMap.get("RSAExponent"));

		return TilesView.mypage(new String[]{"info", "indexPswdUpdate"} );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: 이지희
	 * - 설명		: 마이페이지 > 비밀번호 변경 화면 GET
	 * </pre>
	 * @param session
	 * @param Model
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="indexPswdUpdate" , method=RequestMethod.GET)
	public String indexPswdUpdate(Model model,Session session,ViewBase view, String returnUrl){
		return indexManageCheck(model,session,view,returnUrl,"/mypage/info/indexPswdUpdate");
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInfoController.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: 이지희
	* - 설명		: 마이페이지 > 비밀번호 변경 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param checkCode
	* @param type
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexPswdUpdate" , method=RequestMethod.POST)
	public String indexPswdUpdate(Model model, Session session, ViewBase view, String checkCode, String type,HttpServletRequest request) {
		//비밀번호 체크 확인 (10초 이내 값만 성공)
		Long pswdCheckedDtm = (Long) SessionUtil.getSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO);
		Long nowDtm =System.currentTimeMillis();
		SessionUtil.removeSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO);
		if( pswdCheckedDtm == null || (nowDtm - pswdCheckedDtm) > 10000 ) {
			return "redirect:/mypage/info/indexPswdUpdate";
		}
		
		String newCheckCode = "";

		if(StringUtil.isEmpty(type) || StringUtil.isEmpty(checkCode)){
			return indexManageCheck(model,session,view,"/","/mypage/info/indexPswdUpdate");
		}
		newCheckCode = makeMyInfoCode(session, type);
		if(!StringUtil.equals(newCheckCode,checkCode)){
			return indexManageCheck(model,session,view,"/","/mypage/info/indexPswdUpdate");
		}

		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = memberService.getMemberBase(so);
		vo.setMobile(bizService.twoWayDecrypt(vo.getMobile()));
		vo.setLoginId(bizService.twoWayDecrypt(vo.getLoginId()));
		vo.setBirth(bizService.twoWayDecrypt(vo.getBirth()));

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("view", view);
		model.addAttribute("checkCode", checkCode);
		model.addAttribute("type",type);
		model.addAttribute("memberId", vo.getLoginId());
		model.addAttribute("session",session);
		
		SessionUtil.setAttribute("setPswdMbrNo", vo.getMbrNo()); 
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		model.addAttribute("RSAModulus", publKeyMap.get("RSAModulus"));
		model.addAttribute("RSAExponent", publKeyMap.get("RSAExponent"));

		return TilesView.mypage(new String[]{"info", "indexPswdUpdate"} );
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInfoController.java
	* - 작성일		: 2021. 02. 08
	* - 작성자		: 이지희
	* - 설명		: 회원 비밀번호 변경
	* </pre>
	* @param session
	* @param mbrNo
	* @param newPswd
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="updateMemberPassword", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap updateMemberPassword(Session session, String newPswd) {
		ModelMap map = new ModelMap();
		
		PrivateKey privateKey = (PrivateKey)SessionUtil.getAttribute("_RSA_WEB_KEY_");
		if(privateKey == null) {
			map.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_FAIL);
			return map;
		}
		newPswd = RSAUtil.decryptRas(privateKey, newPswd);
		
		String mbrNo = null;
		if(SessionUtil.getAttribute("setPswdMbrNo") != null) {
			mbrNo = SessionUtil.getAttribute("setPswdMbrNo").toString();
		}else {
			map.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_FAIL);
			return map;
		}

		//이전 비밀번호 갖고오기
		List<String> pwList = this.memberService.listBeforePswd(mbrNo);

		//이전 비밀번호와 일치하는지 체크
		boolean isMatch = false;
		for(String beforePw : pwList) {
			if (passwordEncoder.check( beforePw, newPswd.toLowerCase())) {
				isMatch = true;
				break;
			}
		}
		//일치하는 이전 비번 있다면
		if(isMatch) {
			map.put(FrontConstants.CONTROLLER_RESULT_CODE, "duplicated");
			return map;
		}else {
			this.memberService.updateMemberPassword(Long.parseLong(mbrNo), newPswd);

			map.put(FrontConstants.CONTROLLER_RESULT_CODE, FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS);
			return map;
		}

	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInfoController.java
	* - 작성일		: 2021. 4. 19.
	* - 작성자		: 이지희
	* - 설명		: 회원 중복인 경우 처리
	* </pre>
	* @param session
	* @return
	*/
	@RequestMapping(value="/updateDulicatedMember", method=RequestMethod.POST)
	public String updateDulicatedMember(Model model, ViewBase view, @RequestParam(value="mbrNo",required=false) Long mbrNo, @RequestParam(value="deviceToken",required=false) String deviceToken, @RequestParam(value="deviceTpCd",required=false) String deviceTpCd,@RequestParam(value="loginPathCd",required=false) String loginPathCd, HttpServletRequest request, RedirectAttributes redirect){
		MemberBaseSO so = new MemberBaseSO();
		if(mbrNo == null && SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_MBR_NO) == null) {
			return "redirect:/indexLogin";
		}
		if(mbrNo == null) {
			so.setMbrNo(Long.parseLong(SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_MBR_NO).toString()));
		}else {
			so.setMbrNo(mbrNo);
		}
		so.setPswd("pswd");
		MemberBaseVO vo = memberService.getMemberBase(so);
		
		vo.setLoginPathCd(StringUtil.isEmpty(loginPathCd) ? FrontConstants.LOGIN_PATH_ABOUTPET : loginPathCd);
		if(!StringUtil.isEmpty(deviceToken)) {
			vo.setDeviceToken(deviceToken);
			vo.setDeviceTpCd(deviceTpCd); 
		 }
		
		Session session = frontLoginService.saveLoginSession(vo, null); 
		
		SessionUtil.setSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO, System.currentTimeMillis());
		String type = FrontWebConstants.PSWD_CHECK_TYPE_INFO;
		String checkCode = makeMyInfoCode(session, type);
		
		return indexManageDetail(model, session, view, checkCode, type, request);
		/*request.setAttribute("checkCode", checkCode);
		request.setAttribute("type", type);
		return "forward:/mypage/info/indexManageDetail";*/
	}
	





	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInfoController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 비밀번호 변경
	* </pre>
	* @param session
	* @param oldPswd
	* @param newPswd
	* @return
	* @throws Exception
	*/
	/*@LoginCheck
	@RequestMapping(value="updateMemberPassword", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap updateMemberPassword(Session session, String oldPswd, String newPswd) {

		boolean chkResult = this.memberService.checkMemberPassword(session.getMbrNo(), oldPswd);

		if (chkResult) {
			this.memberService.updateMemberPassword(session.getMbrNo(), newPswd);
			//이력 등록
			try {
				memberService.insertMemberBaseHistory(session.getMbrNo());
			} catch (Exception e) {
				log.error("31.front.web.MyInfoController.updateMemberPassword : {} ", session.getMbrNo());
			}

		} else {
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_PSWD_FAIL);
		}

		return new ModelMap();
	}
	*/

	@ResponseBody
	@RequestMapping(value="leave")
	public String memberLeave(String checkCode,Session session){
		checkCode = Optional.ofNullable(checkCode).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT));
		String newCheckCode = makeMyInfoCode(session,FrontWebConstants.PSWD_CHECK_TYPE_INFO);
		String resultCode = FrontConstants.CONTROLLER_RESULT_CODE_FAIL;
		if(StringUtil.equals(newCheckCode,checkCode)){

			resultCode = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		return resultCode;
	}

	@ResponseBody
	@RequestMapping("gsr-check")
	public MemberBaseVO gsrCheck(){
		Session session = FrontSessionUtil.getSession();
		Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->FrontConstants.NO_MEMBER_NO);

		MemberBaseVO vo;
		if(Long.compare(mbrNo,FrontConstants.NO_MEMBER_NO) != 0){
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(mbrNo);
			vo = memberService.getMemberBase(so);

			String birth = bizService.twoWayDecrypt(vo.getBirth());
			String mbrNm = bizService.twoWayDecrypt(vo.getMbrNm());
			String mobile = bizService.twoWayDecrypt(vo.getMobile());
			vo.setBirth(birth);
			vo.setMbrNm(mbrNm);
			vo.setMobile(mobile);
		}else{
			vo = new MemberBaseVO();
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping("gsr-next-time")
	public String gsrNextTime(){
		//gs 연동 해제로 인해 노출 된 알림 - 다음에 하기 클릭
		Session session = FrontSessionUtil.getSession();
		Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->FrontConstants.NO_MEMBER_NO);

		Integer result = 0;
		if(Long.compare(mbrNo,FrontConstants.NO_MEMBER_NO) != 0){
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(mbrNo);
			MemberBaseVO vo = memberService.getMemberBase(so);

			MemberBasePO po = new MemberBasePO();
			po.setMbrNo(mbrNo);

			po.setGsptNo(null);
			po.setGsptUseYn(FrontConstants.USE_YN_N);
			po.setGsptStateCd(FrontConstants.GSPT_STATE_30);
			po.setCtfYn(FrontConstants.COMM_YN_N);

			result = memberService.updateMemberBaseGspt(po);
		}
		return result.toString();
	}
	
	@RequestMapping(value = "inviteShare")
	public String inviteShare(ModelMap map, Session session, ViewBase view, MemberBaseVO vo
			,@RequestParam(value="frdRcomKey", required=false) String frdRcomKey) {
		
		String title = "친구 초대하기";
		String imgPath = view.getStDomain() + "/_images/common/mn_vis_1_mo.png";
		String desc =  "";
		
		map.put("title", title);
		map.put("img", imgPath);
		map.put("desc", desc);
		map.put("frdRcomKey", frdRcomKey);
		map.put("pageGb", "invite");
		
		SeoInfoSO seoSo = new SeoInfoSO();
		if(StringUtil.isNotEmpty(vo.getSeoInfoNo())) {
			seoSo.setSeoInfoNo(vo.getSeoInfoNo());
			SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
			if(seoInfo != null) {
				map.put("site_name", seoInfo.getPageTtl());
			}else {
				map.put("site_name", "");
			}
		}
		
		return TilesView.none(new String[]{"common", "common", "indexShareView"});
	}
}