package biz.app.receipt.service;

import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.pay.model.PaymentException;
import biz.app.receipt.dao.CashReceiptDao;
import biz.app.receipt.dao.TaxInvoiceDao;
import biz.app.receipt.model.*;
import biz.common.service.BizService;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
@Service("cashReceiptService")
public class CashReceiptServiceImpl implements CashReceiptService {

	@Autowired
	private CashReceiptDao cashReceiptDao;

	@Autowired
	private TaxInvoiceDao taxInvoiceDao;

	@Autowired
	private OrderBaseDao orderBaseDao;

	@Autowired
	private OrderDetailDao orderDetailDao;
	
	@Autowired
	private ClaimDetailDao claimDetailDao;

	@Autowired
	private BizService bizService;

	@Override
	public List<CashReceiptVO> pageCashReceipList( OrderSO orderSO ) {

		log.debug( "================================" );
		log.debug( "= {}", "pageTaxList" );
		log.debug( "================================" );

		List<CashReceiptVO> cashReceiptList = cashReceiptDao.pageCashReceipList( orderSO );
		List<CashReceiptVO> result = new ArrayList<>();

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		try {

			for ( CashReceiptVO vo : cashReceiptList ) {

				Integer cnt = vo.getOrderDetailListVO().size();
				Integer rownum = 0;

				for ( OrderDetailVO orderDetailVO : vo.getOrderDetailListVO() ) {
					rownum++;
					CashReceiptVO cashReceiptVO = new CashReceiptVO();
					BeanUtils.copyProperties( cashReceiptVO, orderDetailVO );
					BeanUtils.copyProperties( cashReceiptVO, vo );

					cashReceiptVO.setOrdDtlStatCd(orderDetailVO.getOrdDtlStatCd());
					cashReceiptVO.setCompNm(orderDetailVO.getCompNm());
					cashReceiptVO.setGoodsNm(orderDetailVO.getGoodsNm());
					cashReceiptVO.setItemNm(orderDetailVO.getItemNm());
					cashReceiptVO.setSaleAmt(orderDetailVO.getSaleAmt());
					cashReceiptVO.setOrdQty(orderDetailVO.getOrdQty());
					cashReceiptVO.setAplQty(orderDetailVO.getAplQty());
					cashReceiptVO.setOrdDtlCnt(cnt);
					cashReceiptVO.setOrdDtlRowNum(rownum);
					result.add(cashReceiptVO);
				}
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		return result;
	}

	@Override
	public CashReceiptVO getCashReceiptSum( CashReceiptSO cashReceiptSO ) {
		return cashReceiptDao.getCashReceiptSum( cashReceiptSO );
	}

	@Override
	public void cashReceiptAcceptExec( OrderSO orderSO, CashReceiptPO cashReceiptPO ) {

		//=============================================================================
		// 현금 영수증 접수 가능 체크
		//=============================================================================
//		Integer check = taxDao.getCashReceiptAcceptPossibleCheck(orderSO);
//		if ( check != 0 ) {
//			throw new CustomException( ExceptionConstants.ERROR_CASH_RECEIPT_EXISTS );
//		}

		//=============================================================================
		// 주문 상세 조회
		//=============================================================================
		OrderDetailSO orderDetailSO = new OrderDetailSO();
		orderDetailSO.setOrdNo(orderSO.getOrdNo());
		List<OrderDetailVO> listOrderDetailVO = orderDetailDao.listOrderDetail(orderDetailSO);
		if ( listOrderDetailVO != null && !listOrderDetailVO.isEmpty()) {
			Long totSplAmt = 0L;
			Long totStaxAmt = 0L;

			for ( OrderDetailVO getOrderDetailVO : listOrderDetailVO ) {

				// 공급 금액
				Long splAmt = Math.round( getOrderDetailVO.getPayAmt() / 1.1 );
				totSplAmt += splAmt;

				// 부가세 금액
				totStaxAmt += getOrderDetailVO.getPayAmt() - splAmt;

			}	// end for ( OrderDetailVO getOrderDetailVO : listOrderDetailVO ) {

			cashReceiptPO.setCashRctNo(bizService.getSequence(AdminConstants.SEQUENCE_CASH_RCT_NO_SEQ));

			// 원 현금 영수증 번호
			cashReceiptPO.setOrgCashRctNo( 0L );

			// 클레임 번호
			cashReceiptPO.setClmNo( null );

			// 발행 유형 코드
			cashReceiptPO.setCrTpCd(CommonConstants.CR_TP_10);

			// 현금 영수증 상태 코드
			cashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_10 );

			// 사용 구분 코드
			cashReceiptPO.setUseGbCd( cashReceiptPO.getUseGbCd());

			// 발급 수단 코드
			cashReceiptPO.setIsuMeansCd( cashReceiptPO.getIsuMeansCd());

			// 발급 수단 번호
			cashReceiptPO.setIsuMeansNo( cashReceiptPO.getIsuMeansNo() );

			// 공급 금액
			cashReceiptPO.setSplAmt( totSplAmt );

			// 부가세 금액
			cashReceiptPO.setStaxAmt( totStaxAmt );

			// 봉사료 금액
			cashReceiptPO.setSrvcAmt( 0L );

			// 연동 일시
			cashReceiptPO.setLnkDtm( null );

			// 연동 거래 번호
			cashReceiptPO.setLnkDealNo( null );

			// 연동 결과 메세지
			cashReceiptPO.setLnkRstMsg( null );

			//=============================================================================
			// 현금영수증 등록
			//=============================================================================
			int result = cashReceiptDao.insertCashReceipt(cashReceiptPO);
			if ( result == 0 ) {
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}

		}	// end if ( listOrderDetailVO != null && listOrderDetailVO.size() > 0 ) {

	}

	@Override
	public void cashReceiptPublishExec( OrderSO orderSO, CashReceiptPO cashReceiptPO ) {

		OrderDetailSO orderDetailSO = new OrderDetailSO();
		orderDetailSO.setOrdNo(orderSO.getOrdNo());

		List<OrderDetailVO> listOrderDetailVO = orderDetailDao.listOrderDetail(orderDetailSO);

		if ( listOrderDetailVO != null && !listOrderDetailVO.isEmpty()) {

			for (int i=0; i<listOrderDetailVO.size(); i++) {

				// 현금 영수증 상태 코드
				cashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_20 );

				//=============================================================================
				// START : 현금영수증 I/F
				//=============================================================================
//				interfaceallthegService.interfaceCash( "new", cashReceiptPO );
				//=============================================================================
				// E N D : 현금영수증 I/F
				//=============================================================================

				// 연동 일시
				cashReceiptPO.setLnkDtm( DateUtil.getTimestamp() );

				// 연동 거래 번호
				cashReceiptPO.setLnkDealNo( "2016121212121212111" );

				// 연동 결과 메세지
				cashReceiptPO.setLnkRstMsg( "성공적으로 발행되었습니다." );

				int result = cashReceiptDao.updateCashReceipt(cashReceiptPO);
				if ( result == 0 ) {
					throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
				}

			}	// end for ( OrderDetailVO getOrderDetailVO : listOrderDetailVO ) {

		}


	}

