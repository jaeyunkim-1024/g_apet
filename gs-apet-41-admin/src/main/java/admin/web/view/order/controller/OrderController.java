package admin.web.view.order.controller;

import java.util.List;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
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
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.service.ClaimDetailService;
import biz.app.claim.service.ClaimService;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.service.CounselService;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;
import biz.app.delivery.service.DeliveryChargeService;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.service.ItemService;
import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderListExcelVO;
import biz.app.order.model.OrderListSO;
import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderMemoPO;
import biz.app.order.model.OrderMemoSO;
import biz.app.order.model.OrderMemoVO;
import biz.app.order.service.OrderBaseService;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderDlvraService;
import biz.app.order.service.OrderMemoService;
import biz.app.order.service.OrderService;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.service.PayBaseService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.ChnlStdInfoSO;
import biz.app.system.model.ChnlStdInfoVO;
import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.service.ChnlStdInfoService;
import biz.app.system.service.LocalPostService;
import biz.app.system.service.PrivacyCnctService;
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
* - 패키지명		: admin.web.view.order.controller
* - 파일명		: OrderController.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 주문 Controller
* </pre>
*/
@Slf4j
@Controller
public class OrderController {
	

	@Autowired	private OrderService orderService;

	@Autowired	private OrderBaseService orderBaseService;

	@Autowired	private OrderDetailService orderDetailService;

	@Autowired private ClaimService claimService;

	@Autowired private ClaimDetailService claimDetailService;

	@Autowired private StService stService;

	@Autowired	private OrderMemoService orderMemoService;

	@Autowired private OrderDlvraService orderDlvraService;

	@Autowired	private MessageSourceAccessor messageSourceAccessor;

	@Autowired	private Properties bizConfig;

	@Autowired private PayBaseService payBaseService;

	@Autowired private ItemService itemService;

	@Autowired private CounselService counselService;

	@Autowired private DeliveryChargeService deliveryChargeService;
	
	@Autowired private ChnlStdInfoService chnlStdInfoService;
	
	@Autowired
	private LocalPostService localPostService;
	
