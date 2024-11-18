package biz.app.receipt.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderDeliveryVO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailTaxVO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrderService;
import biz.app.receipt.dao.CashReceiptDao;
import biz.app.receipt.dao.TaxInvoiceDao;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptVO;
import biz.app.receipt.model.TaxInvoicePO;
import biz.app.receipt.model.TaxInvoiceVO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.tax.service
 * - 파일명		: TaxServiceImpl.java
 * - 작성일		: 2016. 4. 14.
 * - 작성자		: dyyoun
 * - 설명		: 계산서(현금영수증/세금계산서) 서비스
 * </pre>
 */
@Slf4j
@Transactional
@Service("taxService")
public class TaxInvoiceServiceImpl implements TaxInvoiceService {

	@Autowired
	private CashReceiptDao cashReceiptDao;
	
	@Autowired
	private TaxInvoiceDao taxInvoiceDao;

	@Autowired OrderBaseDao orderBaseDao;

	@Autowired OrderDetailDao orderDetailDao;

	
	@Autowired	private BizService bizService;

	@Autowired private OrderService orderService;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//
	@Override
	public List<OrderListVO> pageTaxList( OrderSO orderSO ) {

		log.debug( "================================" );
		log.debug( "= {}", "pageTaxList" );
		log.debug( "================================" );

		List<OrderDeliveryVO> orderBaseList = taxInvoiceDao.pageTaxList( orderSO );
		List<OrderListVO> result = new ArrayList<>();

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		try {

			for ( OrderDeliveryVO orderBaseVO : orderBaseList ) {

				//Integer cnt = orderBaseVO.getOrderDetailTaxListVO().size();
				//Integer rownum = 0;

				for ( OrderDetailTaxVO orderDetailTaxVO : orderBaseVO.getOrderDetailTaxListVO() ) {
					//rownum++;
					OrderListVO orderListVO = new OrderListVO();
					BeanUtils.copyProperties( orderListVO, orderDetailTaxVO );

					// 주문 번호
					orderListVO.setOrdNo( orderBaseVO.getOrdNo() );

					// 주문 상태 코드
					orderListVO.setOrdStatCd( orderBaseVO.getOrdStatCd() );

					// 주문 매체 코드
					orderListVO.setOrdMdaCd( orderBaseVO.getOrdMdaCd() );


					// 회원 번호
//					orderListVO.setMbrNo( orderBaseVO.getMbrNo() );
//
//					// 회원 명
//					orderListVO.setMbrNm( orderBaseVO.getMbrNm() );
//
//					// 회원 등급 코드
//					orderListVO.setMbrGrdCd( orderBaseVO.getMbrGrdCd() );
//
//					// 주문자 명
//					orderListVO.setOrdNm( orderBaseVO.getOrdNm() );
//
//					// 주문자 이메일
//					orderListVO.setOrdrEmail( orderBaseVO.getOrdrEmail() );
//
//					// 주문자 전화
//					orderListVO.setOrdrTel( orderBaseVO.getOrdrTel() );
//
//					// 주문자 휴대폰
//					orderListVO.setOrdrMobile( orderBaseVO.getOrdrMobile() );
//
//					// 주문자 IP
//					orderListVO.setOrdrIp( orderBaseVO.getOrdrIp() );
//
//					// 주문 접수 일시
//					orderListVO.setOrdAcptDtm( orderBaseVO.getOrdAcptDtm() );
//
//					// 주문 완료 일시
//					orderListVO.setOrdCpltDtm( orderBaseVO.getOrdCpltDtm() );
//
//
//					// 결제 수단 코드
//					orderListVO.setPayMeansCd( orderBaseVO.getPayMeansCd() );
//
//					// 전체 결제 금액
//					orderListVO.setPayAmtTotal( orderBaseVO.getPayAmtTotal() );
//
//					// 주문자 ID
//					orderListVO.setOrdrId( orderBaseVO.getOrdrId() );
//
//					orderListVO.setOrdDtlCnt(cnt);
//					orderListVO.setOrdDtlRowNum(rownum);
					result.add(orderListVO);
				}
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		return result;
	}







	@Override
	public TaxInvoiceVO getTaxInvoiceSum( OrderSO orderSO ) {
		return taxInvoiceDao.getTaxInvoiceSum( orderSO );
	}

	@Override
	public void taxInvoiceAcceptExec( OrderSO orderSO, TaxInvoicePO taxInvoicePO ) {
		 // 세금계산서 접수 실행
		log.info("taxInvoiceAcceptExec");
	}

	@Override
	public void taxInvoicePublishExec( OrderSO orderSO, TaxInvoicePO taxInvoicePO ) {

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		//=============================================================================
		// 현금영수증 기 접수/승인 건 체크
		//=============================================================================
//		Integer check = cashReceiptDao.getCashReceiptExistsCheck( orderSO );
//		if ( check != 0 ) {
//			throw new CustomException( ExceptionConstants.ERROR_CASH_RECEIPT_EXISTS );
//		}

		//=============================================================================
		// 세금계산서 기 승인 건 체크
		//=============================================================================
		Integer check = taxInvoiceDao.getTaxInvoiceExistsCheck( orderSO );
		if ( check != 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_TAX_INVOICE_EXISTS );
		}

		//=============================================================================
		// 세금계산서 리스트 추출
		//=============================================================================
		orderSO.setIsuGbCd( AdminConstants.ISU_GB_20 );
		List<TaxInvoiceVO> listTaxInvoiceVO = taxInvoiceDao.listTaxInvoice( orderSO );

		if ( listTaxInvoiceVO != null && !listTaxInvoiceVO.isEmpty()) {

			for ( TaxInvoiceVO getTaxInvoiceVO : listTaxInvoiceVO ) {

				TaxInvoicePO tempTaxInvoicePO = new TaxInvoicePO();
				try {
					BeanUtils.copyProperties( tempTaxInvoicePO, getTaxInvoiceVO );
				} catch (IllegalAccessException | InvocationTargetException e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}

				//=============================================================================
				// 세금계산서 정보 세팅
				//=============================================================================
				// 업체 명
				tempTaxInvoicePO.setCompNm( taxInvoicePO.getCompNm() );

				// 대표자 명
				tempTaxInvoicePO.setCeoNm( taxInvoicePO.getCeoNm() );

				// 업태
				tempTaxInvoicePO.setBizCdts( taxInvoicePO.getBizCdts() );

				// 종목
				tempTaxInvoicePO.setBizTp( taxInvoicePO.getBizTp() );

				// 사업자 번호
				tempTaxInvoicePO.setBizNo( taxInvoicePO.getBizNo() );

				// 지번 주소
				tempTaxInvoicePO.setPostNoOld( taxInvoicePO.getPostNoOld() );
				tempTaxInvoicePO.setPrclAddr( taxInvoicePO.getPrclAddr() );
				tempTaxInvoicePO.setPrclDtlAddr( taxInvoicePO.getPrclDtlAddr() );

				// 도로명 주소
				tempTaxInvoicePO.setPostNoNew( taxInvoicePO.getPostNoNew() );
				tempTaxInvoicePO.setRoadAddr( taxInvoicePO.getRoadAddr() );
				tempTaxInvoicePO.setRoadDtlAddr( taxInvoicePO.getRoadDtlAddr() );

				// 주소
				tempTaxInvoicePO.setAddr( taxInvoicePO.getRoadAddr() + taxInvoicePO.getRoadDtlAddr() );

				// 메모
				tempTaxInvoicePO.setMemo( taxInvoicePO.getMemo() );

				// 처리자 번호
				tempTaxInvoicePO.setPrcsrNo( AdminSessionUtil.getSession().getUsrNo().longValue() );

				//=============================================================================
				// 주문 상세 정보
				//=============================================================================
				orderSO.setOrdDtlSeq( getTaxInvoiceVO.getOrdDtlSeq() );
				
				OrderDetailSO orderDetailSO = new OrderDetailSO();
				orderDetailSO.setOrdNo(orderSO.getOrdNo());
				orderDetailSO.setOrdDtlSeq(orderSO.getOrdDtlSeq());						
				//OrderDetailVO getOrderDetailVO = orderDetailDao.getOrderDetail( orderDetailSO );

				//=============================================================================
				// START : 세금계산서 I/F
				//=============================================================================
				log.info( "======================================================================" );
				log.info( "START : 세금계산서 I/F" );
				LogUtil.log( tempTaxInvoicePO );
				log.info( "======================================================================" );

//				interfaceTaxService.interfaceTax( "new", tempTaxInvoicePO, getOrderDetailVO, null );

				log.info( "======================================================================" );
				log.info( "E N D : 세금계산서 I/F" );
				LogUtil.log( tempTaxInvoicePO );
				log.info( "======================================================================" );
				//=============================================================================
				// E N D : 세금계산서 I/F
				//=============================================================================

				// I/F 결과 반영 : 세금계산서 상태 코드
				if ( "0000".equals( tempTaxInvoicePO.getLnkRstCd() ) ) {
					tempTaxInvoicePO.setTaxIvcStatCd( AdminConstants.CASH_RCT_STAT_20 );
				} else {
					tempTaxInvoicePO.setTaxIvcStatCd( AdminConstants.CASH_RCT_STAT_90 );
				}

				//=============================================================================
				// 세금계산서 변경
				//=============================================================================
				int result = taxInvoiceDao.updateTaxInvoice( tempTaxInvoicePO );
				if ( result == 0 ) {
					throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
				}

			}	// end for ( TaxInvoiceVO getTaxInvoiceVO : listTaxInvoiceVO ) {

		}	// end if ( listTaxInvoiceVO != null && listTaxInvoiceVO.size() > 0 ) {

	}



	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/* 현금영수증 수동 발행
	 * @see biz.app.tax.service.TaxService#insertCashReceipt(biz.app.order.model.OrderSO, biz.app.order.model.CashReceiptPO)
	 */
	/*
	@Override
	public void insertCashReceipt(OrderSO orderSO, CashReceiptPO cashReceiptPO) {

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		//=============================================================================
		// 현금영수증 기 접수/승인 건 체크
		//=============================================================================
		Integer check = taxInvoiceDao.getCashReceiptExistsCheck( orderSO );
		if ( check == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CASH_RE_PUBLISH_NOT_EXISTS );
		}

		//=============================================================================
		// 세금계산서 기 접수/승인 건 체크
		//=============================================================================
		check = taxInvoiceDao.getTaxInvoiceExistsCheck( orderSO );
		if ( check != 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_TAX_INVOICE_EXISTS );
		}

		//=============================================================================
		// 현금영수증 리스트 추출
		//=============================================================================
		orderSO.setIsuGbCd( CommonConstants.ISU_GB_10 );
		List<CashReceiptVO> listCashReceiptVO = orderCommonDao.listCashReceipt( orderSO );

		if ( listCashReceiptVO != null && listCashReceiptVO.size() > 0 ) {

			for ( CashReceiptVO getCashReceiptVO : listCashReceiptVO ) {

				CashReceiptPO tempCashReceiptPO = new CashReceiptPO();
				try {
					BeanUtils.copyProperties( tempCashReceiptPO, getCashReceiptVO );
				} catch (IllegalAccessException e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				} catch (InvocationTargetException e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}

				//=============================================================================
				// 결제 정보 추출
				//=============================================================================
				PayBaseVO payBaseVO = orderCommonDao.getPayBase( orderSO );

				// 승인 일때는 기존꺼 취소 처리
				if ( CommonConstants.CASH_RCT_STAT_20.equals( getCashReceiptVO.getCashRctStatCd() ) ) {

					//=============================================================================
					// START : 현금영수증 I/F
					//interfaceCash( String jobGubun, CashReceiptPO cashReceiptPO, OrderBaseVO orderBaseVO, OrderDetailVO orderDetailVO );
					//=============================================================================
//					interfaceTaxService.interfaceCash( "cancel", tempCashReceiptPO, payBaseVO.getPayMeansCd() );
					//=============================================================================
					// E N D : 현금영수증 I/F
					//=============================================================================

				}

				// 원 현금 영수증 번호
				tempCashReceiptPO.setOrgCashRctNo( getCashReceiptVO.getCashRctNo() );

				// 주문 클레임 구분 코드
				tempCashReceiptPO.setOrdClmGbCd( CommonConstants.ORD_CLM_GB_10 );

				// 현금 영수증 상태 코드
				tempCashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_30 );

				// 처리자 번호
				tempCashReceiptPO.setPrcsrNo( cashReceiptPO.getPrcsrNo() );

				// 메모
				tempCashReceiptPO.setMemo(null);

				//=============================================================================
				// 현금영수증 변경
				//=============================================================================
				int result = orderCommonDao.updateCashReceipt( tempCashReceiptPO );
				if ( result == 0 ) {
					throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
				}

				//=============================================================================
				// 현금영수증 전문 세팅
				//=============================================================================

				// 사용 구분 코드
				tempCashReceiptPO.setUseGbCd( cashReceiptPO.getUseGbCd() );

				// 발급 수단 번호
				tempCashReceiptPO.setIsuMeansNo( cashReceiptPO.getIsuMeansNo() );

				// 발급 구분 코드 : 수동발급
				tempCashReceiptPO.setIsuGbCd( CommonConstants.ISU_GB_20 );

				// 접수 일시
				tempCashReceiptPO.setAcptDtm( DateUtil.getTimestamp() );

				// 메모
				tempCashReceiptPO.setMemo( cashReceiptPO.getMemo() );

				//=============================================================================
				// START : 현금영수증 I/F
				//  interfaceCash( String jobGubun, CashReceiptPO cashReceiptPO, OrderBaseVO orderBaseVO, OrderDetailVO orderDetailVO );
				//=============================================================================
				//interfaceTaxService.interfaceCash( "new", tempCashReceiptPO, payBaseVO.getPayMeansCd() );
				//interfaceTaxService.interfaceCash("new", tempCashReceiptPO, orderBaseVO, orderDetailVO);
				//=============================================================================
				// E N D : 현금영수증 I/F
				//=============================================================================

				if ( "0000".equals( tempCashReceiptPO.getLnkRstCd() ) ) {
					// 현금 영수증 상태 코드
					tempCashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_20 );
				} else {
					tempCashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_90 );
				}

				//=============================================================================
				// 현금영수증 승인/에러 등록
				//=============================================================================
				result = orderCommonDao.insertCashReceipt( tempCashReceiptPO );
				if ( result == 0 ) {
					throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
				}
			}
		}
	}
*/



	/* 세금계산서 신청
	 * @see biz.app.tax.service.TaxService#insertTaxInvoice(biz.app.order.model.OrderSO, biz.app.order.model.TaxInvoicePO)
	 */
	@Override
	public void insertTaxInvoice(OrderSO orderSO, TaxInvoicePO taxInvoicePO) {

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		if(StringUtil.isNotBlank(taxInvoicePO.getPostNoOld())){
			taxInvoicePO.setPostNoOld(taxInvoicePO.getPostNoOld().replace("-", ""));
		}

		//=============================================================================
		// 현금영수증(수동발행) 기 접수/승인 건 체크
		//=============================================================================
		orderSO.setIsuGbCd(CommonConstants.ISU_GB_20);	// /** 발행 구분 코드 : 수동 발급 */
		Integer check = taxInvoiceDao.getCashReceiptExistsCheckTaxInvoice( orderSO );
		if ( check != 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CASH_RECEIPT_EXISTS );
		}

		//=============================================================================
		// 현금영수증(자동발행) 기 접수/승인 건 체크
		//=============================================================================
		check = taxInvoiceDao.getCashReceiptExistsCheckTaxInvoice( orderSO );
		if ( check != 0 ) {
			//=============================================================================
			/*
			 *  - 기존 접수 건 취소 및 DB반영
			 *  - 기존 승인 건 I/F 취소 및 DB반영
			 */
			//=============================================================================

			// 현금영수증 리스트 추출
			orderSO.setIsuGbCd( CommonConstants.ISU_GB_20 );
			List<CashReceiptVO> listCashReceiptVO = cashReceiptDao.listCashReceipt( orderSO );

			if ( listCashReceiptVO != null && !listCashReceiptVO.isEmpty()) {

				for ( CashReceiptVO getCashReceiptVO : listCashReceiptVO ) {

					CashReceiptPO tempCashReceiptPO = new CashReceiptPO();
					try {
						BeanUtils.copyProperties( tempCashReceiptPO, getCashReceiptVO );
					} catch (IllegalAccessException | InvocationTargetException e) {
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}

					//=============================================================================
					// 결제 정보 추출
					//=============================================================================
					//PayBaseVO payBaseVO = orderCommonDao.getPayBase( orderSO );
					OrderBaseSO orderBaseSO = new OrderBaseSO();
					orderBaseSO.setOrdNo(orderSO.getOrdNo());					
					//OrderBaseVO orderBaseVO = orderBaseDao.getOrderBase(orderBaseSO);
					
					OrderDetailSO orderDetailSO = new OrderDetailSO();
					orderDetailSO.setOrdNo(orderSO.getOrdNo());
					//List<OrderDetailVO> orderDtlList = orderDetailDao.listOrderDetail(orderDetailSO);

					// 승인 일때는 기존꺼 취소 처리
					//보안 진단. 불필요한 코드 (비어있는 IF문)
					//if ( CommonConstants.CASH_RCT_STAT_20.equals( getCashReceiptVO.getCashRctStatCd() ) ) {

						//=============================================================================
						// START : 현금영수증 I/F
						//=============================================================================
//						interfaceTaxService.interfaceCash( "cancel", tempCashReceiptPO, payBaseVO.getPayMeansCd() );
						//for(OrderDetailVO m : orderDtlList){
//							interfaceTaxService.interfaceCash("cancel", tempCashReceiptPO, orderBaseVO, m);
						//}
						//=============================================================================
						// E N D : 현금영수증 I/F
						//=============================================================================
					//}

					// 원 현금 영수증 번호
					tempCashReceiptPO.setOrgCashRctNo( getCashReceiptVO.getCashRctNo() );

					// 현금 영수증 상태 코드
					tempCashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_30 );

					//=============================================================================
					// 현금영수증 변경
					//=============================================================================
					int result = cashReceiptDao.updateCashReceipt( tempCashReceiptPO );
					if ( result == 0 ) {
						throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
					}
				}
			}
		}

