package admin.web.view.system.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.member.model.MemberBaseVO;
import biz.app.system.model.*;
import biz.app.system.service.AuthService;
import biz.app.system.service.PrivacyCnctService;
import biz.app.system.service.UserService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

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
public class UserController {
 
	/**
	 * 사용자 서비스
	 */
	@Autowired
	private UserService userService;

	/**
	 * 권한 서비스
	 */
	@Autowired
	private AuthService authService;

	/**
	 * 개인정보 조회 서비스
	 */
	@Autowired
	private PrivacyCnctService privacyCnctService;

	/**
	 * 메세지
	 */
	@Autowired
	private MessageSourceAccessor message;

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
	@RequestMapping("/system/userListView.do")
	public String userListView(Model model) {

		model.addAttribute("auth", authService.listAuth());
		model.addAttribute("usrGrpCdGb", CommonConstants.USR_GRP_10);
		
		return "/system/userListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 목록 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/userListGrid.do", method=RequestMethod.POST)
	public GridResponse userListGrid(UserBaseSO so) {
		List<UserBaseVO> list = userService.pageUser(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2016. 3. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping({"/system/userView.do", "/system/userReg.do"})
	public String userView(Model model, UserBaseSO so, BindingResult br) {
		if(br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
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
		model.addAttribute("usrGrpCdGb", CommonConstants.USR_GRP_10);
		
		return "/system/userView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2016. 3. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 관리자 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/userInsert.do")
	public String userInsert(Model model, UserBasePO po, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 내부 사용자 등록시 업체번호 0
		if(CommonConstants.USR_GRP_10.equals(po.getUsrGrpCd())){
			po.setCompNo(0L);
		}
		
		// PO관리자가 PO시스템에서 PO사용자 동록시 사용자 그룹코드 20
		// PO관리자는 자신 회사의 사용자 밖에 등록하지 못함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {
			po.setUsrGrpCd(CommonConstants.USR_GRP_20);
//			po.setAuthorityPOList(AdminSessionUtil.getSession().getAuthNos());
			po.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}
		
		userService.insertUser(po);
		model.addAttribute("user", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2016. 3. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/userUpdate.do")
	public String userUpdate(Model model, UserBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// PO시스템 사용자는 권한이 무조건 하나. 따라서 PO관리자의 권한을 따라간다
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {
			po.setAuthorityPOList(AdminSessionUtil.getSession().getAuthNos());
		}
		
		userService.updateUser(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 ID 체크
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/userIdCheck.do")
	public String userIdCheck(Model model, UserBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		int cnt = userService.getUserIdCheck(po.getLoginId());
		if(cnt > 0){
			model.addAttribute("message", message.getMessage(AdminConstants.EXCEPTION_MESSAGE_COMMON + ExceptionConstants.ERROR_USER_DUPLICATION_FAIL));
		}
		model.addAttribute("checkCount", cnt);
		return View.jsonView();
	}

	@RequestMapping("/system/userLoginViewPop.do")
	public String userLoginViewPop(Model model, UserBaseSO so) {
		if(so.getUsrNo() != null && so.getUsrNo() > 0) {
			model.addAttribute("userBase", so);
			return "/system/userLoginViewPop";
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@ResponseBody
	@RequestMapping(value="/system/userLoginListGrid.do", method=RequestMethod.POST)
	public GridResponse userLoginListGrid(UserBaseSO so) {
		List<UserLoginHistVO> list = userService.pageUserLogin(so);
		return new GridResponse(list, so);
	}

	@RequestMapping("/system/userPasswordUpdate.do")
	public String userPasswordUpdate(Model model, UserBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		userService.updatePasswordUser(po);
		return View.jsonView();
	}
	

	@RequestMapping("/system/userBaseExcelDownload.do")
	public String userBaseExcelDownload(ModelMap model, UserBaseSO so){
		
		so.setRows(999999999);

		/*if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getGoodsNmArea())) {
			so.setGoodsNms(StringUtil.splitEnter(so.getGoodsNmArea()));
		}

		if (!StringUtil.isEmpty(so.getMdlNmArea())) {
			so.setMdlNms(StringUtil.splitEnter(so.getMdlNmArea()));
		}

		if (!StringUtil.isEmpty(so.getBomCdArea())) {
			so.setBomCds(StringUtil.splitEnter(so.getBomCdArea()));
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}*/

		so.setSidx("sysRegDtm");
		so.setSord("DESC");
		List<UserBaseVO> list = userService.pageUser(so);


		String[] headerName = {
				  "사용자 ID"
				, "소속 명"
				, "사용자 명"
				, "사용자 그룹"
				, "사용자 구분"
				, "권한 명"
				, "휴대폰"
				, "이메일"
				, "최종 로그인 일시"
				, "유효 기간"
				, "사용자 상태"
				, "등록자"
				, "시스템 등록 일시"
				, "수정자"
				, "시스템 수정 일시"
		};

		String[] fieldName = {
				  "loginId"
				, "dpNm"
				, "usrNm"
				, "usrGrpCd"
				, "usrGbCd"
				, "authNm"
				, "mobile"
				, "email"
				, "lastLoginDtm"
				, "validDtm"
				, "usrStatCd"
				, "sysRegrNm"
				, "sysRegDtm"
				, "sysUpdrNm"
				, "sysUpdDtm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("UserBase", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "UserBase");

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: 조은지
	 * - 설명		: 사용자 권한 확인 팝업(임시)
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/userAuthMenuViewPop.do")
	public String userAuthMenuViewPop(Model model, UserBaseSO so) {
		model.addAttribute("userBase", so);
		model.addAttribute("userAuthList", userService.getUserAuthMapList(so));
		model.addAttribute("usrGrpCdGb", so.getUsrGrpCd());
		return "/system/userAuthMenuViewPop";
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: UserController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: 조은지
	 * - 설명		: 사용자 권한 확인 팝업(임시)
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/userAuthMenuListGrid.do", method=RequestMethod.POST)
	public GridResponse userAuthMenuListGrid(UserBaseSO so) {
		List<UserBaseVO> list = userService.getUserAuthMenuList(so);
		return new GridResponse(list, so);
	}

	@RequestMapping(value="/system/logListView.do")
	public String logListView(Model model){
		return "/system/logListView";
	}

	@ResponseBody
	@RequestMapping(value="/system/pageLog.do")
	public GridResponse pageLog(PrivacyCnctHistSO so){
		so.setRows(20);
		List<PrivacyCnctHistVO> list = privacyCnctService.pageLog(so);
		Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(PrivacyCnctHistVO v : list){
			v.setRowNum(Long.parseLong(rowNum.toString()));
			rowNum -=1;
		}
		return new GridResponse(list,so);
	}

	@RequestMapping(value="/system/logExcelDownload.do")
	public String logExcelDownload(PrivacyCnctHistSO so,Model model){
		so.setRows(9999999);
		List<PrivacyCnctHistVO> list = privacyCnctService.pageLog(so);
		Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(PrivacyCnctHistVO v : list){
			v.setRowNum(Long.parseLong(rowNum.toString()));
			rowNum -=1;
		}

		list.forEach(v->{
			v.setInqrGbNm("-");
			if(StringUtil.equals(v.getInqrGbCd(),AdminConstants.INQR_GB_40)){
				v.setInqrGbNm("열람");
			}
		});

		String[] headerName = {"번호","접속 일시","접속자ID","접속자","접속지IP","처리 내역","접근 화면","화면 URL"};
		String[] fieldName = {"rowNum","acsDtm","adminLoginId","usrNm","ip","inqrGbNm","menuPath","url"};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("logList", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "logList");

		return View.excelDownload();
	}


	@RequestMapping(value="/system/logDetailLayerView.do")
	public String getDetailHistoryInfo(Model model, PrivacyCnctHistSO so){
		model.addAttribute("vo",privacyCnctService.getDetailHistoryInfo(so));
		return "/system/logDetailLayerView";
	}
	
	@RequestMapping("/system/userCompanyDupChk.do")
	public String userCompanyDupChk(Model model, UserBaseSO so, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		model.addAttribute("cnt", userService.userCompanyDupChk(so));
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: UserController.java
	* - 작성일		: 2020. 12. 16
	* - 작성자		: CJA
	* - 설명			: 접근 권한 이력 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/system/userAuthHistView.do")
	public String userAuthHistory (Model model) {
		return "/system/userAuthHistView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: UserController.java
	 * - 작성일	: 2021. 01. 13
	 * - 작성자	: CJA
	 * - 설명		: 사용자 접근 권한 그리드
	 * </pre>
	 * 
	 * @param  so
	 * @return
	 */
	
	 @ResponseBody
	 @RequestMapping(value = "/system/userAuthHistGrid.do", method = RequestMethod.POST) 
	 public GridResponse userAuthHistGrid(UserAuthHistSO so) {
	 
		 List<UserAuthHistVO> list = userService.userAuthHistGrid(so);
		 
	 return new GridResponse(list, so);
	 }
	 
	 /**
		 * <pre>
		 * - Method 명	: bannerListExcelDownload
		 * - 작성일		: 2020. 12. 18
		 * - 작성자		: CJA
		 * - 설 명		: 접근 권한 이력 리스트 엑셀 다운로드 
		 * </pre>
		 *
		 * @param  model
		 * @param  so
		 * @return
		 */
		@RequestMapping("/system/userAuthHistListExcelDownload.do")
		public String bannerListExcelDownload(ModelMap model, UserAuthHistSO so){
			
			so.setRows(999999999);

			List<UserAuthHistVO> list = userService.pageUserAuthHist(so);

			String[] headerName = {
					  "이력 번호"
					, "시스템 등록 일시"
					, "ID"
					, "사용자 명"
					, "변경 전 권한 명"
					, "변경 후 권한 명"
					, "변경자명"
			};

			String[] fieldName = {
					  "histNo"
					, "sysRegDtm"
					, "loginId"
					, "usrNm"
					, "bfrAuthNm"
					, "authNm"
					, "sysRegrNm"
			};

			model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("userAuthHist", headerName, fieldName, list));
			model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "userAuthHist");

			return View.excelDownload();
		}

}