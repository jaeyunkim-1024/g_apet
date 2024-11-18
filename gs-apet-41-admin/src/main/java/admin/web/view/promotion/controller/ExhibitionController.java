package admin.web.view.promotion.controller;

import java.io.File;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.promotion.model.ExhibitionBasePO;
import biz.app.promotion.model.ExhibitionSO;
import biz.app.promotion.model.ExhibitionThemeGoodsPO;
import biz.app.promotion.model.ExhibitionThemeGoodsSO;
import biz.app.promotion.model.ExhibitionThemeGoodsVO;
import biz.app.promotion.model.ExhibitionThemePO;
import biz.app.promotion.model.ExhibitionThemeSO;
import biz.app.promotion.model.ExhibitionThemeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.service.ExhibitionService;
import biz.app.system.model.UserBaseSO;
import biz.app.system.service.UserService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import framework.common.util.ExcelUtil;
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

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.promotion.controller
 * - 파일명		: ExhibitionController.java
* - 작성일		: 2017. 5. 29.
* - 작성자		: hongjun
 * - 설명		: 기획전
 * </pre>
 */
@Slf4j
@Controller
public class ExhibitionController {

	@Autowired
	private ExhibitionService exhibitionService;

	@Autowired
	private BizService bizService;

	@Autowired
	private UserService userService;

