package admin.web.view.delivery.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import admin.web.view.delivery.controller.model.DeliveryUploadResult;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.service.ClaimDetailService;
import biz.app.delivery.model.DeliveryHistSO;
import biz.app.delivery.model.DeliveryHistVO;
import biz.app.delivery.model.DeliveryListVO;
import biz.app.delivery.model.DeliveryVO;
import biz.app.delivery.service.DeliveryService;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderService;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.service.PrivacyCnctService;
import biz.common.service.CacheService;
import biz.interfaces.goodsflow.model.request.data.InvoiceVO;
import biz.interfaces.goodsflow.service.GoodsFlowService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;
import framework.common.util.ExcelUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DeliveryController {

	@Autowired
	private DeliveryService deliveryService;

	@Autowired
	private CacheService cacheService;

	@Autowired private OrderService orderService;
	
	@Autowired private OrderDetailService orderDetailService;

	@Autowired private ClaimDetailService claimDetailService;

	@Autowired private GoodsFlowService goodsFlowService;

	@Autowired
	private PrivacyCnctService privacyCnctService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: dyyoun
	 * - 설명		: 배송 리스트 뷰
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/delivery/deliveryListView.do")
	public String deliveryListView(
		OrderSO orderSO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		orderSO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);

		return "/delivery/deliveryListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: dyyoun
	 * - 설명		: 배송 리스트 뷰
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/delivery/claimDeliveryListView.do")
	public String claimDeliveryListView(
		OrderSO orderSO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		orderSO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);

		return "/delivery/deliveryListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: TaxController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 배송 리스트 그리드
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/delivery/deliveryListGrid.do", method=RequestMethod.POST )
	public GridResponse deliveryListGrid(OrderSO orderSO, String searchOrdClmGbCd) {

		orderSO.setOrdClmGbCd(searchOrdClmGbCd);
		// 화면 구분
		orderSO.setViewGb("DELIVERY");

		// 주문 상태 코드
//		String[] arrOrdDtlStatCd = new String[] { AdminConstants.ORD_DTL_STAT_110
//				// , AdminConstants.ORD_DTL_STAT_140
//				// , AdminConstants.ORD_DTL_STAT_150
//				// , AdminConstants.ORD_DTL_STAT_160
//		};
		// orderSO.setArrOrdDtlStatCd( arrOrdDtlStatCd );
		orderSO.setArrOrdDtlStatCd(orderSO.getArrOrdDtlStatCd());

		List<DeliveryListVO> list = deliveryService.pageDeliveryList(orderSO);
		if(StringUtil.equals(orderSO.getMaskingUnlock(),CommonConstants.COMM_YN_N)){
			for(DeliveryListVO vo : list){
				vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(),vo.getRoadDtlAddr()));
				vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));
				vo.setTel(MaskingUtil.getTelNo(vo.getTel()));
				vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
				vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
				vo.setOrdrId(MaskingUtil.getId(vo.getOrdrId()));
				vo.setOrdNm(MaskingUtil.getName(vo.getOrdNm()));
			}
		}

		return new GridResponse(list, orderSO);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: dyyoun
	 * - 설명		: 상품준비중 처리
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/delivery/deliveryReadyExec.do")
	public String deliveryReadyExec(String[] arrOrdNo, Integer[] arrOrdDtlSeq,String[] arrOrdCrmDivision) {
		if(arrOrdNo != null && arrOrdNo.length > 0){

			for (int i = 0; i < arrOrdNo.length; i++) {

				if ("ord".equals(arrOrdCrmDivision[i]) ){
					OrderDetailVO orderDetail = this.orderDetailService.getOrderDetail(arrOrdNo[i], arrOrdDtlSeq[i]);
					if(orderDetail != null && CommonConstants.ORD_DTL_STAT_130.equals(orderDetail.getOrdDtlStatCd()) && orderDetail.getRmnOrdQty() > 0 ){
						this.orderDetailService.updateOrderDetailStatus( arrOrdNo[i], arrOrdDtlSeq[i], AdminConstants.ORD_DTL_STAT_140 );
						
						orderService.deleteOrdDtlCstrtDlvrMap(arrOrdNo[i], Long.valueOf(arrOrdDtlSeq[i]));
					}
				}else if ("clm".equals(arrOrdCrmDivision[i]) ){
					ClaimDetailSO  so = new ClaimDetailSO();
					so.setClmNo(arrOrdNo[i]);
					so.setClmDtlSeq(arrOrdDtlSeq[i]);
					ClaimDetailVO claimDetail  = this.claimDetailService.getClaimDetail(so)	;
					if(claimDetail != null && CommonConstants.CLM_DTL_STAT_420.equals(claimDetail.getClmDtlStatCd() ) && !CommonConstants.CLM_STAT_40.equals(claimDetail.getClmStatCd())){
						this.claimDetailService.updateClaimDetailStatus( arrOrdNo[i], arrOrdDtlSeq[i], AdminConstants.CLM_DTL_STAT_430 );
						
						orderService.deleteOrdDtlCstrtDlvrMap(arrOrdNo[i], Long.valueOf(arrOrdDtlSeq[i]));
					}
				}
			}
		}
		return View.jsonView();
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.delivery.controller
	* - 파일명      : DeliveryController.java
	* - 작성일      : 2017. 3. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  배송분리
	* </pre>
	 */
	@RequestMapping("/delivery/deliveryDivision.do")
	public String deliveryDivision(String[] arrOrdNo, Integer[] arrOrdDtlSeq) {
			deliveryService.deliveryDivision( arrOrdNo,  arrOrdDtlSeq );
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: dyyoun
	 * - 설명		: 송장 건별 등록 팝업
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @return
	 */
	@RequestMapping("/delivery/deliveryInvoiceOneCreatePopView.do")
	public String deliveryInvoiceOneCreatePopView(Model model, Long dlvrNo	) {

		DeliveryVO delivery = this.deliveryService.getDelivery(dlvrNo);


		if(delivery != null){

			if(CommonConstants.ORD_CLM_GB_10.equals(delivery.getOrdClmGbCd())){
				OrderDetailSO odso = new OrderDetailSO();
				odso.setDlvrNo(dlvrNo);
				odso.setRmnOrdQty0Over(true);
				List<OrderDetailVO> orderDetailList = this.orderDetailService.listOrderDetail(odso);

				/*
				 * 주문 상세단위 상태가 '상품준비중' 인지 체크
				 */
				if(CollectionUtils.isNotEmpty(orderDetailList)){
					for(OrderDetailVO odvo : orderDetailList){
						if(!CommonConstants.ORD_DTL_STAT_140.equals(odvo.getOrdDtlStatCd())){
							throw new CustomException(ExceptionConstants.ERROR_DELIVERY_POSSIBLE_INVOICE_READY);
						}
					}
					// 배송비정책의 기본택배사 코드를 설정함.(송장건별 등록 단위의 배송비번호는 모두 똑같음. 따라서 배송비정책의 기본택배사 코드도 동일함)
					delivery.setDftHdcCd(orderDetailList.get(0).getDftHdcCd());
				}else{
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}else{
				ClaimDetailSO cdso = new ClaimDetailSO();
				cdso.setDlvrNo(dlvrNo);
				cdso.setClmStatNot40(true);
				List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);

				/*
				 * 클레임 상세단위 상태가 '상품준비중' 인지 체크
				 */
				if(CollectionUtils.isNotEmpty(claimDetailList)){
					for(ClaimDetailVO cdvo : claimDetailList){
						if(CommonConstants.CLM_DTL_TP_20.equals(cdvo.getClmDtlStatCd()) && !CommonConstants.CLM_DTL_STAT_220.equals(cdvo.getClmDtlStatCd())){
							throw new CustomException(ExceptionConstants.ERROR_DELIVERY_POSSIBLE_INVOICE_COMMAND);
						}else if(CommonConstants.CLM_DTL_TP_30.equals(cdvo.getClmDtlStatCd()) && !CommonConstants.CLM_DTL_STAT_320.equals(cdvo.getClmDtlStatCd())){
							throw new CustomException(ExceptionConstants.ERROR_DELIVERY_POSSIBLE_INVOICE_COMMAND);
						}else if(CommonConstants.CLM_DTL_TP_40.equals(cdvo.getClmDtlStatCd()) && !CommonConstants.CLM_DTL_STAT_430.equals(cdvo.getClmDtlStatCd())){
							throw new CustomException(ExceptionConstants.ERROR_DELIVERY_POSSIBLE_INVOICE_READY);
						}
					}

				}else{
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

			}

		}else{
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		model.addAttribute( "delivery", delivery);

		return "/delivery/deliveryInvoiceOneCreatePopView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: dyyoun
	 * - 설명		:     주문클레임 송장 단일 등록
	 * </pre>
	 * @param orderSO
	 * @param deliveryPO
	 * @param br
	 * @return
	 */
	@RequestMapping("/delivery/deliveryInvoiceOneCreateExec.do")
	public String deliveryInvoiceOneCreateExec(Long dlvrNo,String hdcCd, String invNo ) {

		try {
			deliveryService.processDeliveryInvNo(dlvrNo, hdcCd, invNo);
		} catch(Exception e) {
			log.error("DeliveryController.deliveryInvoiceOneCreateExec::deliveryService.process : {}", e);
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVNO_PROCESS_ERROR);
		}

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 26.
	 * - 작성자		: dyyoun
	 * - 설명		: 송장 일괄 등록 팝업
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @return
	 */
	@RequestMapping("/delivery/deliveryInvoiceBatchCreatePopView.do")
	public String deliveryInvoiceBatchCreatePopView( Model model,OrderSO orderSO ) {

//		model.addAttribute( "delivery", orderCommonService.getDelivery(orderSO) );
		model.addAttribute( "orderSO", orderSO);
		return "/delivery/deliveryInvoiceBatchCreatePopView";

	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.delivery.controller
	* - 파일명      : DeliveryController.java
	* - 작성일      : 2017. 5. 22.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 엑셀 샘플다운로드
	* </pre>
	 */
	@RequestMapping("/delivery/deliveryInvoiceCompanyExcelDownload.do")
	public String deliveryInvoiceCompanyExcelDownload(
		Model model
		, OrderSO orderSO
		, BindingResult br
	) {

		if ( log.isDebugEnabled() ) {
			log.debug( "==================================================" );
			log.debug( "= {}", "deliveryInvoiceCompanyExcelDownload" );
			log.debug( "==================================================" );
		}

		String[]	headerName	= null;
		String[]	fieldName	= null;
		String		sheetName	= "deliveryInvoiceBatchUploadTemplate";
		String		fileName	= "deliveryInvoiceBatchUploadTemplate";

		headerName = new String[] {
				// 사이트 아이디
				//messageSourceAccessor.getMessage("column.settlement.st_id" )
				// 사이트명
				 messageSourceAccessor.getMessage("column.settlement.st_nm" )
				// 클레임구분코드
				,messageSourceAccessor.getMessage("column.ord_clm_gb_cd" )
				// 주문번호
				,messageSourceAccessor.getMessage("column.ord_no" )
				// 배송번호
				,messageSourceAccessor.getMessage("column.dlvr_no" )
				// 택배사 코드
				,messageSourceAccessor.getMessage("column.hdc_cd" )
				// 송장 번호
				,messageSourceAccessor.getMessage("column.inv_no" )
				// 주문상세일련번호
				//,messageSourceAccessor.getMessage("column.ord_dtl_seq" )
				// 주문내역상태코드
				//,messageSourceAccessor.getMessage("column.ord_dtl_stat_cd" )
				// 클레임번호
				//,messageSourceAccessor.getMessage("column.clm_no" )
				// 클레임상세일련번호
				//,messageSourceAccessor.getMessage("column.clm_dtl_seq" )
				// 클레임상태코드
				//,messageSourceAccessor.getMessage("column.clm_dtl_stat_cd" )
				//배송 지시 일시
				//,messageSourceAccessor.getMessage("column.dlvr_cmd_dtm" )
				//배송 완료 일시
				//,messageSourceAccessor.getMessage("column.dlvr_cplt_dtm" )
				//출고 완료 일시
				//,messageSourceAccessor.getMessage("column.oo_cplt_dtm" )
				// 업체명
				,messageSourceAccessor.getMessage("column.comp_nm" )
				// 상품명
				,messageSourceAccessor.getMessage("column.goods_nm" )
				// 단품명
				,messageSourceAccessor.getMessage("column.item_nm" )
				// 상품금액
				//,messageSourceAccessor.getMessage("column.sale_amt" )
				// 결제금액
				//,messageSourceAccessor.getMessage("column.pay_amt" )
				// 배송수량
				,messageSourceAccessor.getMessage("column.dlvr_qty" )
				// 배송 처리 유형 코드
				//,messageSourceAccessor.getMessage("column.dlvr_prcs_tp_cd" )
				// 우편 번호 신
				//,messageSourceAccessor.getMessage("column.post_no_new" )
				// 도로 주소
				//,messageSourceAccessor.getMessage("column.road_addr" )
				// 도로 상세 주소
				//,messageSourceAccessor.getMessage("column.road_dtl_addr" )
				// 전화
				//,messageSourceAccessor.getMessage("column.tel" )
				// 휴대폰
				,messageSourceAccessor.getMessage("column.mobile" )
				// 수취인 명
				,messageSourceAccessor.getMessage("column.adrs_nm" )
				// 배송 메모
				//,messageSourceAccessor.getMessage("column.dlvr_memo" )

		};


		fieldName = new String[] {
				// 사이트 아이디
				// "stId"
				// 사이트 명
				  "stNm"
				// 클레임구분코드
				, "ordClmGbCd"
				// 주문번호
				, "ordNo"
				// 배송번호
				, "excelDlvrNo"
				// 택배사 코드
				,"hdcCd"
				// 송장 번호
				, "invNo"
				// 주문상세일련번호
				//, "ordDtlSeq"
				// 주문내역상태코드
				//, "ordDtlStatCd"
				// 클레임번호
				//, "clmNo"
				// 클레임상세일련번호
				//, "clmDtlSeq"
				// 클레임상태코드
				//, "clmDtlStatCd"
				//배송 지시 일시
				//, "dlvrCmdDtm"
				//배송 완료 일시
				//, "dlvrCpltDtm"
				//출고 완료 일시
				//, "ooCpltDtm"
				// 업체명
				, "compNm"
				// 상품명
				, "goodsNm"
				// 단품명
				, "itemNm"
				// 상품금액
				//, "saleAmt"
				// 결제금액
				//, "payAmt"
				// 배송수량
				, "ordQty"
				// 배송 처리 유형 코드
				//, "dlvrPrcsTpCd"

				// 우편 번호 신
				//, "postNoNew"
				// 도로 주소
				//, "roadAddr"
				// 도로 상세 주소
				//, "roadDtlAddr"
				// 전화
				//, "tel"
				// 휴대폰
				, "mobile"
				// 수취인 명
				, "adrsNm"
				// 배송 메모
				//, "dlvrMemo"
		};

		//=============================================================
		// Sample data set
		//=============================================================

		// 화면 구분
		orderSO.setViewGb( "DELIVERY" );


		log.debug( "=orderSO.getOrdClmGbCd()>>>>>>>>>>>> {}", orderSO.getOrdClmGbCd());

		// 주문 상세 상태 코드 : 상품준비중
		if( AdminConstants.ORD_CLM_GB_10.equals(orderSO.getOrdClmGbCd())){
			orderSO.setOrdDtlStatCd( AdminConstants.ORD_DTL_STAT_140 );
		}else if( AdminConstants.ORD_CLM_GB_20.equals(orderSO.getOrdClmGbCd())){
			String[] arrClmDtlStatCd = {AdminConstants.CLM_DTL_STAT_220
			                            ,AdminConstants.CLM_DTL_STAT_320
			                            ,AdminConstants.CLM_DTL_STAT_430};
			orderSO.setArrClmDtlStatCd(arrClmDtlStatCd);
		}

		orderSO.setPagingY(false);

	    List<DeliveryListVO> listOrderListVO = deliveryService.pageDeliveryList( orderSO );
	    for (DeliveryListVO vo:listOrderListVO) {
	    	vo.setHdcCd(vo.getDftHdcCd());
	    }

		model.addAttribute( CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam( sheetName, headerName, fieldName, listOrderListVO, CommonConstants.COMM_YN_Y ) );
		model.addAttribute( CommonConstants.EXCEL_PARAM_FILE_NAME, fileName );

		return View.excelDownload();

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: dyyoun
	 * - 설명		: 송장 일괄 등록 처리
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/delivery/deliveryInvoiceBatchCreateExec.do")
	public String deliveryInvoiceBatchCreateExec(Model model, OrderSO orderSO, @RequestParam("fileName") String fileName, @RequestParam("filePath") String filePath	) {

		if ( log.isDebugEnabled() ) {
			log.debug( "==================================================" );
			log.debug( "= fileName : {}", fileName );
			log.debug( "= filePath : {}", filePath );
			log.debug( "==================================================" );
		}

        List<DeliveryListVO> listDeliveryListVO = null;

		if (StringUtil.isNotEmpty(filePath)) {

			String[] headerMap = null;

			headerMap = new String[] {
					// 사이트 명
					"stNm"
					// 클레임구분코드
					, "ordClmGbCd"
					// 주문번호
					, "ordNo"
					// 배송번호
					, "dlvrNo"
					// 택배사 코드
					, "hdcCd"
					// 송장 번호
					, "invNo"
					// 업체명
					, "compNm"
					// 상품명
					, "goodsNm"
					// 단품명
					, "itemNm"
					// 배송수량
					, "ordQty"
					// 휴대폰
					, "mobile"
					// 수취인 명
					, "adrsNm" };

			File excelFile;
			try {
				excelFile = new File(filePath); // 파싱할 Excel File
			} catch (Exception e) {
				log.error("송장번호 엑셀파일 업로드 중 오류 발생했습니다. DeliveryController.deliveryInvoiceBatchCreateExec::new File(filePath) filepath {}, {}", filePath, e);
				throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
			}

			try {
				listDeliveryListVO = ExcelUtil.parse(excelFile, DeliveryListVO.class, headerMap, 1);
			} catch (Exception e) {
				log.error("송장번호 엑셀파일 업로드 중 오류 발생했습니다. DeliveryController.deliveryInvoiceBatchCreateExec::ExcelUtil.parse {}", e);
				throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
			}

			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("송장번호 엑셀파일 삭제 중 오류 발생했습니다. DeliveryController.deliveryInvoiceBatchCreateExec::excelFile.delete {}");
			}
		}

        // 전체 송장번호 등록 요청 건수, 등록 성공 건수
		int cntTotal = 0;
        int cntSuccess = 0;

        // 송장번호 등록 처리 결과 저장
		List<DeliveryUploadResult> resultList = new ArrayList<>();

        // 송장번호 엑셀파일에 값이 있을 때
        if (CollectionUtils.isNotEmpty(listDeliveryListVO)) {

        	// 그룹코드를 코드명으로 변환하기 위해 코드 정보 조회
            List<CodeDetailVO> ordClmGbList = this.cacheService.listCodeCache(AdminConstants.ORD_CLM_GB, null, null, null, null, null) ;
            List<CodeDetailVO> hdcList = this.cacheService.listCodeCache(AdminConstants.HDC, null, null, null, null, null) ;

        	for (DeliveryListVO deliveryVO : listDeliveryListVO) {
        		boolean processDeliveryInfo = false;
        		StringBuilder resultMessage = new StringBuilder(1024);

        		// 배송번호(dlvrNo) 단위로 한건씩 배송정보를 처리한다.
        		try {
            		if (Objects.isNull(deliveryVO.getDlvrNo()) || StringUtils.isEmpty(deliveryVO.getHdcCd()) || StringUtils.isEmpty(deliveryVO.getInvNo())) {

            			// 엑셀파일에서 읽어온 배송 정보가 이상합니다..
                		throw new IllegalArgumentException(deliveryVO.toString());
            		}

        			deliveryService.processDeliveryInvNo(deliveryVO.getDlvrNo(), deliveryVO.getHdcCd(), deliveryVO.getInvNo());
        			processDeliveryInfo = true;

        		} catch (IllegalArgumentException ie) {
        			// 송장등록 실패 건은 로그 남긴 후 다음 건을 처리한다.
        			log.error("송장번호 일괄 등록 중 파라미터 오류 발생 - DeliveryController.deliveryInvoiceBatchCreateExec::deliveryService.processDeliveryInvNo {}, {}", deliveryVO, ie);
        			resultMessage.append(ExceptionConstants.ERROR_PARAM);
        		} catch (CustomException ce) {
        			// 송장등록 실패 건은 로그 남긴 후 다음 건을 처리한다.
        			log.error("송장번호 일괄 등록 중 오류 발생 - DeliveryController.deliveryInvoiceBatchCreateExec::deliveryService.processDeliveryInvNo {}, {}", deliveryVO, ce);
        			resultMessage.append(ce.getExCode());
        		} catch (Exception e) {
        			// 송장등록 실패 건은 로그 남긴 후 다음 건을 처리한다.
        			log.error("송장번호 일괄 등록 중 알 수 없는 오류 발생 - DeliveryController.deliveryInvoiceBatchCreateExec::deliveryService.processDeliveryInvNo {}, {}", deliveryVO, e);
        			resultMessage.append(ExceptionConstants.ERROR_DELIVERY_PROCESS_ERROR);
        		} finally {
        			DeliveryUploadResult result = new DeliveryUploadResult();

    				result.setOrdClmGbCd(  returnToName (deliveryVO.getOrdClmGbCd(),ordClmGbList) );
    				result.setOrdNo(deliveryVO.getOrdNo());
    				result.setDlvrNo(deliveryVO.getDlvrNo());
    				result.setOrdDtlSeq(deliveryVO.getOrdDtlSeq());
    				result.setOrdDtlStatCd(deliveryVO.getOrdDtlStatCd());
    				result.setClmNo(deliveryVO.getClmNo());
    				result.setClmDtlSeq(deliveryVO.getClmDtlSeq());
    				result.setClmDtlStatCd(deliveryVO.getClmDtlStatCd());
    				result.setInvNo( deliveryVO.getInvNo());
    				result.setHdcNm( returnToName(deliveryVO.getHdcCd(),hdcList ) )	 ;

    				if (processDeliveryInfo) {
    					cntSuccess++;

    					result.setResultYN("성공");
						result.setResultMsg("정상처리되었습니다.");
    				} else {
    					result.setResultYN("실패");
						result.setResultMsg(messageSourceAccessor.getMessage("business.exception." + resultMessage.toString()));
    				}

    				resultList.add(result);
        		}

        		cntTotal++;
        	}
        } else {
			DeliveryUploadResult result = new DeliveryUploadResult();

			result.setOrdClmGbCd("");
			result.setResultYN("실패");
			result.setResultMsg("송장번호 등록 정보가 없었습니다.");

			resultList.add(result);
        }

        model.addAttribute( "cntTotal", cntTotal );
        model.addAttribute( "cntSuccess", cntSuccess );
        model.addAttribute( "cntFail", cntTotal - cntSuccess );
        model.addAttribute( "resultList", resultList );

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: dyyoun
	 * - 설명		: 송장 일괄 등록 처리
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/delivery/deliveryInvoiceBatchCreateExec_old.do")
	public String deliveryInvoiceBatchCreateExecOld(
		Model model
		, OrderSO orderSO
		, @RequestParam("fileName") String fileName
		, @RequestParam("filePath") String filePath
	) {

		List<DeliveryUploadResult> resultList = new ArrayList<>();
		DeliveryUploadResult result = null;

		if ( log.isDebugEnabled() ) {
			log.debug( "==================================================" );
			log.debug( "= fileName : {}", fileName );
			log.debug( "= filePath : {}", filePath );
			log.debug( "==================================================" );
		}

		int cntTotal=0;
        int cntSuccess=0;
		if ( StringUtil.isNotEmpty( filePath ) ) {

			String[] headerMap = null;

			headerMap = new String[] {
					// 사이트 아이디
					// "stId"
					// 사이트 명
					  "stNm"
					// 클레임구분코드
					, "ordClmGbCd"
					// 주문번호
					, "ordNo"
					// 배송번호
					, "dlvrNo"
					// 택배사 코드
					,"hdcCd"
					// 송장 번호
					, "invNo"
					// 주문상세일련번호
					//, "ordDtlSeq"
					// 주문내역상태코드
					//, "ordDtlStatCd"
					// 클레임번호
					//, "clmNo"
					// 클레임상세일련번호
					//, "clmDtlSeq"
					// 클레임상태코드
					//, "clmDtlStatCd"
					//배송 지시 일시
					//, "dlvrCmdDtm"
					//배송 완료 일시
					//, "dlvrCpltDtm"
					//출고 완료 일시
					//, "ooCpltDtm"
					// 업체명
					, "compNm"
					// 상품명
					, "goodsNm"
					// 단품명
					, "itemNm"
					// 상품금액
					//, "saleAmt"
					// 결제금액
					//, "payAmt"
					// 배송수량
					, "ordQty"
					// 배송 처리 유형 코드
					//, "dlvrPrcsTpCd"
					// 우편 번호 신
					//, "postNoNew"
					// 도로 주소
					//, "roadAddr"
					// 도로 상세 주소
					//, "roadDtlAddr"
					// 전화
					//, "tel"
					// 휴대폰
					, "mobile"
					// 수취인 명
					, "adrsNm"
					// 배송 메모
					//, "dlvrMemo"
			};

			File excelFile = new File(filePath);		// 파싱할 Excel File

			List<DeliveryListVO> listDeliveryListVO = null;


			try {
				listDeliveryListVO = ExcelUtil.parse( excelFile, DeliveryListVO.class, headerMap, 1 );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			/*
			Long dlvrNo   = 0L;
            String hdcCd  = null;
            String invNo  = null;
			 */

            List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> goodsFlowResult;
            CodeDetailVO codeDetail;
            List<CodeDetailVO> ordClmGbList = this.cacheService.listCodeCache(AdminConstants.ORD_CLM_GB, null, null, null, null, null) ;
            List<CodeDetailVO> hdcList = this.cacheService.listCodeCache(AdminConstants.HDC, null, null, null, null, null) ;


            // 1. 굿스플로우 송장 번호 유효성 체크 연동
			if (CollectionUtils.isNotEmpty(listDeliveryListVO)) {
				List<InvoiceVO> invoices = new ArrayList<>();
				for ( DeliveryListVO deliveryListVO : listDeliveryListVO ) {
					// 1.1 굿스플로우 연동용 택배사 코드 조회
					codeDetail = cacheService.getCodeCache(CommonConstants.HDC, deliveryListVO.getHdcCd());

					// 2017.06.07, 송장번호 일괄 등록일 때 택배사 코드 체크를 하지 않음, 어차피 굿스플로우 연동에서 실패할 것임.
					/*
					if (codeDetail == null || StringUtils.isEmpty(codeDetail.getUsrDfn1Val())) {
						throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_HDCCD);
					}
					*/

					// 1.2. 연동 파라미터 저장 - 굿스플로우 연동
					InvoiceVO invoice = new InvoiceVO();
					invoice.setInvoiceNo(deliveryListVO.getInvNo());
					invoice.setLogisticsCode(codeDetail.getUsrDfn1Val());

					invoices.add(invoice);
				}

				// 1.3. 송장번호 유효성 체크 - 굿스플로우 연동
				goodsFlowResult = goodsFlowService.checkInvoiceNo(invoices);
				if (CollectionUtils.isNotEmpty(goodsFlowResult)){
					// 굿스플로우 연동 중 에러 발생한 경우
					throw new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR);
				}

				int cnt = 0;
				//for ( DeliveryListVO deliveryListVO : listDeliveryListVO ) {
				for (int idx=0; idx < listDeliveryListVO.size(); idx++) {
					DeliveryListVO deliveryListVO = listDeliveryListVO.get(idx);
					cntTotal = cntTotal + 1 ;
				/*	log.debug( "==================================================" );
					log.debug( "= deliveryListVO => {}", deliveryListVO );
					log.debug( "==================================================" );
				*/
					result = new DeliveryUploadResult();


					//result.setDlvrNo(dlvrNo);

					result.setOrdClmGbCd(  returnToName (deliveryListVO.getOrdClmGbCd(),ordClmGbList) );
					result.setOrdNo(deliveryListVO.getOrdNo());
					result.setDlvrNo(deliveryListVO.getDlvrNo());
					result.setOrdDtlSeq(deliveryListVO.getOrdDtlSeq());
					result.setOrdDtlStatCd(deliveryListVO.getOrdDtlStatCd());
					result.setClmNo(deliveryListVO.getClmNo());
					result.setClmDtlSeq(deliveryListVO.getClmDtlSeq());
					result.setClmDtlStatCd(deliveryListVO.getClmDtlStatCd());
					result.setInvNo( deliveryListVO.getInvNo());
					result.setHdcNm( returnToName(deliveryListVO.getHdcCd(),hdcList ) )	 ;

					//hdcCd = returnToCode (deliveryListVO.getHdcCd() , hdcList ) ;
					boolean check = false ;
					if(cnt > 0 ){
						for (int i = 0 ; i < cnt ; i++ ){
							DeliveryListVO deliveryCheckVO = listDeliveryListVO.get(i);
								if(deliveryCheckVO.getDlvrNo().equals(deliveryListVO.getDlvrNo())){
									check = true;

									for (int j = 0 ; j < resultList.size() ; j++ ){
										if ( deliveryListVO.getDlvrNo().equals(   resultList.get(j).getDlvrNo()  )  ){
											result.setResultYN(resultList.get(j).getResultYN());
											result.setResultMsg(resultList.get(j).getResultMsg());

											if( resultList.get(j).getResultYN().equals("성공")){
												cntSuccess++;
											}
										}
									}
								}
						}
					}

					cnt ++;

					/*for ( DeliveryListVO deliveryCheckVO : listDeliveryListVO ) {
						if (    deliveryListVO.getDlvrNo() != null && !"".equals(deliveryListVO.getDlvrNo())
							 && deliveryCheckVO.getDlvrNo() != null && !"".equals(deliveryCheckVO.getDlvrNo())
							 &&  ){
							check = true;
						}
					}*/// for deliveryCheckVO

					// 2. 송장번호 등록 처리
					if(!check){
						//log.debug( "dlvrNo [" +dlvrNo + "], hdcCd [" +hdcCd+ "], invNo [" +invNo+ "], ordClmGbCd [" +ordClmGbCd+ "], ordDtlStatCd [" +ordDtlStatCd+ "], clmDtlStatCd [" +clmDtlStatCd +"]"  );
						if (!ObjectUtils.isEmpty(deliveryListVO.getDlvrNo()) && !ObjectUtils.isEmpty(deliveryListVO.getHdcCd()) && !ObjectUtils.isEmpty(deliveryListVO.getInvNo())){

							try {
								// 굿스플로우 연동 후 유효한 송장번호일 때 송장번호 등록 처리함
								if (goodsFlowResult.get(idx).isOk()) {
									// 송장번호 배송정보에 등록
									deliveryService.ordClmInvoiceOneCreateExec(deliveryListVO.getDlvrNo(),deliveryListVO.getHdcCd(),deliveryListVO.getInvNo());

									// 배송 추적정보 요청(to GoodsFlow)
									boolean successSendTrace = false;
									try {
										// return type이 boolean 이므로 if 처리 필요
										successSendTrace = goodsFlowService.sendTraceRequest(deliveryListVO.getDlvrNo());
									} catch (Exception e) {
										// 배송 추적정보 요청은 실패하더라도 다음 프로세스를 계속 진행함.
										log.warn("deliveryInvoiceBatchCreateExec : {}", e);
										log.warn(new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR).toString());
										throw e;
									}

									if (successSendTrace) {
										result.setResultYN("성공");
										result.setResultMsg("정상처리되었습니다.");

										cntSuccess++;
									} else {
										result.setResultYN("실패");
										result.setResultMsg("송장번호 배송추적용 송장 정보 전송 오류입니다.");
									}

								} else {
									result.setResultYN("실패");
									result.setResultMsg("송장번호 유효성 체크 결과 오류입니다.");
								}
							} catch (CustomException e){
								result.setResultYN("실패");
								result.setResultMsg(this.messageSourceAccessor.getMessage("business.exception." + e.getExCode()));


							} catch (Exception e) {
								log.error("송장번호 연동 중 굿스플로우 에러", e);
								result.setResultYN("실패");
								result.setResultMsg("알수없는 오류가 발생하였습니다.");
							}
						}else{
							result.setResultYN("실패");
							result.setResultMsg("택배사코드 또는 송장번호가 입력되지 않았습니다.");

						}
					}
					//보안 진단. 불필요한 코드 (비어있는 IF문)
					//else{
						//cntDuplication++;
						//result.setResultYN("중복");
					//}
					resultList.add(result);
				} //for deliveryListVO
			}
			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("Fail to delete of file. DeliveryController.deliveryInvoiceBatchCreateExecOld::excelFile.delete {}");
			}
		}

        model.addAttribute( "cntTotal", cntTotal );
        model.addAttribute( "cntSuccess", cntSuccess );
        model.addAttribute( "cntFail", cntTotal - cntSuccess );
        model.addAttribute( "resultList", resultList );
		return View.jsonView();
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.delivery.controller
	* - 파일명      : DeliveryController.java
	* - 작성일      : 2017. 3. 13.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  DtlNm 넣어  LIST 에 DtlCd 가지고 오기
	* </pre>
	 */
	public String returnToCode(String inDtlNm ,List<CodeDetailVO> listdata){
		String returnCode = null;
		for ( CodeDetailVO codeDetailVO : listdata ) {
			//log.debug( "등록 될것들 >> inDtlNm [" +inDtlNm + "], hdcCd [" +codeDetailVO.getDtlNm().trim()+ "]"  );
				if( !StringUtils.isEmpty(inDtlNm) && codeDetailVO.getDtlNm().trim().equals(inDtlNm.trim())){
					returnCode = codeDetailVO.getDtlCd();
					//log.debug( "등록 될것들 >> inDtlNm [" +inDtlNm + "], hdcCd [" +codeDetailVO.getDtlNm().trim()+ "]"  );
					//log.debug( "등록 될것들 returnCode>> returnCode [" +returnCode + "]"  );
				}
		}
		return returnCode;
	}

	public String returnToName(String inDtlCd ,List<CodeDetailVO> listdata){
		String returnCodeName = null;
		for ( CodeDetailVO codeDetailVO : listdata ) {
				if( StringUtils.isNotEmpty(inDtlCd) && codeDetailVO.getDtlCd().trim().equals(inDtlCd.trim())){
					returnCodeName = codeDetailVO.getDtlNm();
				}
		}
		return returnCodeName;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: dyyoun
	 * - 설명		: 배송완료 처리
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/delivery/deliveryFinalExec.do")
	public String deliveryFinalExec(Long[] arrDlvrNo) {
		
		Session session = AdminSessionUtil.getSession();
		
		// 배송 완료 수동 변경전 배송 추적 요청을 하지 않았을 경우 배송 추적을 요청
		for(Long dlvrNo : arrDlvrNo) {
			goodsFlowService.requestTraceV3NewForOnce(dlvrNo);
		}
		
		deliveryService.deliveryFinalExec( arrDlvrNo , session.getUsrNo());
		
		return View.jsonView();
	}



	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DeliveryController.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: dyyoun
	 * - 설명		: 배송 목록(엑셀 다운로드)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/delivery/deliveryListExcelDownload.do")
	public String deliveryListExcelDownload(ModelMap model, OrderSO so,@RequestParam(value="arrDlvrNoStr",required = false)String arrDlvrNoStr
			,@RequestParam(value="cnctHistNo",required = false)Long cnctHistNo
			,@RequestParam(value="inqrHistNo",required = false)Long inqrHistNo
	){
		// 화면 구분
		so.setViewGb( "DELIVERY" );

		so.setRows(999999999);
		List<DeliveryListVO> list = deliveryService.pageDeliveryList(so);
		if(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N)){
			for(DeliveryListVO v : list){
				v.setRoadAddr(MaskingUtil.getAddress(v.getRoadAddr(),v.getRoadDtlAddr()));
				v.setRoadDtlAddr(MaskingUtil.getMaskedAll(v.getRoadDtlAddr()));
				v.setTel(MaskingUtil.getTelNo(v.getTel()));
				v.setMobile(MaskingUtil.getTelNo(v.getMobile()));
				v.setAdrsNm(MaskingUtil.getName(v.getAdrsNm()));
				v.setOrdrId(MaskingUtil.getId(v.getOrdrId()));
				v.setOrdNm(MaskingUtil.getName(v.getOrdNm()));
				v.setOrdrMobile(MaskingUtil.getTelNo(v.getOrdrMobile()));
			}
		}

		//선택 된 로우 있을 시
		if(StringUtil.isNotEmpty(arrDlvrNoStr)){
			String[] arrDlvrNos = arrDlvrNoStr.split(",");
			list = list.stream().filter(v-> Arrays.asList(arrDlvrNos).contains(v.getDlvrNo().toString())).collect(Collectors.toList());
		}

		String[] headerName = null;
		String[] fieldName = null;
		if("10".equals(so.getOrdClmGbCd())) { //주문관리 > 배송 관리 엑셀 다운로드
			headerName = new String[]{
					// 주문자 회원 번
					messageSourceAccessor.getMessage("column.user_no")
					// 주문자 아이디
					,messageSourceAccessor.getMessage("column.ordUserId" )
					// 주문자명
					,messageSourceAccessor.getMessage("column.ord_nm" )
					// 주문자 핸드폰 번호
					,messageSourceAccessor.getMessage("column.ordr_mobile")
					// 수취인 명
					,messageSourceAccessor.getMessage("column.adrs_nm" )
					// 휴대폰
					,messageSourceAccessor.getMessage("column.mobile" )
					// 주문번호
					,messageSourceAccessor.getMessage("column.ord_no" )
					// 주문상세일련번호
					,messageSourceAccessor.getMessage("column.ord_dtl_seq" )
					// 주문내역상태코드
					,messageSourceAccessor.getMessage("column.ord_dtl_stat_cd" )
					// 클레임번호
					,messageSourceAccessor.getMessage("column.clm_no" )
					// 클레임상세일련번호
					,messageSourceAccessor.getMessage("column.clm_dtl_seq" )
					// 클레임상태코드
					,messageSourceAccessor.getMessage("column.clm_dtl_stat_cd" )
					//주문완료일시
					,messageSourceAccessor.getMessage("column.ord_cplt_dtm" )
					//출고 완료 일시
					,messageSourceAccessor.getMessage("column.oo_cplt_dtm" )
					//배송 완료 일시
					,messageSourceAccessor.getMessage("column.dlvr_cplt_dtm" )
					// 배송 처리 유형 코드
					,messageSourceAccessor.getMessage("column.dlvr_prcs_tp_cd" )
					// 매입 업체명
					,messageSourceAccessor.getMessage("column.goods.phsCompNo")
					// 업체 유형
					,messageSourceAccessor.getMessage("column.comp_tp_cd" )
					// 상품 구성 유형
					,messageSourceAccessor.getMessage("column.goods_cstrt_cd")
					// 상품 번호
					,messageSourceAccessor.getMessage("column.goods_id" )
					// 상품명
					,messageSourceAccessor.getMessage("column.goods_nm" )
					// 사은품 정보
					,messageSourceAccessor.getMessage("column.frb_goods_info")
					// 배송수량
					,messageSourceAccessor.getMessage("column.dlvr_qty" )
					// 배송번호
					,messageSourceAccessor.getMessage("column.dlvr_no" )
					// 택배사 코드
					,messageSourceAccessor.getMessage("column.hdc_cd" )
					// 송장 번호
					,messageSourceAccessor.getMessage("column.inv_no" )
					// 우편 번호 신
					,messageSourceAccessor.getMessage("column.post_no_new" )
					// 도로 주소
					,messageSourceAccessor.getMessage("column.road_addr" )
					// 도로 상세 주소
					,messageSourceAccessor.getMessage("column.road_dtl_addr" )
					// 배송 메모
					,messageSourceAccessor.getMessage("column.dlvr_memo" )
			};
	
			fieldName = new String[]{
					// 회원 번호
					 "mbrNo"
					// 주문자ID
					, "ordrId"
					// 주문자명
					, "ordNm"
					// 주문자 핸드폰 번호
					, "ordrMobile"
					// 수취인 명
					, "adrsNm"
					// 휴대폰
					, "mobile"
					// 주문번호
					, "ordNo"
					// 주문상세일련번호
					, "ordDtlSeq"
					// 주문내역상태코드
					, "ordDtlStatCd"
					// 클레임번호
					, "clmNo"
					// 클레임상세일련번호
					, "clmDtlSeq"
					// 클레임상태코드
					, "clmDtlStatCd"
					// 주문완료일시
					, "ordCpltDtm"
					//출고 완료 일시
					, "ooCpltDtm"
					//배송 완료 일시
					, "dlvrCpltDtm"
					// 배송 처리 유형 명
					, "dlvrPrcsTpNm" 	
					// 매입 업체 명
					, "phsCompNm"
					// 업체 유형
					, "compTpNm"
					// 상품 구성 유형
					, "goodsCstrtTpNm"
					// 상품아이디
					, "goodsId"
					// 상품명
					, "goodsNm"
					// 사은품 정보
					, "subGoodsNm"
					// 배송수량
					, "ordQty"
					// 배송번호
					, "dlvrNo"
					// 택배사 코드
					, "hdcCd"
					// 송장 번호
					, "invNo"
					// 우편 번호 신
					, "postNoNew"
					// 도로 주소
					, "roadAddr"
					// 도로 상세 주소
					, "roadDtlAddr"
					// 배송 메모
					, "dlvrMemo"
			};
		} else if ("20".equals(so.getOrdClmGbCd())) { //주문관리 > 클레임 관리 > 클레임 배송 관리 엑셀 다운로드
			headerName = new String[]{
					// 주문자 회원 번호
					messageSourceAccessor.getMessage("column.user_no")
					// 주문자 아이디
					,messageSourceAccessor.getMessage("column.ordUserId" )
					// 주문자명
					,messageSourceAccessor.getMessage("column.ord_nm" )
					// 주문자 핸드폰 번호
					,messageSourceAccessor.getMessage("column.ordr_mobile")
					// 수취인 명
					,messageSourceAccessor.getMessage("column.adrs_nm" )
					// 휴대폰
					,messageSourceAccessor.getMessage("column.mobile" )
					// 주문번호
					,messageSourceAccessor.getMessage("column.ord_no" )
					// 배송 번호
					,messageSourceAccessor.getMessage("column.dlvr_no" )
					// 주문상세일련번호
					,messageSourceAccessor.getMessage("column.ord_dtl_seq" )
					// 주문내역상태코드
					,messageSourceAccessor.getMessage("column.ord_dtl_stat_cd" )
					// 클레임 유형
					,messageSourceAccessor.getMessage("column.clm_tp_cd" )
					// 클레임번호
					,messageSourceAccessor.getMessage("column.clm_no" )
					// 클레임 사유
					,messageSourceAccessor.getMessage("column.clm_rsn_cd" )
					// 클레임 상세사유
					,messageSourceAccessor.getMessage("column.clm_rsn_content" )
					// 클레임상세일련번호
					,messageSourceAccessor.getMessage("column.clm_dtl_seq" )
					// 클레임상태코드
					,messageSourceAccessor.getMessage("column.clm_dtl_stat_cd" )
					//주문완료일시
					,messageSourceAccessor.getMessage("column.ord_cplt_dtm" )
					//출고 완료 일시
					,messageSourceAccessor.getMessage("column.oo_cplt_dtm" )
					//배송 완료 일시
					,messageSourceAccessor.getMessage("column.dlvr_cplt_dtm" )
					//공급사 구분
					,messageSourceAccessor.getMessage("column.comp_tp_nm")
					// 배송 처리 유형 코드
					,messageSourceAccessor.getMessage("column.dlvr_prcs_tp_cd" )
					// 매입 업체명
					,messageSourceAccessor.getMessage("column.goods.phsCompNo")
					// 상품 구성 유형
					,messageSourceAccessor.getMessage("column.goods_cstrt_cd")
					// 상품 번호
					,messageSourceAccessor.getMessage("column.goods_id" )
					// 상품명
					,messageSourceAccessor.getMessage("column.goods_nm" )
					// 사은품 정보
					,messageSourceAccessor.getMessage("column.frb_goods_info")
					// 배송수량
					,messageSourceAccessor.getMessage("column.dlvr_qty" )
					// 클레임수량
					,messageSourceAccessor.getMessage("column.clm_qty" )
					// 택배사 코드
					,messageSourceAccessor.getMessage("column.hdc_cd" )
					// 송장 번호
					,messageSourceAccessor.getMessage("column.inv_no" )
					// 우편 번호 신
					,messageSourceAccessor.getMessage("column.post_no_new" )
					// 도로 주소
					,messageSourceAccessor.getMessage("column.road_addr" )
					// 도로 상세 주소
					,messageSourceAccessor.getMessage("column.road_dtl_addr" )
					// 배송 메모
					,messageSourceAccessor.getMessage("column.dlvr_memo" )
			};
	
			fieldName = new String[]{
					// 회원 번호
					 "mbrNo"
					// 주문자ID
					, "ordrId"
					// 주문자명
					, "ordNm"
					// 주문자 핸드폰 번호
					, "ordrMobile"
					// 수취인 명
					, "adrsNm"
					// 휴대폰
					, "mobile"
					// 주문번호
					, "ordNo"
					// 배송번호
					, "dlvrNo"
					// 주문상세일련번호
					, "ordDtlSeq"
					// 주문내역상태코드
					, "ordDtlStatCd"
					// 클레임 유형 
					, "clmTpCd"
					// 클레임번호
					, "clmNo"
					//클레임 사유 명
					,"clmRsnNm"
					//클레임 사유 내용 
					,"clmRsnContent"
					// 클레임상세일련번호
					, "clmDtlSeq"
					// 클레임상태코드
					, "clmDtlStatCd"
					// 주문완료일시
					, "ordCpltDtm"
					//출고 완료 일시
					, "ooCpltDtm"
					//배송 완료 일시
					, "dlvrCpltDtm"
					// 공급사 구분
					, "compTpNm"
					// 배송 처리 유형 명
					, "dlvrPrcsTpNm"
					// 매입 업체 명
					, "phsCompNm"
					// 상품 구성 유형
					, "goodsCstrtTpNm"
					// 상품아이디
					, "goodsId"
					// 상품명
					, "goodsNm"
					// 사은품 정보
					, "subGoodsNm"
					// 배송수량
					, "ordQty"
					// 클레임 수량
					, "clmQty"
					// 택배사 코드
					, "hdcCd"
					// 송장 번호
					, "invNo"
					// 우편 번호 신
					, "postNoNew"
					// 도로 주소
					, "roadAddr"
					// 도로 상세 주소
					, "roadDtlAddr"
					// 배송 메모
					, "dlvrMemo"
			};
		}
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("delivery", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "delivery");
		model.addAttribute(CommonConstants.EXCEL_PASSWORD, DateUtil.getNowDate());

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
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.delivery.controller
	* - 파일명      : DeliveryController.java
	* - 작성일      : 2017. 5. 16.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  송장단순수정 화면
	* </pre>
	 */
	@RequestMapping("/delivery/deliveryInvoiceUpdatePopView.do")
	public String deliveryInvoiceUpdatePopView(Model model, Long dlvrNo	) {
		DeliveryVO delivery = this.deliveryService.getDelivery(dlvrNo);
		model.addAttribute( "delivery", delivery);
		return "/delivery/deliveryInvoiceUpdatePopView";
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.delivery.controller
	* - 파일명      : DeliveryController.java
	* - 작성일      : 2017. 5. 16.
	* - 작성자      : valuefactory 권성중
	* - 설명      :송장단순수정
	* </pre>
	 */
	@RequestMapping("/delivery/deliveryInvoiceUpdateExec.do")
	public String deliveryInvoiceUpdateExec(Long dlvrNo,String hdcCd, String invNo ) {

		CodeDetailVO codeDetail = cacheService.getCodeCache(CommonConstants.HDC, hdcCd);

		if (codeDetail == null || StringUtils.isEmpty(codeDetail.getUsrDfn1Val())) {
			// 등록되지 않은 택배사 코드인 경우
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_HDCCD);
		}

		// 1. 송장번호 유효성 체크 - 굿스플로우 연동
		List<InvoiceVO> invoices = new ArrayList<>();

		InvoiceVO invoice = new InvoiceVO();
		invoice.setInvoiceNo(invNo);
		invoice.setLogisticsCode(codeDetail.getUsrDfn1Val());

		invoices.add(invoice);

		List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> goodsFlowResult = goodsFlowService.checkInvoiceNo(invoices);
		if (CollectionUtils.isNotEmpty(goodsFlowResult)) {
			// 굿스플로우 연동 중 에러 발생한 경우
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR);
		}

		// 2. 유효한 송장번호일 때 송장번호 등록 처리함
		if (goodsFlowResult.get(0).isOk()) {
			// 송장번호 배송정보에 등록
			deliveryService.deliveryInvoiceUpdateExec(dlvrNo,hdcCd,invNo);

			// 배송 추적정보 요청(to GoodsFlow)
			boolean successSendTrace = false;
			try {
				// return type이 boolean 이므로 if 처리 필요
				successSendTrace = goodsFlowService.sendTraceRequest(dlvrNo);
			} catch (Exception e) {
				// 배송 추적정보 요청은 실패하더라도 다음 프로세스를 계속 진행함.
				log.warn("deliveryInvoiceUpdateExec : {}", e);
				log.warn(new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR).toString());
				throw e;
			}

			if (! successSendTrace) {
				log.warn("굿스플로우 송장 추적 연동 실패 : deliveryInvoiceUpdateExec.goodsFlowService.sendTraceRequest : {}", dlvrNo);
				throw new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR);
			}

		} else {
			// 사용가능한 송장번호가 아닌 경우
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_INVNO);
		}

		return View.jsonView();
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.delivery.controller
	* - 파일명      : DeliveryController.java
	* - 작성일      : 2017. 5. 18.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  배송지시의 상품들을 업데이트 후 출력
	* </pre>
	*/
	@RequestMapping("/delivery/deliveryInstructionsListExcelDownload.do")
	public String deliveryInstructionsListExcelDownload(ModelMap model, OrderSO so
			,String[] arrOrdNo, Integer[] arrOrdDtlSeq,String[] arrOrdCrmDivision
			){
		// 화면 구분
		so.setViewGb( "DELIVERY" );

		so.setRows(999999999);

		List<String> arrOrdNoList = new ArrayList<>();
		List<String> arrClmNoList = new ArrayList<>();

		if(arrOrdNo != null && arrOrdNo.length > 0){
			for (int i = 0; i < arrOrdNo.length; i++) {

				if ("ord".equals(arrOrdCrmDivision[i]) && !arrOrdNoList.contains(arrOrdNo[i]) ){
					arrOrdNoList.add(arrOrdNo[i]);
				}else if ("clm".equals(arrOrdCrmDivision[i]) && !arrClmNoList.contains(arrOrdNo[i]) ){
					arrClmNoList.add(arrOrdNo[i]);
				}
			}
			so.setArrOrdNo(arrOrdNoList.toArray(new String[arrOrdNoList.size()]) );
			so.setArrClmNo(arrClmNoList.toArray(new String[arrClmNoList.size()]) );
		}

		List<DeliveryListVO> list = deliveryService.pageDeliveryList( so );

		for(DeliveryListVO vo : list){
			// 대상조회 SQL 에서 주문일때 잔여수량, 클레임일때 클레임취소 여부 체크하고 있음.
			if(CommonConstants.ORD_CLM_GB_10.equals(vo.getOrdClmGbCd()) && CommonConstants.ORD_DTL_STAT_130.equals(vo.getOrdDtlStatCd())){
				this.orderDetailService.updateOrderDetailStatus( vo.getOrdNo(), Integer.valueOf( vo.getOrdDtlSeq().toString() ), AdminConstants.ORD_DTL_STAT_140 );
				vo.setOrdDtlStatCd(CommonConstants.ORD_DTL_STAT_140);
			}else if(CommonConstants.ORD_CLM_GB_20.equals(vo.getOrdClmGbCd()) && CommonConstants.CLM_DTL_STAT_420.equals(vo.getClmDtlStatCd())){
				this.claimDetailService.updateClaimDetailStatus(vo.getClmNo(), Integer.valueOf( vo.getClmDtlSeq().toString() ), AdminConstants.CLM_DTL_STAT_430);
				vo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_430);
			}

			if(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N)){
				vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(),vo.getRoadDtlAddr()));
				vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));
				vo.setTel(MaskingUtil.getTelNo(vo.getTel()));
				vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
				vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
				vo.setOrdrId(MaskingUtil.getId(vo.getOrdrId()));
				vo.setOrdNm(MaskingUtil.getName(vo.getOrdNm()));
				vo.setOrdrMobile(MaskingUtil.getTelNo(vo.getOrdrMobile()));
			}
		}

		String[] headerName = {
				// 클레임구분코드
				messageSourceAccessor.getMessage("column.ord_clm_gb_cd" )
				// 주문번호
				,messageSourceAccessor.getMessage("column.ord_no" )
				// 배송번호
				,messageSourceAccessor.getMessage("column.dlvr_no" )
				// 주문상세일련번호
				,messageSourceAccessor.getMessage("column.ord_dtl_seq" )
				// 주문내역상태코드
				,messageSourceAccessor.getMessage("column.ord_dtl_stat_cd" )
				// 클레임번호
				,messageSourceAccessor.getMessage("column.clm_no" )
				// 클레임상세일련번호
				,messageSourceAccessor.getMessage("column.clm_dtl_seq" )
				// 클레임상태코드
				,messageSourceAccessor.getMessage("column.clm_dtl_stat_cd" )
				//배송 지시 일시
				//,messageSourceAccessor.getMessage("column.dlvr_cmd_dtm" )
				//배송 완료 일시
				//,messageSourceAccessor.getMessage("column.dlvr_cplt_dtm" )
				//출고 완료 일시
				//,messageSourceAccessor.getMessage("column.oo_cplt_dtm" )
				// 업체명
				,messageSourceAccessor.getMessage("column.comp_nm" )
				// 상품명
				,messageSourceAccessor.getMessage("column.goods_nm" )
				// 단품명
				,messageSourceAccessor.getMessage("column.item_nm" )
				// 상품금액
				,messageSourceAccessor.getMessage("column.sale_amt" )
				// 결제금액
				,messageSourceAccessor.getMessage("column.pay_amt" )
				// 배송수량
				,messageSourceAccessor.getMessage("column.dlvr_qty" )
				// 배송 처리 유형 코드
				,messageSourceAccessor.getMessage("column.dlvr_prcs_tp_cd" )
				// 택배사 코드
				,messageSourceAccessor.getMessage("column.hdc_cd" )
				// 송장 번호
				,messageSourceAccessor.getMessage("column.inv_no" )
				// 우편 번호 신
				,messageSourceAccessor.getMessage("column.post_no_new" )
				// 도로 주소
				,messageSourceAccessor.getMessage("column.road_addr" )
				// 도로 상세 주소
				,messageSourceAccessor.getMessage("column.road_dtl_addr" )
				// 전화
				,messageSourceAccessor.getMessage("column.tel" )
				// 휴대폰
				,messageSourceAccessor.getMessage("column.mobile" )
				// 수취인 명
				,messageSourceAccessor.getMessage("column.adrs_nm" )
				// 배송 메모
				,messageSourceAccessor.getMessage("column.dlvr_memo" )

		};
		String[] fieldName = {
				// 클레임구분코드
				  "ordClmGbCd"
				// 주문번호
				, "ordNo"
				// 배송번호
				, "dlvrNo"
				// 주문상세일련번호
				, "ordDtlSeq"
				// 주문내역상태코드
				, "ordDtlStatCd"
				// 클레임번호
				, "clmNo"
				// 클레임상세일련번호
				, "clmDtlSeq"
				// 클레임상태코드
				, "clmDtlStatCd"
				//배송 지시 일시
				//, "dlvrCmdDtm"
				//배송 완료 일시
				//, "dlvrCpltDtm"
				//출고 완료 일시
				//, "ooCpltDtm"
				// 업체명
				, "compNm"
				// 상품명
				, "goodsNm"
				// 단품명
				, "itemNm"
				// 상품금액
				, "saleAmt"
				// 결제금액
				, "payAmt"
				// 배송수량
				, "ordQty"
				// 배송 처리 유형 코드
				, "dlvrPrcsTpCd"
				// 택배사 코드
				, "hdcCd"
				// 송장 번호
				, "invNo"
				// 우편 번호 신
				, "postNoNew"
				// 도로 주소
				, "roadAddr"
				// 도로 상세 주소
				, "roadDtlAddr"
				// 전화
				, "tel"
				// 휴대폰
				, "mobile"
				// 수취인 명
				, "adrsNm"
				// 배송 메모
				, "dlvrMemo"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("delivery", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "delivery");

		return View.excelDownload();
	}
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: DeliveryController.java
	* - 작성일	: 2021. 9. 8.
	* - 작성자 	: valfac
	* - 설명 		: 배송 히스토리 팝업
	* </pre>
	*
	* @param model
	* @return
	*/
	@RequestMapping("/delivery/deliveryHistoryListView.do")
	public String deliveryHistoryListView (Model model, @RequestParam("ordClmGbCd") String ordClmGbCd) {
		
		model.addAttribute("ordClmGbCd", ordClmGbCd);

		return "/delivery/deliveryHistoryListView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: DeliveryController.java
	* - 작성일	: 2021. 9. 8.
	* - 작성자 	: valfac
	* - 설명 		: 배송완료 이력
	* </pre>
	*
	* @param model
	* @param dlvrNo
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/delivery/deliveryHistoryLayerGrid.do", method = RequestMethod.POST)
	public GridResponse dlvrHistoryLayerGrid (Model model, DeliveryHistSO so) {

		List<DeliveryHistVO> list = deliveryService.pageDeliveryHist(so);

		return new GridResponse(list, so);
	}
}
