package admin.web.view.contents.controller;

import java.util.List;

import org.apache.logging.log4j.core.appender.rewrite.MapRewritePolicy.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import biz.app.contents.model.EduContsPO;
import biz.app.contents.model.EduContsSO;
import biz.app.contents.model.EduContsVO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.contents.service.EduContsService;
import biz.app.contents.service.VodService;
import biz.app.system.model.CodeDetailVO;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.contents.controller
 * - 파일명		: EduContsController.java
 * - 작성자		: KKB
 * - 설명		: 컨텐츠 관리
 * </pre>
 */
@Slf4j
@Controller
public class EduContsController {

	@Autowired
	private EduContsService eduContsService;
	
	/**
	 * <pre>교육용 컨텐츠 리스트 페이지</pre>
	 * 
	 * @author KKB
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/eduContsListView.do")
	public String eduContsListView() {
		return "/contents/eduContsListView";
	}

	/**
	 * <pre>교육용 카테고리 목록</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<CodeDetailVO>
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/getEduCategoryList.do", method = RequestMethod.POST)
	public List<CodeDetailVO> getEduCategoryList(EduContsSO so) {
		List<CodeDetailVO> codeList = eduContsService.getEduCtgList(so);
		return codeList;
	}
	
	
	/**
	 * <pre>교육용 컨텐츠 그리드 리스트</pre>
	 * 
	 * @author KKB
	 * @param EduContsSO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/eduContsListGrid.do", method = RequestMethod.POST)
	public GridResponse eduContsListGrid(EduContsSO so) {
		so.setVdGbCd(CommonConstants.VD_GB_20);
		List<EduContsVO> list = eduContsService.pageEduConts(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>교육용 컨텐츠 등록 화면</pre>
	 * 
	 * @author KKB
	 * @param model
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/eduContsInsertView.do")
	public String eduContsInsertView() {
		return "/contents/eduContsInsertView";
	}
	
	/**
	 * <pre>교육용 컨텐츠 등록화면 include </pre>
	 * 
	 * @author KKB
	 * @return viewResolver path
	 */
	@RequestMapping(value = "/contents/eduContsIntroN.do")
	public String eduContsIntroN() {
		return "/contents/include/eduContsIntroN";
	}
	
	/**
	 * <pre>교육용 컨텐츠 step include </pre>
	 * 
	 * @author KKB
	 * @return viewResolver path
	 */
	@RequestMapping(value = "/contents/eduContsIntroNStep.do")
	public String eduContsIntroNStep(Model model, Long idx) {
		model.addAttribute("idx",idx);
		return "/contents/include/eduContsIntroNStep";
	}
	
	/**
	 * <pre>교육용 컨텐츠 QnA include </pre>
	 * 
	 * @author KKB
	 * @return viewResolver path
	 */
	@RequestMapping(value = "/contents/eduContsIntroNQna.do")
	public String eduContsIntroNQna(Model model, Long idx) {
		model.addAttribute("idx",idx);
		return "/contents/include/eduContsIntroNQna";
	}
	
	/**
	 * <pre>교육용 컨텐츠 등록 </pre>
	 * 
	 * @author KKB
	 * @return viewResolver path
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/insertEduContents.do")
	public String insertEduContents(EduContsPO po) {
		String result = eduContsService.insertEduContents(po);
		return result;
	}

	/**
	 * <pre>교육용 컨텐츠 상세 화면</pre>
	 * 
	 * @author KKB
	 * @param model
	 * @param E
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/eduContsDetailView.do")
	public String eduContsDetailView(Model model, EduContsSO so) {
		EduContsVO eduContsDetail = eduContsService.getEduConts(so);
		model.addAttribute("eduConts", eduContsDetail);
		return "/contents/eduContsDetailView";
	}
	
	/**
	 * <pre>교육용 컨텐츠 수정 </pre>
	 * 
	 * @author KKB
	 * @return viewResolver path
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/updateEduContents.do")
	public String updateEduContents(EduContsPO po) {
		String result = eduContsService.updateEduContents(po);
		return result;
	}
}