		//=============================================================================
		// 세금계산서 기 접수/승인 건 체크
		//=============================================================================
		check = taxInvoiceDao.getTaxInvoiceExistsCheck( orderSO );
		if ( check != 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_TAX_INVOICE_EXISTS );
		}

		//=============================================================================
		// 주문 상세 만큼 반복
		//=============================================================================
		OrderDetailSO orderDetailSO = new OrderDetailSO();
		orderDetailSO.setOrdNo(orderSO.getOrdNo());				
		List<OrderDetailVO> listOrderDetailVO = orderDetailDao.listOrderDetail( orderDetailSO );

		if (listOrderDetailVO != null && !listOrderDetailVO.isEmpty()) {

			for (OrderDetailVO getOrderDetailVO : listOrderDetailVO) {

//				if (!StringUtils.equals(getOrderDetailVO.getOrdDtlStatCd(), CommonConstants.ORD_DTL_STAT_03) && !StringUtils.equals(getOrderDetailVO.getOrdDtlStatCd(), CommonConstants.ORD_DTL_STAT_14)
//						&& !StringUtils.equals(getOrderDetailVO.getOrdDtlStatCd(), CommonConstants.ORD_DTL_STAT_16)
//						&& !StringUtils.equals(getOrderDetailVO.getOrdDtlStatCd(), CommonConstants.ORD_DTL_STAT_17)
//						&& !StringUtils.equals(getOrderDetailVO.getOrdDtlStatCd(), CommonConstants.ORD_DTL_STAT_18)) {

					// =============================================================================
					// 세금계산서 전문 세팅
					// =============================================================================

					// 원 세금 계산서 번호
					taxInvoicePO.setOrgTaxIvcNo(0L);

					// 주문 클레임 구분 코드
					taxInvoicePO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);

					// 주문 번호
					taxInvoicePO.setOrdNo(getOrderDetailVO.getOrdNo());

					// 주문 상세 순번
					taxInvoicePO.setOrdDtlSeq(getOrderDetailVO.getOrdDtlSeq());

					// 클레임 번호
					taxInvoicePO.setClmNo(null);

					// 클레임 상세 순번
					taxInvoicePO.setClmDtlSeq(null);

					// 신청자 구분 코드
// 오류주석		taxInvoicePO.setApctGbCd(CommonConstants.APCT_GB_02);

					// 회원 번호
					taxInvoicePO.setMbrNo(getOrderDetailVO.getMbrNo());

					// 사용 구분 코드
					taxInvoicePO.setUseGbCd(null);

					// 발급 수단 코드
					taxInvoicePO.setIsuMeansCd(CommonConstants.ISU_MEANS_30);

					// 공급 금액
					Long splAmt = Math.round(getOrderDetailVO.getPayAmt() / 1.1);
					taxInvoicePO.setSplAmt(splAmt);

					// 부가세 금액
					taxInvoicePO.setStaxAmt(getOrderDetailVO.getPayAmt() - splAmt);

					// 총 금액
					taxInvoicePO.setTotAmt(taxInvoicePO.getSplAmt() + taxInvoicePO.getStaxAmt());

					// 접수 일시
					taxInvoicePO.setAcptDtm(DateUtil.getTimestamp());

					// 처리자 번호
					taxInvoicePO.setPrcsrNo(taxInvoicePO.getPrcsrNo());

					// =============================================================================
					// START : 세금계산서 I/F [ interfaceTax( String jobGubun,
					// TaxInvoicePO taxInvoicePO, OrderDetailVO orderDetailVO,
					// ClaimDetailVO claimDetailVO )]
					// 세금계산서는 따로 인터페이스 호출 안해주는걸로 확인함. 20160812
					// =============================================================================
					// interfaceTaxService.interfaceTax( "new", taxInvoicePO,
					// getOrderDetailVO, null );
					// =============================================================================
					// E N D : 세금계산서 I/F
					// =============================================================================

					// I/F 결과 반영 : 세금계산서 상태 코드
					taxInvoicePO.setTaxIvcStatCd(CommonConstants.TAX_IVC_STAT_01); // 접수

					// =============================================================================
					// 세금계산서 승인/에러 등록
					// =============================================================================
					int result = taxInvoiceDao.insertTaxInvoice(taxInvoicePO);
					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
//				}
			}
		}
	}




	@Override
	public List<TaxInvoiceVO> listTaxInvoice( OrderSO orderSO ) {
		return taxInvoiceDao.listTaxInvoice( orderSO );
	}
	
}
