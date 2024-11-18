package admin.web.view.partner.controller;

import java.io.File;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.partner.model.PartnerInfoPO;
import biz.app.partner.model.PartnerInfoSO;
import biz.app.partner.model.PartnerInfoVO;
import biz.app.partner.service.PartnerService;
import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.service.AuthService;
import biz.app.system.service.PrivacyCnctService;
import biz.app.system.service.UserService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.StringUtil;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.partner.controller
 * - 파일명		: PartnerController.java
 * - 작성자		: valueFactory
 * - 설명		: 파트너 관리
 * </pre>
 */
@Controller
public class PartnerController {
	
	@Autowired private PartnerService partnerService;
	
	@Autowired private MessageSourceAccessor message;
	
	@Autowired private PrivacyCnctService privacyCnctService;

	@Autowired private AuthService authService;
	
	@Autowired private UserService userService;

	@Autowired private NhnObjectStorageUtil nhnObjectStorageUtil;

	@Autowired private Properties bizConfig;
	

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 펫로그 파트너 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/partner/petLogPartnerListView.do")
	public String petLogPartnerListView(Model model) {
		
		return "/partner/petLogPartnerListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 펫로그 파트너 등록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/partner/petLogPartnerInsertView.do")
	public String petLogPartnerInsertView(Model model) {
		
		return "/partner/petLogPartnerInsertView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 펫로그 파트너 상세 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/partner/petLogPartnerView.do")
	public String petLogPartnerView(HttpServletRequest req, Model model, PartnerInfoSO so) {
		so.setMaskingYn(CommonConstants.COMM_YN_Y);
		PartnerInfoVO vo = partnerService.getPartner(so);
		
		// 개인정보 접근이력
		PrivacyCnctHistPO pchPO = new PrivacyCnctHistPO();
		pchPO.setUrl(req.getRequestURI());
		pchPO.setActGbCd(AdminConstants.ACT_GB_30);
		Long cnctHistNo = privacyCnctService.insertPrivacyCnctHist(pchPO);
		
		// 개인정보 접속 조회 내역
		pchPO.setCnctHistNo(cnctHistNo);
		pchPO.setColGbCd(AdminConstants.COL_GB_00);
		pchPO.setInqrGbCd(AdminConstants.INQR_GB_40);
		Long inqrHistNo = privacyCnctService.insertPrivacyCnctInquiry(pchPO);
		
		model.addAttribute("cnctHistNo", cnctHistNo);
		model.addAttribute("inqrHistNo", inqrHistNo);
		model.addAttribute("partner", vo);
		
		return "/partner/petLogPartnerView";
	}
	
	@RequestMapping("/partner/getPartner.do")
	public String getPartner(Model model, PartnerInfoSO so) {
		PartnerInfoVO vo = partnerService.getPartner(so);
		
		model.addAttribute("partner", vo);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 펫로그 파트너ID 중복체크
	 * </pre>
	 * @return
	 */
	@RequestMapping("/partner/partnerIdCheck.do")
	public String partnerIdCheck(Model model, PartnerInfoSO so) {
		int cnt = partnerService.getPartnerIdCheck(so);
		
		if(cnt > 0){
			model.addAttribute("message", message.getMessage(AdminConstants.EXCEPTION_MESSAGE_COMMON + ExceptionConstants.ERROR_USER_DUPLICATION_FAIL));
		}
		
		model.addAttribute("checkCount", cnt);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 파트너 등록
	 * </pre>
	 * @return
	 */
	@RequestMapping("/partner/partnerInsert.do")
	public String partnerInsert(Model model, PartnerInfoPO po) {
		partnerService.insertPartner(po);
		
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 파트너 목록 조회
	 * </pre>
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/partner/partnerListGrid.do", method=RequestMethod.POST)
	public GridResponse partnerListGrid(Model model, PartnerInfoSO so) {
		List<PartnerInfoVO> list = partnerService.pagePartnerList(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PartnerController.java
	 * - 작성일		: 2021. 01. 06
	 * - 작성자		: valueFactory
	 * - 설명		: 파트너 수정
	 * </pre>
	 * @return
	 */
	@RequestMapping("/partner/partnerUpdate.do")
	public String partnerUpdate(Model model, PartnerInfoPO po) {
		partnerService.updatePartner(po);
		
		return View.jsonView();
	}
	
	
	@RequestMapping("/partner/petLogPartnerExcelDownload.do")
	public String petLogPartnerExcelDownload(ModelMap model, PartnerInfoSO so){
		
		so.setRows(999999999);

		so.setSidx("sysRegDtm");
		so.setSord("DESC");
		List<PartnerInfoVO> list = partnerService.pagePartnerList(so);


		String[] headerName = {
				  "회원 번호"
				, "아이디"
				, "파트너명"
				, "이메일"
				, "상태"
				, "최종 로그인 일시"
				, "제휴일"
		};

		String[] fieldName = {
				  "mbrNo"
				, "loginId"
				, "bizNm"
				, "email"
				, "mbrStatCd"
				, "lastLoginDtm"
				, "ptnDate"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("PartnerInfo", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "PartnerInfo");

		return View.excelDownload();
	}
	
	@RequestMapping(value="/partner/partnerListView.do")
	public String partnerListView(Model model) {

		model.addAttribute("auth", authService.listAuth());
		model.addAttribute("usrGrpCdGb", CommonConstants.USR_GRP_20);
		
		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			model.addAttribute("compNo", session.getCompNo());
		}
		
		return "/system/userListView";
	}
	
	@RequestMapping(value="/partner/partnerView.do")
	public String partnerView(Model model, UserBaseSO so) {
		UserBaseVO user = null;

		if(so.getUsrNo() != null){
			user = this.userService.getUser(so);
		}else{
			user = new UserBaseVO();
			
			// PO사용자가 로그인하여 사용자 등록할 경우 자신의 업체번호, 업체명을 세팅한다.
			if(StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {
				user.setCompNo(AdminSessionUtil.getSession().getCompNo());
				user.setCompNm(AdminSessionUtil.getSession().getCompNm());
			}
		}

		model.addAttribute("auth", userService.listAuth(so)); 
		//model.addAttribute("auth", authService.listAuth());
		model.addAttribute("user", user);
		model.addAttribute("usrGrpCdGb", CommonConstants.USR_GRP_20);
		
		return "/system/userView";
	}

	@ResponseBody
	@RequestMapping("/partner/afterImageDelete.do")
	public String afterImageDelete(Model model, PartnerInfoPO po) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		
		int result = partnerService.deleteImage(po);
		
		if(result > 0) {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
	
	@ResponseBody
	@RequestMapping("/partner/beforeImageDelete.do")
	public String beforeImageDelete(Model model, PartnerInfoPO po) {
		String resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		
		File file = new File(po.getPrflImg());
		if(file.exists()) {
			file.delete();
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
		
		return resultCode;
	}
	

	@RequestMapping("/partner/partnerEmailNickNmCheck.do")
	public String partnerEmailNickNmCheck(Model model, PartnerInfoSO so) {
		int emailCnt = partnerService.getPartnerEmailCheck(so);
		int nickNmCnt = partnerService.getPartnerNickNmCheck(so);
		
		model.addAttribute("emailCnt", emailCnt);
		model.addAttribute("nickNmCnt", nickNmCnt);
		return View.jsonView();
	}
}
