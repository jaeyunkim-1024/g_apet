package admin.web.view.event.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.event.model.*;
import biz.app.event.service.EventService;
import biz.app.goods.model.GoodsCommentVO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.event.controller
* - 파일명		: EventController.java
* - 작성일		: 2016. 6. 20.
* - 작성자		: valueFactory
* - 설명			:
* </pre>
*/
@Slf4j
@Controller
public class EventController {

	@Autowired
	private EventService eventService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	@Autowired
	private Properties bizConfig;

	@Autowired
	private Properties webConfig;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventController.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 등록 페이지
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/event/eventInsertView.do")
	public String eventInsertView (Model model ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Event 등록");
			log.debug("==================================================");
		}
		model.addAttribute("strtDtm",DateUtil.getNowDateTime());
		model.addAttribute("endDtm", DateUtil.getDatePickerValue(1,"M"));
		return "/event/eventInsertView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventController.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 등록
	* </pre>
	* @param model
	* @param eventBaseStr
	* @param eventQuestionStr
	* @return
	*/
	@RequestMapping(value = "/event/eventInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
 	public String eventInsert (Model model
 			, EventBasePO eventBasePO ) {
		// 이벤트 기본정보
		Long eventNo = eventService.saveEvent(eventBasePO);
		model.addAttribute("eventNo", eventNo);
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventController.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 상세 조회
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping(value = "/event/eventDetailView.do")
	public String eventDetailView (Model model, EventBaseSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Event 상세 ");
			log.debug("==================================================");
		}

		Long eventNo = so.getEventNo();
		model.addAttribute("vo", eventService.getEventBase(eventNo));

		return "/event/eventDetailView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EventController.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 수정
	* </pre>
	* @param model
	* @param eventBaseStr
	* @param eventQuestionStr
	* @return
	*/
	@RequestMapping(value = "/event/eventUpdate.do")
	public String eventUpdate (Model model, EventBasePO po) {
		Long eventNo = eventService.saveEvent(po);
		model.addAttribute("vo", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: EventController.java
	 * - 작성일		: 2016. 06. 20.
	 * - 작성자		: joeunok
	 * - 설명		: 이벤트 관리 화면
	 * </pre>
	 * @param so
	 * @return
	*/
	@RequestMapping("/event/eventListView.do")
	public String boardListView(Model model) {
		return "/event/eventListView";
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: EventController.java
	 * - 작성일		: 2016. 6. 20.
	 * - 작성자		: joeunok
	 * - 설명		: 이벤트 목록 그리드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/event/eventBaseGrid.do", method=RequestMethod.POST)
	public GridResponse eventBaseGrid(Model model, EventBaseSO so) {
		List<EventBaseVO> list = eventService.pageEventBase(so);
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/event/listQuestionAndAnswerInfo.do", method=RequestMethod.POST)
	public List listQuestionAndAnswerInfo(Model model, Long eventNo) {
		return eventService.listQuestionAndAnswerInfo(eventNo);
	}
	@ResponseBody
	@RequestMapping(value="/event/listEventAddField.do", method=RequestMethod.POST)
	public List listEventAddField(Model model, Long eventNo) {
		return eventService.listEventAddField(eventNo);
	}

	@RequestMapping(value="/event/eventParticipantManageView.do")
	public String eventParticipantManageView(Model model,EventBaseSO so){
		model.addAttribute("vo",eventService.getEventBase(so.getEventNo()));
		return "/event/eventParticipantManageView";
	}

	@RequestMapping(value="/event/eventParticipantView.do")
	public String eventParticipantView(Model model,EventBaseSO so){
		model.addAttribute("vo",eventService.getEventBase(so.getEventNo()));
		return "/event/eventParticipantView";
	}

	@ResponseBody
	@RequestMapping(value="/event/creatParticipantGrid.do")
	public GridResponse creatParticipantGrid(EventEntryWinInfoSO so){
		so.setSidx("EEI.SYS_UPD_DTM");
		so.setSord("DESC");
		List<EventEntryWinInfoVO> list = eventService.pageEventJoinMember(so);
		return new GridResponse(list, so);
	}

	@RequestMapping(value="/event/eventWinnerView.do")
	public String eventWinnerView(Model model,EventBaseSO so){
		model.addAttribute("vo",eventService.getEventWinInfo(so));
		return "/event/eventWinnerView";
	}

	@ResponseBody
	@RequestMapping(value="/event/creatWinnerGrid.do")
	public GridResponse creatWinnerGrid(EventEntryWinInfoSO so){
		List<EventBaseVO> list = eventService.pageEventWinnerMember(so);
		return new GridResponse(list, so);
	}

	@RequestMapping(value = "/event/eventWinnerPopView.do", method = RequestMethod.POST)
	public String eventWinnerPopView(Model model, EventBaseSO so) {
		model.addAttribute("vo", Optional.ofNullable(eventService.getEventWinInfo(so)).orElseGet(
				()->new EventBaseVO()));
		return "/event/eventWinnerPopView";
	}

	/**
	 * <pre>
	 * - Method 명	: eventWinnerUploadCsv
	 * - 작성일		: 2020. 7. 28.
	 * - 작성자		: pcm
	 * - 설 명		: 이벤트 당첨 목록 등록/수정
	 * </pre>
	 *
	 * @param po
	 * @param rowData
	 */
	@RequestMapping(value = "/event/eventWinnerUploadCsv.do", method = RequestMethod.POST)
	public String eventWinnerUploadCsv(EventBasePO po) {
		if(StringUtil.isNotEmpty(Optional.ofNullable(po.getFilePath()).orElseGet(()->""))) {
			String uploadBase = bizConfig.getProperty("common.file.upload.base");
			String row = null;
			List<String> csvData = new ArrayList<String>();
			File csvFile = new File(uploadBase + FileUtil.SEPARATOR + FilenameUtils.getPath(po.getFilePath()), FilenameUtils.getName(po.getFilePath()));// 파싱할 Excel File
			BufferedReader csvReader = null;
			//보안 진단. 부적절한 자원 해제 (IO)
			FileReader fr = null;
			try {
				fr = new FileReader(csvFile);
				csvReader = new BufferedReader(fr);
				while ((row = csvReader.readLine()) != null) {
					csvData.add(row);
				}
				csvReader.close();
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
			} finally {
				try {
					if(fr !=null) {
						fr.close();
					}
				} catch (IOException e2) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e2);
					throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
				}
				
			}

			po.setNotOpenYn(Optional.ofNullable(po.getNotOpenYn()).orElseGet(()-> AdminConstants.COMM_YN_N));
			po.setCsvData(csvData);
			eventService.insertEventWinList(po);
		}

		return View.jsonView();
	}
}