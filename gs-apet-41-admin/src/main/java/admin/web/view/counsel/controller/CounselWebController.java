package admin.web.view.counsel.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.counsel.model.*;
import biz.app.counsel.service.CounselOrderDetailService;
import biz.app.counsel.service.CounselProcessService;
import biz.app.counsel.service.CounselService;
import biz.common.model.AttachFileSO;
import biz.common.model.AttachFileVO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
 
/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.counsel.controller
* - 파일명		: CounselWebController.java
* - 작성일		: 2017. 5. 10.
* - 작성자		: Administrator
* - 설명			: 상담 1:1문의 관리 Controller
* </pre>
*/
@Controller
@RequestMapping("counsel/web")
public class CounselWebController {


	@Autowired	private CounselService counselService;

	@Autowired	private CounselProcessService counselProcessService;
	
	@Autowired private CounselOrderDetailService counselOrderDetailService;
	
	@Autowired	private BizService bizService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselWebController.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 1:1문의 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("counselWebListView.do")
	public String counselListView(Model model) {
		return "/counsel/counselWebListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselWebController.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 1:1 문의 목록
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="counselWebListGrid.do", method=RequestMethod.POST )
	public GridResponse counselListGrid(CounselSO so) {
		//문의자 아이디 암호화
		if(StringUtil.isNotEmpty(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		
		so.setCusPathCd(CommonConstants.CUS_PATH_10);
		List<CounselVO> list = counselService.pageCounsel(so);
		Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(CounselVO v : list){
			v.setRowNum(Long.parseLong(rowNum.toString()));
			rowNum -=1;
		}

		return new GridResponse(list, so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselWebController.java
	* - 작성일		: 2017. 6. 1.
	* - 작성자		: Administrator
	* - 설명			: 상담 당당자 변경
	* </pre>
	* @param cusChrgNo
	* @param cusNos
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="updateCounselChrg.do", method=RequestMethod.POST )
	public String updateCounselChrg(Long cusChrgNo, Long[] cusNos) {
		this.counselService.updateCounselChrg(cusNos, cusChrgNo);
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselWebController.java
	* - 작성일		: 2017. 5. 10.
	* - 작성자		: Administrator
	* - 설명			: 1:1 문의 상세 화면
	* </pre>
	* @param model
	* @param so
	* @param counselProcessSO
	* @param br
	* @return
	*/
	@RequestMapping("counselWebView.do")
	public String counselWebView(Model model, Long cusNo, String viewGb, String popTitleYn, String popupYn) {

		/***************************
		 * 상담 내역 조회
		 ***************************/
		CounselSO cso = new CounselSO();
		cso.setCusNo(cusNo);
		
		CounselVO counsel = counselService.getCounsel(cso);
		
		if(counsel != null) {
			if(StringUtil.isNotEmpty(counsel.getLoginId())) {
				counsel.setLoginId(bizService.twoWayDecrypt(counsel.getLoginId()));
			}
		}

		if(counsel == null || CommonConstants.CUS_PATH_20.equals(counsel.getCusPathCd())) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		/*
		 * 첨부파일 조회
		 */
		List<AttachFileVO> counselFileList = null;
		if(counsel.getFlNo() != null) {
			AttachFileSO afso = new AttachFileSO();
			afso.setFlNo(counsel.getFlNo());
			counselFileList = this.bizService.listAttachFile(afso);
		}
		
		/***************************
		 * 상담 주문 조회
		 ****************************/
		List<CounselOrderDetailVO> counselOrderList = this.counselOrderDetailService.listCounselOrderDetail(cusNo);

		/*********************************
		 * 상담 처리 조회
		 *********************************/
		CounselProcessSO cpso = new CounselProcessSO();
		cpso.setCusNo(cusNo);
		List<CounselProcessVO> counselProcessList = this.counselProcessService.listCounselProcess(cpso);

		
		model.addAttribute("counsel", counsel);
		model.addAttribute("counselFileList", counselFileList);
		model.addAttribute("counselProcessList", counselProcessList);
		model.addAttribute("counselOrderList", counselOrderList);
		
		// LayOut 설정
		String layOut = AdminConstants.LAYOUT_DEFAULT;
		
		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
			String titleYn = "Y";
			if(popTitleYn != null && !"".equals(popTitleYn)){
				titleYn = popTitleYn;
			}
			model.addAttribute("titleYn", titleYn);
		}
		model.addAttribute("viewGb", viewGb);
		model.addAttribute("popTitleYn", popTitleYn);		
		model.addAttribute("layout", layOut);

		if(popupYn != null && popupYn.equals(CommonConstants.COMM_YN_Y)) {
			return "/member/memberTab/counselWebViewPop";
		} else {
			return "/counsel/counselWebView";	
		}
	}	

	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselWebController.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 상담 기본 수정
	* </pre>
	* @param model
	* @param po
	* @param br
	* @return
	*/
	@RequestMapping("updateCounsel.do")
	public String updateCounsel(Model model, Long cusNo, String cusCtg2Cd, String cusCtg3Cd, 
			CounselProcessPO po) {
		
		//this.counselService.updateCounselCtg(cusNo, cusCtg2Cd, cusCtg3Cd);
		this.counselProcessService.updateCounselProcess(po);
		
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselWebController.java
	* - 작성일		: 2017. 5. 11.
	* - 작성자		: Administrator
	* - 설명			: 1:1 문의 답변 등록
	* </pre>
	* @param model
	* @param po
	* @param br
	* @return
	*/
	@RequestMapping("insertCounselProcess.do")
	public String insertCounselProcess(Model model, CounselProcessPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		this.counselProcessService.insertCounselProcess(po, true);
		return View.jsonView();
	}
	
}