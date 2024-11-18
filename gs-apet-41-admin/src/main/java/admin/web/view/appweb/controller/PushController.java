package admin.web.view.appweb.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.appweb.model.PushPO;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.service.CodeService;
import biz.common.model.PushTargetPO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.ExcelUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.appweb.controller
 * - 파일명		: PushController.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 Controller
 * </pre>
 */
@Slf4j
@Controller
public class PushController {
	@Autowired
	private PushService pushService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BizService bizService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 목록
	 * </pre>
	 * @return
	 */
	@RequestMapping("/appweb/pushMessageView.do")
	public String pushMessageView(Model model, PushSO so) {
		if (!StringUtil.isEmpty(so.getNoticeTypeCd())) {
			model.addAttribute("noticeTypeCd", so.getNoticeTypeCd());
		}
		return "/appweb/pushMessageView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송현황 목록
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushStatusListView.do", method = RequestMethod.POST)
	public String pushStatusListView() {
		return "/appweb/pushStatusListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송현황 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/listPushStatusGrid.do", method = RequestMethod.POST)
	public GridResponse listPushStatusGrid(PushSO so) {
		List<PushVO> list = pushService.pageNoticeSendList(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송현황 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushMessageDetailView.do", method = RequestMethod.POST)
	public String pushMessageDetailView(Model model, @ModelAttribute("pushMessageDetailSo") PushSO so) {
		PushVO vo = pushService.getPushMessage(so);
		model.addAttribute("pushMessageDetail", vo);
		return "/appweb/pushMessageDetailViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 예약 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushReserveListView.do", method = RequestMethod.POST)
	public String pushReserveListView(PushSO so) {
		return "/appweb/pushReserveListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 예약 리스트 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/listPushReserveGrid.do", method = RequestMethod.POST)
	public GridResponse listPushReserveGrid(PushSO so) {
		List<PushVO> list = pushService.pageNoticeSendList(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송건수 상세 팝업
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushCountDetailView.do", method = RequestMethod.POST)
	public String pushCountDetailView(Model model, PushSO so) {
		PushVO vo = pushService.getPushMessage(so);
		model.addAttribute("pushCountDetail", vo);
		return "/appweb/pushCountDetailViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 건수 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/listPushCountGrid.do", method = RequestMethod.POST)
	public GridResponse listPushCountGrid(PushSO so) {
		List<PushVO> list = pushService.pageNoticeCnt(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: push 엑셀 다운로드
	 * </pre>
	 * @param so
	 * @return
	 */
	@RequestMapping("/appweb/pushCommonExcelDownload.do")
	public String pushCountExcelDownload(Model model, PushSO so) {
		String sheetName = so.getSheetName();
		String fileName = so.getFileName();
		
		List<PushVO> list = null;
		List<CodeDetailVO> codeList = null;
		CodeDetailSO cdSO = new CodeDetailSO();
		cdSO.setGrpCd(AdminConstants.PUSH_TMPL_VRBL);
		
		so.setRows(999999999);
		cdSO.setRows(999999999);
		
		if (so.getPushTpGb().equals("status")) {
			list = pushService.pageNoticeSendList(so);
		} else if (so.getPushTpGb().equals("reserve")) {
			list = pushService.pageNoticeSendList(so);
		} else if (so.getPushTpGb().equals("pushCount")) {
			list = pushService.pageNoticeCnt(so);
		} else if (so.getPushTpGb().equals("tmplList") || so.getPushTpGb().equals("tmplSelectList")) {
			list = pushService.pageNoticeTemplate(so);
		} else if (so.getPushTpGb().equals("variableList")) {
			codeList = codeService.pageCodeDetail(cdSO);
		}
		// 엑셀 데이터 값
		String[] headerName = so.getHeaderName();
		String[] fieldName = so.getFieldName();
		
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(sheetName, headerName, fieldName, so.getPushTpGb().equals("variableList") ? codeList : list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, fileName);
		return View.excelDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 수신 대상자 엑셀 업로드
	 * </pre>
	 * @param so
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/appweb/pushMsgSendExcelUpload.do", method = RequestMethod.POST)
	public String pushMsgSendExcelUploadExec(Model model, PushSO so, @RequestParam("fileName") String fileName,
			@RequestParam("filePath") String filePath) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("==================================================");
		}

		List<PushVO> pushMemberExcelListVO = null;

		File excelFile = null;
		if (StringUtil.isNotEmpty(filePath)) {
			excelFile = new File(filePath);
		}
		
		String[] headerMap = new String[]{"회원 번호"};
		String[] fieldMap = new String[]{"mbrNo"};
		try {
			// 엑셀데이타
			pushMemberExcelListVO = ExcelUtil.parse(excelFile, PushVO.class, fieldMap, 1);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
		}
		
		ArrayList<String> headerList = ExcelUtil.getHeaderList(excelFile);
		boolean validateYn = true;
		
		// 기존 엑셀 양식과 업로드 받은 엑셀 양식 비교
		if(headerMap.length != headerList.size()) {
			validateYn = false;
		}else {
			for(int i = 0 ; i < headerMap.length ; i ++) {
				log.info("headerMap : " + headerMap[i]);
				log.info("headerList : " + headerList.get(i));
				log.info("equals : " + StringUtil.equals(headerMap[i], headerList.get(i)));
				if(!StringUtil.equals(headerMap[i], headerList.get(i))) {
					validateYn = false;
				}
			}
		}
		
		// 엑셀 양식이 맞지 않을 경우
		if(!validateYn) {
			throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
		}

		// 읽은 파일 삭제
		if (!excelFile.delete()) {
			log.error("Fail to delete of file. PushController.pushMsgSendExcelUploadExec::excelFile.delete {}");
		}
		
		List<PushVO> resultList = new ArrayList<>();
		List<MemberBaseVO> memberList = new ArrayList<>();
		List<String> mbrNos = new ArrayList<>();
		if (CollectionUtils.isNotEmpty(pushMemberExcelListVO)) {
			for(PushVO pushVO : pushMemberExcelListVO) {
				log.debug("pushVO.getMbrNo() ::::=====" + pushVO.getMbrNo());
				if (pushVO.getMbrNo() == null) {
					throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
				}
				if (pushVO.getMbrNo() == 0L) {
					throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
				}
				mbrNos.add(pushVO.getMbrNo().toString());
			}
			
			String[] arrMbrNos = new String[mbrNos.size()];
			for(int i=0; i<arrMbrNos.length; i++) {
				arrMbrNos[i] = mbrNos.get(i);
			}
			MemberBaseSO mbSO = new MemberBaseSO();
			mbSO.setMbrNos(arrMbrNos);
			mbSO.setRows(arrMbrNos.length);
			memberList = memberService.pageMemberBase(mbSO);
			for(MemberBaseVO vo : memberList) {
				PushVO resultPushVO = new PushVO();
				resultPushVO.setMbrNo(vo.getMbrNo());
				resultPushVO.setMbrNm(vo.getMbrNm());
				resultPushVO.setLoginId(vo.getLoginId());
				resultList.add(resultPushVO);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
		}
		
		model.addAttribute("resultList", resultList);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 목록
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/appweb/pushTemplateListView")
	public String pushTemplateListView() {
		return "/appweb/pushTemplateListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/listPushTemplateGrid.do", method = RequestMethod.POST)
	public GridResponse listPushTemplateGrid(PushSO so) {
		List<PushVO> list = pushService.pageNoticeTemplate(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 상세 팝업
	 * </pre>
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushTemplateDetailViewPop.do", method = RequestMethod.POST)
	public String pushTemplateDetailViewPop(Model model, PushSO so) {
		PushVO vo = pushService.getNoticeTemplate(so);
		model.addAttribute("noticeTemplateInfo", vo);
		return "/appweb/pushTemplateDetailViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 등록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/appweb/pushTemplateInsertView.do")
	public String pushTemplateInsertView() {
		return "/appweb/pushTemplateInsertView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping("/appweb/saveNoticeTemplate.do")
	public String saveNoticeTemplate(PushPO po) {
		pushService.saveNoticeTemplate(po);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping("/appweb/deleteNoticeTemplate.do")
	public String deleteNoticeTemplate(PushPO po) {
		pushService.deleteNoticeTemplate(po);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 변수 리스트 팝업
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushVariableViewPop.do", method = RequestMethod.POST)
	public String pushVariableViewPop() {
		return "/appweb/pushVariableViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 변수 리스트 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/listPushVariableGrid.do", method = RequestMethod.POST)
	public GridResponse listPushVariableGrid(CodeDetailSO so) {
		so.setGrpCd(AdminConstants.PUSH_TMPL_VRBL);
		so.setSidx("SORT_SEQ");
		so.setSord("ASC");
		List<CodeDetailVO> list = codeService.pageCodeDetail(so);
		
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송하기 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/appweb/pushMessageSendView.do")
	public String pushMsgSendView(Model model, PushSO so) {
		PushVO vo = new PushVO();
		if (so.getTmplNo() != null) {
			vo = pushService.getNoticeTemplate(so);
			model.addAttribute("noticeSendInfo", vo);
		}
		
		return "/appweb/pushMessageSendView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송하기 화면 팝업
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushMessageSendViewPop.do", method = RequestMethod.POST)
	public String pushMessageSendViewPop(Model model, PushSO so) {
		List<PushVO> list = new ArrayList<>();
		if (so.getNoticeSendNo() != null) {
			list = pushService.listPushMsgSendView(so);
			model.addAttribute("noticeSendInfoList", list);
		}
		
		return "/appweb/pushMessageSendViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/appweb/updateNoticeSendList.do", method = RequestMethod.POST)
	public String updateNoticeSendList(PushPO po) {
		pushService.updateNoticeSendList(po);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/appweb/deleteNoticeSendList.do", method = RequestMethod.POST)
	public String deleteNoticeSendList(PushPO po) {
		pushService.deleteNoticeSendList(po);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 선택 팝업
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/appweb/pushTemplateSelectView.do", method = RequestMethod.POST)
	public String pushTemplateSelectView() {
		return "/appweb/pushTemplateSelectViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송하기
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/appweb/sendPushMessage.do", method = RequestMethod.POST)
	public String sendPushMessage(PushPO po) {
		po.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysUseYn(CommonConstants.SYS_USE_YN_N);
		pushService.sendPushMessage(po);
		return View.jsonView();
	}
	
}
