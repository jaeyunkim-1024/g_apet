package admin.web.view.tax.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderSO;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.model.CashReceiptVO;
import biz.app.receipt.model.TaxInvoicePO;
import biz.app.receipt.service.CashReceiptService;
import biz.app.receipt.service.TaxInvoiceService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.service.CodeService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.tax.controller
 * - 파일명		: TaxController.java
 * - 작성일		: 2016. 4. 14.
 * - 작성자		: dyyoun
 * - 설명		: 계산서(현금영수증/세금계산서)) 컨트롤러
 * </pre>
 */
//@Slf4j
@Controller
public class TaxController {

	@Autowired
	private CashReceiptService cashReceiptService;

	@Autowired
	private TaxInvoiceService taxInvoiceService;


	@Autowired
	private CodeService codeService;
	
	@Autowired private StService stService;
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 리스트 뷰
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/cashListView.do")
	public String cashListView(ModelMap map,
		OrderSO orderSO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		/****************************
		 * 세션 정보
		 ****************************/
		Session session = AdminSessionUtil.getSession();

		/***********************
		 * 사이트 정보 조회
		 *************************/
		StStdInfoSO ssiso = new StStdInfoSO();
		
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

		// 화면 구분
		orderSO.setViewGb( "CASH" );

		return "/tax/cashListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 리스트 그리드
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/tax/cashListGrid.do", method=RequestMethod.POST )
	public GridResponse cashListGrid(
		OrderSO orderSO
	) {
		List<CashReceiptVO> list = cashReceiptService.pageCashReceipList( orderSO );

		return new GridResponse( list, orderSO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 상세 보기 팝업
	 * </pre>
	 * @param model
	 * @param cashReceiptSO
	 * @return
	 */
	@RequestMapping("/tax/cashReceiptDetailPopView.do")
	public String cashReceiptDetailPopView(
		Model model
		, CashReceiptSO cashReceiptSO
	) {
		model.addAttribute( "cashReceipt", cashReceiptService.getCashReceipt( cashReceiptSO ) );
		
		 
		
		return "/tax/cashReceiptDetailPopView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 접수 팝업
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @return
	 */
	@RequestMapping("/tax/cashReceiptAcceptPopView.do")
	public String cashReceiptAcceptPopView(
		Model model
		, OrderSO orderSO
	) {

		model.addAttribute( "orderSO", orderSO );

		return "/tax/cashReceiptAcceptPopView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param claimDetailPO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/cashReceiptAcceptExec.do")
	public String cashReceiptAcceptExec(
		OrderSO orderSO
		, CashReceiptPO cashReceiptPO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		cashReceiptService.cashReceiptAcceptExec( orderSO, cashReceiptPO );

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 발행
	 * </pre>
	 * @param orderSO
	 * @param cashReceiptPO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/cashReceiptPublishExec.do")
	public String cashReceiptPublishExec(
		OrderSO orderSO
		, CashReceiptPO cashReceiptPO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		cashReceiptService.cashReceiptPublishExec( orderSO, cashReceiptPO );

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 재발행
	 * </pre>
	 * @param cashReceiptSO
	 * @param cashReceiptPO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/cashReceiptRePublishExec.do")
	public String cashReceiptRePublishExec(
		CashReceiptSO cashReceiptSO
		, CashReceiptPO cashReceiptPO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		cashReceiptService.cashReceiptRePublishExec( cashReceiptSO, cashReceiptPO );

		return View.jsonView();
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 리스트 뷰
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/taxListView.do")
	public String taxListView(
		OrderSO orderSO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 화면 구분
		orderSO.setViewGb( "TAX" );

		return "/tax/taxListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 리스트 그리드
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/tax/taxListGrid.do", method=RequestMethod.POST )
	public GridResponse taxListGrid(
		OrderSO orderSO
	) {

		// 화면 구분
		orderSO.setViewGb( "TAX" );

		List<OrderListVO> list = taxInvoiceService.pageTaxList( orderSO );

		return new GridResponse( list, orderSO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 접수 팝업
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @return
	 */
	@RequestMapping("/tax/taxInvoiceAcceptPopView.do")
	public String taxInvoiceAcceptPopView(
		Model model
		, OrderSO orderSO
	) {

		model.addAttribute( "orderSO", orderSO );

		return "/tax/taxInvoiceAcceptPopView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param taxInvoicePO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/taxInvoiceAcceptExec.do")
	public String taxInvoiceAcceptExec(
		OrderSO orderSO
		, TaxInvoicePO taxInvoicePO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		taxInvoiceService.taxInvoiceAcceptExec( orderSO, taxInvoicePO );

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 상세 팝업
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @return
	 */
	@RequestMapping("/tax/taxInvoiceDetailPopView.do")
	public String taxInvoiceDetailPopView(
		Model model
		, OrderSO orderSO
	) {

		model.addAttribute( "orderSO", orderSO );
		model.addAttribute( "taxInvoice", taxInvoiceService.getTaxInvoiceSum( orderSO ) );

		return "/tax/taxInvoiceDetailPopView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 발행 실행
	 * </pre>
	 * @param orderSO
	 * @param taxInvoicePO
	 * @param br
	 * @return
	 */
	@RequestMapping("/tax/taxInvoicePublishExec.do")
	public String taxInvoicePublishExec(
		OrderSO orderSO
		, TaxInvoicePO taxInvoicePO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		taxInvoiceService.taxInvoicePublishExec( orderSO, taxInvoicePO );

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금 영수증 목록(엑셀 다운로드)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/tax/cashListExcelDownload.do")
	public String cashListExcelDownload(ModelMap model, OrderSO so){
		// 화면 구분
		so.setViewGb( "CASH" );
		so.setRows(999999999);
		List<OrderListVO> list = taxInvoiceService.pageTaxList( so );

		String[] headerName = {
				// 주문번호
				messageSourceAccessor.getMessage("column.ord_no")
				// 주문접수일자
				, messageSourceAccessor.getMessage("column.ord_acpt_dtm")
				// 주문자명
//				, messageSourceAccessor.getMessage("column.ord_nm")
				// 주문자 휴대폰
//				, messageSourceAccessor.getMessage("column.ordr_mobile")
				// 회원번호
//				, messageSourceAccessor.getMessage("column.mbr_no")
				// 회원명
				, messageSourceAccessor.getMessage("column.mbr_nm")
				// 업체번호
//				, messageSourceAccessor.getMessage("column.comp_no")
				// 업체명
				, messageSourceAccessor.getMessage("column.comp_nm")
				// 페이지구분
//				, messageSourceAccessor.getMessage("column.page_gb_cd")
				// 상품명
				, messageSourceAccessor.getMessage("column.goods_nm")
				// 상품번호
//				, messageSourceAccessor.getMessage("column.goods_id")
				// 단품명
				, messageSourceAccessor.getMessage("column.item_nm")
				// 단품번호
//				, messageSourceAccessor.getMessage("column.item_no")
				// 상품금액
				, messageSourceAccessor.getMessage("column.sale_amt")
				// 수량
				, messageSourceAccessor.getMessage("column.ord_qty")
				// 상품쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
//				// 배송비쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.dlvrc_cp_dc_amt")
//				// 조립비쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.asbc_cp_dc_amt")
//				// 생일쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.birth_cp_dc_amt")
//				// 적립금할인금액
//				, messageSourceAccessor.getMessage("column.svmn_dc_amt")
//				// 건별결제금액
//				, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
//				// 전체결제금액
//				, messageSourceAccessor.getMessage("column.order_common.pay_tot_amt")
				// 주문내역상태코드
				, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
				// 주문매체
//				, messageSourceAccessor.getMessage("column.ord_mda_cd")
//				// 결제수단
//				, messageSourceAccessor.getMessage("column.pay_means_cd")
//				// 현금 영수증 번호
//				, messageSourceAccessor.getMessage("column.cash_rct_no")
//				// 원 현금 영수증 번호
//				, messageSourceAccessor.getMessage("column.org_cash_rct_no")
//				// 주문 상세 순번
//				, messageSourceAccessor.getMessage("column.ord_dtl_seq")
//				// 클레임 번호
//				, messageSourceAccessor.getMessage("column.clm_no")
				// 발행 유형 코드
				, messageSourceAccessor.getMessage("column.cr_tp_cd")
				// 현금 영수증 상태 코드
				, messageSourceAccessor.getMessage("column.cash_rct_stat_cd")
				// 사용 구분 코드
				, messageSourceAccessor.getMessage("column.use_gb_cd")
				// 발급 수단 코드
				, messageSourceAccessor.getMessage("column.isu_means_cd")
				// 발급 수단 번호
				, messageSourceAccessor.getMessage("column.isu_means_no")
				// 공급 금액
				, messageSourceAccessor.getMessage("column.spl_amt")
				// 부가세 금액
				, messageSourceAccessor.getMessage("column.stax_amt")
				// 봉사료 금액
//				, messageSourceAccessor.getMessage("column.srvc_amt")
				// 연동 일시
				, messageSourceAccessor.getMessage("column.lnk_dtm")
				// 연동 거래 번호
				, messageSourceAccessor.getMessage("column.lnk_deal_no")
				// 연동 결과 메세지
				, messageSourceAccessor.getMessage("column.lnk_rst_msg")
		};
		String[] fieldName = {
				  "ordNo"
				, "ordAcptDtm"
//				, "ordNm"
//				, "ordrMobile"
//				, "mbrNo"
				, "mbrNm"
//				, "compNo"
				, "compNm"
//				, "pageGbCd"
				, "goodsNm"
//				, "goodsId"
				, "itemNm"
//				, "itemNo"
				, "saleAmt"
				, "ordQty"
//				, "goodsCpDcAmt"
//				, "dlvrcCpDcAmt"
//				, "asbcCpDcAmt"
//				, "birthCpDcAmt"
//				, "svmnDcAmt"
//				, "payDtlAmt"
//				, "payTotAmt"
				, "ordDtlStatCd"
//				, "ordMdaCd"
//				, "payMeansCd"
//				, "cashRctNo"
//				, "orgCashRctNo"
//				, "ordDtlSeq"
//				, "clmNo"
				, "crTpCd"
				, "cashRctStatCd"
				, "useGbCd"
				, "isuMeansCd"
				, "isuMeansNo"
				, "splAmt"
				, "staxAmt"
//				, "srvcAmt"
				, "lnkDtm"
				, "lnkDealNo"
				, "lnkRstMsg"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("cash", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "cash");

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금 계산서 목록(엑셀 다운로드)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/tax/taxListExcelDownload.do")
	public String taxListExcelDownload(ModelMap model, OrderSO so){
		// 화면 구분
		so.setViewGb( "TAX" );
		so.setRows(999999999);
		List<OrderListVO> list = taxInvoiceService.pageTaxList( so );

		String[] headerName = {
				// 주문번호
				messageSourceAccessor.getMessage("column.ord_no")
				// 주문상세일련번호
				, messageSourceAccessor.getMessage("column.ord_dtl_seq")
				// 주문접수일자
				, messageSourceAccessor.getMessage("column.ord_acpt_dtm")
				// 주문자명
//				, messageSourceAccessor.getMessage("column.ord_nm")
				// 주문자 휴대폰
//				, messageSourceAccessor.getMessage("column.ordr_mobile")
				// 회원번호
//				, messageSourceAccessor.getMessage("column.mbr_no")
				// 회원명
				, messageSourceAccessor.getMessage("column.mbr_nm")
				// 페이지구분
//				, messageSourceAccessor.getMessage("column.page_gb_cd")
				// 상품명
				, messageSourceAccessor.getMessage("column.goods_nm")
				// 상품번호
//				, messageSourceAccessor.getMessage("column.goods_id")
				// 단품명
				, messageSourceAccessor.getMessage("column.item_nm")
				// 단품번호
//				, messageSourceAccessor.getMessage("column.item_no")
				// 상품금액
				, messageSourceAccessor.getMessage("column.sale_amt")
				// 수량
				, messageSourceAccessor.getMessage("column.ord_qty")
				// 상품쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.goods_cp_dc_amt")
				// 배송비쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.dlvrc_cp_dc_amt")
				// 조립비쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.asbc_cp_dc_amt")
				// 생일쿠폰할인금액
//				, messageSourceAccessor.getMessage("column.birth_cp_dc_amt")
				// 적립금할인금액
//				, messageSourceAccessor.getMessage("column.svmn_dc_amt")
				// 건별결제금액
//				, messageSourceAccessor.getMessage("column.order_common.pay_dtl_amt")
				// 전체결제금액
//				, messageSourceAccessor.getMessage("column.order_common.pay_tot_amt")
				// 주문내역상태코드
				, messageSourceAccessor.getMessage("column.ord_dtl_stat_cd")
				// 주문매체
//				, messageSourceAccessor.getMessage("column.ord_mda_cd")
				// 결제수단
//				, messageSourceAccessor.getMessage("column.pay_means_cd")
				// 세금 계산서 번호
//				, messageSourceAccessor.getMessage("column.tax_ivc_no")
				// 원 세금 계산서 번호
//				, messageSourceAccessor.getMessage("column.org_tax_ivc_no")
				// 주문 클레임 구분 코드
//				, messageSourceAccessor.getMessage("column.ord_clm_gb_cd")
				// 주문 번호
//				, messageSourceAccessor.getMessage("column.ord_no")
				// 주문 상세 순번
//				, messageSourceAccessor.getMessage("column.ord_dtl_seq")
				// 클레임 번호
//				, messageSourceAccessor.getMessage("column.clm_no")
				// 클레임 상세 순번
//				, messageSourceAccessor.getMessage("column.clm_dtl_seq")
				// 세금 계산서 상태 코드
				, messageSourceAccessor.getMessage("column.tax_ivc_stat_cd")
				// 신청자 구분 코드
				, messageSourceAccessor.getMessage("column.apct_gb_cd")
				// 회원 번호
//				, messageSourceAccessor.getMessage("column.mbr_no")
				// 사용 구분 코드
//				, messageSourceAccessor.getMessage("column.use_gb_cd")
				// 발급 수단 코드
//				, messageSourceAccessor.getMessage("column.isu_means_cd")
				// 업체번호
//				, messageSourceAccessor.getMessage("column.comp_no")
				// 업체 명
				, messageSourceAccessor.getMessage("column.comp_nm")
				// 대표자 명
				, messageSourceAccessor.getMessage("column.ceo_nm")
				// 업태
				, messageSourceAccessor.getMessage("column.biz_cdts")
				// 종목
				, messageSourceAccessor.getMessage("column.biz_tp")
				// 사업자 번호
				, messageSourceAccessor.getMessage("column.biz_no")
				// 우편 번호 구
//				, messageSourceAccessor.getMessage("column.post_no_old")
				// 우편 번호 신
				, messageSourceAccessor.getMessage("column.post_no_new")
				// 도로 주소
				, messageSourceAccessor.getMessage("column.road_addr")
				// 도로 상세 주소
				, messageSourceAccessor.getMessage("column.road_dtl_addr")
				// 지번 주소
//				, messageSourceAccessor.getMessage("column.prcl_addr")
				// 지번 상세 주소
//				, messageSourceAccessor.getMessage("column.prcl_dtl_addr")
				// 공급 금액
				, messageSourceAccessor.getMessage("column.spl_amt")
				// 부가세 금액
				, messageSourceAccessor.getMessage("column.stax_amt")
				// 총 금액
				, messageSourceAccessor.getMessage("column.tot_amt")
				// 접수 일시
				, messageSourceAccessor.getMessage("column.acpt_dtm")
				// 처리자 번호
				, messageSourceAccessor.getMessage("column.prcsr_no")
				// 연동 일시
				, messageSourceAccessor.getMessage("column.lnk_dtm")
				// 연동 거래 번호
				, messageSourceAccessor.getMessage("column.lnk_deal_no")
				// 연동 결과 코드
				, messageSourceAccessor.getMessage("column.lnk_rst_cd")
				// 연동 결과 메세지
				, messageSourceAccessor.getMessage("column.lnk_rst_msg")
				// 메모
				, messageSourceAccessor.getMessage("column.memo")
				// 시스템 등록자 번호
//				, messageSourceAccessor.getMessage("column.sys_regr_no")
				// 시스템 등록 일시
//				, messageSourceAccessor.getMessage("column.sys_reg_dtm")
				// 시스템 수정자 번호
//				, messageSourceAccessor.getMessage("column.sys_updr_no")
				// 시스템 수정 일시
//				, messageSourceAccessor.getMessage("column.sys_upd_dtm")
//				, messageSourceAccessor.getMessage("column.sys_regr_nm")
//				, messageSourceAccessor.getMessage("column.sys_updr_nm")
		};
		String[] fieldName = {
				  "ordNo"
				, "ordDtlSeq"
				, "ordAcptDtm"
//				, "ordNm"
//				, "ordrMobile"
//				, "mbrNo"
				, "mbrNm"
//				, "pageGbCd"
				, "goodsNm"
//				, "goodsId"
				, "itemNm"
//				, "itemNo"
				, "saleAmt"
				, "ordQty"
//				, "goodsCpDcAmt"
//				, "dlvrcCpDcAmt"
//				, "asbcCpDcAmt"
//				, "birthCpDcAmt"
//				, "svmnDcAmt"
//				, "orderCommon.payDtlAmt"
//				, "orderCommon.payTotAmt"
				, "ordDtlStatCd"
//				, "ordMdaCd"
//				, "payMeansCd"
//				, "taxIvcNo"
//				, "orgTaxIvcNo"
//				, "ordClmGbCd"
//				, "ordNo"
//				, "ordDtlSeq"
//				, "clmNo"
//				, "clmDtlSeq"
				, "taxIvcStatCd"
				, "apctGbCd"
//				, "mbrNo"
//				, "useGbCd"
//				, "isuMeansCd"
//				, "compNo"
				, "compNm"
				, "ceoNm"
				, "bizCdts"
				, "bizTp"
				, "bizNo"
//				, "postNoOld"
				, "postNoNew"
				, "roadAddr"
				, "roadDtlAddr"
//				, "prclAddr"
//				, "prclDtlAddr"
				, "splAmt"
				, "staxAmt"
				, "totAmt"
				, "acptDtm"
				, "prcsrNo"
				, "lnkDtm"
				, "lnkDealNo"
				, "lnkRstCd"
				, "lnkRstMsg"
				, "memo"
//				, "sysRegrNo"
//				, "sysRegDtm"
//				, "sysUpdrNo"
//				, "sysUpdDtm"
//				, "sysRegrNm"
//				, "sysUpdrNm"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("tax", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "tax");

		return View.excelDownload();
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

}
