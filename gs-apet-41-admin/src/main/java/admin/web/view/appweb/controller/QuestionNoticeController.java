package admin.web.view.appweb.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.web.config.view.View;
import biz.app.system.model.BbsBaseVO;
import biz.app.system.model.BbsGbSO;
import biz.app.system.model.BbsLetterPO;
import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.BbsLetterVO;
import biz.app.system.model.BbsPocVO;
import biz.app.system.model.BbsSO;
import biz.app.system.service.BoardService;
import biz.common.model.AttachFileSO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class QuestionNoticeController {
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Autowired
	private BoardService boardService;

	@Autowired
	private BizService bizService;

	@Autowired
	private CacheService cacheService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: QuestionNoticeController.java
	 * - 작성일		: 2020. 12. 29
	 * - 작성자		: 이지희
	 * - 설명		: APP/Web > FAQ 화면
	 * </pre>
	 * @param so
	 * @return
	*/
	@RequestMapping("/appweb/faqListView.do")
	public String bbsListView(Model model, BbsSO so) {
		so.setBbsId("dwFaq");
		BbsBaseVO vo = boardService.getBoardBase(so);
		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("board", vo);
		
		BbsGbSO gbSo = new BbsGbSO();
		gbSo.setBbsId(vo.getBbsId());
		model.addAttribute("gb", boardService.listBoardGb(gbSo));
		
		return "/appweb/faqListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2020. 12. 29
	 * - 작성자		: 이지희
	 * - 설명		: APP/Web > FAQ 등록 /수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/appweb/faqWriteView.do")
	public String bbsView(Model model, BbsSO so, BbsGbSO gbSo, BbsLetterSO bbsLetterSO, BindingResult br, String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		so.setBbsId(bbsId);
		gbSo.setBbsId(bbsId);

		BbsBaseVO vo = boardService.getBoardBase(so);
		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("board", vo);
		
		BbsLetterVO bbsLetterVO  = new BbsLetterVO();
		//등록인 경우
		if(bbsLetterSO.getLettNo() == null) {
			bbsLetterVO.setLettNo(bizService.getSequence(AdminConstants.SEQUENCE_BBS_LETTER_SEQ).longValue());
		}else {
			//수정인 경우
			bbsLetterVO = boardService.getBbsLetter(bbsLetterSO);
			model.addAttribute("hist",boardService.getBbsLetterHist(bbsLetterSO));
		}
		model.addAttribute("bbsLetter", bbsLetterVO);
		model.addAttribute("listBoardGb", boardService.listBoardGb(gbSo));
		model.addAttribute("session", AdminSessionUtil.getSession());
		

		if(bbsLetterVO != null && AdminConstants.USE_YN_Y.equals(vo.getFlUseYn())) {
			AttachFileSO attachFileSO = new AttachFileSO();
			attachFileSO.setFlNo(bbsLetterVO.getFlNo());
			model.addAttribute("listFile", bizService.listAttachFile(attachFileSO));
		}
		
		return "/appweb/faqWriteView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: QuestionNoticeController.java
	 * - 작성일		: 2020. 12. 29
	 * - 작성자		: 이지희
	 * - 설명		: APP/Web > FAQ 화면
	 * </pre>
	 * @param so
	 * @return
	*/
	@RequestMapping("/appweb/NoticeListView.do")
	public String noticeListView(Model model, BbsSO so) {
		so.setBbsId("dwNotice");
		BbsBaseVO vo = boardService.getBoardBase(so);
		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("board", vo);
		
		BbsGbSO gbSo = new BbsGbSO();
		gbSo.setBbsId(vo.getBbsId());
		model.addAttribute("gb", boardService.listBoardGb(gbSo));
		
		return "/appweb/noticeListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2021. 01. 04
	 * - 작성자		: 이지희
	 * - 설명		: APP/Web > 공지사항 등록 /수정 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/appweb/NoticeWriteView.do")
	public String noticeUpdate(Model model, BbsSO so, BbsGbSO gbSo, BbsLetterSO bbsLetterSO, BindingResult br, String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		so.setBbsId(bbsId);
		gbSo.setBbsId(bbsId);

		BbsBaseVO vo = boardService.getBoardBase(so);
		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("board", vo);
		
		BbsLetterVO bbsLetterVO  = new BbsLetterVO();
		//등록인 경우
		if(bbsLetterSO.getLettNo() == null) {
			bbsLetterVO.setLettNo(bizService.getSequence(AdminConstants.SEQUENCE_BBS_LETTER_SEQ).longValue());
		}else {
			//수정인 경우
			bbsLetterVO = boardService.getBbsLetter(bbsLetterSO);
		}
		model.addAttribute("bbsLetter", bbsLetterVO);
		model.addAttribute("listBoardGb", boardService.listBoardGb(gbSo));
		model.addAttribute("bbsStat", cacheService.listCodeCache(AdminConstants.BBS_STAT_CD, null, null, null, null, null));
		

		return "/appweb/noticeWriteView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2021. 01. 04
	 * - 작성자		: 이지희
	 * - 설명		: APP/Web > 공지사항 등록 /수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/appweb/noticeLetterInsert.do")
	public String noticeLetterInsert(Model model, BbsLetterPO po, BindingResult br){
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		String orginPoc = "";
		//poc 비교
		if(po.getUsrDfn4Val() != null && !po.getUsrDfn4Val().equals("")  ) {
			orginPoc = po.getUsrDfn4Val();
			po.setUsrDfn4Val(null); 
		}
		
		po.setBbsId(AdminConstants.BBS_ID_NOTICE);
		
		//update 할 때
		if(po.getUsrDfn5Val() != null && !po.getUsrDfn5Val().equals("")  ) {
			po.setUsrDfn5Val(null);
			boardService.updateBbsLetter(po); 
			
			List<BbsPocVO> pocList = new ArrayList<BbsPocVO>();
			
			List<String> originList = Arrays.asList(orginPoc.split(","));
			List<String> nowList = Arrays.asList(po.getArrPocGb());
			if(!originList.equals(nowList)) {
				
				for(int i = 0 ; i< nowList.size(); i++) {
					String n = nowList.get(i);
					int cnt = 0;
					for(int j = 0 ; j<originList.size() ; j++) {
						if(n.equals(originList.get(j))) {
							cnt++;
						}
					}
					if(cnt == 0) { //insert
						BbsPocVO vo = new BbsPocVO();
						vo.setLettNo(po.getLettNo());
						vo.setPocGbCd(Long.parseLong(n));
						vo.setSysRegrNo(po.getSysRegrNo());
						pocList.add(vo);
					}
				}
				if(pocList.size() > 0 ) {boardService.insertLetterPoc(pocList);}
						
				List<BbsPocVO> delPocList = new ArrayList<BbsPocVO>();		
				if(orginPoc != null && !orginPoc.equals("")) {
					for(int i = 0 ; i< originList.size(); i++) {
						String o = originList.get(i);
						int cnt = 0;
						for(int j = 0 ; j<nowList.size() ; j++) {
							if(o.equals(nowList.get(j))) {
								cnt++;
							}
						}
						if(cnt == 0) { //delete
							BbsPocVO vo = new BbsPocVO();
							vo.setLettNo(po.getLettNo());
							vo.setPocGbCd(Long.parseLong(o));
							delPocList.add(vo);
						}
					}
				}
				if(delPocList.size() > 0 ) {boardService.deleteLetterPoc(delPocList);}
			}
				
		}else { //insert 할 때
			
			boardService.insertBbsLetter(po);
			
			List<BbsPocVO> pocList = new ArrayList<BbsPocVO>();
			
			for(String poc : po.getArrPocGb()) {
				BbsPocVO vo = new BbsPocVO();
				vo.setLettNo(po.getLettNo());
				vo.setPocGbCd(Long.parseLong(poc));
				vo.setSysRegrNo(po.getSysRegrNo());
				pocList.add(vo);
			}
			
			if(pocList.size() > 0 ) {boardService.insertLetterPoc(pocList);} 
			
			
		}
		
		//알림 발송 - almSndYn="Y"이고, 상태가 '게시중' 이고, 게시시작날짜가 미래가 아닐 떄. + 알림발송날짜가 null일때
		if(po.getAlmSndYn().equals("Y") && po.getBbsStatCd().equals(CommonConstants.BBS_STAT_SHOW) ) {
			BbsLetterSO bbsLetterSO = new BbsLetterSO();
			bbsLetterSO.setLettNo(po.getLettNo());
			bbsLetterSO.setBbsId(AdminConstants.BBS_ID_NOTICE); 
			BbsLetterVO lettVO = boardService.getBbsLetter(bbsLetterSO);
			if(lettVO.getAlmSndDtm() == null) {
				
					SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd");
					String strtDate = format.format(po.getBbsStrtDtm());
					String nowDate = format.format(new Date());
					
					if( po.getBbsStrtDtm().before(new Date()) || strtDate.equals(nowDate)) {
						//알림발송하기
						log.debug("send alarm!!!!!!!!!!!!!!!!!!!!!!!!"); 
					}
			}
		}
		
		model.addAttribute("bbsLetter", po);
		return View.jsonView();
	}
	
}
