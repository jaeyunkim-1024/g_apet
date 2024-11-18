package admin.web.view.settlement.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.order.model.OrderDetailPO;
import biz.app.settlement.model.GsPntHistSO;
import biz.app.settlement.model.GsPntHistVO;
import biz.app.settlement.model.SettlementListExcelVO;
import biz.app.settlement.model.SettlementListSO;
import biz.app.settlement.model.SettlementListVO;
import biz.app.settlement.model.SettlementPO;
import biz.app.settlement.model.SettlementSO;
import biz.app.settlement.model.SettlementVO;
import biz.app.settlement.service.SettlementService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.ChnlStdInfoSO;
import biz.app.system.model.ChnlStdInfoVO;
import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.service.ChnlStdInfoService;
import biz.app.system.service.PrivacyCnctService;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;



/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.settle.controller
* - 파일명		: SettlementController.java
* - 작성일		: 2017. 6. 20.
* - 작성자		: schoi
* - 설명			:
* </pre>
*/
@Slf4j
@Controller
public class SettlementController {

	@Autowired
	private SettlementService settlementService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Autowired
	private StService stService;
	
	@Autowired
	private ChnlStdInfoService chnlStdInfoService;
	
	@Autowired
	private PrivacyCnctService privacyCnctService;
	
	@Autowired SktmpService sktmpService;


	@RequestMapping("/settlement/settlementList.do")
	public String settlementList (Model model) {
		/****************************
		 * 세션 정보
		 ****************************/
		Session session = AdminSessionUtil.getSession();
		model.addAttribute("session", session);
		
		/***********************
		 * 사이트 정보 조회
		 *************************/
		StStdInfoSO ssiso = new StStdInfoSO();

		/*
		 * 사용자 그룹이 업체사용자일 경우 업체 계약된 사이트 정보만 노출
		 */
		if(!AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd()) ) {
			ssiso.setCompNo(session.getCompNo());
		}

		List<StStdInfoVO> stList = this.stService.listStStdInfo(ssiso);

		model.addAttribute("siteList", stList);
		
		ChnlStdInfoSO chnso = new ChnlStdInfoSO();
		chnso.setChnlGbCd("20");
		List<ChnlStdInfoVO> chnList = chnlStdInfoService.pageChnlStdInfo(chnso);

		model.addAttribute("chnList", chnList);

		return "/settlement/settlementList";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/settlementListGrid.do", method = RequestMethod.POST)
	public GridResponse settlementListGrid (SettlementListSO so ) {
		// type01 : 구매확정일시
		// type02 : 정산완료일시
		// type03 : 주문접수일시
		if (!StringUtil.equals("type03", so.getSearchKeyDate())) {
			if (StringUtil.equals("type01", so.getSearchKeyDate())) {
				so.setPurConfDtmStart(so.getOrdAcptDtmStart());
				so.setPurConfDtmEnd(so.getOrdAcptDtmEnd());
			}
			if (StringUtil.equals("type02", so.getSearchKeyDate())) {
				so.setOrdCclCpltDtmStart(so.getOrdAcptDtmStart());
				so.setOrdCclCpltDtmEnd(so.getOrdAcptDtmEnd());
			}
			so.setOrdAcptDtmStart(null);
			so.setOrdAcptDtmEnd(null);
		}

		List<SettlementListVO> list = settlementService.pageOrderOrgStlm( so );
		
		if(list != null) {
			for(SettlementListVO vo : list) {
				String outsideOrdNo = vo.getOutsideOrdNo();
				
				if(!StringUtils.isEmpty(outsideOrdNo)) {
					vo.setOrdNo(vo.getOrdNo() + "{" + vo.getChnlNm() + ": " + outsideOrdNo + "}");
					vo.setStNm(vo.getChnlNm());
				}
				//마스킹처리
				if(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N)){
					//마스킹 처리
					vo = getMaskingOrderListVo(vo);
				}
			}
		}

