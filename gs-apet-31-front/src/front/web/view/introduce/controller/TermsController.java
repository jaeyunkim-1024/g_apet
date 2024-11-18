package front.web.view.introduce.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.appweb.service.TermsService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.introduce.controller
* - 파일명		: TermsController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 이용약관 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("introduce/terms")
public class TermsController {

	@Autowired private BizService bizService;
	
	@Autowired private MessageSourceAccessor message;
	
	@Autowired private TermsService termsService;
	
	@Autowired private MemberService memberService;
	 
	@Autowired private CacheService codeCacheService;


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TermsController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 이용약관 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexTerms")
	public String indexTerms(ModelMap map, Session session, ViewBase view , TermsSO so , String settingYn
			,@RequestParam(value="joinPath", required=false) String joinPath){
	    List<TermsVO> termsList = termsService.listTermsContent(so);
	    
	    map.put("joinPath", joinPath);
	    map.put("settingYn", settingYn);
	    map.put("termsList" , termsList);
		map.put("session", session);
		map.put("view", view);
		map.put("termsCd", so.getTermsCd());

		MemberBaseSO memberBaseSO = new MemberBaseSO();
		memberBaseSO.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = new MemberBaseVO();
		// 선택 약관인 경우
		if(StringUtil.equals(settingYn, CommonConstants.COMM_YN_N)) {
			vo = memberService.getMemberBase(memberBaseSO);
		}
		
		map.put("vo", vo);

		return "introduce/indexTerms";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TermsController.java
	* - 작성일		: 2021. 6. 7.
	* - 작성자		: snw
	* - 설명		: 이용약관 화면 팝업(앱에서 사용)
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexTermsApp")
	public String indexTermsApp(ModelMap map, Session session, ViewBase view , TermsSO so , String settingYn){
	    List<TermsVO> termsList = termsService.listTermsContent(so);
	    
	    map.put("settingYn", settingYn);
	    map.put("termsList" , termsList);
		map.put("session", session);
		map.put("view", view);
		map.put("termsCd", so.getTermsCd());

		MemberBaseSO memberBaseSO = new MemberBaseSO();
		memberBaseSO.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = new MemberBaseVO();
		// 선택 약관인 경우
		if(StringUtil.equals(settingYn, CommonConstants.COMM_YN_N)) {
			vo = memberService.getMemberBase(memberBaseSO);
		}
		
		map.put("vo", vo);
		
		return TilesView.none(new String[]{"introduce", "indexTermsApp"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TermsController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 청소년보호정책
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexTeen")
	public String indexTeen(ModelMap map, Session session, ViewBase view){

		view.setNavigation(new String[] {"청소년보호정책"});
		map.put("session", session);
		map.put("view", view);

		return  TilesView.login(new String[]{"introduce", "indexTeen"});
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: TermsController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: escrow
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexEscrow")
	public String indexEscrow(ModelMap map, Session session, ViewBase view){

		view.setTitle("구매안전서비스 안내");
		
		map.put("session", session);
		map.put("view", view);

		return  TilesView.popup(new String[]{"introduce", "indexEscrow"});
	}
	


	@ResponseBody
	@RequestMapping(value="updateMemberBaseTermsYn")
	public String updateMkngRcvYn(MemberBasePO po, Session session) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		
		int result = memberService.updateMemberBaseTermsYn(po);
		session.setPstInfoAgrYn(po.getPstInfoAgrYn());
		FrontSessionUtil.setSession(session);
		
		if(result == 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		}
		
		return resultCode;
	}

	@RequestMapping(value="indexGsPointTerms")
	public String indexGsPointTerms(ModelMap map, Session session, ViewBase view){
		String pocGbcd = "";
		String viewOs = view.getOs();			//OS 구분 코드
		String deviceGb = view.getDeviceGb();	//디바이스 구분 코드

		//앱 IOS
		if(StringUtil.equals(deviceGb, FrontConstants.DEVICE_GB_30) && !StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbcd = FrontConstants.TERMS_POC_IOS;
		}
		//앱 AOS
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) && StringUtil.equals(viewOs,FrontConstants.DEVICE_TYPE_10)){
			pocGbcd = FrontConstants.TERMS_POC_ANDR;
		}
		//모바일
		else if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_20)){
			pocGbcd = FrontConstants.TERMS_POC_MO;
		}
		//PC
		else{
			pocGbcd = FrontConstants.TERMS_POC_WEB;
		}

		TermsSO so = new TermsSO();
		so.setPocGbCd(pocGbcd);
		
		List<TermsVO> termsList = termsService.listGsPointTerms(so);
	    
	    map.put("termsList" , termsList);
		map.put("session", session);
		map.put("view", view);

		return "/mypage/info/indexGsPointTerms";
	}
	

	@ResponseBody
	@RequestMapping(value="indexGsPointTermsContents")
	public ModelMap indexGsPointTermsContents(Session session, TermsSO so , String settingYn){
		ModelMap map = new ModelMap();
	    List<TermsVO> termsList = termsService.listTermsContent(so);
	    
	    for(int intIndex = 0; intIndex < termsList.size(); intIndex++) {
	    	termsList.get(intIndex).setTermsStrtDt(DateUtil.convertDateToString(termsList.get(intIndex).getTermsStrtDt(), "H"));
	    	termsList.get(intIndex).setTermsEndDt(DateUtil.convertDateToString(termsList.get(intIndex).getTermsEndDt(), "H"));
	    }
	    
	    map.put("settingYn", settingYn);
	    map.put("termsList" , termsList);

		MemberBaseSO memberBaseSO = new MemberBaseSO();
		memberBaseSO.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = new MemberBaseVO();
		// 선택 약관인 경우
		if(settingYn.equals(CommonConstants.COMM_YN_N)) {
			vo = memberService.getMemberBase(memberBaseSO);
		}
		
		map.put("vo", vo);

		return map;
	}
	
}