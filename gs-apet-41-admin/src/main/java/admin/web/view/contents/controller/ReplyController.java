package admin.web.view.contents.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.contents.model.ContentsReplyPO;
import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;
import biz.app.contents.service.ReplyService;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.contents.controller
 * - 파일명		: ReplyController.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 댓글 Controller
 * </pre>
 */
@Slf4j
@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 목록
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/contents/indexApetReplyList.do")
	public String indexApetReplyList(Model model) {
		model.addAttribute("replyGb", "apet");
		return "/contents/apetReplyListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/listApetReplyGrid.do", method = RequestMethod.POST)
	public GridResponse listApetReplyGrid(ContentsReplySO so) {
		List<ContentsReplyVO> list = replyService.listApetReplyGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설 명		: 공통 댓글쓰기 팝업
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/contents/popupReplyWrite.do", method = RequestMethod.POST)
	public String popupReplyWrite(Model model, ContentsReplySO so) {
		if (so.getAplySeq() != null) {
			ContentsReplyVO vo = replyService.getApetReply(so);
			model.addAttribute("contsReplyInfo", vo);
		}
		return "/contents/replyWriteViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 목록
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/contents/indexPetLogReplyList.do")
	public String indexPetLogReplyList(Model model) {
		model.addAttribute("replyGb", "petlog");
		return "/contents/petLogReplyListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/listPetLogReplyGrid.do", method = RequestMethod.POST)
	public GridResponse listPetLogReplyGrid(ContentsReplySO so) {
		List<ContentsReplyVO> list = replyService.listPetLogReplyGrid(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/contents/updateApetReplyContsStat.do", method = RequestMethod.POST)
	public String updateApetReplyContsStat(ContentsReplyPO po) {
		replyService.updateApetReplyContsStat(po);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/contents/updatePetLogReplyContsStat.do", method = RequestMethod.POST)
	public String updatePetLogReplyContsStat(ContentsReplyPO po) {
		replyService.updatePetLogReplyContsStat(po);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/contents/saveApetReply.do", method = RequestMethod.POST)
	public String saveApetReply(ContentsReplyPO po) {
		replyService.saveApetReply(po);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/contents/deleteApetReply.do", method = RequestMethod.POST)
	public String deleteApetReply(ContentsReplyPO po) {
		replyService.deleteApetReply(po);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 목록
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/contents/apetReplyRptpListView.do")
	public String apetReplyRptpListView(Model model) {
		model.addAttribute("replyGb", "apetRptp");
		return "/contents/apetReplyRptpListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/listApetReplyRptpGrid.do", method = RequestMethod.POST)
	public GridResponse listApetReplyRptpGrid(ContentsReplySO so) {
		List<ContentsReplyVO> list = replyService.pageApetReplyRptp(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설 명		: 펫TV 댓글 신고 상세 팝업
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/contents/apetReplyRptpDetailView.do", method = RequestMethod.POST)
	public String apetReplyRptpDetailView(Model model, ContentsReplySO so) {
		if (so.getAplySeq() != null) {
			ContentsReplyVO vo = replyService.getApetReply(so);
			model.addAttribute("contsReplyInfo", vo);
		}
		return "/contents/apetReplyRptpDetailViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 신고 목록
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/contents/petLogReplyRptpListView.do")
	public String petLogReplyRptpListView(Model model) {
		model.addAttribute("replyGb", "petLogRptp");
		return "/contents/petLogReplyRptpListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyController.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/listPetLogReplyRptpGrid.do", method = RequestMethod.POST)
	public GridResponse listPetLogReplyRptpGrid(ContentsReplySO so) {
		List<ContentsReplyVO> list = replyService.pagePetLogReplyRptp(so);
		return new GridResponse(list, so);
	}
	
}
