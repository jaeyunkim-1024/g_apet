package front.web.view.tv.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.app.tv.model.TvDetailReplyPO;
import biz.app.tv.model.TvDetailReplyRptpPO;
import biz.app.tv.model.TvDetailReplyRptpSO;
import biz.app.tv.model.TvDetailReplySO;
import biz.app.tv.model.TvDetailReplyVO;
import biz.app.tv.service.TvDetailReplyService;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.page.Paging;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명		: 31.front.web
* - 패키지명		: front.web.view.tv.controller
* - 파일명		: TvDetailReplyController.java
* - 작성일		: 2021. 01. 19.
* - 작성자		: hjh
* - 설명			: 펫 TV 상세 댓글 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("tv/reply")
public class TvDetailReplyController {
	@Autowired
	private TvDetailReplyService tvDetailReplyService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private TagService tagService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailReplyController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 리스트 조회
	 * </pre>
	 * @param session
	 * @param po
	 * @return
	 */
	@RequestMapping("selectTvDetailReplyList")
	@ResponseBody
	public ModelMap selectTvDetailReplyList(Session session, TvDetailReplySO so) {
		ModelMap map = new ModelMap();
		so.setRows(FrontWebConstants.PAGE_ROWS_20);
		so.setSord(FrontWebConstants.SORD_DESC);
		
		MemberBaseVO mbvo = new MemberBaseVO();
		if (!session.getMbrNo().equals(FrontConstants.NO_MEMBER_NO)) {
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(session.getMbrNo());
			mbvo = memberService.getMemberBase(mbso);
		}
		List<TvDetailReplyVO> replyList = tvDetailReplyService.selectTvDetailReplyList(so);
		map.put("replyList", replyList);
		map.put("mbvo", mbvo);
		map.put("paging", new Paging(so));
		map.put("page", so.getPage());
		map.put("so", so);
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailReplyController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 신고 등록
	 * </pre>
	 * @param session
	 * @param po
	 * @return
	 */
	@RequestMapping("insertTvDetailReplyRptp")
	@ResponseBody
	public ModelMap insertTvDetailReplyRptp(Session session, TvDetailReplyRptpPO po) {
		ModelMap map = new ModelMap();
		int rptpCnt = tvDetailReplyService.insertTvDetailReplyRptp(po);
		map.put("rptpCnt", rptpCnt);
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailReplyController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록/수정
	 * </pre>
	 * @param session
	 * @param po
	 * @return
	 */
	@RequestMapping("saveTvDetailReply")
	@ResponseBody
	public ModelMap saveTvDetailReply(Session session, TvDetailReplyPO po) {
		ModelMap map = new ModelMap();
		int replyResult = tvDetailReplyService.saveTvDetailReply(po);
		
		if (replyResult == 1) {
			map.put("replyGb", "I");
		} else {
			map.put("replyGb", "U");

			TvDetailReplySO so = new TvDetailReplySO();
			so.setVdId(po.getVdId());
			so.setAplySeq(po.getAplySeq());
			List<TvDetailReplyVO> replyList = tvDetailReplyService.selectTvDetailReplyList(so);
			po.setAply(replyList.get(0).getAply());
		}
		
		map.put("po", po);
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailReplyController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 삭제
	 * </pre>
	 * @param session
	 * @param po
	 * @return
	 */
	@RequestMapping("deleteTvDetailReply")
	@ResponseBody
	public ModelMap deleteTvDetailReply(Session session, TvDetailReplyPO po) {
		ModelMap map = new ModelMap();
		tvDetailReplyService.deleteTvDetailReply(po);
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailReplyController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 신고 중복 체크
	 * </pre>
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping("tvDetailReplyRptpDupChk")
	@ResponseBody
	public ModelMap tvDetailReplyRptpDupChk(Session session, TvDetailReplyRptpSO so) {
		ModelMap map = new ModelMap();
		int dupChkCnt = tvDetailReplyService.tvDetailReplyRptpDupChk(so);
		map.put("dupChkCnt", dupChkCnt);
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailReplyController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 태그 번호 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@RequestMapping("getPetTvReplyTagNo")
	@ResponseBody
	public ModelMap getPetTvReplyTagNo(TvDetailReplySO so) {
		ModelMap map = new ModelMap();
		TagBaseSO tbso = new TagBaseSO();
		tbso.setTagNm(so.getTagNm());
		TagBaseVO tbvo = tagService.getTagInfo(tbso);
		map.put("tagNo", tbvo.getTagNo());
		
		return map;
	}
}