	@Autowired
	private PrivacyCnctService privacyCnctService;
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: snw
	* - 설명			: 주문 목록 조회 화면
	* </pre>
	* @param orderSO
	* @param br
	* @return
	*/
	@RequestMapping("/order/orderListView.do")
	public String orderListView(Model model) {

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

		return "/order/orderListView";

	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 6. 1.
	* - 작성자		: Administrator
	* - 설명			: 도서 산간 지역 여부
	 * </pre>
	 * 
	 * @param postNoOld
	 * @param postNoNew
	 * @return
	 */
	@RequestMapping(value ="/order/checkLocalPost.do")
	@ResponseBody
	public ModelMap checkLocalPost(String postNoOld, String postNoNew) {
		
		String localPostYn = this.localPostService.getLocalPostYn(postNoNew, postNoOld.replaceAll("-", ""));

		ModelMap map = new ModelMap();
		
		map.put("localPostYn", localPostYn);

		return map;
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: snw
	* - 설명			: 주문 목록 조회(그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/orderListGrid.do", method=RequestMethod.POST )
	public GridResponse orderListGrid(OrderListSO so){
		List<OrderListVO> list = orderService.pageOrderOrg( so );
		
		if(list != null) {
			for(OrderListVO vo : list) {
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

		return new GridResponse( list, so );
	}

	private OrderListVO getMaskingOrderListVo(OrderListVO vo) {
		vo.setOrdrId(MaskingUtil.getId(vo.getOrdrId()));
		vo.setOrdNm(MaskingUtil.getName(vo.getOrdNm()));
		vo.setOrdrMobile(MaskingUtil.getTelNo(vo.getOrdrMobile()));
		vo.setOrdrEmail(MaskingUtil.getEmail(vo.getOrdrEmail()));
		vo.setOrdrTel(MaskingUtil.getTelNo(vo.getTel()));

		vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
		vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
		vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(), vo.getRoadDtlAddr()));
		vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));
		return vo;
	}

	private OrderListExcelVO getMaskingOrderListVo(OrderListExcelVO vo) {
		vo.setOrdrId(MaskingUtil.getId(vo.getOrdrId()));
		vo.setOrdNm(MaskingUtil.getName(vo.getOrdNm()));
		vo.setOrdrMobile(MaskingUtil.getTelNo(vo.getOrdrMobile()));
		vo.setOrdrEmail(MaskingUtil.getEmail(vo.getOrdrEmail()));
		vo.setOrdrTel(MaskingUtil.getTelNo(vo.getTel()));

		vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
		vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
		vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(), vo.getRoadDtlAddr()));
		vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));
		return vo;
	}



	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 주문 목록 엑셀 다운로드
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/order/orderListExcelDownload.do")
	public String orderListExcelDownload(ModelMap model, OrderListSO so
		,@RequestParam(value="cnctHistNo",required = false)Long cnctHistNo
		,@RequestParam(value="inqrHistNo",required = false)Long inqrHistNo
	){
		so.setRows(999999999);
		model.addAttribute(CommonConstants.EXCEL_PASSWORD,DateUtil.getNowDate());

		if(so.getSearchTypeExcel()==null || "member".equals(so.getSearchTypeExcel())) {
			return orderListExcelDownloadOrg(model, so,cnctHistNo,inqrHistNo);
		} else if ("adjust".equals(so.getSearchTypeExcel())) {
			return orderAdjustListExcelDownload(model, so,cnctHistNo,inqrHistNo);
		}
		List<OrderListExcelVO> list = orderService.orderOrgExcel( so );
		if(StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_N)){
			for(OrderListExcelVO v : list){
				v = getMaskingOrderListVo(v);
			}
		}

		String[] headerName = null;
		String[] fieldName = null;
		if("type00".equals(so.getSearchTypeExcel())) { //전체 엑셀 다운로드
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.user_no")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ordr_email")
					, messageSourceAccessor.getMessage("column.ordr_mobile")
					, messageSourceAccessor.getMessage("column.login_id")
					, messageSourceAccessor.getMessage("column.mbr_grd_cd")
					, messageSourceAccessor.getMessage("column.comp_tp_cd")
					, messageSourceAccessor.getMessage("column.goods.phsCompNo")
					, messageSourceAccessor.getMessage("column.statistics.goods_cd")
					, messageSourceAccessor.getMessage("column.comp_goods_no")
					, messageSourceAccessor.getMessage("column.goods_cstrt_cd")
					, messageSourceAccessor.getMessage("column.goods_nm")
					, messageSourceAccessor.getMessage("column.order_common.cs_demand")
					, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
					, messageSourceAccessor.getMessage("column.spl_prc")
					, messageSourceAccessor.getMessage("column.goods.org_sale_prc")
					, messageSourceAccessor.getMessage("column.statistics.sale_amt")
					, messageSourceAccessor.getMessage("column.goods_dc_amt")
					, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.cart_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.pay_amt")
					, messageSourceAccessor.getMessage("column.goodsQty")
					, messageSourceAccessor.getMessage("column.cnc_qty")
					, messageSourceAccessor.getMessage("column.exc_qty")
					, messageSourceAccessor.getMessage("column.rtn_qty")
					, messageSourceAccessor.getMessage("column.tot_goods_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_cart_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_discount_amt")
					, messageSourceAccessor.getMessage("column.tot_pay_amt")
					, messageSourceAccessor.getMessage("column.payMeansNm")
					, messageSourceAccessor.getMessage("column.dpsAcctNo")
					, messageSourceAccessor.getMessage("column.dpstrNm")
					, messageSourceAccessor.getMessage("column.order_common.cash_rct_yn")
					, messageSourceAccessor.getMessage("column.cfm_rst_cd_pg")
					, messageSourceAccessor.getMessage("column.deal_no_pg")
					, messageSourceAccessor.getMessage("column.cfm_no_pg")
					, messageSourceAccessor.getMessage("column.ordDt")
					, messageSourceAccessor.getMessage("column.payDt")
					, messageSourceAccessor.getMessage("column.pay_end_date")
					, messageSourceAccessor.getMessage("column.adrs_nm")
					, messageSourceAccessor.getMessage("column.adrs_mobile")
					, messageSourceAccessor.getMessage("column.adrs_post_no_new")
					, messageSourceAccessor.getMessage("column.adrs_addr1")
					, messageSourceAccessor.getMessage("column.adrs_addr2")
					, messageSourceAccessor.getMessage("column.cash_rfd_amt")
					, messageSourceAccessor.getMessage("column.card_rfd_amt")
					, messageSourceAccessor.getMessage("column.pay_rfd_amt")
					, messageSourceAccessor.getMessage("column.settlement.clm_dlvrc_amt")
					, messageSourceAccessor.getMessage("column.clm_rsn_cd")
					, messageSourceAccessor.getMessage("column.claim_common.claim_rsn_detail_content")
					, messageSourceAccessor.getMessage("column.order_common.refund_name")
					, messageSourceAccessor.getMessage("column.order_common.refund_bank")
					, messageSourceAccessor.getMessage("column.order_common.refund_account")
					, messageSourceAccessor.getMessage("column.clm_acpt_dtm")
					, messageSourceAccessor.getMessage("column.clm_cplt_dtm")
					, messageSourceAccessor.getMessage("column.mdl_nm")
					, messageSourceAccessor.getMessage("column.ctg_cd_nm")
					, messageSourceAccessor.getMessage("column.bnd_nm")
					, messageSourceAccessor.getMessage("column.mmft")
					, messageSourceAccessor.getMessage("column.ctr_org")
					, messageSourceAccessor.getMessage("column.frb_goods_info")
					, messageSourceAccessor.getMessage("column.dlvrPrcsTpNm")
					, messageSourceAccessor.getMessage("column.dlvrNo")
					, messageSourceAccessor.getMessage("column.hdcCd")
					, messageSourceAccessor.getMessage("column.inv_no")
					, messageSourceAccessor.getMessage("column.order_common.dlvr_demand")
					, messageSourceAccessor.getMessage("column.deliver_date")
					, messageSourceAccessor.getMessage("column.dlvr_cplt_dtm")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "mbrNo"
					, "ordNm"
					, "ordrEmail"
					, "ordrMobile"
					, "ordrId"
					, "mbrGrdNm"
					, "compTpNm"
					, "phsCompNm"
					, "goodsId"
					, "itemNo"
					, "goodsCstrtTpNm"
					, "goodsNm"
					, "mkiGoodsOptContent"
					, "ordDtlStatCd"
					, "splAmt"
					, "orgSaleAmt"
					, "saleAmt"
					, "prmtDcAmt"
					, "cpDcAmt"
					, "cartCpDcAmt"
					, "payAmt"
					, "ordQty"
					, "cncQty"
					, "clmExcIngQty"
					, "rtnQty"
					, "prmtDcSumAmt"
					, "cpSumAmt"
					, "cartCpSumAmt"
					, "cpDcSumAmt"
					, "paySumAmt"
					, "payMeansNm"
					, "acctNo"
					, "ooaNm"
					, "cashRctNo"
					, "cfmRstCd"
					, "dealNo"
					, "cfmNo"
					, "ordAcptDtm"
					, "payCpltDtm"
					, "payCpltDtmVirtualAccount"
					, "adrsNm"
					, "mobile"
					, "postNoNew"
					, "roadAddr"
					, "roadDtlAddr"
					, "cashRefundAmt"
					, "cardRefundAmt"
					, "payRefundAmt"
					, "clmDlvrcAmt"
					, "clmRsnNm"
					, "clmRsnContent"
					, "refundOoaNm"
					, "refundBankCd"
					, "refundAcctNo"
					, "clmAcptDtm"
					, "clmCpltDtm"
					, "mdlNm"
					, "category"
					, "bndNmKo"
					, "mmft"
					, "ctrOrg"
					, "subGoodsNm"
					, "dlvrPrcsTpNm"
					, "dlvrNo"
					, "hdcNm"
					, "invNo"
					, "dlvrDemand"
					, "dlvrCmdDtm"
					, "dlvrCpltDtm"
			};
		} else if("type01".equals(so.getSearchTypeExcel())) { //배송비 포함 전체 엑셀 다운로드
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.user_no")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ordr_email")
					, messageSourceAccessor.getMessage("column.ordr_mobile")
					, messageSourceAccessor.getMessage("column.login_id")
					, messageSourceAccessor.getMessage("column.mbr_grd_cd")
					, messageSourceAccessor.getMessage("column.comp_tp_cd")
					, messageSourceAccessor.getMessage("column.goods.phsCompNo")
					, messageSourceAccessor.getMessage("column.statistics.goods_cd")
					, messageSourceAccessor.getMessage("column.comp_goods_no")
					, messageSourceAccessor.getMessage("column.goods_cstrt_cd")
					, messageSourceAccessor.getMessage("column.goods_nm")
					, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
					, messageSourceAccessor.getMessage("column.spl_prc")
					, messageSourceAccessor.getMessage("column.goods.org_sale_prc")
					, messageSourceAccessor.getMessage("column.statistics.sale_amt")
					, messageSourceAccessor.getMessage("column.goods_dc_amt")
					, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.cart_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.pay_amt")
					, messageSourceAccessor.getMessage("column.goodsQty")
					, messageSourceAccessor.getMessage("column.cnc_qty")
					, messageSourceAccessor.getMessage("column.exc_qty")
					, messageSourceAccessor.getMessage("column.rtn_qty")
					, messageSourceAccessor.getMessage("column.tot_goods_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_cart_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_discount_amt")
					, messageSourceAccessor.getMessage("column.tot_pay_amt")
					, messageSourceAccessor.getMessage("column.dlvrc_no")
					, messageSourceAccessor.getMessage("column.org_dlvr_amt")
					, messageSourceAccessor.getMessage("column.settlement.dlvrc_dc_amt")
					, messageSourceAccessor.getMessage("column.settlement.dlvrc_pay_amt")
					, messageSourceAccessor.getMessage("column.payMeansNm")
					, messageSourceAccessor.getMessage("column.dpsAcctNo")
					, messageSourceAccessor.getMessage("column.dpstrNm")
					, messageSourceAccessor.getMessage("column.order_common.cash_rct_yn")
					, messageSourceAccessor.getMessage("column.cfm_rst_cd_pg")
					, messageSourceAccessor.getMessage("column.deal_no_pg")
					, messageSourceAccessor.getMessage("column.cfm_no_pg")
					, messageSourceAccessor.getMessage("column.ordDt")
					, messageSourceAccessor.getMessage("column.payDt")
					, messageSourceAccessor.getMessage("column.pay_end_date")
					, messageSourceAccessor.getMessage("column.adrs_nm")
					, messageSourceAccessor.getMessage("column.adrs_mobile")
					, messageSourceAccessor.getMessage("column.adrs_post_no_new")
					, messageSourceAccessor.getMessage("column.adrs_addr1")
					, messageSourceAccessor.getMessage("column.adrs_addr2")
					, messageSourceAccessor.getMessage("column.cash_rfd_amt")
					, messageSourceAccessor.getMessage("column.card_rfd_amt")
					, messageSourceAccessor.getMessage("column.pay_rfd_amt")
					, messageSourceAccessor.getMessage("column.settlement.clm_dlvrc_amt")
					, messageSourceAccessor.getMessage("column.clm_rsn_cd")
					, messageSourceAccessor.getMessage("column.claim_common.claim_rsn_detail_content")
					, messageSourceAccessor.getMessage("column.order_common.refund_name")
					, messageSourceAccessor.getMessage("column.order_common.refund_bank")
					, messageSourceAccessor.getMessage("column.order_common.refund_account")
					, messageSourceAccessor.getMessage("column.clm_acpt_dtm")
					, messageSourceAccessor.getMessage("column.clm_cplt_dtm")
					, messageSourceAccessor.getMessage("column.mdl_nm")
					, messageSourceAccessor.getMessage("column.ctg_cd_nm")
					, messageSourceAccessor.getMessage("column.bnd_nm")
					, messageSourceAccessor.getMessage("column.mmft")
					, messageSourceAccessor.getMessage("column.ctr_org")
					, messageSourceAccessor.getMessage("column.frb_goods_info")
					, messageSourceAccessor.getMessage("column.dlvrPrcsTpNm")
					, messageSourceAccessor.getMessage("column.dlvrNo")
					, messageSourceAccessor.getMessage("column.hdcCd")
					, messageSourceAccessor.getMessage("column.inv_no")
					, messageSourceAccessor.getMessage("column.order_common.dlvr_demand")
					, messageSourceAccessor.getMessage("column.deliver_date")
					, messageSourceAccessor.getMessage("column.dlvr_cplt_dtm")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "mbrNo"
					, "ordNm"
					, "ordrEmail"
					, "ordrMobile"
					, "ordrId"
					, "mbrGrdNm"
					, "compTpNm"
					, "phsCompNm"
					, "goodsId"
					, "itemNo"
					, "goodsCstrtTpNm"
					, "goodsNm"
					, "ordDtlStatCd"
					, "splAmt"
					, "orgSaleAmt"
					, "saleAmt"
					, "prmtDcAmt"
					, "cpDcAmt"
					, "cartCpDcAmt"
					, "payAmt"
					, "ordQty"
					, "cncQty"
					, "clmExcIngQty"
					, "rtnQty"
					, "prmtDcSumAmt"
					, "cpSumAmt"
					, "cartCpSumAmt"
					, "cpDcSumAmt"
					, "paySumAmt"
					, "dlvrcNo"
					, "orgDlvrAmt"
					, "dlvrcCpDcAmt"
					, "realDlvrAmt"
					, "payMeansNm"
					, "acctNo"
					, "ooaNm"
					, "cashRctNo"
					, "cfmRstCd"
					, "dealNo"
					, "cfmNo"
					, "ordAcptDtm"
					, "payCpltDtm"
					, "payCpltDtmVirtualAccount"
					, "adrsNm"
					, "mobile"
					, "postNoNew"
					, "roadAddr"
					, "roadDtlAddr"
					, "cashRefundAmt"
					, "cardRefundAmt"
					, "payRefundAmt"
					, "clmDlvrcAmt"
					, "clmRsnNm"
					, "clmRsnContent"
					, "refundOoaNm"
					, "refundBankCd"
					, "refundAcctNo"
					, "clmAcptDtm"
					, "clmCpltDtm"
					, "mdlNm"
					, "category"
					, "bndNmKo"
					, "mmft"
					, "ctrOrg"
					, "subGoodsNm"
					, "dlvrPrcsTpNm"
					, "dlvrNo"
					, "hdcNm"
					, "invNo"
					, "dlvrDemand"
					, "dlvrCmdDtm"
					, "dlvrCpltDtm"
			};
		} else if("type02".equals(so.getSearchTypeExcel())) { //상품 엑셀 다운로드
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ordr_mobile")
					, messageSourceAccessor.getMessage("column.statistics.goods_cd")
					, messageSourceAccessor.getMessage("column.goods_cstrt_cd")
					, messageSourceAccessor.getMessage("column.goods_nm")
					, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
					, messageSourceAccessor.getMessage("column.statistics.sale_amt")
					, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.cart_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.pay_amt")
					, messageSourceAccessor.getMessage("column.goodsQty")
					, messageSourceAccessor.getMessage("column.tot_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_cart_cp_dc_amt")
					, messageSourceAccessor.getMessage("column.tot_discount_amt")
					, messageSourceAccessor.getMessage("column.tot_pay_amt")
					, messageSourceAccessor.getMessage("column.payMeansNm")
					, messageSourceAccessor.getMessage("column.ordDt")
					, messageSourceAccessor.getMessage("column.adrs_nm")
					, messageSourceAccessor.getMessage("column.adrs_mobile")
					, messageSourceAccessor.getMessage("column.adrs_post_no_new")
					, messageSourceAccessor.getMessage("column.adrs_addr1")
					, messageSourceAccessor.getMessage("column.adrs_addr2")
					, messageSourceAccessor.getMessage("column.ctg_cd_nm")
					, messageSourceAccessor.getMessage("column.bnd_nm")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "ordNm"
					, "ordrMobile"
					, "goodsId"
					, "goodsCstrtTpNm"
					, "goodsNm"
					, "ordDtlStatCd"
					, "saleAmt"
					, "cpDcAmt"
					, "cartCpDcAmt"
					, "payAmt"
					, "ordQty"
					, "cpSumAmt"
					, "cartCpSumAmt"
					, "cpDcSumAmt"
					, "paySumAmt"
					, "payMeansNm"
					, "ordAcptDtm"
					, "adrsNm"
					, "mobile"
					, "postNoNew"
					, "roadAddr"
					, "roadDtlAddr"
					, "category"
					, "bndNmKo"
			};
		} else if("type03".equals(so.getSearchTypeExcel())) { //주요 요약 엑셀 다운로드
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.user_no")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ordr_email")
					, messageSourceAccessor.getMessage("column.ordr_mobile")
					, messageSourceAccessor.getMessage("column.login_id")
					, messageSourceAccessor.getMessage("column.goods_nm")
					, messageSourceAccessor.getMessage("column.statistics.sale_amt")
					, messageSourceAccessor.getMessage("column.goodsQty")
					, messageSourceAccessor.getMessage("column.tot_pay_amt")
					, messageSourceAccessor.getMessage("column.payMeansNm")
					, messageSourceAccessor.getMessage("column.settlement.bank_nm")
					, messageSourceAccessor.getMessage("column.dpsAcctNo")
					, messageSourceAccessor.getMessage("column.dpstrNm")
					, messageSourceAccessor.getMessage("column.order_common.cash_rct_yn")
					, messageSourceAccessor.getMessage("column.cfm_rst_cd_pg")
					, messageSourceAccessor.getMessage("column.deal_no_pg")
					, messageSourceAccessor.getMessage("column.cfm_no_pg")
					, messageSourceAccessor.getMessage("column.ordDt")
					, messageSourceAccessor.getMessage("column.payDt")
					, messageSourceAccessor.getMessage("column.pay_end_date")
					, messageSourceAccessor.getMessage("column.adrs_nm")
					, messageSourceAccessor.getMessage("column.adrs_mobile")
					, messageSourceAccessor.getMessage("column.adrs_post_no_new")
					, messageSourceAccessor.getMessage("column.adrs_addr1")
					, messageSourceAccessor.getMessage("column.adrs_addr2")
					, messageSourceAccessor.getMessage("column.frb_goods_info")
					, messageSourceAccessor.getMessage("column.order_common.dlvr_demand")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "mbrNo"
					, "ordNm"
					, "ordrEmail"
					, "ordrMobile"
					, "ordrId"
					, "goodsNm"
					, "saleAmt"
					, "ordQty"
					, "paySumAmt"
					, "payMeansNm"
					, "bankNm"
					, "acctNo"
					, "ooaNm"
					, "cashRctNo"
					, "cfmRstCd"
					, "dealNo"
					, "cfmNo"
					, "ordAcptDtm"
					, "payCpltDtm"
					, "payCpltDtmVirtualAccount"
					, "adrsNm"
					, "mobile"
					, "postNoNew"
					, "roadAddr"
					, "roadDtlAddr"
					, "subGoodsNm"
					, "dlvrDemand"
			};
		} else if("type04".equals(so.getSearchTypeExcel())) { //CRM 엑셀 다운로드
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.user_no")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ordr_mobile")
					, messageSourceAccessor.getMessage("column.login_id")
					, messageSourceAccessor.getMessage("column.mbr_grd_cd")
					, messageSourceAccessor.getMessage("column.cp_dc_unit_prc_amt")
					, messageSourceAccessor.getMessage("column.cart_cp_dc_unit_prc_amt")
					, messageSourceAccessor.getMessage("column.tot_discount_amt")
					, messageSourceAccessor.getMessage("column.tot_pay_amt")
					, messageSourceAccessor.getMessage("column.ordDt")
					, messageSourceAccessor.getMessage("column.applyGoodsCpNm")
					, messageSourceAccessor.getMessage("column.applyCartCpNm")
					, messageSourceAccessor.getMessage("column.mkngRcvYn")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "mbrNo"
					, "ordNm"
					, "ordrMobile"
					, "ordrId"
					, "mbrGrdNm"
					, "cpSumAmt"
					, "cartCpSumAmt"
					, "cpDcSumAmt"
					, "paySumAmt"
					, "ordAcptDtm"
					, "goodsCpNm"
					, "cartCpNm"
					, "mkngRcvYn"
			};
		}

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("order", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "order");

		//엑셀 다운로드
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
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2021. 5. 17.
	* - 작성자		: 
	* - 설명			: 주문 정산내역 엑셀 다운로드 > 구매확정 건 전제, 같은 주문 건 내 주문당 배송비 부과에 대해서는 seq 1만 표기하고 2에는 공백. 무료배송은 0 으로 표기.
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/order/orderAdjustListExcelDownload.do")
	public String orderAdjustListExcelDownload(ModelMap model, OrderListSO so
		,@RequestParam(value="cnctHistNo",required = false)Long cnctHistNo
		,@RequestParam(value="inqrHistNo",required = false)Long inqrHistNo){
		so.setRows(999999999);
		List<OrderListExcelVO> list = orderService.orderAdjustExcel( so );
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
		
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("order", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "order");

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
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 주문목록 엑셀 다운로드
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	public String orderListExcelDownloadOrg(ModelMap model, OrderListSO so
			,@RequestParam(value="cnctHistNo",required = false)Long cnctHistNo
			,@RequestParam(value="inqrHistNo",required = false)Long inqrHistNo){
		so.setRows(999999999);
		List<OrderListVO> list = orderService.pageOrderOrg( so );
		if(StringUtil.equals(so.getMaskingUnlock(),CommonConstants.COMM_YN_N)){
			for(OrderListVO v : list){
				v = getMaskingOrderListVo(v);
			}
		}
		String[] headerName = null;
		String[] fieldName = null;
		if("member".equals(so.getSearchTypeExcel())) {
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.st_nm")
					, messageSourceAccessor.getMessage("column.ord_mda_cd")
					, messageSourceAccessor.getMessage("column.ord_acpt_dtm")
					, messageSourceAccessor.getMessage("column.ord_cplt_dtm")
					, messageSourceAccessor.getMessage("column.ordUserId")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ord.ordrMobile")
					, messageSourceAccessor.getMessage("column.compNm")
					, messageSourceAccessor.getMessage("column.bnd_nm")
					, messageSourceAccessor.getMessage("column.goods_nm")
					, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
					, messageSourceAccessor.getMessage("column.ord_qty")
					, messageSourceAccessor.getMessage("column.cnc_qty")
					, messageSourceAccessor.getMessage("column.rtn_cplt_qty")
					, messageSourceAccessor.getMessage("column.rtn_ing_qty")
					, messageSourceAccessor.getMessage("column.clm_exc_ing_qty")
					, messageSourceAccessor.getMessage("column.sale_unit_prc")
					, messageSourceAccessor.getMessage("column.cp_dc_unit_prc")
					, messageSourceAccessor.getMessage("column.real_dlvr_amt")
					, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
					, messageSourceAccessor.getMessage("column.ord.adrsNm")
					, messageSourceAccessor.getMessage("column.ord.mobile")
					, messageSourceAccessor.getMessage("column.ord.roadAddr")
					, messageSourceAccessor.getMessage("column.ord.roadDtlAddr")
					, messageSourceAccessor.getMessage("column.dlvr_prcs_tp_cd")
					, messageSourceAccessor.getMessage("column.order_common.mki_goods_yn")
					, messageSourceAccessor.getMessage("column.order_common.rsv_goods_yn")
					, messageSourceAccessor.getMessage("column.order_common.frb_goods_yn")
					, messageSourceAccessor.getMessage("column.goods_cstrt_cd")
					, messageSourceAccessor.getMessage("column.order_common.pak_goods_yn")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "stNm"
					, "ordMdaCd"
					, "ordAcptDtm"
					, "ordCpltDtm"
					, "ordrId"
					, "ordNm"
					, "ordrMobile"
					, "compNm"
					, "bndNmKo"
					, "goodsNm"
					, "ordDtlStatNm"
					, "ordQty"
					, "cncQty"
					, "rtnCpltQty"
					, "rtnIngQty"
					, "clmExcIngQty"
					, "saleAmt"
					, "cpDcAmt"
					, "realDlvrAmt"
					, "paySumAmt"
					, "adrsNm"
					, "mobile"
					, "roadAddr"
					, "roadDtlAddr"
					, "dlvrPrcsTpCd"
					, "mkiGoodsYn"
					, "rsvGoodsYn"
					, "frbGoodsYn"
					, "goodsCstrtTpCd"
					, "pakGoodsYn"
			};
		} else {
			headerName = new String[]{
					messageSourceAccessor.getMessage("column.ord_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_seq")
					, messageSourceAccessor.getMessage("column.st_nm")
					, messageSourceAccessor.getMessage("column.ord_mda_cd")
					, messageSourceAccessor.getMessage("column.ord_acpt_dtm")
					, messageSourceAccessor.getMessage("column.ord_cplt_dtm")
					, messageSourceAccessor.getMessage("column.ordUserId")
					, messageSourceAccessor.getMessage("column.ord_nm")
					, messageSourceAccessor.getMessage("column.ord.ordrMobile")
					, messageSourceAccessor.getMessage("column.goods_nm")
					, messageSourceAccessor.getMessage("column.goods_id")
					, messageSourceAccessor.getMessage("column.item_nm")
					, messageSourceAccessor.getMessage("column.item_no")
					, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
					, messageSourceAccessor.getMessage("column.clm_stat_cd")
					, messageSourceAccessor.getMessage("column.ord_qty")
					, messageSourceAccessor.getMessage("column.cnc_qty")
					, messageSourceAccessor.getMessage("column.rmn_ord_qty")
					, messageSourceAccessor.getMessage("column.rtn_qty")
					, messageSourceAccessor.getMessage("column.prmt_dc_unit_prc")
					, messageSourceAccessor.getMessage("column.cp_dc_unit_prc")
					, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
					, messageSourceAccessor.getMessage("column.order_common.pay_tot_amt")
					, messageSourceAccessor.getMessage("column.ord.adrsNm")
					, messageSourceAccessor.getMessage("column.ord.mobile")
					, messageSourceAccessor.getMessage("column.ord.roadAddr")
					, messageSourceAccessor.getMessage("column.ord.roadDtlAddr")
			};
			fieldName = new String[]{
					"ordNo"
					, "ordDtlSeq"
					, "stNm"
					, "ordMdaCd"
					, "ordAcptDtm"
					, "ordCpltDtm"
					, "ordrId"
					, "ordNm"
					, "ordrMobile"
					, "goodsNm"
					, "goodsId"
					, "itemNm"
					, "itemNo"
					, "ordDtlStatCd"
					, "clmIngYn"
					, "ordQty"
					, "cncQty"
					, "rmnOrdQty"
					, "rtnQty"
					, "prmtDcAmt"
					, "cpDcAmt"
					, "payAmt"
					, "paySumAmt"
					, "adrsNm"
					, "mobile"
					, "roadAddr"
					, "roadDtlAddr"
			};
		}
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("order", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "order");

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
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: snw
	* - 설명			: 주문 상세 화면
	* </pre>
	* @param model
	* @param ordNo
	* @param request
	* @return
	*/
	@RequestMapping(	value ="/*/orderDetailView.do")
	public String orderDetailView(Model model, String ordNo, String viewGb, HttpServletRequest request
			, @RequestParam(value="maskingUnlock",required=false) String maskingUnlock
			, @RequestParam(value="cnctHistNo",required = false)Long cnctHistNo) {

		if ( ordNo == null ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		StringBuilder execSqlBuilder = new StringBuilder();

		/************************
		 *  주문 정보
		 ************************/
		maskingUnlock = StringUtil.isEmpty(maskingUnlock) ? AdminConstants.COMM_YN_N : maskingUnlock;
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase( ordNo );
		if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N)){
			//마스킹 처리
			orderBase = orderService.getMaskingOrderBaseVO(orderBase);
		}

		String ordrMobile = Optional.ofNullable(orderBase.getOrdrMobile()).orElseGet(()->"")
				.replaceFirst("(^02|[0-9]{3})([0-9|*]{3,4})([0-9|*]{4})$", "$1-$2-$3");
		String ordrTel = Optional.ofNullable(orderBase.getOrdrTel()).orElseGet(()->"")
				.replaceFirst("(^02|[0-9]{3})([0-9|*]{3,4})([0-9|*]{4})$", "$1-$2-$3");
		orderBase.setOrdrMobile(ordrMobile);
		orderBase.setOrdrTel(ordrTel);

		model.addAttribute("maskingUnlock",maskingUnlock);
		model.addAttribute( "orderBase", orderBase );
		execSqlBuilder.append(orderBase.getExecSql());
		
		//주문 상세
		OrderDetailSO detailSO = new OrderDetailSO();
		detailSO.setOrdNo(ordNo);
		List<OrderDetailVO> orderDetailList = this.orderDetailService.listOrderDetailShort( detailSO );
		model.addAttribute( "orderDetailList", orderDetailList );

		/************************
		 *  배송지 정보
		 ************************/
		OrderDlvraSO odso = new OrderDlvraSO();
		odso.setOrdNo(ordNo);
		OrderDlvraVO orderDlvra =  this.orderDlvraService.getOrderDlvra(odso);
		if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N)){
			orderDlvra = orderService.getMaskingOrderDlvraVO(orderDlvra);
		}
		String ordrDlvrMobile = Optional.ofNullable(orderDlvra.getMobile()).orElseGet(()->"")
				.replaceFirst("(^02|[0-9]{3})([0-9|*]{3,4})([0-9|*]{4})$", "$1-$2-$3");
		String ordrDlvrTel = Optional.ofNullable(orderDlvra.getTel()).orElseGet(()->"")
				.replaceFirst("(^02|[0-9]{3})([0-9|*]{3,4})([0-9|*]{4})$", "$1-$2-$3");
		orderDlvra.setMobile(ordrDlvrMobile);
		orderDlvra.setTel(ordrDlvrTel);
		
		String localPostYn = localPostService.getLocalPostYn(orderDlvra.getPostNoNew(), orderDlvra.getPostNoOld());
		//마스킹
		//orderDlvra = orderService.getMaskingOrderDlvraVO(orderDlvra);
		model.addAttribute("localPostYn", localPostYn);
		model.addAttribute( "orderDlvra", orderDlvra);
		execSqlBuilder.append("\n\n"+odso.getExecSql());

		/************************
		 *  주문 메모
		 ***********************/
		OrderMemoSO omso = new OrderMemoSO();
		omso.setOrdNo(ordNo);
		List<OrderMemoVO> orderMemoList = this.orderMemoService.listOrderMemo(omso);
		model.addAttribute("orderMemoList", orderMemoList);

		// URI
		model.addAttribute( "getHeader", request.getHeader("REFERER") );

		// LayOut 설정
		String layOut = AdminConstants.LAYOUT_MAIN;

		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
		}
		model.addAttribute("layout", layOut);
		model.addAttribute("viewGb",viewGb);

		/****************************
		 * 세션 정보
		 ****************************/
		Session session = AdminSessionUtil.getSession();
		model.addAttribute("session", session);
		model.addAttribute("ordNo",ordNo);
		model.addAttribute("cnctHistNo",Optional.ofNullable(cnctHistNo).orElseGet(()->0L));
		model.addAttribute("execSql", StringEscapeUtils.escapeEcmaScript(execSqlBuilder.toString()));
		return "/order/orderDetailView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문 기본 수정
	* </pre>
	* @param orderBasePO
	* @param br
	* @return
	*/
	@RequestMapping("/order/orderInfoUpdate.do")
	public String orderInfoUpdate(OrderBasePO orderBasePO, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		this.orderBaseService.updateOrderBase( orderBasePO );

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문 배송지 수정
	* </pre>
	* @param deliveryPO
	* @param br
	* @return
	*/
	@RequestMapping("/order/orderDeliveryAddressUpdate.do")
	public String orderDeliveryAddressUpdate(OrderDlvraPO po, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 도로명상세 주소를 지번 상세 주소에 설정
		// 지번상세주소는 별도 입력 받지 않음
		po.setPrclDtlAddr(po.getRoadDtlAddr());
		
		String exCode = this.orderDlvraService.updateDeliveryAddress(po);
		
		if(!"SUCCESS".equals(exCode)) {
			throw new CustomException(exCode);
		}

		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 결제 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/payBaseListGrid.do", method=RequestMethod.POST )
	public GridResponse payBaseListGrid(PayBaseSO so,String maskingUnlock) {

		//so.setOrdClmGbCd(AdminConstants.ORD_CLM_GB_10); //20.01.23 결제목록 전체 조회를 위해 주석처리
		so.setCncYn(CommonConstants.COMM_YN_N); // 주문 결제 목록에서 PAY_BASE의 취소 된 건은 보여주지 않는다.
		so.setOrder("payNo");
		List<PayBaseVO> list = this.payBaseService.listPayBase(so);

		for(PayBaseVO vo : list){
			if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N)){
				vo.setAcctNo(MaskingUtil.getBankNo(vo.getAcctNo()));
			}
			if(CommonConstants.PAY_GB_30.equals(vo.getPayGbCd()) || CommonConstants.PAY_GB_40.equals(vo.getPayGbCd())) {	// 마이너스 환불 구분
				vo.setPayAmt02(vo.getPayAmt());
			}else {
				vo.setPayAmt01(vo.getPayAmt());
			}
		}
		return new GridResponse( list, so );

	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 3.
	* - 작성자		: snw
	* - 설명			: 주문상세 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/orderDetailListGrid.do", method=RequestMethod.POST )
	public GridResponse orderDetailListGrid(OrderDetailSO so) {

		Session session = AdminSessionUtil.getSession();

		if(CommonConstants.USR_GRP_20.equals(session.getUsrGrpCd())){
			
			if(CommonConstants.USR_GB_2010.equals(session.getUsrGbCd())){
				so.setUpCompNo(session.getCompNo());
			}else{
				so.setCompNo(session.getCompNo());
			}
		}

		List<OrderDetailVO> list = this.orderDetailService.listOrderDetail(so);
		return new GridResponse( list, so );

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 결제 완료 처리
	* </pre>
	* @param orderSO
	* @param payBasePO
	* @param br
	* @return
	*/
	@Deprecated
	@RequestMapping("/order/orderPayComplete.do")
	public String orderPayComplete(Long payNo) {

		this.payBaseService.updatePayBaseComplete(payNo);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: OrderController.java
	 * - 작성일		: 2016. 12. 23.
	 * - 작성자		: yhj
	 * - 설명		: 구매완료
	 * </pre>
	 * @param orderMemoPO
	 * @param br
	 * @return
	 */
	@RequestMapping("/order/orderPurchase.do")
	public String orderPurchase(String ordNo, Integer[] arrOrdDtlSeq) {

		this.orderDetailService.updateOrderDetailPurchase(ordNo, arrOrdDtlSeq);

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: Administrator
	* - 설명			: 배송비 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/deliveryChargeListGrid.do", method=RequestMethod.POST )
	public GridResponse deliveryChargeListGrid(DeliveryChargeSO so) {

		Session session = AdminSessionUtil.getSession();
		
		if(CommonConstants.USR_GRP_20.equals(session.getUsrGrpCd())){
			
			if(CommonConstants.USR_GB_2010.equals(session.getUsrGbCd())){
				so.setUpCompNo(session.getCompNo());
			}else{
				so.setCompNo(session.getCompNo());
			}
		}
		
		so.setSearchType("ALL"); // 20.01.23 배송비 목록 전체 조회를 위해 추가 
		List<DeliveryChargeVO> deliveryChargeList = this.deliveryChargeService.listDeliveryCharge(so);

		return new GridResponse( deliveryChargeList, so );

	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/orderClaimListGrid.do", method=RequestMethod.POST )
	public GridResponse orderClaimListGrid(ClaimDetailSO so){

		Session session = AdminSessionUtil.getSession();
		
		if(CommonConstants.USR_GRP_20.equals(session.getUsrGrpCd())){
			
			if(CommonConstants.USR_GB_2010.equals(session.getUsrGbCd())){
				so.setUpCompNo(session.getCompNo());
			}else{
				so.setCompNo(session.getCompNo());
			}
		}
		
		List<ClaimDetailVO> list = this.claimDetailService.listClaimDetail(so);

		return new GridResponse( list, so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 주문 CS 목록 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/orderCsListGrid.do", method=RequestMethod.POST )
	public GridResponse orderCsListGrid(CounselSO so) {
		List<CounselVO> list = this.counselService.listCounsel(so);
		return new GridResponse( list, so );

	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문 메모 등록
	* </pre>
	* @param orderMemoPO
	* @param br
	* @return
	*/
	@RequestMapping("/order/orderMemoInsert.do")
	public String orderMemoInsert(OrderMemoPO orderMemoPO, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		this.orderMemoService.insertOrderMemo( orderMemoPO );

		return View.jsonView();
	}

















	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 5. 8.
	* - 작성자		: Administrator
	* - 설명			: 단품 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/order/itemListGrid.do", method=RequestMethod.POST )
	public GridResponse itemListGrid(ItemSO so) {

		so.setItemStatCd(CommonConstants.ITEM_STAT_10);
		List<ItemVO> list = itemService.listItem(so);

		return new GridResponse( list, so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: OrderController.java
	* - 작성일		: 2017. 5. 8.
	* - 작성자		: Administrator
	* - 설명			: 주문상품 단품 변경
	* </pre>
	* @param ordNo
	* @param ordDtlSeq
	* @param itemNo
	* @return
	*/
	@RequestMapping("/order/orderGoodsItemChange.do")
	public String orderGoodsItemChange(String ordNo, Integer ordDtlSeq, Long itemNo) {

		this.orderDetailService.updateOrderDetailItem(ordNo, ordDtlSeq, itemNo);

		return View.jsonView();
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.order.controller
	* - 파일명      : OrderController.java
	* - 작성일      : 2017. 7. 3.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  카드 사용 목록 
	* </pre>
	 */
	@RequestMapping("/order/cardListView.do")
	public String cardListView(ModelMap map) {

		/****************************
		 * 세션 정보
		 ****************************/
		Session session = AdminSessionUtil.getSession();

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

		String srchEndDtm = DateUtil.getNowDate();

		String srchStartDtm = DateUtil.addDay("yyyyMMdd", -7);

		map.put("srchStartDtm", srchStartDtm);
		map.put("srchEndDtm", srchEndDtm);
		map.put("session", session);
		map.put("siteList", stList);

		return "/order/cardListView";

	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.order.controller
	* - 파일명      : OrderController.java
	* - 작성일      : 2017. 7. 3.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 카드 영수증 목록 
	* </pre>
	 */
	@RequestMapping(	value ="/order/cardListPopView.do")
	public String cardListPopView(Model model, String ordNo ) {
		model.addAttribute("ordNo", ordNo);
		return "/order/cardListPopView";
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.order.controller
	* - 파일명      : OrderController.java
	* - 작성일      : 2017. 7. 3.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 카드영수증 그리드 
	* </pre>
	 */
	@ResponseBody
	@RequestMapping( value="/order/payBaseCardListGrid.do", method=RequestMethod.POST )
	public GridResponse payBaseCardListGrid(PayBaseSO so) {
		so.setCncYn(AdminConstants.COMM_YN_N); 
		so.setCardReceiptSortYn(true);
		 
		
		List<PayBaseVO> list = this.payBaseService.listPayBase(so);
		return new GridResponse( list, so );
	}
	
	
	@RequestMapping("/order/orderDetailCstrtPopView.do")
	public String orderDetailCstrtPopView(ModelMap map, OrderDetailSO so) {
		OrderDetailVO orderDetail = orderDetailService.getOrderDetail(so.getOrdNo(), so.getOrdDtlSeq());
		map.put("orderDetail", orderDetail);
		return "/order/orderDetailCstrtPopView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.order.controller
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 상세 구성 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/order/orderDetailCstrtListGrid.do", method=RequestMethod.POST )
	public GridResponse orderDetailCstrtListGrid(OrderDetailSO so) {

		List<OrdDtlCstrtVO> list = this.orderDetailService.listOrdDtlCstrt(so);
		return new GridResponse( list, so );
	}
	
}