		return new GridResponse(list, so);

	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/settlementListDtlGrid.do", method = RequestMethod.POST)
	public GridResponse settlementListDtlGrid (SettlementSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<SettlementVO> list = settlementService.pageListSettlementDtl(so );
		return new GridResponse(list, so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementListExcelDownload.do")
	public String settlementListExcelDownload (ModelMap model, SettlementSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "settlementListExcelDownload");
			log.debug("==================================================");
		}
		so.setRows(999999999);
		List<SettlementVO> list = settlementService.pageListSettlement(so );
		
		String[] headerName = {
				messageSourceAccessor.getMessage("column.settlement.stl_no")
				, messageSourceAccessor.getMessage("column.settlement.stl_month")
				//, messageSourceAccessor.getMessage("column.settlement.st_id")
				, messageSourceAccessor.getMessage("column.settlement.st_nm")
				, messageSourceAccessor.getMessage("column.settlement.stl_order")
				, messageSourceAccessor.getMessage("column.settlement.stl_term")
				//, messageSourceAccessor.getMessage("column.settlement.comp_no")
				, messageSourceAccessor.getMessage("column.settlement.comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.comp_gb_nm")
				, messageSourceAccessor.getMessage("column.settlement.sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_cms")
				, messageSourceAccessor.getMessage("column.settlement.comp_sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.rfd_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_rfd_cms")
				, messageSourceAccessor.getMessage("column.settlement.comp_rfd_amt")
				, messageSourceAccessor.getMessage("column.settlement.ord_dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.clm_dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.mrg_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_stl_amt")
				, messageSourceAccessor.getMessage("column.settlement.rtn_rsrv_rate")
				, messageSourceAccessor.getMessage("column.settlement.rtn_rsrv_amt")
				, messageSourceAccessor.getMessage("column.settlement.pre_rtn_rsrv_amt")
				, messageSourceAccessor.getMessage("column.settlement.real_stl_amt")
				, messageSourceAccessor.getMessage("column.settlement.bank_nm")
				, messageSourceAccessor.getMessage("column.settlement.acct_no")
				, messageSourceAccessor.getMessage("column.settlement.ooa_nm")			
				, messageSourceAccessor.getMessage("column.settlement.stl_stat_nm")
				, messageSourceAccessor.getMessage("column.settlement.md_usr_nm")
	
		};

		String[] fieldName = {
				"stlNo"
				, "stlMonth"
				//, "stId"
				, "stNm"
				, "stlOrder"
				, "stlTerm"
				//, "compNo"
				, "compNm"
				, "compGbNm"
				, "saleAmt"
				, "brkrCms"
				, "compSaleAmt"
				, "dcAmt"
				, "brkrBdnDcAmt"
				, "compBdnDcAmt"
				, "rfdAmt"
				, "brkrRfdCms"
				, "compRfdAmt"
				, "ordDlvrc"
				, "clmDlvrc"
				, "mrgAmt"
				, "compStlAmt"
				, "rtnRsrvRate"
				, "rtnRsrvAmt"
				, "preRtnRsrvAmt"
				, "realStlAmt"
				, "bankNm"
				, "acctNo"
				, "ooaNm"
				, "stlStatNm"
				, "mdUsrNm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlementList", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlementList");

		return View.excelDownload();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementListDtlExcelDownload.do")
	public String settlementListDtlExcelDownload (ModelMap model, SettlementSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "settlementListDtlExcelDownload");
			log.debug("==================================================");
		}

		so.setRows(999999999);
		List<SettlementVO> list = settlementService.pageListSettlementDtl(so );

		String[] headerName = {
				messageSourceAccessor.getMessage("column.settlement.st_nm")
				//, messageSourceAccessor.getMessage("column.settlement.st_id")				
				//, messageSourceAccessor.getMessage("column.settlement.comp_no")
				//, messageSourceAccessor.getMessage("column.settlement.org_comp_no")
				, messageSourceAccessor.getMessage("column.settlement.comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.comp_gb_nm")
				, messageSourceAccessor.getMessage("column.settlement.acpt_dtm")
				, messageSourceAccessor.getMessage("column.settlement.ord_no")
				//, messageSourceAccessor.getMessage("column.settlement.ord_dtl_seq")
				, messageSourceAccessor.getMessage("column.settlement.clm_no")
				//, messageSourceAccessor.getMessage("column.settlement.clm_dtl_seq")
				, messageSourceAccessor.getMessage("column.settlement.stl_ord_tp_nm")
				, messageSourceAccessor.getMessage("column.settlement.ord_nm")
				, messageSourceAccessor.getMessage("column.settlement.ordr_id")
				, messageSourceAccessor.getMessage("column.settlement.goods_id")
				, messageSourceAccessor.getMessage("column.settlement.goods_nm")
				, messageSourceAccessor.getMessage("column.settlement.item_no")
				, messageSourceAccessor.getMessage("column.settlement.item_nm")
				, messageSourceAccessor.getMessage("column.settlement.stl_tg_qty")
				, messageSourceAccessor.getMessage("column.settlement.sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.svmn_use_amt")
				, messageSourceAccessor.getMessage("column.settlement.dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.dlvrc_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.pay_amt")
				, messageSourceAccessor.getMessage("column.settlement.pay_means_nm")
				, messageSourceAccessor.getMessage("column.settlement.prmt_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.prmt_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.prmt_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.gc_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.gc_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.gc_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.cc_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.cc_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.cc_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.clm_dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.cms_rate")
				, messageSourceAccessor.getMessage("column.settlement.sale_mrg_amt")
				, messageSourceAccessor.getMessage("column.settlement.real_mrg_amt")
				, messageSourceAccessor.getMessage("column.settlement.sale_set_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_sale_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.dlvrc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_bdn_dlvrc_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.set_tot_amt")
		};

		String[] fieldName = {
				"stNm"
				//, "stId"
				//, "compNo"
				//, "orgCompNo"
				, "compNm"
				, "compGbNm"
				, "acptDtm"
				, "ordNo"
				//, "ordDtlSeq"
				, "clmNo"
				//, "clmDtlSeq"
				, "stlOrdTpNm"
				, "ordNm"
				, "ordrId"
				, "goodsId"
				, "goodsNm"
				, "itemNo"
				, "itemNm"
				, "stlTgQty"
				, "saleAmt"
				, "dcAmt"
				, "svmnUseAmt"
				, "dlvrc"
				, "dlvrcDcAmt"
				, "payAmt"
				, "payMeansNm"
				, "prmtBdnDcTotAmt"
				, "prmtBrkrBdnDcAmt"
				, "prmtCompBdnDcAmt"
				, "gcBdnDcTotAmt"
				, "gcBrkrBdnDcAmt"
				, "gcCompBdnDcAmt"
				, "ccBdnDcTotAmt"
				, "ccBrkrBdnDcAmt"
				, "ccCompBdnDcAmt"
				, "dcBdnDcTotAmt"
				, "dcBrkrBdnDcAmt"
				, "dcCompBdnDcAmt"
				, "brkrDcTotAmt"
				, "compDcTotAmt"
				, "clmDlvrc"
				, "cmsRate"
				, "saleMrgAmt"
				, "realMrgAmt"
				, "saleSetAmt"
				, "compSaleDcAmt"
				, "dlvrcTotAmt"
				, "compBdnDlvrcDcAmt"
				, "setTotAmt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlementListDtl", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlementListDtl");

		return View.excelDownload();
	}

	
	@RequestMapping("/settlement/settlementListStlStatUpdateLayerView.do")
	public String settlementListStlStatUpdateLayerView() {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("===================정산 상태 변경=====================");
			log.debug("==================================================");
		}
		return "/settlement/settlementListStlStatUpdateLayerView";
	}
	
	
	@RequestMapping("/settlement/settlementListStlStatUpdate.do")
	public String settlementListStlStatUpdate(Model model, SettlementPO settlementPO, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		settlementService.updateSettlementListStlStat(settlementPO);
		return View.jsonView();
	}	
	
	
	@RequestMapping("/settlement/settlementComplete.do")
	public String settlementComplete (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("======================정산 완료======================");
			log.debug("==================================================");
		}

