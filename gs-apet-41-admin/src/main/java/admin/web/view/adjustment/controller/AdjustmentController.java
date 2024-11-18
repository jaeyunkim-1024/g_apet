package admin.web.view.adjustment.controller;

import java.util.List;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.adjustment.model.AdjustmentSO;
import biz.app.adjustment.model.AdjustmentVO;
import biz.app.adjustment.service.AdjustmentService;



/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.adjustment.controller
* - 파일명		: AdjustmentController.java
* - 작성일		: 2016. 8. 31.
* - 작성자		: valueFactory
* - 설명			:
* </pre>
*/
@Slf4j
@Controller
public class AdjustmentController {

	@Autowired
	private AdjustmentService adjustmentService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;


	@RequestMapping("/adjustment/compAdjustmentView.do")
	public String compAdjustmentView (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "업체 정산");
			log.debug("==================================================");
		}

		return "/adjustment/compAdjustmentView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/adjustment/compAdjustmentGrid.do", method = RequestMethod.POST)
	public GridResponse compAdjustmentGrid (AdjustmentSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<AdjustmentVO> list = adjustmentService.listCompAdjustment(so );
		return new GridResponse(list, so);

	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/adjustment/compAdjustmentDtlGrid.do", method = RequestMethod.POST)
	public GridResponse compAdjustmentDtlGrid (AdjustmentSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<AdjustmentVO> list = adjustmentService.listCompAdjustmentDtl(so );
		return new GridResponse(list, so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/adjustment/compAdjustmentExcelDownload.do")
	public String compAdjustmentExcelDownload (ModelMap model, AdjustmentSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "compAdjustmentExcelDownload");
			log.debug("==================================================");
		}

		String[] headerName = {
				messageSourceAccessor.getMessage("column.comp_no")
				, messageSourceAccessor.getMessage("column.comp_nm")
				, messageSourceAccessor.getMessage("column.sale_prc")
				, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
				, "무통장"
				, "가상계좌"
				, "실시간"
				, "신용카드"
				, "페이코"
				, "휴대폰"
				, "쇼룸"
				, "외부몰"
				, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.dlvrc_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.asbc_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.cart_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.svmn_dc_amt")
				, messageSourceAccessor.getMessage("column.real_asb_amt")
				, messageSourceAccessor.getMessage("column.real_dlvr_amt")
				, "수수료"
				, "정산금액"
				, "세액"
		};

		String[] fieldName = {
				"compNo"
				, "compNm"
				, "saleAmt"
				, "payAmt"
				, "pay10Amt"
				, "pay20Amt"
				, "pay30Amt"
				, "pay40Amt"
				, "pay50Amt"
				, "pay90Amt"
				, "goodsCpDcAmt"
				, "dlvrcCpDcAmt"
				, "asbcCpDcAmt"
				, "cartCpDcAmt"
				, "svmnDcAmt"
				, "realAsbAmt"
				, "realDlvrAmt"
				, "cmsAmt"
				, "adjtAmt"
				, "adjtTax"
		};

		List<AdjustmentVO> list = adjustmentService.listCompAdjustment(so );

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("adjustment", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "adjustment");

		return View.excelDownload();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/adjustment/compAdjustmentDtlExcelDownload.do")
	public String compAdjustmentDtlExcelDownload (ModelMap model, AdjustmentSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "compAdjustmentDtlExcelDownload");
			log.debug("==================================================");
		}

		String[] headerName = {
				messageSourceAccessor.getMessage("column.ord_no")
				, messageSourceAccessor.getMessage("column.ord_dtl_seq")
				, messageSourceAccessor.getMessage("column.comp_no")
				, messageSourceAccessor.getMessage("column.comp_nm")
				, messageSourceAccessor.getMessage("column.goods_id")
				, messageSourceAccessor.getMessage("column.goods_nm")
				, messageSourceAccessor.getMessage("column.item_no")
				, messageSourceAccessor.getMessage("column.item_nm")
				, messageSourceAccessor.getMessage("column.pay_means_cd")
				, messageSourceAccessor.getMessage("column.sale_prc")
				, messageSourceAccessor.getMessage("column.ord_qty")
				, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
				, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.dlvrc_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.asbc_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.cart_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.svmn_dc_amt")
				, messageSourceAccessor.getMessage("column.real_asb_amt")
				, messageSourceAccessor.getMessage("column.real_dlvr_amt")
				, messageSourceAccessor.getMessage("column.cms_rate")
				, "수수료"
				, "정산금액"
				, "세액"
		};

		String[] fieldName = {
				"ordNo"
				, "ordDtlSeq"
				, "compNo"
				, "compNm"
				, "goodsId"
				, "goodsNm"
				, "itemNo"
				, "itemNm"
				, "payMeansCd"
				, "saleAmt"
				, "ordQty"
				, "payAmt"
				, "goodsCpDcAmt"
				, "dlvrcCpDcAmt"
				, "asbcCpDcAmt"
				, "cartCpDcAmt"
				, "svmnDcAmt"
				, "realAsbAmt"
				, "realDlvrAmt"
				, "cmsRate"
				, "cmsAmt"
				, "adjtAmt"
				, "adjtTax"
		};

		List<AdjustmentVO> list = adjustmentService.listCompAdjustmentDtl(so );

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("adjustmentDtl", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "adjustmentDtl");

		return View.excelDownload();
	}





	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 9. 3.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/adjustment/pageAdjustmentView.do")
	public String pageAdjustmentView (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "외부몰 정산");
			log.debug("==================================================");
		}

		return "/adjustment/pageAdjustmentView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/adjustment/pageAdjustmentGrid.do", method = RequestMethod.POST)
	public GridResponse pageAdjustmentGrid (AdjustmentSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<AdjustmentVO> list = adjustmentService.listPageAdjustment(so );
		return new GridResponse(list, so);

	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/adjustment/pageAdjustmentDtlGrid.do", method = RequestMethod.POST)
	public GridResponse pageAdjustmentDtlGrid (AdjustmentSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<AdjustmentVO> list = adjustmentService.listPageAdjustmentDtl(so );
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/adjustment/pageAdjustmentExcelDownload.do")
	public String pageAdjustmentExcelDownload (ModelMap model, AdjustmentSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "pageAdjustmentExcelDownload");
			log.debug("==================================================");
		}

		String[] headerName = {
				messageSourceAccessor.getMessage("column.page_gb_cd")
				, messageSourceAccessor.getMessage("column.sale_prc")
				, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
				, "수수료"
				, "정산금액"
				, "세액"
		};

		String[] fieldName = {
				"pageGbCd"
				, "saleAmt"
				, "payAmt"
				, "cmsAmt"
				, "adjtAmt"
				, "adjtTax"
		};

		List<AdjustmentVO> list = adjustmentService.listPageAdjustment(so );

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("adjustment", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "adjustment");

		return View.excelDownload();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: AdjustmentController.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/adjustment/pageAdjustmentDtlExcelDownload.do")
	public String pageAdjustmentDtlExcelDownload (ModelMap model, AdjustmentSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "pageAdjustmentDtlExcelDownload");
			log.debug("==================================================");
		}

		String[] headerName = {
				messageSourceAccessor.getMessage("column.ord_no")
				, messageSourceAccessor.getMessage("column.ord_dtl_seq")
				, messageSourceAccessor.getMessage("column.comp_no")
				, messageSourceAccessor.getMessage("column.comp_nm")
				, messageSourceAccessor.getMessage("column.goods_id")
				, messageSourceAccessor.getMessage("column.goods_nm")
				, messageSourceAccessor.getMessage("column.item_no")
				, messageSourceAccessor.getMessage("column.item_nm")
				, messageSourceAccessor.getMessage("column.pay_means_cd")
				, messageSourceAccessor.getMessage("column.sale_prc")
				, messageSourceAccessor.getMessage("column.ord_qty")
				, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
				, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.dlvrc_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.asbc_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.cart_cp_dc_amt")
				, messageSourceAccessor.getMessage("column.svmn_dc_amt")
				, messageSourceAccessor.getMessage("column.real_asb_amt")
				, messageSourceAccessor.getMessage("column.real_dlvr_amt")
				, messageSourceAccessor.getMessage("column.cms_rate")
				, "수수료"
				, "정산금액"
				, "세액"
		};

		String[] fieldName = {
				"ordNo"
				, "ordDtlSeq"
				, "compNo"
				, "compNm"
				, "goodsId"
				, "goodsNm"
				, "itemNo"
				, "itemNm"
				, "payMeansCd"
				, "saleAmt"
				, "ordQty"
				, "payAmt"
				, "goodsCpDcAmt"
				, "dlvrcCpDcAmt"
				, "asbcCpDcAmt"
				, "cartCpDcAmt"
				, "svmnDcAmt"
				, "realAsbAmt"
				, "realDlvrAmt"
				, "cmsRate"
				, "cmsAmt"
				, "adjtAmt"
				, "adjtTax"
		};

		List<AdjustmentVO> list = adjustmentService.listPageAdjustmentDtl(so );

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("adjustmentDtl", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "adjustmentDtl");

		return View.excelDownload();
	}







}
