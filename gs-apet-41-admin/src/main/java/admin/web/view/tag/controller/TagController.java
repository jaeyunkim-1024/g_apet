package admin.web.view.tag.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.company.model.CompanyCclVO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayGoodsPO;
import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCautionPO;
import biz.app.goods.model.GoodsCautionVO;
import biz.app.goods.model.GoodsCstrtInfoPO;
import biz.app.goods.model.GoodsDescPO;
import biz.app.goods.model.GoodsDescVO;
import biz.app.goods.model.GoodsImgPO;
import biz.app.goods.model.GoodsImgVO;
import biz.app.goods.model.GoodsNotifyPO;
import biz.app.goods.model.GoodsPO;
import biz.app.goods.model.GoodsPricePO;
import biz.app.goods.model.GoodsPriceVO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.NotifyInfoVO;
import biz.app.goods.model.NotifyItemSO;
import biz.app.goods.model.NotifyItemVO;
import biz.app.goods.model.StGoodsMapPO;
import biz.app.goods.model.StGoodsMapSO;
import biz.app.goods.model.StGoodsMapVO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.model.CodeDetailPO;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.CodeGroupSO;
import biz.app.system.service.CodeService;
import biz.app.tag.model.TagBasePO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.model.TagGroupPO;
import biz.app.tag.model.TagGroupSO;
import biz.app.tag.model.TagGroupTreeVO;
import biz.app.tag.model.TagGroupVO;
import biz.app.tag.model.TagTrendPO;
import biz.app.tag.model.TagTrendSO;
import biz.app.tag.model.TagTrendVO;
import biz.app.tag.service.TagService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명 : gs-apet-41-admin
* - 패키지명   : admin.web.view.tag.controller
* - 파일명     : TagController.java
* - 작성일     : 2020. 12. 17.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Slf4j
@Controller
public class TagController {

	@Autowired
	private TagService tagService;	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping("/tag/matchedTagListView.do")
	public String indexMatchedTagList(Model model) {
		log.debug("================================");
		log.debug("= {}", "Matched 태그 리스트 시작 페이지");
		log.debug("================================");
		return "/tag/matchedTagListView";
	}
	
	
	@RequestMapping("/tag/unmatchedTagListView.do")
	public String indexUnmatchedTagList(Model model) {
		log.debug("================================");
		log.debug("= {}", "Unmatched 태그 리스트 시작 페이지");
		log.debug("================================");
		return "/tag/unmatchedTagListView";
	}

	
	
	@RequestMapping(value = "/tag/tagBaseDetailView.do")
	public String tagBaseDetailView(Model model, String viewGb,  TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Tag Detail");
			log.debug("==================================================");
			//LogUtil.log(so);
		}
		String tagNo = so.getTagNo();
		
		// 태그 정보 조회
		TagBaseVO tagBaseVO = tagService.getTagDetail(tagNo);
		if (tagBaseVO == null) {
			// Tag가 존재하지 않습니다.
			throw new CustomException(ExceptionConstants.ERROR_TAG_NO_DATA);
		}

		model.addAttribute("tagBase", tagBaseVO);
		model.addAttribute("tagGroups", tagService.listTagGroupMap(so));
		model.addAttribute("rltTags", tagService.listTagRelationMap(so));		
		model.addAttribute("synTags", tagService.listTagSynonymMap(so));

//		String layOut = AdminConstants.LAYOUT_DEFAULT;
//		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
//			layOut = AdminConstants.LAYOUT_POP;
//		}
//		model.addAttribute("layout", layOut);

		return "/tag/tagBaseDetailView";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/tag/tagBaseGrid.do", method = RequestMethod.POST)
	public GridResponse tagBaseGrid(TagBaseSO so) {
		// Tag 조회 팝업의 경우
		//if( "Y".equals(so.getPopYn()) ) {so.setTagGrpNo(so.getSearchTagGrpNo());}
		
		if(so.getSrchWord() !=null && so.getSrchWord() !="") {			
			so.setSrchWords(so.getSrchWord().trim().split(";"));
			so.setSrchWord(null);
		}
		
		List<TagBaseVO> list = tagService.pageTagBase(so);
		return new GridResponse(list, so);
	}
	