		return "/settlement/settlementComplete";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/settlementCompleteGrid.do", method = RequestMethod.POST)
	public GridResponse settlementCompleteGrid (SettlementSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<SettlementVO> list = settlementService.pageListSettlementComplete(so );
		return new GridResponse(list, so);

	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/settlementCompleteDtlGrid.do", method = RequestMethod.POST)
	public GridResponse settlementCompleteDtlGrid (SettlementSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<SettlementVO> list = settlementService.pageListSettlementCompleteDtl(so );
		return new GridResponse(list, so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementCompleteExcelDownload.do")
	public String settlementCompleteExcelDownload (ModelMap model, SettlementSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "settlementCompleteExcelDownload");
			log.debug("==================================================");
		}

		so.setRows(999999999);
		List<SettlementVO> list = settlementService.pageListSettlementComplete(so );

		String[] headerName = {
				messageSourceAccessor.getMessage("column.settlement.stl_no")
				, messageSourceAccessor.getMessage("column.settlement.stl_month")
				//, messageSourceAccessor.getMessage("column.settlement.st_id")
				, messageSourceAccessor.getMessage("column.settlement.st_nm")
				, messageSourceAccessor.getMessage("column.settlement.stl_order")
				, messageSourceAccessor.getMessage("column.settlement.stl_term")
				//, messageSourceAccessor.getMessage("column.settlement.comp_no")
				, messageSourceAccessor.getMessage("column.settlement.comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.comp_gb_nm")
				, messageSourceAccessor.getMessage("column.settlement.sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_cms")
				, messageSourceAccessor.getMessage("column.settlement.comp_sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.rfd_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_rfd_cms")
				, messageSourceAccessor.getMessage("column.settlement.comp_rfd_amt")
				, messageSourceAccessor.getMessage("column.settlement.ord_dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.clm_dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.mrg_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_stl_amt")
				, messageSourceAccessor.getMessage("column.settlement.rtn_rsrv_rate")
				, messageSourceAccessor.getMessage("column.settlement.rtn_rsrv_amt")
				, messageSourceAccessor.getMessage("column.settlement.pre_rtn_rsrv_amt")
				, messageSourceAccessor.getMessage("column.settlement.real_stl_amt")
				, messageSourceAccessor.getMessage("column.settlement.bank_nm")
				, messageSourceAccessor.getMessage("column.settlement.acct_no")
				, messageSourceAccessor.getMessage("column.settlement.ooa_nm")			
				, messageSourceAccessor.getMessage("column.settlement.pvd_stat_nm")
				, messageSourceAccessor.getMessage("column.settlement.md_usr_nm")
	
		};

		String[] fieldName = {
				"stlNo"
				, "stlMonth"
				//, "stId"
				, "stNm"
				, "stlOrder"
				, "stlTerm"
				//, "compNo"
				, "compNm"
				, "compGbNm"
				, "saleAmt"
				, "brkrCms"
				, "compSaleAmt"
				, "dcAmt"
				, "brkrBdnDcAmt"
				, "compBdnDcAmt"
				, "rfdAmt"
				, "brkrRfdCms"
				, "compRfdAmt"
				, "ordDlvrc"
				, "clmDlvrc"
				, "mrgAmt"
				, "compStlAmt"
				, "rtnRsrvRate"
				, "rtnRsrvAmt"
				, "preRtnRsrvAmt"
				, "realStlAmt"
				, "bankNm"
				, "acctNo"
				, "ooaNm"
				, "pvdStatNm"
				, "mdUsrNm"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlementComplete", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlementComplete");

		return View.excelDownload();
	}
		
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementCompleteDtlExcelDownload.do")
	public String settlementCompleteDtlExcelDownload (ModelMap model, SettlementSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "settlementCompleteDtlExcelDownload");
			log.debug("==================================================");
		}

