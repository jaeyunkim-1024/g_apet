package admin.web.view.contents.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.contents.model.PetLogMgmtPO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.PetLogMgmtVO;
import biz.app.contents.service.PetLogMgmtService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PetLogMgmtController {
	
	@Autowired	private PetLogMgmtService petLogMgmtService;
	@Autowired  private MessageSourceAccessor messageSourceAccessor;
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 관리 페이지
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/petLogMgmt/petlogListView.do")
	public String petlogListView(Model model, PetLogMgmtSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlogListView");
			log.debug("==================================================");
		}

		model.addAttribute("petLogSO", so);
		return "/contents/petlogListView";
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 16.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/petLogMgmt/listPetLog.do", method = RequestMethod.POST)
	public GridResponse listPetLog(PetLogMgmtSO so) {	
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlog listPetLog");
			log.debug("==================================================");
		}

		Session session = AdminSessionUtil.getSession();
		if(so.getTag() != null && !"".equals(so.getTag())) {
			String[] tags = so.getTag().replace(" ", "").split(",");
			so.setTags(tags);
		}
		
		List<PetLogMgmtVO> list = petLogMgmtService.pagePetLog(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 일괄 업데이트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/petLogMgmt/updatePetLog.do")
	public String updatePetLog(Model model, PetLogMgmtSO so, String contsStatUpdateGb) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "updatePetLog");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
		Session session = AdminSessionUtil.getSession();
		
		Long[] petLogNos = so.getPetLogNos();
		String snctYn = so.getSnctYn();
		List<PetLogMgmtPO> petLogPOList = new ArrayList<>();
		for (Long petLogNo : petLogNos) {
			PetLogMgmtPO po = new PetLogMgmtPO();
			po.setPetLogNo(petLogNo);
			po.setContsStatCd(contsStatUpdateGb);
			po.setSnctYn(snctYn);
			po.setSysUpdrNo(session.getUsrNo());
			
			petLogPOList.add(po);
		}
		updateCnt = petLogMgmtService.updatePetLogStat(petLogPOList);


		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 상세 Layer View
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/petLogMgmt/popupPetLogDetail.do")
	public String popupPetLogDetail(Model model, PetLogMgmtSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlog popupPetLogDetail");
			log.debug("==================================================");
		}
		//TODO

		model.addAttribute("petLogSO", so);
		return "/contents/petlogListViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 신고내역조회 페이지
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/petLogMgmt/petlogReportView.do")
	public String petlogReportView(Model model, PetLogMgmtSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlogReportView");
			log.debug("==================================================");
		}

		model.addAttribute("petLogSO", so);
		return "/contents/petlogReportView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 신고내역 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/petLogMgmt/listPetLogReport.do", method = RequestMethod.POST)
	public GridResponse listPetLogReport(PetLogMgmtSO so) {	
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlog listPetLogReport");
			log.debug("==================================================");
		}

		Session session = AdminSessionUtil.getSession();
		
		List<PetLogMgmtVO> list = petLogMgmtService.pagePetLogReport(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 신고내역 엑셀다운로드
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @return
	 */
	@Deprecated
	@RequestMapping("/petLogMgmt/petLogReportExcelDownload.do")
	public String petLogReportExcelDownload(ModelMap model, PetLogMgmtSO so){
		//so.setSidx("po_no");
		//so.setSord("desc");
		so.setSort("sysRegDtm");
		so.setSord("DESC");
		so.setRows(999999999);

		List<PetLogMgmtVO> list = petLogMgmtService.pagePetLogReport(so);

		String[] headerName = {				  
				  messageSourceAccessor.getMessage("column.petlog_no") //번호
				, messageSourceAccessor.getMessage("column.content") //내용
				, messageSourceAccessor.getMessage("column.mbrNo") //등록자
				, messageSourceAccessor.getMessage("column.claim_mbr") //신고자
				, messageSourceAccessor.getMessage("column.rptp_rsn") //신고구분
				, messageSourceAccessor.getMessage("column.rptp_dt") //신고일
		};

		String[] fieldName = {
				  "petLogRptpNo"
				, "rptpContent"
				, "loginId"
				, "rptpLoginId"
				, "rptpRsnNm"				
				, "regModDtm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("petLogReport", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "petLogReport");

		return View.excelDownload();
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-41-admin
	 * - 파일명		: PetLogMgmtController.java
	 * - 작성일		: 2021. 1. 14. 
	 * - 작성자		: YJU
	 * - 설명			: 펫로그 검색 레이어
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/petLogMgmt/petLogSearchLayerView.do")
	public String vodSearchLayerView(Model model, PetLogMgmtSO so) {
		model.addAttribute("petLogSO", so);
		return "/contents/petLogSearchLayerView";
	}
}