	@Override
	public void cashReceiptRePublishExec( CashReceiptSO cashReceiptSO, CashReceiptPO cashReceiptPO ) {

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		//=============================================================================
		// 현금영수증 기 접수/승인 건 체크
		//=============================================================================
		Integer check = cashReceiptDao.getCashReceiptExistsCheck( cashReceiptSO );
		if ( check == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CASH_RE_PUBLISH_NOT_EXISTS );
		}

		//=============================================================================
		// 현금영수증 리스트 추출
		//=============================================================================
		CashReceiptVO cashReceiptVO = cashReceiptDao.getCashReceipt( cashReceiptSO );

		if ( cashReceiptVO != null ) {
			CashReceiptPO tempCashReceiptPO = new CashReceiptPO();

			tempCashReceiptPO.setCashRctNo(cashReceiptVO.getCashRctNo());
			// 현금 영수증 상태 코드
			tempCashReceiptPO.setCashRctStatCd( AdminConstants.CASH_RCT_STAT_30 );

			//=============================================================================
			// 현금영수증 변경
			//=============================================================================
			int result = cashReceiptDao.updateCashReceipt( tempCashReceiptPO );
			if ( result == 0 ) {
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}

			// '발행' 일때는 현금영수증 '발행취소' 건으로 '접수' 생성
			if ( AdminConstants.CASH_RCT_STAT_20.equals( cashReceiptVO.getCashRctStatCd() ) ) {
				cashReceiptRePublishExecCrTpCd(AdminConstants.CR_TP_20, tempCashReceiptPO, cashReceiptPO, cashReceiptVO);
			}

			cashReceiptRePublishExecCrTpCd(AdminConstants.CR_TP_10, tempCashReceiptPO, cashReceiptPO, cashReceiptVO);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptServiceImpl.java
	 * - 작성일		: 2017. 2. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 발행 유형 코드에 따라 현금영수증 생성
	 * </pre>
	 * @param crTpCd
	 * @param tempCashReceiptPO
	 * @param cashReceiptPO
	 * @param cashReceiptVO
	 * @return
	 */
	private void cashReceiptRePublishExecCrTpCd(String crTpCd, CashReceiptPO tempCashReceiptPO, CashReceiptPO cashReceiptPO, CashReceiptVO cashReceiptVO) {
		try {
			BeanUtils.copyProperties( tempCashReceiptPO, cashReceiptVO );
		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}

		tempCashReceiptPO.setCashRctNo(bizService.getSequence(AdminConstants.SEQUENCE_CASH_RCT_NO_SEQ));
		tempCashReceiptPO.setCashRctStatCd(AdminConstants.CASH_RCT_STAT_10); // 현금 영수증 상태 코드 : 접수

		if (AdminConstants.CR_TP_20.equals(crTpCd)) {
			tempCashReceiptPO.setOrgCashRctNo( cashReceiptVO.getCashRctNo() ); // 원 현금 영수증 번호
			tempCashReceiptPO.setCrTpCd( crTpCd ); // 원 현금 영수증 번호
			tempCashReceiptPO.setLnkDealNo(cashReceiptVO.getLnkDealNo()); // 원 연동 거래 번호
		} else {
			tempCashReceiptPO.setIsuGbCd( AdminConstants.ISU_GB_20 ); // 발급 구분 코드 : 수동발급
			tempCashReceiptPO.setUseGbCd( cashReceiptPO.getUseGbCd() );
			tempCashReceiptPO.setIsuMeansCd( cashReceiptPO.getIsuMeansCd() );
			tempCashReceiptPO.setIsuMeansNo( cashReceiptPO.getIsuMeansNo() );
		}

		//=============================================================================
		// 현금영수증 승인/에러 등록
		//=============================================================================
		int result = cashReceiptDao.insertCashReceipt( tempCashReceiptPO );
		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		} else {
			CashReceiptGoodsMapSO cashReceiptGoodsMapSO = new CashReceiptGoodsMapSO();

			try {
				BeanUtils.copyProperties( cashReceiptGoodsMapSO, cashReceiptVO );
			} catch (IllegalAccessException | InvocationTargetException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			List<CashReceiptGoodsMapVO> listCashReceiptGoodsMapVO = cashReceiptDao.listCashReceiptGoodsMap(cashReceiptGoodsMapSO);

			if (listCashReceiptGoodsMapVO != null && !listCashReceiptGoodsMapVO.isEmpty()) {
				for (CashReceiptGoodsMapVO cashReceiptGoodsMapVO : listCashReceiptGoodsMapVO) {
					CashReceiptGoodsMapPO cashReceiptGoodsMapPO = new CashReceiptGoodsMapPO();
					cashReceiptGoodsMapPO.setCashRctNo(tempCashReceiptPO.getCashRctNo());
					cashReceiptGoodsMapPO.setOrdClmNo(cashReceiptGoodsMapVO.getOrdClmNo());
					cashReceiptGoodsMapPO.setOrdClmDtlSeq(cashReceiptGoodsMapVO.getOrdClmDtlSeq());
					cashReceiptGoodsMapPO.setAplQty(cashReceiptGoodsMapVO.getAplQty());
					cashReceiptDao.insertCashReceiptGoodsMap(cashReceiptGoodsMapPO);
				}
			}
		}
	}

	@Override
	public List<CashReceiptVO> listBatchCashReceipt() {
		return cashReceiptDao.listBatchCashReceipt();
	}

	@Override
	public List<CashReceiptVO> listCashReceipt( OrderSO orderSO ) {
		return cashReceiptDao.listCashReceipt( orderSO );
	}

	@Override
	public CashReceiptVO getCashReceipt( CashReceiptSO cashReceiptSO ) {
		return cashReceiptDao.getCashReceipt( cashReceiptSO );
	}

	/* 현금영수증 수동 발행
	 * @see biz.app.tax.service.TaxService#insertCashReceipt(biz.app.order.model.OrderSO, biz.app.order.model.CashReceiptPO)
	 */
	@Override
	public void insertCashReceipt(OrderSO orderSO, CashReceiptPO cashReceiptPO) {

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		//=============================================================================
		// 현금영수증: 주문상태이고 접수/승인 건 체크 ( 필요없는 로직 )
		//=============================================================================
		CashReceiptSO cashReceiptSO = new CashReceiptSO();
		cashReceiptSO.setOrdNo(orderSO.getOrdNo());
		Integer check = cashReceiptDao.getCashReceiptExistsCheck( cashReceiptSO );
		if ( check == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CASH_RE_PUBLISH_NOT_EXISTS );
		}

		//=============================================================================
		// 세금계산서 기 접수/승인 건 체크
		//=============================================================================
		//check = taxInvoiceDao.getTaxInvoiceExistsCheck( orderSO );
		//if ( check != 0 ) {
		//	throw new CustomException( ExceptionConstants.ERROR_TAX_INVOICE_EXISTS ); /** 세금계산서로 접수나 승인된 건이 이미 존재합니다. */
		//}

		//=============================================================================
		// 현금영수증 리스트 추출
		//=============================================================================
		orderSO.setIsuGbCd( CommonConstants.ISU_GB_10 );
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
					//for(OrderDetailVO m : orderDtlList){
//						interfaceTaxService.interfaceCash("cancel", tempCashReceiptPO, orderBaseVO, m);
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

				//=============================================================================
				// 현금영수증 전문 세팅
				//=============================================================================
				tempCashReceiptPO.setCashRctNo(bizService.getSequence(AdminConstants.SEQUENCE_CASH_RCT_NO_SEQ));

				// 사용 구분 코드
				tempCashReceiptPO.setUseGbCd( cashReceiptPO.getUseGbCd() );

				// 발급 수단 번호
				tempCashReceiptPO.setIsuMeansNo( cashReceiptPO.getIsuMeansNo() );

				// 발급 구분 코드 : 수동발급
				tempCashReceiptPO.setIsuGbCd( CommonConstants.ISU_GB_20 );

				//=============================================================================
				// START : 현금영수증 I/F
				//  interfaceCash( String jobGubun, CashReceiptPO cashReceiptPO, OrderBaseVO orderBaseVO, OrderDetailVO orderDetailVO );
				//=============================================================================
				//for(OrderDetailVO m : orderDtlList){
//					interfaceTaxService.interfaceCash("new", tempCashReceiptPO, orderBaseVO, m);
				//}
				//=============================================================================
				// E N D : 현금영수증 I/F
				//=============================================================================


				if ( StringUtil.isNotEmpty(tempCashReceiptPO.getLnkDealNo() ) ) {
					// 현금 영수증 상태 코드
					tempCashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_20 );
				} else {
					tempCashReceiptPO.setCashRctStatCd( CommonConstants.CASH_RCT_STAT_90 );
				}

