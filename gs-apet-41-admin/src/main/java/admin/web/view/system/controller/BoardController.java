package admin.web.view.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.system.model.BbsBasePO;
import biz.app.system.model.BbsBaseVO;
import biz.app.system.model.BbsGbPO;
import biz.app.system.model.BbsGbSO;
import biz.app.system.model.BbsLetterDispPO;
import biz.app.system.model.BbsLetterDispSO;
import biz.app.system.model.BbsLetterDispVO;
import biz.app.system.model.BbsLetterGoodsSO;
import biz.app.system.model.BbsLetterGoodsVO;
import biz.app.system.model.BbsLetterPO;
import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.BbsLetterVO;
import biz.app.system.model.BbsPocVO;
import biz.app.system.model.BbsReplyPO;
import biz.app.system.model.BbsReplySO;
import biz.app.system.model.BbsSO;
import biz.app.system.service.BoardService;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileSO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

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
@Slf4j
@Controller
public class BoardController {

	/**
	 * 게시판 서비스
	 */
	@Autowired
	private BoardService boardService;

	@Autowired
	private BizService bizService;

	@Autowired
	private CacheService cacheService;

	/**
	 * 메시지
	 */
	@Autowired
	private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 화면
	 * </pre>
	 * @param so
	 * @return
	*/
	@RequestMapping("/system/boardListView.do")
	public String boardListView(Model model) {
		return "/system/boardListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 리스트
	 * </pre>
	 * @param so
	 * @return
	*/
	@ResponseBody
	@RequestMapping(value="/system/boardList.do", method=RequestMethod.POST)
	public GridResponse boardListGrid(Model model, BbsSO so) {
		so.setSidx("A.SYS_REG_DTM");
		so.setSord("DESC");
		List<BbsBaseVO> list = boardService.pageBoardBase(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 등록/상세 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping({"/system/boardView.do", "/system/boardReg.do"})
	public String boardView(Model model, BbsSO so, BbsGbSO gbSo, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("board", boardService.getBoardBase(so));
		model.addAttribute("listBoardGb", boardService.listBoardGb(gbSo));

		return "/system/boardView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 등록 / 구분자 리스트 등록
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/system/boardInsert.do")
	public String boardInsert(BbsBasePO bbsInPO, @RequestParam(value="bbsInGbStr", required=false) String bbsInGbStr) {

		JsonUtil jsonUtil = new JsonUtil();
		List<BbsGbPO> list = null;

		if(StringUtil.isNotBlank(bbsInGbStr)) {
			list = jsonUtil.toArray(BbsGbPO.class, bbsInGbStr);
		}
		boardService.insertBoardBase(bbsInPO, list);
		
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 수정 / 구분자 리스트 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/system/boardUpdate.do")
	public String boardUpdate(BbsBasePO basePo, @RequestParam(value="bbsInGbStr", required=false) String bbsInGbStr, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		JsonUtil jsonUtil = new JsonUtil();
		List<BbsGbPO> list = null;

		if(StringUtil.isNotBlank(bbsInGbStr)) {
			list = jsonUtil.toArray(BbsGbPO.class, bbsInGbStr);
		}

		boardService.updateBoardBase(basePo, list);
		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 삭제
	 * </pre>
	 * @param model
	 * @param displayCornerItemListStr
	 * @return
	 */
	@RequestMapping("/system/boardDelete.do")
	public String boardDelete(Model model, BbsBasePO po) {
		boardService.deleteBoardBase(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 05. 04
	 * - 작성자		: eojo
	 * - 설명		: 게시판 구분자 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/system/boardGbDelete.do")
	public String boardGbDelete(Model model, BbsGbPO po) {
		boardService.deleteBoardGb(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 등록  > 중복 검사
	 * </pre>
	 * @param so
	 * @return
	*/
	@RequestMapping("/system/bbsIdCheck.do")
	public String userIdCheck(Model model, BbsBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		int cnt = boardService.getBbsIdCheck(po.getBbsId());

		if(cnt > 0){
			model.addAttribute("message", message.getMessage(AdminConstants.EXCEPTION_MESSAGE_COMMON + ExceptionConstants.ERROR_USER_DUPLICATION_FAIL));
		}

		model.addAttribute("checkCount", cnt);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 20
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 화면
	 * </pre>
	 * @param so
	 * @return
	*/
	@RequestMapping("/{bbsId}/bbsLetterListView.do")
	public String bbsListView(Model model, BbsSO so, @PathVariable("bbsId") String bbsId) {
		so.setBbsId(bbsId);
		BbsBaseVO vo = boardService.getBoardBase(so);
		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		String url;
		if(StringUtil.equals(bbsId, "COMPFAQ")) {
			url = "/system/compfaqListView";
		}else {
			url = "/system/bbsLetterListView";
		}
		
		model.addAttribute("board", vo);
		return url;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 리스트
	 * </pre>
	 * @param so
	 * @return
	*/
	@ResponseBody
	@RequestMapping(value="/{bbsId}/bbsLetterListGrid.do", method=RequestMethod.POST)
	public GridResponse boardDetailList(Model model, BbsLetterSO so, @PathVariable("bbsId") String bbsId) {
		//log.debug("@@@ : {}->",so);
		so.setBbsId(bbsId);
		
		if(so.getArrPocGb() != null && so.getArrPocGb().length > 0) {
			List<Map<String,Object>> listmap = new ArrayList<Map<String,Object>>(); 
			
			for(String pocNo : so.getArrPocGb()) {
				Map<String,Object> pocMap = new HashMap<String,Object>();
				pocMap.put("pocGbCd", pocNo);
				String viewName = "VIEW"+pocNo;
				pocMap.put("viewNm", viewName); 
				listmap.add(pocMap);
			}
			so.setListPocGb(listmap);
		}
		List<BbsLetterVO> list = boardService.pageBbsLetter(so);
		
		//poc 공통코드 명으로 세팅
		if(list != null && list.size() > 0) {
			for(BbsLetterVO letter : list) {
				if(letter.getPocGbCd() != null && !letter.getPocGbCd().equals("")) {
				
					String pocStr = "";
					for(String poc : letter.getPocGbCd().split(",")) {
						String pocNM = cacheService.getCodeName(AdminConstants.POC_GB, poc);
						pocStr += pocNM +",";
					}
					pocStr =pocStr.substring(0, pocStr.length()-1);
					
					letter.setPocGbCd(pocStr);
				}
			}
		}
		
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 20
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 >  게시 글 등록/수정 화면
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsLetterView.do")
	public String bbsView(Model model, BbsSO so, BbsGbSO gbSo, BbsLetterSO bbsLetterSO, BindingResult br, @PathVariable("bbsId") String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		so.setBbsId(bbsId);
		gbSo.setBbsId(bbsId);

		BbsBaseVO vo = boardService.getBoardBase(so);
		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		BbsLetterVO bbsLetterVO = boardService.getBbsLetter(bbsLetterSO);
		model.addAttribute("board", vo);
		model.addAttribute("bbsLetter", bbsLetterVO);
		model.addAttribute("listBoardGb", boardService.listBoardGb(gbSo));

		if(bbsLetterVO != null && AdminConstants.USE_YN_Y.equals(vo.getFlUseYn())) {
			AttachFileSO attachFileSO = new AttachFileSO();
			attachFileSO.setFlNo(bbsLetterVO.getFlNo());
			model.addAttribute("listFile", bizService.listAttachFile(attachFileSO));
		}
		
		return "/system/bbsLetterView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 20
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 >  게시 글 상세
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsLetterDetailView.do")
	public String bbsLetterDetailView(Model model, BbsSO so, BbsGbSO gbSo, BbsLetterSO bbsLetterSO, BbsReplySO bbsReplySO, BindingResult br, @PathVariable("bbsId") String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		so.setBbsId(bbsId);
		gbSo.setBbsId(bbsId);

		BbsBaseVO vo = boardService.getBoardBase(so);

		if ( vo == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		BbsLetterVO bbsLetterVO = boardService.getBbsLetter(bbsLetterSO);
		if ( bbsLetterVO == null ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		model.addAttribute("board", vo);
		// 구분자 리스트
		model.addAttribute("listBoardGb", boardService.listBoardGb(gbSo));
		// 게시글 상세
		model.addAttribute("bbsLetter", bbsLetterVO);
		// 게시판 답글
		model.addAttribute("listBoardReply", boardService.listBoardReply(bbsReplySO));

		if(AdminConstants.USE_YN_Y.equals(vo.getFlUseYn())) {
			AttachFileSO attachFileSO = new AttachFileSO();
			attachFileSO.setFlNo(bbsLetterVO.getFlNo());
			model.addAttribute("listFile", bizService.listAttachFile(attachFileSO));
		}

		String url;
		if(StringUtil.equals(bbsId, "COMPFAQ")) {
			url = "/system/compfaqDetailView";
		}else {
			url = "/system/bbsLetterDetailView";
		}
		
		return url;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 삭제
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsLetterDelete.do")
	public String bbsLetterDelete(Model model, BbsLetterPO po, @PathVariable("bbsId") String bbsId, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		po.setBbsId(bbsId);

		boardService.deleteBoardLetter(po);

		return View.jsonView();
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/{bbsId}/bbsLetterArrDelete.do")
	public String bbsLetterDelete(Model model, @RequestParam("deleteLettNoStr") String deleteLettNoStr, @PathVariable("bbsId") String bbsId) {

		JsonUtil jsonUtil = new JsonUtil();
		if (StringUtil.isNotBlank(deleteLettNoStr)) {
			List<BbsLetterPO> list = jsonUtil.toArray(BbsLetterPO.class, deleteLettNoStr);

			if(CollectionUtils.isNotEmpty(list)) {
				for(BbsLetterPO po : list) {
					po.setBbsId(bbsId);
					boardService.deleteBoardLetter(po);
					//공지사항일때는 poc데이터도 삭제
					if(bbsId.equals(AdminConstants.BBS_ID_NOTICE)) {
						List<BbsPocVO> pocList = new ArrayList<>();
						BbsPocVO poc = new BbsPocVO();
						poc.setLettNo(po.getLettNo()); 
						pocList.add(poc);
						boardService.deleteLetterPoc(pocList);
					}
				}
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return View.jsonView();
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 등록
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsLetterInsert.do")
	public String bbsLetterInsert(Model model, BbsLetterPO po, BindingResult br, @PathVariable("bbsId") String bbsId){
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		po.setBbsId(bbsId);
		
		boardService.insertBbsLetter(po);
		
		model.addAttribute("bbsLetter", po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 05. 16
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 상세 > 게시판 답글 등록
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsReplyInsert.do")
	public String bbsReplyInsert(Model model, BbsSO bbsSO, BbsReplyPO bbsReplyPO, BindingResult br, @PathVariable("bbsId") String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		bbsSO.setBbsId(bbsId);
		boardService.insertBbsReply(bbsReplyPO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 05. 16
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 수정
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsLetterUpdate.do")
	public String bbsLetterUpdate(Model model, BbsLetterPO po, BindingResult br, @PathVariable("bbsId") String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		po.setBbsId(bbsId);
		boardService.updateBbsLetter(po);
		model.addAttribute("bbsLetter", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 05. 16
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 글 파일 삭제
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsFileDelete.do")
	public String bbsFileDelete(Model model, AttachFilePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		bizService.deleteAttachFile(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 05. 16
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시 답글 삭제
	 *
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/{bbsId}/bbsReplyDelete.do")
	public String bbsReplyDelete(Model model, BbsSO so, BbsGbSO gbSo, BbsLetterSO bbsLetterSO, BbsReplyPO bbsReplyPO, BindingResult br, @PathVariable("bbsId") String bbsId) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		so.setBbsId(bbsId);
		gbSo.setBbsId(bbsId);

		boardService.deleteBbsReply(bbsReplyPO);

		return View.jsonView();
	}
	/**
	 * 게시판상품목록 그리드 
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/bbsLetterGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse bbsLetterGoodsListGrid(BbsLetterGoodsSO so) {
		List<BbsLetterGoodsVO> list = boardService.listBbsLetterGoods(so);
		return new GridResponse(list, so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardController.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		:  
	 * - 설명		: 게시판 글 전시순서 리스트 
	 * </pre>
	 * @param so
	 * @return
	*/
	@ResponseBody
	@RequestMapping(value="/{bbsId}/bbsLetterDispListGrid.do", method=RequestMethod.POST)
	public GridResponse bbsLetterDispList(Model model, BbsLetterDispSO so, @PathVariable("bbsId") String bbsId) {
		so.setBbsId(bbsId);
		List<BbsLetterDispVO> list = boardService.bbsLetterDispList(so);
		return new GridResponse(list, so);
	}
	
	
	
/**
 * 
	* <pre>
	* - 프로젝트명	: admin.web.view.system.controller
	* - 파일명		: BoardController.java
	* - 작성일		: 2017. 2. 13.
	* - 작성자		: inkorea
	* - 설명			:게시판 글 전시순서 등록  
	* </pre>
 */
	@RequestMapping("/{bbsId}/insertBbsLetterDisp.do")
	public String insertBbsLetterDisp(Model model, @RequestParam("bbsLetterDispPOList") String bbsLetterDispPOListStr  , @PathVariable("bbsId") String bbsId) {
		 
		JsonUtil jsonUt = new JsonUtil();
		BbsLetterDispPO po = new BbsLetterDispPO();
		
		
		if(StringUtil.isNotEmpty(bbsLetterDispPOListStr)) {
			List<BbsLetterDispPO> bbsLetterDispPOList = jsonUt.toArray(BbsLetterDispPO.class, bbsLetterDispPOListStr);
			po.setBbsLetterDispPOList(bbsLetterDispPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		boardService.insertBbsLetterDisp(po,bbsId);
		model.addAttribute("bbsLetterDisp", po);

		return View.jsonView();
	}
/**
 * 
	* <pre>
	* - 프로젝트명	: admin.web.view.system.controller
	* - 파일명		: BoardController.java
	* - 작성일		: 2017. 2. 13.
	* - 작성자		: inkorea
	* - 설명			: 게시판 글 전시순서 삭제  
	* </pre>
 */
	@RequestMapping("/{bbsId}/deleteBbsLetterDisp.do")
	public String deleteBbsLetterDisp(Model model, @RequestParam("bbsLetterDispPOList") String bbsLetterDispPOListStr  , @PathVariable("bbsId") String bbsId) {
		 
		JsonUtil jsonUt = new JsonUtil();
		BbsLetterDispPO po = new BbsLetterDispPO();
		
		
		if(StringUtil.isNotEmpty(bbsLetterDispPOListStr)) {
			List<BbsLetterDispPO> bbsLetterDispPOList = jsonUt.toArray(BbsLetterDispPO.class, bbsLetterDispPOListStr);
			po.setBbsLetterDispPOList(bbsLetterDispPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		boardService.deleteBbsLetterDisp(po,bbsId);
		model.addAttribute("bbsLetterDisp", po);

		return View.jsonView();
	}

	@RequestMapping("/{bbsId}/compfaqView.do")
	public String compfaqView(Model model , @PathVariable("bbsId") String bbsId) {
		
		BbsLetterVO vo = new BbsLetterVO();
		vo.setLettNo(bizService.getSequence(CommonConstants.SEQUENCE_BBS_LETTER_SEQ));
		model.addAttribute("bbsLetter" , vo);
		model.addAttribute("bbsId" , bbsId);
		return "/system/compfaqDetailView";
	}
}