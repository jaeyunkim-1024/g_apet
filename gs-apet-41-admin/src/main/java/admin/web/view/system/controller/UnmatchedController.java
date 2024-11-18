package admin.web.view.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import admin.web.config.view.View;

import org.apache.commons.collections.CollectionUtils;
import admin.web.config.grid.GridResponse;
import biz.app.banner.model.BannerPO;
import biz.app.banner.model.BannerSO;
import biz.app.banner.model.BannerTagMapPO;
import biz.app.banner.model.BannerVO;
import biz.app.banner.service.BannerService;
import biz.app.tag.model.TagBasePO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class UnmatchedController {
	
	@Autowired
	private TagService tagService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 금지어 목록 페이지
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/system/unmatchedView.do")
	public String unmatchedView(Model model) {
		
		return "/system/unmatchedView";
	}
	
	@RequestMapping(value = "/system/insertUnmatchedViewPop.do", method = RequestMethod.POST)
	public String insertUnmatched(Model model) {
		
		return "/system/insertUnmatchedViewPop";
	}
	
	 @ResponseBody
	 @RequestMapping(value = "/system/createUnmatchedGrid.do", method = RequestMethod.POST) 
	 public GridResponse bannerListGrid(TagBaseSO so) {
	 List<TagBaseVO> list = tagService.unmatchedGrid(so);
	 return new GridResponse(list, so);
	 }
	 
	 /**
	 * <pre>
	 * - Method 명	: deleteUnmatched
	 * - 작성일		: 2020. 5. 27.
	 * - 작성자		: CJA
	 * - 설 명		: 금지어 삭제
	 * </pre>
	 *
	 * @param  model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/system/deleteUnmatched.do", method = RequestMethod.POST)
	public String deleteUnmatched(Model model, @RequestParam("unmatchedItems") String unmatchedItems) {
		
		JsonUtil jsonUtil = new JsonUtil();
		if(StringUtil.isNotBlank(unmatchedItems)) {
			List<TagBasePO> list  = jsonUtil.toArray(TagBasePO.class, unmatchedItems);
			
			if(CollectionUtils.isNotEmpty(list)) {
				for(TagBasePO po : list) {
					tagService.deleteUnmatched(po);
				}
			}
		}
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: bannerListExcelDownload
	 * - 작성일		: 2020. 12. 18
	 * - 작성자		: CJA
	 * - 설 명		: 배너 리스트 엑셀 다운로드 
	 * </pre>
	 *
	 * @param  model
	 * @param  so
	 * @return
	 */
	@RequestMapping("/system/unmatchedListExcelDownload.do")
	public String unmatchedListExcelDownload(ModelMap model, TagBaseSO so){
		
		so.setRows(999999999);

		List<TagBaseVO> list = tagService.pageUnmatched(so);

		String[] headerName = {
				"태그 번호"
				, "금지어"
				, "등록자"
				, "등록일"
		};

		String[] fieldName = {
				"tagNo"
				, "tagNm"
				, "sysRegrNm"
				, "sysRegDtm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("unmatched", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "unmatched");

		return View.excelDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - Method 명	: insertUnmatched
	 * - 작성일		: 2020. 12. 16
	 * - 작성자		: CJA
	 * - 설명		: 금지어 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/system/insertUnmatched.do", method = RequestMethod.POST)
	public String insertUnmatched(Model model, TagBasePO po) {
		String tagNm = "";
		if(po.getTagNm().contains("#")) {
			tagNm = po.getTagNm().substring(1);
		} else {
			tagNm = po.getTagNm();
		}
		
		po.setTagNm(tagNm);
		po.setStatCd("P");
		tagService.insertTagBase(po);
		return View.jsonView();
	}
	
}
