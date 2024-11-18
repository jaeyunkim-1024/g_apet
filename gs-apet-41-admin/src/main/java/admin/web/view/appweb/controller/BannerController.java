package admin.web.view.appweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.banner.model.BannerPO;
import biz.app.banner.model.BannerSO;
import biz.app.banner.model.BannerTagMapPO;
import biz.app.banner.model.BannerTagMapSO;
import biz.app.banner.model.BannerTagMapVO;
import biz.app.banner.model.BannerVO;
import biz.app.banner.service.BannerService;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.tag.model.TagBaseVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BannerController {
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Autowired
	private BannerService bannerService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BannerController.java
	* - 작성일		: 2020. 12. 16
	* - 작성자		: CJA
	* - 설명			: 배너 관리 > 배너 목록
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/appweb/bannerListView.do")
	public String bannerListView () {
		return "/appweb/bannerListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BannerController.java
	 * - 작성일	: 2020. 12. 16
	 * - 작성자	: CJA
	 * - 설명		: 배너 목록 Gird
	 * </pre>
	 * 
	 * @param  so
	 * @return
	 */
	
	 @ResponseBody
	 @RequestMapping(value = "/appweb/bannerListGrid.do", method = RequestMethod.POST) 
	 public GridResponse bannerListGrid(BannerSO so) {
	 List<BannerVO> list = bannerService.bannerListGrid(so);
	 return new GridResponse(list, so);
	 }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BannerController.java
	 * - 작성일	: 2020. 12. 16
	 * - 작성자	: CJA
	 * - 설명		: 배너 등록/상세 화면
	 * </pre>
	 * 
	 * @param  model
	 * @param  bnrNo
	 * @return
	 */
	@RequestMapping(value = "/appweb/bannerView.do", method = RequestMethod.GET)
	public String bannerView(Model model, @RequestParam(value = "bnrNo", required = false) Long bnrNo) {
		BannerSO so = new BannerSO();
		so.setBnrNo(bnrNo);
		
		List<TagBaseVO> tbvo = new ArrayList<>();
		
		if(StringUtil.isNotEmpty(bnrNo)) {
			
			List<BannerTagMapVO> list =  bannerService.getBannerTagList(so);
			
			BannerTagMapSO tso = new BannerTagMapSO();
			
			for(int i = 0; i < list.size(); i++) {
				tso.setTagNo(list.get(i).getTagNo());
				tbvo.add(bannerService.getTagBase(tso));
			}
		}
		
		model.addAttribute("banner", bannerService.getBanner(so));
		model.addAttribute("bannerTagList", tbvo);
		
		return "/appweb/bannerView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BannerController.java
	 * - 작성일		: 2020. 12. 16
	 * - 작성자		: CJA
	 * - 설명		: 배너 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping(value = "/appweb/insertBanner.do", method = RequestMethod.POST)
	public String userInsert(Model model, BannerPO po, BannerTagMapPO tpo, String[] tagNo, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		bannerService.insertBanner(po, tpo, tagNo);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BannerController.java
	 * - 작성일	: 2020. 12. 16
	 * - 작성자	: CJA
	 * - 설명		: 배너 수정
	 * </pre>
	 * 
	 * @param  model
	 * @param  po
	 * @return
	 */
	@RequestMapping(value = "/appweb/updateBanner.do", method = RequestMethod.POST)
	 public String updateBanner(Model model, BannerPO po, BannerTagMapPO tpo, String[] tagNo, BindingResult br) {
		
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		bannerService.updateBanner(po, tpo, tagNo);
		return View.jsonView();
	 }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BannerController.java
	 * - 작성일	: 2020. 12. 16
	 * - 작성자	: CJA
	 * - 설명		: 배너 삭제
	 * </pre>
	 * 
	 * @param  model
	 * @param  po
	 * @return
	 */
	@RequestMapping(value = "/appweb/deleteBanner.do", method = RequestMethod.POST)
	 public String deleteBanner(Model model, BannerPO po) {
		
		bannerService.deleteBanner(po);
		return View.jsonView();
	 }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BannerController.java
	 * - 작성일	: 2020. 12. 18
	 * - 작성자	: CJA
	 * - 설명		: 배너 수정
	 * </pre>
	 * 
	 * @param  model
	 * @param  po
	 * @return
	 */
	@RequestMapping(value = "/banner/updateUseYn.do", method = RequestMethod.POST)
	 public String useYnChange(Model model, BannerPO po) {
		
		bannerService.updateUseYn(po);
		return View.jsonView();
	 }
	
	/**
	 * <pre>
	 * - Method 명	: bnrIdDplctCheck
	 * - 작성일		: 2020. 12. 18
	 * - 작성자		: CJA
	 * - 설 명		: 배너 ID 중복 체크 
	 * </pre>
	 *
	 * @param  model
	 * @param  po
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/appweb/bnrIdDplctCheck.do", method = RequestMethod.POST)
	public Boolean bnrIdDplctCheck(@RequestParam(value="bnrId") String bnrId) {
		
		boolean bnrlIdCheck;
		
		int count = bannerService.bannerIdCheck(bnrId);
		
		if(count > 0) {
			bnrlIdCheck = true;	// 배너 ID 중복
		} else {
			bnrlIdCheck = false; // 배너 ID 등록 가능
		}
		
		return bnrlIdCheck;
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
	@RequestMapping("/appweb/bannerListExcelDownload.do")
	public String bannerListExcelDownload(ModelMap model, BannerSO so){
		
		so.setRows(999999999);

		List<BannerVO> list = bannerService.pageBanner(so);

		String[] headerName = {
				  "배너 No"
				, "배너 ID"
				, "배너 타입명"
				, "배너 제목"
				, "사용 여부"
				, "사이트 아이디"
				, "등록자"
				, "시스템 등록 일시"
				, "수정자"
				, "시스템 수정 일시"
		};

		String[] fieldName = {
				  "bnrNo"
				, "bnrId"
				, "bnrTpCd"
				, "bnrTtl"
				, "useYn"
				, "stId"
				, "sysRegrNm"
				, "sysRegDtm"
				, "sysUpdrNm"
				, "sysUpdDtm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("Banner", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "Banner");

		return View.excelDownload();
	}
	
	/**
	 * <pre>
	 * - Method 명	: bannerSearchLayerView
	 * - 작성일		: 2020. 12. 22
	 * - 작성자		: CJA
	 * - 설 명		: 배너 조회 팝업
	 * </pre>
	 *
	 * @param  model
	 * @param  so
	 * @return
	 */
	@RequestMapping(value="/banner/bannerSearchLayerView.do", method = RequestMethod.POST)
	public String bannerSearchLayerView(Model model, BannerSO so) {

		model.addAttribute("bannerSO", so);

		return "/appweb/bannerSearchLayerView";
	}
	
	/**
	 * <pre>
	 * - Method 명	: bannerSearchLayerView
	 * - 작성일		: 2020. 12. 22
	 * - 작성자		: CJA
	 * - 설 명		: 배너 타입별 조회 팝업
	 * </pre>
	 *
	 * @param  model
	 * @return
	 */
	@RequestMapping(value = "/banner/bannerTypePopView.do", method = RequestMethod.POST)
	public String bannerTypeViewPopView(Model model) {
		
		return "/appweb/bannerTypeListView";
	}
	
	
}
