package admin.web.view.system.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.system.model.*;
import biz.app.system.service.CodeService;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

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
public class CodeController {

	@Autowired
	private CodeService codeService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 코드 시작 페이지
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/system/codeListView.do")
	public String codeListView(Model model , CodeGroupSO so) {
		log.debug("================================");
		log.debug("= {}", "공통 코드 시작 페이지");
		log.debug("================================");
		so.setSidx("CG.GRP_CD");
		so.setSord("ASC");
		Map<String,List<String>> listMap = codeService.createAutoSearchKeyWord(so);
		model.addAttribute("grpCds",listMap.get("GRP_CD"));
		model.addAttribute("grpNms",listMap.get("GRP_NM"));
		return "/system/codeListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 그룹 코드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/codeGroupListGrid.do", method=RequestMethod.POST)
	public GridResponse codeGroupListGrid(CodeGroupSO so) {
		so.setSidx("GRP_CD");
		so.setSord("ASC");
		List<CodeGroupVO> list = codeService.pageCodeGroup(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 그룹 코드 화면
	 *                등록 / 수정
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeGroupView.do")
	public String codeGroupView(Model model, CodeGroupSO so, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("codeGroup", codeService.getCodeGroup(so));
		return "/system/codeGroupView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 그룹 코드 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeGroupInsert.do")
	public String codeGroupInsert(Model model, CodeGroupPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		codeService.insertCodeGroup(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 그룹 코드 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeGroupUpdate.do")
	public String codeGroupUpdate(Model model, CodeGroupPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		codeService.updateCodeGroup(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 그룹 코드 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeGroupDelete.do")
	public String codeGroupDelete(Model model, CodeGroupPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		codeService.deleteCodeGroup(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/codeDetailListGrid.do", method=RequestMethod.POST)
	public GridResponse codeDetailListGrid(CodeDetailSO so) {
		so.setSidx("A.SORT_SEQ");
		so.setSord("ASC");
		List<CodeDetailVO> list = codeService.pageCodeDetail(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeDetailView.do")
	public String codeDetailView(Model model, CodeDetailSO so, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("codeDetail", codeService.getCodeDetail(so));
		return "/system/codeDetailView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeDetailInsert.do")
	public String codeDetailInsert(Model model, CodeDetailPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		codeService.insertCodeDetail(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeDetailUpdate.do")
	public String codeDetailUpdate(Model model, CodeDetailPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		codeService.updateCodeDetail(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/codeDetailDelete.do")
	public String codeDetailDelete(Model model, CodeDetailPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		codeService.deleteCodeDetail(po);
		return View.jsonView();
	}

}