	@Autowired
	private CacheService cacheService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionListView.do")
	public String exhibitionListView(Model model) {
		UserBaseSO userBaseSO = new UserBaseSO();
		userBaseSO.setUsrGbCd(AdminConstants.USR_GB_1020);
		userBaseSO.setUsrStatCd(AdminConstants.USR_STAT_20);
		model.addAttribute("userBaseList", userService.getUserList(userBaseSO));

		return "/promotion/exhibitionListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/exhibitionListGrid.do", method=RequestMethod.POST)
	public GridResponse exhibitionListGrid(ExhibitionSO so) {
		List<ExhibitionVO> list = exhibitionService.pageExhibition(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: hongjun
	 * - 설명			: 기획전상태 일괄 수정 조회
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionBaseExhbtStatCdUpdateLayerView.do")
	public String exhibitionBaseExhbtStatCdUpdateLayerView(Model model) {
		return "/promotion/exhibitionBaseExhbtStatCdUpdateLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 기본 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionBaseView.do")
	public String exhibitionBaseView(Model model, ExhibitionSO so, HttpServletRequest request) {
		if(so.getExhbtNo() != null) {
			ExhibitionVO exhibitionBase = exhibitionService.getExhibitionBase(so);
			exhibitionBase.setStStdList(exhibitionService.getExhibitionStMap(so));
			exhibitionBase.setExhbtThmCnt(exhibitionService.getExhbtThmCnt(so));
			model.addAttribute("exhibitionBase", exhibitionBase);
			
			List<ExhibitionVO> exhibitionTag = exhibitionService.listExhibitionTagMap(so);
			model.addAttribute("exhibitionTag", exhibitionTag);
		} 
		
		// 210621 [CSR-1169] BO >> 기획전목록 >> 미리보기 기존 개발건 추가
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		String envGb = bizConfig.getProperty("envmt.gb");
		model.addAttribute("env",envGb);

		UserBaseSO userBaseSO = new UserBaseSO();
		userBaseSO.setUsrGbCd(AdminConstants.USR_GB_1020);
		userBaseSO.setUsrStatCd(AdminConstants.USR_STAT_20);
		model.addAttribute("userBaseList", userService.getUserList(userBaseSO));
		model.addAttribute("copyYn", so.getCopyYn());
		
		return "/promotion/exhibitionBaseView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 기본정보 저장
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionBaseSave.do")
	public String exhibitionBaseSave(Model model, ExhibitionBasePO po) {
		long exhbtNo = 0;
		if (po.getExhbtNos() != null) {
			for (long exhbtNo1 : po.getExhbtNos()) {
				ExhibitionBasePO exhibitionBasePO = new ExhibitionBasePO();
				exhibitionBasePO.setExhbtNo(exhbtNo1);
				exhibitionBasePO.setDispYn(po.getDispYn());
				exhibitionBasePO.setExhbtStatCd(po.getExhbtStatCd());
				exhibitionService.updateExhibitionBase(exhibitionBasePO);
			}
		} else if (po.getExhbtNo() == null) {
			exhbtNo = bizService.getSequence(AdminConstants.SEQUENCE_EXHBT_NO_SEQ);
			po.setExhbtNo(exhbtNo);
			exhibitionService.insertExhibitionBase(po);
		} else {
			exhbtNo = po.getExhbtNo();
			exhibitionService.updateExhibitionBase(po);
		}

		model.addAttribute("exhbtNo", exhbtNo);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 상태 일괄 수정
	 * 					- 업체 기획전 상태 일괄 승인/거절, 기획전 전시상태 일괄 변경
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionStateBatchSave.do")
	public String exhibitionStateBatchSave(Model model, ExhibitionBasePO po) {

		int updateCount = exhibitionService.updateExhibitionStateBatch(po);

		model.addAttribute("exhibitionStateUpdateCount", updateCount);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 1.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionThemeView.do")
	public String exhibitionThemeView(Model model, ExhibitionThemeSO so) {
		List<ExhibitionThemeVO> exhibitionThemeList = exhibitionService.getExhibitionTheme(so);
		model.addAttribute("exhibitionThemeList", exhibitionThemeList);
		model.addAttribute("so", so);
		model.addAttribute("dispYnList", this.cacheService.listCodeCache(AdminConstants.DISP_YN, null, null, null, null, null));
		model.addAttribute("showYnList", this.cacheService.listCodeCache(AdminConstants.SHOW_YN, null, null, null, null, null));
		model.addAttribute("listTpCdList", this.cacheService.listCodeCache(AdminConstants.LIST_TP, null, null, null, null, null));

		return "/promotion/exhibitionThemeView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 페이지
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/exhibitionThemeGrid.do", method=RequestMethod.POST)
	public GridResponse exhibitionThemeGrid(ExhibitionThemeSO so) {
		List<ExhibitionThemeVO> list = exhibitionService.pageExhibitionTheme(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 5.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마정보 저장
	 * </pre>
	 * @param model
	 * @param themeItemListStr
	 * @param exhbtNo
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/promotion/exhibitionThemeSave.do")
	public String exhibitionThemeSave(Model model
			, @RequestParam("themeItemPOList") String themeItemListStr
			, Long exhbtNo) {
		JsonUtil jsonUt = new JsonUtil();

		List<ExhibitionThemePO> exhibitionThemePOList = jsonUt.toArray(ExhibitionThemePO.class, themeItemListStr);
		for (ExhibitionThemePO po : exhibitionThemePOList) {
			if (po.getThmNo() == null) {
				exhibitionService.insertExhibitionTheme(po);
			} else {
				exhibitionService.updateExhibitionTheme(po);
			}
		}

		ExhibitionBasePO exhibitionBasePO = new ExhibitionBasePO();
		exhibitionBasePO.setExhbtNo(exhbtNo);
		exhibitionService.updateExhibitionBaseStat30To10(exhibitionBasePO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 7.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/exhibitionThemeGoodsView.do")
	public String exhibitionThemeGoodsView(Model model, ExhibitionSO so) {
		ExhibitionVO exhibitionBase = exhibitionService.getExhibitionBase(so);
		
		ExhibitionThemeGoodsSO gso = new ExhibitionThemeGoodsSO();
		gso.setExhbtNo(so.getExhbtNo());
		int goodsCnt = exhibitionService.countThemeGoods(gso);
		model.addAttribute("goodsCnt", goodsCnt);
		
		
		model.addAttribute("exhibitionBase", exhibitionBase);
		model.addAttribute("so", so);

		return "/promotion/exhibitionThemeGoodsView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 페이지
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/exhibitionThemeGoodsGrid.do", method=RequestMethod.POST)
	public GridResponse exhibitionThemeGoodsGrid(ExhibitionThemeSO so) {
		List<ExhibitionThemeGoodsVO> list = exhibitionService.pageExhibitionThemeGoods(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 정보 저장
	 * </pre>
	 * @param model
	 * @param themeGoodsItemListStr
	 * @param exhbtNo
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/promotion/exhibitionThemeGoodsSave.do")
	public String exhibitionThemeGoodsSave(Model model
			, @RequestParam("themeGoodsItemPOList") String themeGoodsItemListStr
			, Long exhbtNo) {
		JsonUtil jsonUt = new JsonUtil();

		List<ExhibitionThemeGoodsPO> exhibitionThemeGoodsPOList = jsonUt.toArray(ExhibitionThemeGoodsPO.class, themeGoodsItemListStr);
		for (ExhibitionThemeGoodsPO po : exhibitionThemeGoodsPOList) {
//			if (po.getIsUpdate() == 0) {
				exhibitionService.insertUpdateExhibitionThemeGoods(po);
//			} else {
//				exhibitionService.updateExhibitionThemeGoods(po);
//			}
		}

		ExhibitionBasePO exhibitionBasePO = new ExhibitionBasePO();
		exhibitionBasePO.setExhbtNo(exhbtNo);
		exhibitionService.updateExhibitionBaseStat30To10(exhibitionBasePO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 정보 삭제
	 * </pre>
	 * @param model
	 * @param themeGoodsItemListStr
	 * @param exhbtNo
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/promotion/exhibitionThemeGoodsDelete.do")
	public String exhibitionThemeGoodsDelete(Model model
			, @RequestParam("themeGoodsItemPOList") String themeGoodsItemListStr
			, Long exhbtNo) {
		JsonUtil jsonUt = new JsonUtil();

		List<ExhibitionThemeGoodsPO> exhibitionThemeGoodsPOList = jsonUt.toArray(ExhibitionThemeGoodsPO.class, themeGoodsItemListStr);
		for (ExhibitionThemeGoodsPO po : exhibitionThemeGoodsPOList) {
			if (po.getThmNo() != null) {
				exhibitionService.deleteExhibitionThemeGoods(po);
			}
		}

		ExhibitionBasePO exhibitionBasePO = new ExhibitionBasePO();
		exhibitionBasePO.setExhbtNo(exhbtNo);
		exhibitionService.updateExhibitionBaseStat30To10(exhibitionBasePO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 22.
	* - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품(일괄) 엑셀 양식 다운로드
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/promotion/exhbtThmGoodsExcelDownload.do")
	public String exhbtThmGoodsExcelDownload(Model model) {
		String[]	headerName	= null;
		String[]	fieldName	= null;
		String		sheetName	= "exhbtThmGoodsUploadTemplate";
		String		fileName	= "exhbtThmGoodsUploadTemplate";

		headerName = new String[] {
			messageSourceAccessor.getMessage("column.display_view.disp_prior_rank" ) //우선순위
			,messageSourceAccessor.getMessage("column.goods_id" ) //상품 아이디
		};

		fieldName = new String[] {
			"dispPriorRank" //우선순위
			, "goodsId" //상품 아이디
		};

		//=============================================================
		// Sample data set
		//=============================================================
		model.addAttribute( CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam( sheetName, headerName, fieldName, null) );
		model.addAttribute( CommonConstants.EXCEL_PARAM_FILE_NAME, fileName );

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ExhibitionController.java
	* - 작성일		: 2017. 6. 22.
	* - 작성자		: hongjun
	 * - 설명		: 상품 대량업로드
	 * </pre>
	 * @param model
	 * @param so
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/promotion/exhbtThmGoodsBatchCreateExec.do")
	public String exhbtThmGoodsBatchCreateExec(
		Model model
		, ExhibitionThemeGoodsSO so
		, @RequestParam("fileName") String fileName
		, @RequestParam("filePath") String filePath
		, Long exhbtNo
	) {
		if ( StringUtil.isNotEmpty( filePath ) ) {

			String[] headerMap = null;

			headerMap = new String[] {
				"dispPriorRank" //우선순위
				, "goodsId" //상품 아이디
			};

			File excelFile = new File(filePath);		// 파싱할 Excel File
			List<ExhibitionThemeGoodsPO> listPO = null;

			try {
				listPO = ExcelUtil.parse( excelFile, ExhibitionThemeGoodsPO.class, headerMap, 1 );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			boolean duplicateGoods = false;
			if(listPO.size() > 0) {
				for (ExhibitionThemeGoodsPO po : listPO) {
					po.setThmNo(so.getThmNo());
					po.setGoodsId(po.getGoodsId().trim());
					int result = exhibitionService.insertUpdateExhibitionThemeGoods(po);
					if(!duplicateGoods && result == 2) {
						duplicateGoods = true;
						model.addAttribute("returnCode", "duplicateGoods");
					}
				}

				ExhibitionBasePO exhibitionBasePO = new ExhibitionBasePO();
				exhibitionBasePO.setExhbtNo(exhbtNo);
				exhibitionService.updateExhibitionBaseStat30To10(exhibitionBasePO);
			}else {
				model.addAttribute("returnCode", "noData");
			}

			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("Fail to delete of file. ExhibitionController.exhbtThmGoodsBatchCreateExec::excelFile.delete {}");
			}
		}

		return View.jsonView();
	}

	@RequestMapping("/promotion/exhibitionListPopView.do")
	public String exhibitionListPopView(Model model) {
		UserBaseSO userBaseSO = new UserBaseSO();
		userBaseSO.setUsrGbCd(AdminConstants.USR_GB_1020);
		userBaseSO.setUsrStatCd(AdminConstants.USR_STAT_20);
		model.addAttribute("userBaseList", userService.getUserList(userBaseSO));

		return "/promotion/exhibitionListPopView";
	}
}