	@RequestMapping("/tag/tagBaseListExcelDownload.do")
	public String tagBaseListExcelDownload(ModelMap model, TagBaseSO so){
		so.setRows(999999999);
		so.setSort("tagNm");
		so.setSord("DESC");

		List<TagBaseVO> list = tagService.pageTagBase(so);

		String[] headerName = {
				  "No"
				, "Tag"
				, "상태"
				, "등록일/등장일"
		};

		String[] fieldName = {
				  "rowIndex"
				, "tagNm"
				, "statNm"
				, "sysRegDt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("Tag List", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "Tag List");

		return View.excelDownload();
	}
	
	
	@RequestMapping("/tag/matchedTagExcelDownload.do")
	public String matchedTagExcelDownload(ModelMap model, TagBaseSO so){
		so.setRows(999999999);
		so.setSort("tagNm");
		so.setSord("DESC");

		List<TagBaseVO> list = tagService.pageTagBase(so);

		String[] headerName = {
				  "Tag ID"
				, "Tag 명"
				, "소속 그룹"
				, "Related Tag"
				, "관련 영상 수"
				, "관련 상품 수"
				, "상태"
				, "등록자"
				, "등록일"
		};

		String[] fieldName = {
				  "tagNo"
				, "tagNm"
				, "grpNm"
				, "rltTagCnt"
				, "rltCntsCnt"
				, "rltGoodsCnt"
				, "statNm"
				, "sysRegrNm"
				, "sysRegDt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("Matched Tag", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "Matched Tag List");

		return View.excelDownload();
	}
		
	
	@ResponseBody
	@RequestMapping(value = "/tag/unmatchedTagBaseGrid.do", method = RequestMethod.POST)
	public GridResponse unmatchedTagBaseGrid(TagBaseSO so) {
		so.setStatCd("U");
		List<TagBaseVO> list = tagService.pageUnmatchedTagBase(so);
		return new GridResponse(list, so);
	}
	
	
	@RequestMapping("/tag/unmatchedTagExcelDownload.do")
	public String unmatchedTagExcelDownload(ModelMap model, TagBaseSO so){
		so.setRows(999999999);
		//so.setSort("sysRegDtm");
		//so.setSord("DESC");
		so.setStatCd("U");

		List<TagBaseVO> list = tagService.pageUnmatchedTagBase(so);

		String[] headerName = {
				//  "No"
				  "Tag 명"
				, "관련 영상 수"
				, "관련 로그 수"
				, "관련 상품 수"
				, "등장 횟수"
				//, "사용 여부"
				, "출처"
				, "첫 등장일"
		};

		String[] fieldName = {
				//  "rowIndex"
				  "tagNm"
				, "rltCntsCnt"
				, "rltLogCnt"
				, "rltGoodsCnt"
				, "nbrCnt"
				//, "statNm"
				, "tagSrcCd"
				, "sysRegDt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("Unmatched Tag", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "Tag List");

		return View.excelDownload();
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/tag/listDisplayTagGroup.do", method=RequestMethod.POST)
	public List<TagGroupVO> listDisplayTagGroup(TagGroupSO so) {		
		return tagService.listDisplayTagGroup(so);
	}
	
	
	@RequestMapping("/tag/tagBaseSearchLayerView.do")
	public String tagSearchLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Tag Search", so);
			log.debug("==================================================");
		}
		return "/tag/tagBaseSearchLayerView";
	}
	
	@RequestMapping("/tag/tagBaseInsertView.do")
	public String tagBaseInsertView(Model model, TagBasePO po) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "TAG 등록");
			log.debug("==================================================");
		}

		model.addAttribute("tagBase", po);

