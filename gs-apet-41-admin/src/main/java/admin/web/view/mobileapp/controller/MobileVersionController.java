package admin.web.view.mobileapp.controller;

import java.util.List;

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

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.mobileapp.model.MobileVersionPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;
import biz.app.mobileapp.service.MobileVersionService;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.mobileapp.controller
 * - 파일명		: MobileVersionController.java
 * - 작성일		: 2016. 05. 12.
 * - 작성자		: wyjeong
 * - 설명			: APP 버전관리 Controller
 * </pre>
 */
@Controller
@RequestMapping("/mobileapp/version")
public class MobileVersionController {
	
	@Autowired
	private MobileVersionService mobileVersionService;
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 화면
	 * </pre>
	 * 
	 * @return
	 */
	@RequestMapping("/list.do")
	public String listView(Model model, MobileVersionSO so) {
		model.addAttribute("versionSo", so);
		
		return "/mobileapp/versionListView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 목록 리스트
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/listGrid.do", method = RequestMethod.POST)
	public GridResponse listGrid(MobileVersionSO so) {
		List<MobileVersionVO> list = mobileVersionService.pageMobileVersion(so);
		return new GridResponse(list, so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 등록 화면
	 * </pre>
	 * 
	 * @return
	 */
	@RequestMapping("/reg.do")
	public String reg(Model model) {
		
		model.addAttribute("session", AdminSessionUtil.getSession());
		
		return "/mobileapp/versionView";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 상세 화면
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/view.do")
	public String view(Model model, MobileVersionSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("version", mobileVersionService.getMobileVersion(so));
		
		return "/mobileapp/versionView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 상세 팝업
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/versionDetailViewPop.do")
	public String versionDetailViewPop(Model model, MobileVersionSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("version", mobileVersionService.getMobileVersion(so));
		
		return "/mobileapp/versionDetailViewPop";
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: 해당 앱 버전 정보 존재 여부 체크
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/verCheck.do")
	public String verCheck(Model model, MobileVersionSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		int count = mobileVersionService.checkMobileVersion(so);
		model.addAttribute("checkCount", count);
		
		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 등록
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/insert.do")
	public String insert(Model model, MobileVersionPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		mobileVersionService.insertMobileVersion(po);
		model.addAttribute("version", po);
		
		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 수정
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/update.do")
	public String update(Model model, MobileVersionPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		mobileVersionService.updateMobileVersion(po);
		model.addAttribute("version", po);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 삭제
	 * </pre>
	 * 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/delete.do")
	public String delete(Model model, MobileVersionPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		int delCnt = mobileVersionService.deleteMobileVersion(po);
		model.addAttribute("delCnt", delCnt);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MobileVersionController.java
	 * - 작성일		: 2016. 05. 12.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 엑셀 다운로드
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/versionExcelDownload.do")
	public String versionExcelDownload(ModelMap model, MobileVersionSO so){
		//so.setSidx("po_no");
		//so.setSord("desc");
		so.setSort("sysRegDtm");
		so.setSord("DESC");
		so.setRows(999999999);

		List<MobileVersionVO> list = mobileVersionService.pageMobileVersion(so);

		String[] headerName = {
				  "No"
				, messageSourceAccessor.getMessage("column.version.os_gb") //OS 구분
				, messageSourceAccessor.getMessage("column.version.version") //버전
				, messageSourceAccessor.getMessage("column.version.update_cnts") //업데이트 내용
				, messageSourceAccessor.getMessage("column.version.update_dtm") //업데이트 일시
				, messageSourceAccessor.getMessage("column.sys_regr_nm") //등록자
				, messageSourceAccessor.getMessage("column.sys_reg_dt") //등록일
		};

		String[] fieldName = {
				  "verNo"
				, "mobileOsNm"
				, "appVer"
				, "message"
				, "marketRegDtm"
				, "sysRegrNm"
				, "sysRegDt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("appVersion", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "appVersion");

		return View.excelDownload();
	}
}