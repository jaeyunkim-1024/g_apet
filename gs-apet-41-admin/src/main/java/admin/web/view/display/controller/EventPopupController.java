package admin.web.view.display.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupPO;
import biz.app.display.model.EventPopupVO;
import biz.app.display.service.EventPopupService;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EventPopupController {

	@Autowired
	private EventPopupService eventPopupService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너조회
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/display/eventPopupListView.do")
	public String eventPopupListView(Model model){
		return "/display/eventPopupListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너조회 그리드 조회
	* </pre>
	* @param model
	* @param popupSO
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/display/eventPopupListGrid.do", method=RequestMethod.POST)
	public GridResponse eventPopupListGrid(Model model, EventPopupSO so) {
		List<EventPopupVO> list = eventPopupService.pageEventPopupList(so);
		return new GridResponse(list, so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너등록화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/display/eventPopupInsertView.do")
	public String eventPopupInsertView (Model model ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "POPUP 등록");
			log.debug("==================================================");
		}

		return "/display/eventPopupInsertView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너등록
	* </pre>
	* @param model
	* @param EventPopupPO
	* @return
	*/
	@RequestMapping(value = "/display/eventPopupInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String eventPopupInsert (Model model, EventPopupPO po) {
		int insertCnt = eventPopupService.insertEventPopup(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("POPUP 등록 : {}", "eventPopupInsert");
			log.debug("==================================================");
		}
		model.addAttribute("insertCnt", insertCnt );

		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너수정
	* </pre>
	* @param model
	* @param EventPopupPO
	* @return
	*/
	@RequestMapping(value = "/display/eventPopupUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String eventPopupUpdate (Model model, EventPopupPO po) {
		int resultCnt = eventPopupService.updateEventPopup(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("POPUP 수정 : {}", "eventPopupUpdate");
			log.debug("==================================================");
		}
		model.addAttribute("updateCnt", resultCnt );

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너상세
	* </pre>
	* @param model
	* @param EventPopupSO
	* @return
	*/
	@RequestMapping("/display/eventPopupDetailView.do")
	public String eventPopupDetailView (Model model, EventPopupSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		EventPopupVO EventPopupVO = eventPopupService.getEventPopupDetail(so );

		model.addAttribute("evtpop", EventPopupVO );
		return "/display/eventPopupDetailView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventPopupController.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너삭제
	* </pre>
	* @param model
	* @param EventPopupPO
	* @return
	*/
	@RequestMapping(value = "/display/eventPopupDelete.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String eventPopupDelete (Model model, EventPopupPO po) {
		int resultCnt = eventPopupService.deleteEventPopup(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("이벤트POPUP 삭제 : {}", "eventPopupDelete");
			log.debug("==================================================");
		}
		model.addAttribute("updateCnt", resultCnt );

		return View.jsonView();
	}
	
	@RequestMapping("/display/eventPopupExcelDownload.do")
	public String eventPopupExcelDownload(ModelMap model, EventPopupSO so){
		so.setRows(999999999);		
		so.setExcelYn("Y");

		List<EventPopupVO> list = eventPopupService.pageEventPopupList(so);

		String[] headerName = {
				  "번호"
				, "게시구분"
				, "제목"
				, "위치"
				, "게시시간"
				, "노출순서"
				, "작성자"
				, "등록일"
				, "진행여부"
				, "게시여부"
		};

		String[] fieldName = {
				  "rowIndex"
				, "evtpopGbNm"
				, "evtpopTtl"
				, "evtpopLocNm"
				, "strtEndDtm"
				, "evtpopSortSeq"
				, "sysRegrNm"
				, "sysRegDtm"
				, "progressStatNm"
				, "evtpopStatNm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("PopupBannerList", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "PopupBannerList");

		return View.excelDownload();
	}



}