				//=============================================================================
				// 현금영수증 승인/에러 등록
				//=============================================================================
				result = cashReceiptDao.insertCashReceipt( tempCashReceiptPO );
				if ( result == 0 ) {
					throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
				}
			}
		}
	}

	@Override
	public List<CashReceiptVO> listBatchCashReceiptAppr() {
		return cashReceiptDao.listBatchCashReceiptAppr();
	}

	@Override
	public List<CashReceiptVO> listBatchCashReceiptCncl() {
		return cashReceiptDao.listBatchCashReceiptCncl();
	}

	@Override
	public int updateCashReceipt(CashReceiptPO cashReceiptPO) {
		return cashReceiptDao.updateCashReceipt(cashReceiptPO);
	}

	/* 
	 * 현금영수증 상품명 조회
	 * @see biz.app.receipt.service.CashReceiptService#getCashReceiptGoodsNm(java.lang.Long)
	 */
	@Override
	public String getCashReceiptGoodsNm(Long cashRctNo) {
		String goodsNm ="";
		
		CashReceiptGoodsMapSO crgmso = new CashReceiptGoodsMapSO();
		crgmso.setCashRctNo(cashRctNo);
		List<CashReceiptGoodsMapVO> mapList = this.cashReceiptDao.listCashReceiptGoodsMap(crgmso);
		
		if(mapList != null && !mapList.isEmpty()){
			int etcCnt = 0;
			
			goodsNm = mapList.get(0).getGoodsNm();
			
			if(goodsNm.length() > 15){
				goodsNm = goodsNm.substring(0, 15);
			}
			
			if(mapList.size() > 1){
				etcCnt = mapList.size() - 1;
			}
			
			goodsNm += goodsNm + "외" + etcCnt + "개";
			
		}
		
		return goodsNm;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2021. 4. 9.
	 * - 작성자		: pse
	 * - 설명		: 현금영수증 발행 데이터 db insert
	 * </pre>
	 * @param cashReceiptPO
	 */
	@Override
	public void cashReceiptInsert( CashReceiptPO po ) {
		int result = cashReceiptDao.insertCashReceipt( po );
		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		} else {
			CashReceiptGoodsMapPO crgmpo = null;
			if(po.getOrdClmNo().length()==16) { // ORDER
				OrderDetailSO odso = new OrderDetailSO();
				odso.setOrdNo(po.getOrdClmNo());
				List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);
				
				for (OrderDetailVO orderDetail : orderDetailList) {
					crgmpo = new CashReceiptGoodsMapPO();
					crgmpo.setCashRctNo(po.getCashRctNo());
					crgmpo.setOrdClmNo(orderDetail.getOrdNo());
					crgmpo.setOrdClmDtlSeq(orderDetail.getOrdDtlSeq());
					crgmpo.setAplQty(orderDetail.getOrdQty());
					int cashReceiptGoodsMapResult = this.cashReceiptDao.insertCashReceiptGoodsMap(crgmpo);

					if (cashReceiptGoodsMapResult == 0) {
						throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else { // CLAIM
				ClaimDetailSO clmso = new ClaimDetailSO();
				clmso.setOrdNo(po.getOrdClmNo());
				List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(clmso);
				
				for (ClaimDetailVO claimDetail : claimDetailList) {
					crgmpo = new CashReceiptGoodsMapPO();
					crgmpo.setCashRctNo(po.getCashRctNo());
					crgmpo.setOrdClmNo(claimDetail.getClmNo());
					crgmpo.setOrdClmDtlSeq(claimDetail.getClmDtlSeq());
					crgmpo.setAplQty(claimDetail.getClmQty());
					int cashReceiptGoodsMapResult = this.cashReceiptDao.insertCashReceiptGoodsMap(crgmpo);

					if (cashReceiptGoodsMapResult == 0) {
						throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: pse
	 * - 설명		: 현금영수증 발행/취소 DB Insert Data Setting 
	 * </pre>
	 * @param vo
	 * @return
	 */
	public CashReceiptPO insertCancelCashReceipt(CancelProcessResVO res, String ordNo, String clmNo) {
		//CASH_RECEIPT INSERT
		CashReceiptPO cashReceiptPo = new CashReceiptPO();
		CashReceiptSO cashReceiptSO = new CashReceiptSO();
		
		cashReceiptSO.setOrdNo(ordNo);
		CashReceiptVO reqData = getCashReceipt(cashReceiptSO);
		
		Long payAmt = reqData.getPayAmt();
		Long staxAmt = Math.round(payAmt.doubleValue() / 1.1 * 0.1);
		Long splAmt = payAmt - staxAmt;
		Long srvcAmt = 0L;
		
		cashReceiptPo.setCashRctNo(bizService.getSequence(AdminConstants.SEQUENCE_CASH_RCT_NO_SEQ));
		cashReceiptPo.setOrgCashRctNo(reqData.getCashRctNo());
		cashReceiptPo.setCrTpCd("20"); //발행 취소
		cashReceiptPo.setCashRctStatCd("30");//취소
		cashReceiptPo.setUseGbCd(reqData.getUseGbCd()); 
		cashReceiptPo.setIsuMeansCd(reqData.getIsuMeansCd());
		cashReceiptPo.setIsuMeansNo(reqData.getIsuMeansNo());
		cashReceiptPo.setIsuGbCd("20");//10:자동 20:수동
		cashReceiptPo.setPayAmt(reqData.getPayAmt());
		cashReceiptPo.setSplAmt(splAmt);
		cashReceiptPo.setStaxAmt(staxAmt);
		cashReceiptPo.setSrvcAmt(srvcAmt);
		cashReceiptPo.setStrId(res.getMID());
		try {
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		    SimpleDateFormat orgFormat = new SimpleDateFormat("yyyyMMddhhmmss");
		    Date parsedDate = orgFormat.parse(res.getCancelDate()+res.getCancelTime());
		    Date autoDate = dateFormat.parse(dateFormat.format(parsedDate));
			cashReceiptPo.setLnkDtm(new java.sql.Timestamp(autoDate.getTime()));
		} catch (ParseException e) {
			throw new CustomException(ExceptionConstants.ERROR_DATA_PARSE_FAIL);
		}
		cashReceiptPo.setLnkDealNo(res.getTID());
		cashReceiptPo.setLnkRstMsg(res.toString());
		cashReceiptPo.setSysRegrNo(reqData.getMbrNo());
		cashReceiptPo.setCfmRstCd(res.getResultCode());
		cashReceiptPo.setCfmRstMsg(res.getResultMsg());
		cashReceiptPo.setOrdClmNo(clmNo);
		cashReceiptInsert(cashReceiptPo);
		
		return new CashReceiptPO();
	}
	
	
}