		return "/tag/tagBaseInsertView";
	}
	
	
	@RequestMapping(value = "/tag/tagBaseInsert.do")
	public String insertTagBase( Model model, TagBasePO po, BindingResult br) {

		if (!StringUtil.isEmpty(po.getTagGrpArea())) {
			po.setTagGrpNos(StringUtil.split(po.getTagGrpArea(),","));
		}		
		po.setTagNm(po.getTagNm().replaceAll(" ", "")); //tag 명 공백제거 필수
		// Tag 등록
		String tagNo = tagService.insertTagBase(po);
		model.addAttribute("tagNo", tagNo);

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("태그 등록 : {}", tagNo);
			log.debug("==================================================");
		}

		return View.jsonView();
	}
	
	
	@RequestMapping(value = "/tag/tagBaseUpdate.do")
	public String updateTagBase( Model model, TagBasePO po, BindingResult br) {
		// Tag 수정
		String tagNo = tagService.updateTagBase(po);
		model.addAttribute("tagNo", tagNo);

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("태그 변경 : {}", tagNo);
			log.debug("==================================================");
		}

		return View.jsonView();
	}
	
	@RequestMapping("/tag/tagBaseDelete.do")
	public String deleteTagBase(Model model, TagBasePO po) {

		tagService.deleteTagBase(po);
		return View.jsonView();
	}
	
	
	@RequestMapping("/tag/tagBatchUpdate.do")
	public String tagBatchUpdate(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Tag BatchUpdate");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;

		String[] tagNos = so.getTagNos();
		List<TagBasePO> tagBasePOList = new ArrayList<>();
		for (String tagNo : tagNos) {
			log.debug("##################### : " + tagNo);
			TagBasePO po = new TagBasePO();
			po.setTagNo(tagNo);
			po.setStatCd("N");
			tagBasePOList.add(po);
		}

		updateCnt = tagService.updateTagBaseBatch(tagBasePOList);

		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	
	
	
	@RequestMapping("/tag/tagGroupLayerView.do")
	public String tagGroupLayerView(Model model) {
		log.debug("================================");
		log.debug("= {}", "태그 그룹 레이어 팝업");
		log.debug("================================");
		return "/tag/tagGroupLayerView";
	}
		
		
		

	@RequestMapping("/tag/tagGroupListView.do")
	public String indexTagGroupList(Model model) {
		log.debug("================================");
		log.debug("= {}", "태그 그룹 시작 페이지");
		log.debug("================================");
		return "/tag/tagGroupListView";
	}	

	@ResponseBody
	@RequestMapping(value="/tag/tagGroupTree.do", method=RequestMethod.POST)
	public List<TagGroupTreeVO> listTagGroupTree() {
		log.debug("================================");
		log.debug("= {}", "태그 그룹 Tree");
		log.debug("================================");
		
		return tagService.listTagGroupTree();
	}	

	@RequestMapping("/tag/tagGroupView.do")
	public String getTagGroup(Model model, @ModelAttribute("tagGroupResult") TagGroupSO so) {
		model.addAttribute("tagGroup", tagService.getTagGroup(so));
		return "/tag/tagGroupView";
	}

	@ResponseBody
	@RequestMapping(value="/tag/tagGroupListGrid.do", method=RequestMethod.POST)
	public GridResponse tagGroupListGrid(TagGroupSO so) {
		List<TagGroupVO> list = tagService.listTagGroup(so);
		return new GridResponse(list, so);
	}


	@RequestMapping("/tag/tagGroupSave.do")
	public String saveTagGroup(Model model, TagGroupPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		tagService.saveTagGroup(po);
		return View.jsonView();
	}

	@RequestMapping("/tag/tagGroupDelete.do")
	public String deleteTagGroup(Model model, TagGroupPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		tagService.deleteTagGroup(po);
		return View.jsonView();
	}
	
	
	@RequestMapping("/tag/trendTagListView.do")
	public String indexTrendTagList(Model model) {
		log.debug("================================");
		log.debug("= {}", "Unmatched 태그 리스트 시작 페이지");
		log.debug("================================");
		return "/tag/trendTagListView";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/tag/tagTrendGrid.do", method = RequestMethod.POST)
	public GridResponse tagTrendGrid(TagTrendSO so) {
		List<TagTrendVO> list = tagService.pageTagTrend(so);
		return new GridResponse(list, so);
	}
	
	
	@RequestMapping("/tag/tagTrendInsertView.do")
	public String tagTrendInsertView(Model model) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "TAG 등록");
			log.debug("==================================================");
		}

		return "/tag/tagTrendInsertView";
	}
	
	
	@RequestMapping(value = "/tag/tagTrendInsert.do")
	public String insertTagTrend( Model model, TagTrendPO po, BindingResult br) {

		if (!StringUtil.isEmpty(po.getTagArea())) {
			po.setTagNos(StringUtil.split(po.getTagArea(),","));
		}	
		
		// Trend Tag 등록
		tagService.insertTagTrend(po);
		model.addAttribute("tagTrend", po);

		return View.jsonView();
	}
	
	
	@RequestMapping("/tag/tagTrendBatchUpdate.do")
	public String tagTrendBatchUpdate(Model model, TagTrendSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "TagTrend BatchUpdate");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;

		String[] trdNos = so.getTrdNos();
		List<TagTrendPO> tagTrendPOList = new ArrayList<>();
		for (String trdNo : trdNos) {
			log.debug("##################### : " + trdNo);
			TagTrendPO po = new TagTrendPO();
			po.setTrdNo(trdNo);
			po.setUseYn(so.getUseYn());
			tagTrendPOList.add(po);
		}

		updateCnt = tagService.updateTagTrendBatch(tagTrendPOList);

		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	
	@RequestMapping("/tag/tagTrendBatchDelete.do")
	public String tagTrendBatchDelete(Model model, TagTrendSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "TagTrend BatchDelete");
			log.debug("==================================================");
		}
		int deleteCnt = 0 ;

		String[] trdNos = so.getTrdNos();
		List<TagTrendPO> tagTrendPOList = new ArrayList<>();
		for (String trdNo : trdNos) {
			log.debug("##################### : " + trdNo);
			TagTrendPO po = new TagTrendPO();
			po.setTrdNo(trdNo);
			tagTrendPOList.add(po);
		}

		deleteCnt = tagService.deleteTagTrendBatch(tagTrendPOList);

		model.addAttribute("deleteCnt", deleteCnt);

		return View.jsonView();
	}
	
	@RequestMapping("/tag/trendTagExcelDownload.do")
	public String trendTagExcelDownload(ModelMap model, TagTrendSO so){
		so.setRows(999999999);
		//so.setSort("sysRegDtm");
		//so.setSord("DESC");

		List<TagTrendVO> list = tagService.pageTagTrend(so);

		String[] headerName = {
				//  "No"
				 "Trend Tag ID"
				, "Trend Tag 명"
				, "Tag"
				, "사용기간"
				, "상태"
				, "등록자"
				, "등록 일시"
		};

		String[] fieldName = {
				//  "rowIndex"
				 "trdNo"
				, "trdTagNm"
				, "tagNmExcel"
				, "useDtm"
				, "useYn"
				, "sysRegrNm"
				, "sysRegDtm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("Trend Tag", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "Trend Tag List");

		return View.excelDownload();
	}
	
	
	@RequestMapping(value = "/tag/tagBaseDetailLayerView.do")
	public String tagBaseDetailLayerView(Model model, String viewGb,  TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Tag Detail");
			log.debug("==================================================");
			//LogUtil.log(so);
		}
		String tagNo = so.getTagNo();
		
		// 태그 정보 조회
		TagBaseVO tagBaseVO = tagService.getTagDetail(tagNo);
		if (tagBaseVO == null) {
			// Tag가 존재하지 않습니다.
			throw new CustomException(ExceptionConstants.ERROR_TAG_NO_DATA);
		}

		model.addAttribute("tagBase", tagBaseVO);
		model.addAttribute("tagGroups", tagService.listTagGroupMap(so));
		model.addAttribute("rltTags", tagService.listTagRelationMap(so));		
		model.addAttribute("synTags", tagService.listTagSynonymMap(so));

		String layOut = AdminConstants.LAYOUT_DEFAULT;
		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
		}
		model.addAttribute("layout", layOut);

		return "/tag/tagBaseDetailLayerView";
	}
	
	
	@RequestMapping("/tag/tagGoodsLayerView.do")
	public String tagGoodsLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Tag View", so);
			log.debug("==================================================");
		}
		model.addAttribute("tagBase", so);
		
		return "/tag/tagGoodsLayerView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/tag/tagGoodsListGrid.do", method = RequestMethod.POST)
	public GridResponse tagGoodsListGrid(TagBaseSO so) {
		List<TagBaseVO> list = tagService.pageTagGoodsList(so);
		return new GridResponse(list, so);
	}
	
	
	
	@RequestMapping("/tag/tagContentsLayerView.do")
	public String tagContentsLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Contents Tag View", so);
			log.debug("==================================================");
		}
		model.addAttribute("tagBase", so);
		
		return "/tag/tagContentsLayerView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/tag/tagContentsListGrid.do", method = RequestMethod.POST)
	public GridResponse tagContentsListGrid(TagBaseSO so) {
		List<TagBaseVO> list = tagService.pageTagContentsList(so);
		return new GridResponse(list, so);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/tag/tagNmCheck.do", method = RequestMethod.POST)
	public Boolean tagNmCheck(@RequestParam(value="tagNm") String bnrId) {
		if( tagService.tagNmCheck(bnrId.replaceAll(" ", "")) > 0) {
			return true;	
		} else {
			return false; 
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명		: admin.web.view.tab.controller
	 * - 파일명		: TagController.java
	 * - 작성자		: valueFactory
	 * - 설명		: 태그 그룹 정렬순서 중복체크
	 * </pre>
	 */
	@ResponseBody
	@RequestMapping(value = "/tag/tagGrpSortSeqChk.do", method = RequestMethod.POST)
	public Boolean tagGrpSortSeqChk(TagGroupSO so) {
		if (tagService.tagGrpSortSeqChk(so) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@RequestMapping("/tag/umTagTotalLayerView.do")
	public String umTagTotalLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "umTagLayerView", so);
			log.debug("==================================================");
		}
		model.addAttribute("tagBase", so);
		
		return "/tag/umTagTotalLayerView";
	}
	@RequestMapping("/tag/umTagGoodsLayerView.do")
	public String umTagGoodsLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "umTagGoodsLayerView", so);
			log.debug("==================================================");
		}
		model.addAttribute("tagBase", so);
		
		return "/tag/umTagGoodsLayerView";
	}
	@RequestMapping("/tag/umTagLogLayerView.do")
	public String umTagLogLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "umTagLogLayerView", so);
			log.debug("==================================================");
		}
		model.addAttribute("tagBase", so);
		
		return "/tag/umTagLogLayerView";
	}
	@RequestMapping("/tag/umTagContsLayerView.do")
	public String umTagContsLayerView(Model model, TagBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "umTagContsLayerView", so);
			log.debug("==================================================");
		}
		model.addAttribute("tagBase", so);
		
		return "/tag/umTagContsLayerView";
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명		: admin.web.view.tab.controller
	 * - 파일명		: TagController.java
	 * - 작성자		: valueFactory
	 * - 설명		: tag 신조어 관련영상팝업 그리드 리스트
	 * </pre>
	 */
	@ResponseBody
	@RequestMapping(value = "/tag/pageUmTagContsLayer.do", method = RequestMethod.POST)
	public GridResponse pageUmTagContsLayer(TagBaseSO so) {
		List<TagBaseVO> list = tagService.pageUmTagContsLayer(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명		: admin.web.view.tab.controller
	 * - 파일명		: TagController.java
	 * - 작성자		: valueFactory
	 * - 설명		: tag 신조어 관련로그팝업 그리드 리스트
	 * </pre>
	 */
	@ResponseBody
	@RequestMapping(value = "/tag/pageUmTagLogLayer.do", method = RequestMethod.POST)
	public GridResponse pageUmTagLogLayer(TagBaseSO so) {
		List<TagBaseVO> list = tagService.pageUmTagLogLayer(so);
		return new GridResponse(list, so);
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명		: admin.web.view.tab.controller
	 * - 파일명		: TagController.java
	 * - 작성자		: valueFactory
	 * - 설명		: tag 신조어 관련상품팝업 그리드 리스트
	 * </pre>
	 */
	@ResponseBody
	@RequestMapping(value = "/tag/pageUmTagGoodsLayer.do", method = RequestMethod.POST)
	public GridResponse pageUmTagGoodsLayer(TagBaseSO so) {
		List<TagBaseVO> list = tagService.pageUmTagGoodsLayer(so);
		return new GridResponse(list, so);
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명		: admin.web.view.tab.controller
	 * - 파일명		: TagController.java
	 * - 작성자		: valueFactory
	 * - 설명		: tag 신조어 등장횟수팝업 그리드 리스트
	 * </pre>
	 */
	@ResponseBody
	@RequestMapping(value = "/tag/pageUmTagTotalLayer.do", method = RequestMethod.POST)
	public GridResponse pageUmTagTotalLayer(TagBaseSO so) {
		List<TagBaseVO> list = tagService.pageUmTagTotalLayer(so);
		return new GridResponse(list, so);
	}
	
}