		so.setRows(999999999);
		List<SettlementVO> list = settlementService.pageListSettlementCompleteDtl(so );

		String[] headerName = {
				messageSourceAccessor.getMessage("column.settlement.st_nm")
				//, messageSourceAccessor.getMessage("column.settlement.st_id")				
				//, messageSourceAccessor.getMessage("column.settlement.comp_no")
				//, messageSourceAccessor.getMessage("column.settlement.org_comp_no")
				, messageSourceAccessor.getMessage("column.settlement.comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.acpt_dtm")
				, messageSourceAccessor.getMessage("column.settlement.ord_no")
				//, messageSourceAccessor.getMessage("column.settlement.ord_dtl_seq")
				, messageSourceAccessor.getMessage("column.settlement.clm_no")
				//, messageSourceAccessor.getMessage("column.settlement.clm_dtl_seq")
				, messageSourceAccessor.getMessage("column.settlement.stl_ord_tp_nm")
				, messageSourceAccessor.getMessage("column.settlement.ord_nm")
				, messageSourceAccessor.getMessage("column.settlement.ordr_id")
				, messageSourceAccessor.getMessage("column.settlement.goods_id")
				, messageSourceAccessor.getMessage("column.settlement.goods_nm")
				, messageSourceAccessor.getMessage("column.settlement.item_no")
				, messageSourceAccessor.getMessage("column.settlement.item_nm")
				, messageSourceAccessor.getMessage("column.settlement.stl_tg_qty")
				, messageSourceAccessor.getMessage("column.settlement.sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.svmn_use_amt")
				, messageSourceAccessor.getMessage("column.settlement.dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.dlvrc_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.pay_amt")
				, messageSourceAccessor.getMessage("column.settlement.pay_means_nm")
				, messageSourceAccessor.getMessage("column.settlement.prmt_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.prmt_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.prmt_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.gc_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.gc_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.gc_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.cc_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.cc_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.cc_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_bdn_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_brkr_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.dc_comp_bdn_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.brkr_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_dc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.clm_dlvrc")
				, messageSourceAccessor.getMessage("column.settlement.cms_rate")
				, messageSourceAccessor.getMessage("column.settlement.sale_mrg_amt")
				, messageSourceAccessor.getMessage("column.settlement.real_mrg_amt")
				, messageSourceAccessor.getMessage("column.settlement.sale_set_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_sale_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.dlvrc_tot_amt")
				, messageSourceAccessor.getMessage("column.settlement.comp_bdn_dlvrc_dc_amt")
				, messageSourceAccessor.getMessage("column.settlement.set_tot_amt")
		};

		String[] fieldName = {
				"stNm"
				//, "stId"
				//, "compNo"
				//, "orgCompNo"
				, "compNm"
				, "acptDtm"
				, "ordNo"
				//, "ordDtlSeq"
				, "clmNo"
				//, "clmDtlSeq"
				, "stlOrdTpNm"
				, "ordNm"
				, "ordrId"
				, "goodsId"
				, "goodsNm"
				, "itemNo"
				, "itemNm"
				, "stlTgQty"
				, "saleAmt"
				, "dcAmt"
				, "svmnUseAmt"
				, "dlvrc"
				, "dlvrcDcAmt"
				, "payAmt"
				, "payMeansNm"
				, "prmtBdnDcTotAmt"
				, "prmtBrkrBdnDcAmt"
				, "prmtCompBdnDcAmt"
				, "gcBdnDcTotAmt"
				, "gcBrkrBdnDcAmt"
				, "gcCompBdnDcAmt"
				, "ccBdnDcTotAmt"
				, "ccBrkrBdnDcAmt"
				, "ccCompBdnDcAmt"
				, "dcBdnDcTotAmt"
				, "dcBrkrBdnDcAmt"
				, "dcCompBdnDcAmt"
				, "brkrDcTotAmt"
				, "compDcTotAmt"
				, "clmDlvrc"
				, "cmsRate"
				, "saleMrgAmt"
				, "realMrgAmt"
				, "saleSetAmt"
				, "compSaleDcAmt"
				, "dlvrcTotAmt"
				, "compBdnDlvrcDcAmt"
				, "setTotAmt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlementCompleteDtl", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlementCompleteDtl");

		return View.excelDownload();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 7. 18.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementCompleteTaxInvoiceExcelDownload.do")
	public String settlementCompleteTaxInvoiceExcelDownload (ModelMap model, SettlementSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "settlementCompleteTaxInvoiceExcelDownload");
			log.debug("==================================================");
		}

