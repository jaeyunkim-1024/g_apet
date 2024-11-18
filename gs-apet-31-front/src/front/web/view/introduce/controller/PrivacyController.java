package front.web.view.introduce.controller;

import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.privacy.model.PrivacyPolicySO;
import biz.app.privacy.model.PrivacyPolicyVO;
import biz.app.privacy.service.PrivacyService;
import framework.common.constants.CommonConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewCommon;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.introduce.controller
* - 파일명		: PrivacyController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 개인정보취급방침 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("introduce/privacy")
public class PrivacyController {
	
	private static final String[] NAVIGATION_INTRO_PRIVACY = {"개인정보처리방침"};
	
	@Autowired Properties webConfig;
	@Autowired private PrivacyService privacyService;
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 개인정보취급방침 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexPrivacy")
	public String indexPrivacy(ModelMap map, Session session, ViewBase view){

		view.setNavigation(NAVIGATION_INTRO_PRIVACY);
		
		PrivacyPolicySO privacySO = new PrivacyPolicySO();
		privacySO.setStId(Integer.valueOf(this.webConfig.getProperty("site.id")));
		privacySO.setUseYn(CommonConstants.COMM_YN_Y);
		
		if(privacySO.getSidx() == null || privacySO.getSidx().equals("")){
			privacySO.setSidx("SYS_REG_DTM"); //정렬 컬럼 명
		}
		privacySO.setSord(FrontWebConstants.SORD_DESC);
		
		List<PrivacyPolicyVO> allPrivacy = privacyService.pagePrivacyPolicy(privacySO);
		
		map.put("privacyList", allPrivacy);
		map.put("view", view);

		return  TilesView.login(new String[]{"introduce", "indexPrivacy"});
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 32.front.mobile
	* - 파일명		: PrivacyController.java
	* - 작성일		: 2017. 2. 10.
	* - 작성자		: 
	* - 설명			: 개인정보취급방침 단건 조회
	* </pre>
	* @param 
	* @param 
	* @param 
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="getPrivacy", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap getPrivacy(String policyNo){
		
		PrivacyPolicyVO getPrivate =privacyService.getPrivacyPolicy(Integer.valueOf(policyNo));
		
		ModelMap map = new ModelMap();
		
		map.addAttribute("privacyCont", getPrivate.getContent());
		
		return map;
	}
	
	
}