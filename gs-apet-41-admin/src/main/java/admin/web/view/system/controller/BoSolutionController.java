package admin.web.view.system.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.system.model.*;
import biz.app.system.service.AuthService;
import biz.app.system.service.PrivacyCnctService;
import biz.app.system.service.UserService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import framework.common.util.TwcCryptoUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Properties;

/**
 * 네이밍 룰
 * 업무명View		:	화면
 * 업무명Grid		:	그리드
 * 업무명Tree		:	트리
 * 업무명Insert		:	입력
 * 업무명Update		:	수정
 * 업무명Delete		:	삭제
 * 업무명Save		:	입력 / 수정
 * 업무명ViewPop		:	화면팝업
 */

@Controller
public class BoSolutionController {

	@Autowired private Properties bizConfig;
	
	@Autowired private TwcCryptoUtil twcCryptoUtil;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 메인 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/solution/solutionBoView.do")
	public String solutionBoView(Model model) {
		Session session = AdminSessionUtil.getSession();
		String searchCenterUrl = bizConfig.getProperty("aboutpet.url.search_center");
		String videoCenterUrl = bizConfig.getProperty("aboutpet.url.video_center");

		model.addAttribute("session" , session);
		model.addAttribute("searchCenterUrl" , searchCenterUrl);
		model.addAttribute("videoCenterUrl" , videoCenterUrl);
		return "/system/solutionBoView";
	}
	
	@RequestMapping(value = "/solution/goDataCenter.do")
	public String twcTest(Model model, @RequestParam(value="loginId") String loginId, @RequestParam(value="userNo") String userNo) {
		String dataCenterUrl = bizConfig.getProperty("aboutpet.url.data_center");
		String loginIdEnc = "";
		String userNoEnc = "";
		try {
			loginIdEnc = twcCryptoUtil.encryptWithKey(loginId, "");
			userNoEnc = twcCryptoUtil.encryptWithKey(userNo, "");
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("dataCenterUrl" , dataCenterUrl);
		model.addAttribute("loginId", loginIdEnc);
		model.addAttribute("userNo", userNoEnc);
		return View.jsonView();
	}
}