		so.setRows(999999999);
		List<SettlementVO> list = settlementService.listSettlementCompleteTaxInvoice(so );

		String[] headerName = {
				messageSourceAccessor.getMessage("column.settlement.tax.tax_type")
				, messageSourceAccessor.getMessage("column.settlement.tax.stl_end_dt")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_biz_no")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_biz_no2")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_ceo_nm")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_prcl_addr")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_biz_cdts")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_biz_tp")
				, messageSourceAccessor.getMessage("column.settlement.tax.dcg_dlgt_email")
				, messageSourceAccessor.getMessage("column.settlement.tax.biz_no")
				, messageSourceAccessor.getMessage("column.settlement.tax.col1")
				, messageSourceAccessor.getMessage("column.settlement.tax.comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.tax.ceo_nm")
				, messageSourceAccessor.getMessage("column.settlement.tax.prcl_addr")
				, messageSourceAccessor.getMessage("column.settlement.tax.biz_cdts")
				, messageSourceAccessor.getMessage("column.settlement.tax.biz_tp")
				, messageSourceAccessor.getMessage("column.settlement.tax.dlgt_email")
				, messageSourceAccessor.getMessage("column.settlement.tax.col2")
				, messageSourceAccessor.getMessage("column.settlement.tax.prov_amt")
				, messageSourceAccessor.getMessage("column.settlement.tax.prov_tax_amt")
				, messageSourceAccessor.getMessage("column.settlement.tax.col3")
				, messageSourceAccessor.getMessage("column.settlement.tax.stl_end_day1")
				, messageSourceAccessor.getMessage("column.settlement.tax.item1")
				, messageSourceAccessor.getMessage("column.settlement.tax.col4")
				, messageSourceAccessor.getMessage("column.settlement.tax.col5")
				, messageSourceAccessor.getMessage("column.settlement.tax.col6")
				, messageSourceAccessor.getMessage("column.settlement.tax.prov_amt1")
				, messageSourceAccessor.getMessage("column.settlement.tax.prov_tax_amt1")
				, messageSourceAccessor.getMessage("column.settlement.tax.col7")
				, messageSourceAccessor.getMessage("column.settlement.tax.col8")
				, messageSourceAccessor.getMessage("column.settlement.tax.col9")
				, messageSourceAccessor.getMessage("column.settlement.tax.col10")
				, messageSourceAccessor.getMessage("column.settlement.tax.col11")
				, messageSourceAccessor.getMessage("column.settlement.tax.col12")
				, messageSourceAccessor.getMessage("column.settlement.tax.col13")
				, messageSourceAccessor.getMessage("column.settlement.tax.col14")
				, messageSourceAccessor.getMessage("column.settlement.tax.col15")
				, messageSourceAccessor.getMessage("column.settlement.tax.col16")
				, messageSourceAccessor.getMessage("column.settlement.tax.col17")
				, messageSourceAccessor.getMessage("column.settlement.tax.col18")
				, messageSourceAccessor.getMessage("column.settlement.tax.col19")
				, messageSourceAccessor.getMessage("column.settlement.tax.col20")
				, messageSourceAccessor.getMessage("column.settlement.tax.col21")
				, messageSourceAccessor.getMessage("column.settlement.tax.col22")
				, messageSourceAccessor.getMessage("column.settlement.tax.col23")
				, messageSourceAccessor.getMessage("column.settlement.tax.col24")
				, messageSourceAccessor.getMessage("column.settlement.tax.col25")
				, messageSourceAccessor.getMessage("column.settlement.tax.col26")
				, messageSourceAccessor.getMessage("column.settlement.tax.col27")
				, messageSourceAccessor.getMessage("column.settlement.tax.col28")
				, messageSourceAccessor.getMessage("column.settlement.tax.col29")
				, messageSourceAccessor.getMessage("column.settlement.tax.col30")
				, messageSourceAccessor.getMessage("column.settlement.tax.col31")
				, messageSourceAccessor.getMessage("column.settlement.tax.col32")
				, messageSourceAccessor.getMessage("column.settlement.tax.col33")
				, messageSourceAccessor.getMessage("column.settlement.tax.col34")
				, messageSourceAccessor.getMessage("column.settlement.tax.col35")
				, messageSourceAccessor.getMessage("column.settlement.tax.rcpt_gb")

		};

		String[] fieldName = {
				"taxType"
				, "stlEndDt"
				, "dcgBizNo"
				, "dcgBizNo2"
				, "dcgCompNm"
				, "dcgCeoNm"
				, "dcgPrclAddr"
				, "dcgBiz"
				, "dcgBizTp"
				, "dcgDlgtEmail"
				, "bizNo"
				, "col1"
				, "compNm"
				, "ceoNm"
				, "prclAddr"
				, "biz"
				, "bizTp"
				, "dlgtEmail"
				, "col2"
				, "provAmt"
				, "provTaxAmt"
				, "col3"
				, "stlEndDay"
				, "item"
				, "col4"
				, "col5"
				, "col6"
				, "provAmt1"
				, "provTaxAmt1"
				, "col7"
				, "col8"
				, "col9"
				, "col10"
				, "col11"
				, "col12"
				, "col13"
				, "col14"
				, "col15"
				, "col16"
				, "col17"
				, "col18"
				, "col19"
				, "col20"
				, "col21"
				, "col22"
				, "col23"
				, "col24"
				, "col25"
				, "col26"
				, "col27"
				, "col28"
				, "col29"
				, "col30"
				, "col31"
				, "col32"
				, "col33"
				, "col34"
				, "col35"
				, "rcptGb"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlementCompleteTaxInvoice", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlementCompleteTaxInvoice");

		return View.excelDownload();
	}
	
	@RequestMapping("/settlement/settlementCompletePvdStatUpdateLayerView.do")
	public String settlementCompletePvdStatUpdateLayerView() {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("===================지급 상태 변경=====================");
			log.debug("==================================================");
		}
		return "/settlement/settlementCompletePvdStatUpdateLayerView";
	}
	
	@RequestMapping("/settlement/settlementCompletePvdStatUpdate.do")
	public String settlementCompletePvdStatUpdate(Model model, SettlementPO settlementPO, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		settlementService.updateSettlementCompletePvdStat(settlementPO);
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 7. 7.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementInfo.do")
	public String settlementInfo (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("======================매출 정보======================");
			log.debug("==================================================");
		}

		return "/settlement/settlementInfo";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 7. 7.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/settlementInfoGrid.do", method = RequestMethod.POST)
	public GridResponse settlementInfoGrid (SettlementSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		List<SettlementVO> list = settlementService.pageListSettlementInfo(so );
		return new GridResponse(list, so);

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2017. 7. 18.
	* - 작성자		: schoi
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementInfoExcelDownload.do")
	public String settlementInfoExcelDownload (ModelMap model, SettlementSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "settlementInfoExcelDownload");
			log.debug("==================================================");
		}

		so.setRows(999999999);
		List<SettlementVO> list = settlementService.pageListSettlementInfo(so );

		String[] headerName = {
				messageSourceAccessor.getMessage("column.settlement.st_nm")
				//, messageSourceAccessor.getMessage("column.settlement.st_id")				
				//, messageSourceAccessor.getMessage("column.settlement.comp_no")
				, messageSourceAccessor.getMessage("column.settlement.comp_nm")
				, messageSourceAccessor.getMessage("column.settlement.acpt_dtm")
				, messageSourceAccessor.getMessage("column.settlement.ord_no")
				//, messageSourceAccessor.getMessage("column.settlement.ord_dtl_seq")
				, messageSourceAccessor.getMessage("column.settlement.clm_no")
				//, messageSourceAccessor.getMessage("column.settlement.clm_dtl_seq")
				, messageSourceAccessor.getMessage("column.settlement.stl_ord_tp_nm")
				, messageSourceAccessor.getMessage("column.settlement.ord_nm")
				, messageSourceAccessor.getMessage("column.settlement.ordr_id")
				, messageSourceAccessor.getMessage("column.settlement.goods_id")
				, messageSourceAccessor.getMessage("column.settlement.goods_nm")
				, messageSourceAccessor.getMessage("column.settlement.item_no")
				, messageSourceAccessor.getMessage("column.settlement.item_nm")
				, messageSourceAccessor.getMessage("column.settlement.sale_amt")
				, messageSourceAccessor.getMessage("column.settlement.stl_tg_qty")
				, messageSourceAccessor.getMessage("column.settlement.sale_tot_amt")
		};

		String[] fieldName = {
				"stNm"
				//, "stId"
				//, "compNo"
				, "compNm"
				, "acptDtm"
				, "ordNo"
				//, "ordDtlSeq"
				, "clmNo"
				//, "clmDtlSeq"
				, "stlOrdTpNm"
				, "ordNm"
				, "ordrId"
				, "goodsId"
				, "goodsNm"
				, "itemNo"
				, "itemNm"
				, "saleAmt"
				, "stlTgQty"
				, "saleTotAmt"
		};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlementInfo", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlementInfo");

		return View.excelDownload();
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2021. 04. 06.
	* - 작성자		: KKB
	* - 설명	 	: GS&포인트 내역 조회 화면
	* </pre>
	* @param 
	* @return
	*/
	@RequestMapping("/settlement/gsPntHistView.do")
	public String gsPntHistListView () {
		return "/settlement/gsPntHistView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2021. 04. 06.
	* - 작성자		: KKB
	* - 설명	 	: GS&포인트 내역 조회 목록
	* </pre>
	* @param 	GsPntHistSO so
	* @return	GridResponse
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/getGsPntHistList.do", method = RequestMethod.POST)
	public GridResponse getGsPntHistList(GsPntHistSO so) {
		List<GsPntHistVO> list = settlementService.pageGsPntHist(so);
		for(int i=0 ; i < list.size() ;  i++) {
			list.get(i).setRowIndex((so.getPage()-1)*so.getRows()+i+1l);
		}
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2021. 04. 07.
	* - 작성자		: KKB
	* - 설명	 	: GS&포인트 내역 조회 총액
	* </pre>
	* @param 	GsPntHistSO so
	* @return	GsPntHistVO
	*/
	@ResponseBody
	@RequestMapping(value = "/settlement/getGsPntHistTotal.do")
	public ModelMap getGsPntHistTotal(GsPntHistSO so) {
		GsPntHistVO gphvo = settlementService.getGsPntHistTotal(so);
		ModelMap map = new ModelMap();
		map.put("totlal",gphvo);
		return map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2021. 04. 07.
	* - 작성자		: KKB
	* - 설명	 	: GS&포인트 내역 엑셀 다운로드
	* </pre>
	* @param 	GsPntHistSO so
	* @return	GsPntHistVO
	*/
	@RequestMapping("/settlement/gsPntHistExcelDownload.do")
	public String pushCountExcelDownload(Model model, GsPntHistSO so) {
		so.setRows(999999999);
		List<GsPntHistVO> list = settlementService.pageGsPntHist(so);
		for(int i=0 ; i < list.size() ;  i++) {
			list.get(i).setExcelNo(i+1l);
		}
		// 엑셀 데이터 값
		String[] headerName = so.getHeaderName();
		String[] fieldName = so.getFieldName();
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("gsPntHistList", headerName, fieldName,  list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "gsPntHistList");
		return View.excelDownload();
	}
	
	private SettlementListVO getMaskingOrderListVo(SettlementListVO vo) {
		vo.setOrdrId(MaskingUtil.getId(vo.getOrdrId()));
		vo.setOrdNm(MaskingUtil.getName(vo.getOrdNm()));
		vo.setOrdrMobile(MaskingUtil.getTelNo(StringUtil.formatPhone(vo.getOrdrMobile())));
		vo.setOrdrEmail(MaskingUtil.getEmail(vo.getOrdrEmail()));
		vo.setOrdrTel(MaskingUtil.getTelNo(StringUtil.formatPhone(vo.getTel())));

		vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
		vo.setMobile(MaskingUtil.getTelNo(StringUtil.formatPhone(vo.getMobile())));
		vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(), vo.getRoadDtlAddr()));
		vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));
		return vo;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SettlementController.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 정산 상태 일괄 업데이트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/settlement/batchUpdateStat.do")
	public String batchUpdateStat(Model model, SettlementListSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "settlement batchUpdateStat");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
		
		String[] ordDtlSeqs = so.getOrdDtlSeqs();
		List<OrderDetailPO> orderDetailPoList = new ArrayList<>();
		for (String ordDtlSeq : ordDtlSeqs) {
			OrderDetailPO po = new OrderDetailPO();
			String ordNo = ordDtlSeq.split("\\|")[0];
			String ordDetailSeq = ordDtlSeq.split("\\|")[1];
			po.setOrdNo(ordNo);
			po.setOrdDtlSeq(Integer.valueOf(ordDetailSeq));
			orderDetailPoList.add(po);
		}
		updateCnt = settlementService.batchUpdateStat(orderDetailPoList);
		model.addAttribute("updateCnt", updateCnt);
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: SettlementController.java
	* - 작성일		: 2021. 5. 17.
	* - 작성자		: 
	* - 설명			: 주문 정산내역 엑셀 다운로드 > 구매확정 건 전제, 같은 주문 건 내 주문당 배송비 부과에 대해서는 seq 1만 표기하고 2에는 공백. 무료배송은 0 으로 표기.
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/settlement/settlementAdjustListExcelDownload.do")
	public String orderAdjustListExcelDownload(ModelMap model, SettlementListSO so
		,@RequestParam(value="cnctHistNo",required = false)Long cnctHistNo
		,@RequestParam(value="inqrHistNo",required = false)Long inqrHistNo){
		so.setRows(999999999);
		List<SettlementListExcelVO> list = settlementService.settlementAdjustExcel( so );
		String[] headerName = null;
		String[] fieldName = null;
		headerName = new String[]{
				 messageSourceAccessor.getMessage("column.user_no")
				, messageSourceAccessor.getMessage("column.ord_no")
				, messageSourceAccessor.getMessage("column.ord_dtl_seq")
				, messageSourceAccessor.getMessage("column.goods_id")
				, messageSourceAccessor.getMessage("column.goods_nm")
				, messageSourceAccessor.getMessage("column.goods_cstrt_cd")
				, messageSourceAccessor.getMessage("column.statistics.sale_amt")
				, messageSourceAccessor.getMessage("column.goodsQty")
				, messageSourceAccessor.getMessage("column.ordAmt")
				, messageSourceAccessor.getMessage("column.trans_cost")
				, messageSourceAccessor.getMessage("column.spl_prc")
				, messageSourceAccessor.getMessage("column.spl_prc_tot")
				, messageSourceAccessor.getMessage("column.cnc_qty")
				, messageSourceAccessor.getMessage("column.exc_qty")
				, messageSourceAccessor.getMessage("column.rtn_qty")
				, messageSourceAccessor.getMessage("column.order_common.return_dlvr_amt")
				, messageSourceAccessor.getMessage("column.settlement.stl_amt")
				, messageSourceAccessor.getMessage("column.compNm2")
				, messageSourceAccessor.getMessage("column.inv_reg_dtm")
				, messageSourceAccessor.getMessage("column.comp_biz_no")
		};
		fieldName = new String[]{
				"mbrNo"
				, "ordNo"
				, "ordDtlSeq"
				, "goodsId"
				, "goodsNm"
				, "goodsCstrtTpNm"
				, "saleAmt"
				, "ordQty"
				, "payAmt"
				, "realDlvrAmtString"
				, "splAmt"
				, "splAmtTot"
				, "cncQty"
				, "excQty"
				, "rtnQty"
				, "rtnDlvrAmt"
				, "stlAmt"
				, "phsCompNm"
				, "ooCpltDtm"
				, "bizNo"
		};
		
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("settlement", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "settlement");
		model.addAttribute(CommonConstants.EXCEL_PASSWORD,DateUtil.getNowDate());
		String execSql = so.getExecSql();
		PrivacyCnctHistPO p = new PrivacyCnctHistPO();
		p.setCnctHistNo(cnctHistNo);
		p.setInqrHistNo(inqrHistNo);
		p.setExecSql(execSql);
		p.setInqrGbCd(AdminConstants.INQR_GB_60);
		privacyCnctService.updateExecSql(p);

		return View.excelDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.settlement.controller
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: 우주코인 내역 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/settlement/sktmpPntHistListView.do")
	public String sktmpPntHistListView() {
		return "/settlement/sktmpPntHistListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.settlement.controller
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: 우주코인 내역 그리드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/settlement/sktmpPntHistListGrid.do")
	public GridResponse sktmpLinkedHistoryGrid(SktmpLnkHistSO so){
		List<SktmpLnkHistVO> list = sktmpService.pageSktmpLnkHist(so);
		for(int i=0 ; i < list.size() ;  i++) {
			list.get(i).setRowIndex((so.getPage()-1)*so.getRows()+i+1l);
		}
		return new GridResponse(list,so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.settlement.controller
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: 우주코인 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/settlement/sktmpPntHistExcelDownload.do")
	public String sktmpPntHistExcelDownload(Model model, SktmpLnkHistSO so) {
		so.setRows(999999999);
		List<SktmpLnkHistVO> list = sktmpService.pageSktmpLnkHist(so);
		for(int i=0 ; i < list.size() ;  i++) {
			list.get(i).setExcelNo(i+1l);
		}
		
		// 엑셀 데이터 값
		String[] headerName = new String[]{
			"No"
			, "주문 번호"
			, "클레임 번호"
			, "거래 구분"
			, "적립 사용 구분"
			, "user-no"
			, "멤버십 번호"
			, "총 결제 금액"
			, "우주코인 거래일시"
			, "사용"
			, "적립"
			, "사용취소"
			, "적립취소"
		};
		String[] fieldName = new String[]{
			"excelNo"
			, "ordNo"
			, "clmNo"
			, "mpRealLnkGbCd"
			, "mpLnkGbCd"
			, "mbrNo"
			, "cardNo"
			, "payAmt"
			, "reqDtm"
			, "viewUsePnt"
			, "viewSavePnt"
			, "viewUseCncPnt"
			, "viewSaveCncPnt"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("sktmpPntHistList", headerName, fieldName,  list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "sktmpPntHistList");
		return View.excelDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.settlement.controller
	 * - 작성일		: 2021. 07. 27.
	 * - 작성자		: JinHong
	 * - 설명		: 우주코인 리스트 합계 정보
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/settlement/getSktmpPntHistTotal.do")
	public ModelMap getSktmpPntHistTotal(SktmpLnkHistSO so) {
		SktmpLnkHistVO vo = sktmpService.getSktmpPntHistTotal(so);
		ModelMap map = new ModelMap();
		map.put("total", vo);
		return map;
	}
	
}
