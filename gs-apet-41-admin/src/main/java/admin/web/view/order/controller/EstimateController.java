package admin.web.view.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.estimate.model.EstimateGoodsVO;
import biz.app.estimate.model.EstimateSO;
import biz.app.estimate.model.EstimateVO;
import biz.app.estimate.service.EstimateGoodsService;
import biz.app.estimate.service.EstimateService;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.order.controller
* - 파일명		: EstimateController.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 Controller
* </pre>
*/
@Slf4j
@Controller
public class EstimateController {


	@Autowired	private EstimateService estimateService;

	@Autowired	private EstimateGoodsService estimateGoodsService;

	@Autowired	private MessageSourceAccessor messageSourceAccessor;


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 목록 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/order/estimateListView.do")
	public String estimateListView(Model model) {
		return "/order/estimateListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EstimateController.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 목록 조회(그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/order/estimateListGrid.do", method=RequestMethod.POST)
	public GridResponse estimateListGrid(EstimateSO so) {
		List<EstimateVO> list = this.estimateService.pageEstimate(so);
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EstimateController.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 상세 목록 조회 (그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/order/estimateDetailListGrid.do", method=RequestMethod.POST)
	public GridResponse estimateDetailListGrid(EstimateSO so) {
		List<EstimateGoodsVO> list = this.estimateGoodsService.listEstimateGoods(so);
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: EstimateController.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 엑셀 다운로드
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/order/estimateListExcelDownload.do")
	public String estimateListExcelDownload(ModelMap model, EstimateSO so) {
		so.setRows(999999999);
		List<EstimateVO> list = this.estimateService.pageEstimate(so);

		String[] headerName = {
				  messageSourceAccessor.getMessage("column.comp_nm")
				, messageSourceAccessor.getMessage("column.stockAmount")
				, messageSourceAccessor.getMessage("column.componentRate")
		};

		String[] fieldName = {
				 "compNm"
				, "stkAmt"
				, "rate"
		};

		String excelTitle = "EstimateList";

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(excelTitle, headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, excelTitle);

		return View.excelDownload();
	}


}
