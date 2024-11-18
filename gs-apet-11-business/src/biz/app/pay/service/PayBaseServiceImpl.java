package biz.app.pay.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.delivery.dao.DeliveryChargeDao;
import biz.app.member.dao.MemberSavedMoneyDetailDao;
import biz.app.member.service.MemberSavedMoneyService;
import biz.app.order.dao.OrdSavePntDao;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.GsPntHistVO;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrdSavePntSO;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.service.OrderBaseService;
import biz.app.order.service.OrderSendService;
import biz.app.pay.dao.PayBaseDao;
import biz.app.pay.dao.PayCashRefundDao;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PayCashRefundPO;
import biz.app.pay.model.PayIfLogVO;
import biz.app.receipt.dao.CashReceiptDao;
import biz.app.receipt.model.CashReceiptGoodsMapPO;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.model.CashReceiptVO;
import biz.app.receipt.service.CashReceiptService;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.service.CodeService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.enums.NicePayCodeMapping;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.request.data.FixAccountReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import biz.interfaces.nicepay.model.response.data.FixAccountResVO;
import biz.interfaces.nicepay.service.NicePayCashReceiptService;
import biz.interfaces.nicepay.service.NicePayCommonService;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.service
* - 파일명		: PayBaseServiceImpl.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 서비스 Impl
* </pre>
*/
@Slf4j
@Service("payBaseService")
@Transactional
public class PayBaseServiceImpl implements PayBaseService {

	@Autowired	private PayBaseDao payBaseDao;

	@Autowired private PayCashRefundDao payCashRefundDao;
	
	@Autowired private OrderBaseDao orderBaseDao;
	
	@Autowired private OrderDetailDao orderDetailDao;
	
	@Autowired private ClaimBaseDao claimBaseDao;
	
	@Autowired private ClaimDetailDao claimDetailDao;
	
	@Autowired private MemberSavedMoneyDetailDao memberSavedMoneyDetailDao;
	
	@Autowired private MemberSavedMoneyService memberSavedMoneyService;
	
	@Autowired private MessageSourceAccessor message;
	
	@Autowired private CacheService cacheService;
	
	@Autowired private OrderBaseService orderBaseService;
	
	@Autowired private BizService bizService;
	
	@Autowired private NicePayCommonService nicePayCommonService; 
	
	
//	@Autowired private INIPayService iniPayService;
	
	@Autowired private DeliveryChargeDao deliveryChargeDao;
	
	@Autowired private CashReceiptDao cashReceiptDao;
	
	@Autowired private OrderSendService orderSendService;
	
	@Autowired private PaySendService paySendService;
	
	@Autowired private GsrService gsrService;
	
	@Autowired private CashReceiptService cashReceiptService;
	@Autowired private NicePayCashReceiptService nicePayCashReceiptService;
	
	@Autowired private OrdSavePntDao ordSavePntDao;
	@Autowired private CodeService codeService;
	@Autowired private SktmpService sktmpService;
	
	
	/*
	 * 주문에 따른 전체 결제 완료 여부 체크
	 * @see biz.app.pay.service.PayBaseService#checkPayStatus(java.lang.String)
	 */
	@Override
	@Transactional(readOnly=true)
	public boolean checkPayStatus(String ordNo) {
		boolean payComplete = true;
		
		/*
		 * 결제 목록 조회
		 */
		PayBaseSO pbso = new PayBaseSO();
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
		pbso.setOrdNo(ordNo);
		List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);

		/*
		 * 결제 상태 체크
		 */
		if(payBaseList != null && !payBaseList.isEmpty()){
			for(PayBaseVO payBase : payBaseList){
				if(!CommonConstants.PAY_STAT_01.equals(payBase.getPayStatCd())){
					payComplete = false;
				}
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_PAY);
		}
		
		return payComplete;
	}

	/* 
	 * 결제 목록 조회
	 * @see biz.app.pay.service.PayBaseService#listPayBase(biz.app.pay.model.PayBaseSO)
	 */
	@Override
	public List<PayBaseVO>  listPayBase(PayBaseSO so) {
		return this.payBaseDao.listPayBase(so);
	}
	
	/*
	 * 주문의 원 결제 상세 조회
	 * @see biz.app.pay.service.PayBaseService#getPayBaseOrg(java.lang.String, java.lang.String)
	 */
	@Override
	public PayBaseVO getPayBaseOrg(String ordNo, String payMeansCd) {
		PayBaseSO pbso = new PayBaseSO();
		pbso.setOrdNo(ordNo);
		pbso.setPayMeansCd(payMeansCd);
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
		return this.payBaseDao.getPayBase(pbso);
	}
	
	/* 
	 * 가상계좌 입금 대상 정보 조회
	 * @see biz.app.pay.service.PayBaseService#getPayBaseVirtual(java.lang.String, java.lang.String)
	 */
	@Override
	public PayBaseVO getPayBaseVirtual(String ordNo, String acctNo) {
		PayBaseSO pbso = new PayBaseSO();
		pbso.setOrdNo(ordNo);
		pbso.setAcctNo(acctNo);
		pbso.setPayMeansCd(CommonConstants.PAY_MEANS_30);
		return this.payBaseDao.getPayBase(pbso);
	}

	/*
	 * 결제 완료 처리
	 * @see biz.app.pay.service.PayBaseService#updatePayBaseComplete(java.lang.Long)
	 */
	@Override
	public void updatePayBaseComplete(Long payNo){
		PayBaseSO so = new PayBaseSO();
		so.setPayNo(payNo);
		PayBaseVO payBase = this.payBaseDao.getPayBase(so);

		if(payBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_PAY);
		}
		
		/***********************************************
		 * Validation 
		 * - 주문 상태
		 * - 결제 상태
		 * - 결제 수단
		 ***********************************************/
		OrderBaseSO obso = new OrderBaseSO();
		obso.setOrdNo(payBase.getOrdNo());
		OrderBaseVO orderBase = this.orderBaseDao.getOrderBase(obso);

		/*
		 * 주문이 접수 상태가 아닌경우 오류
		 */
		if(orderBase != null){
			if(!CommonConstants.ORD_STAT_10.equals(orderBase.getOrdStatCd())){
				throw new CustomException(ExceptionConstants.ERROR_PAY_COMPLETE_ORDER_STATUS);
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		/*
		 * 결제 상태가 입금대기인 경우만 가능
		 */
		if(!CommonConstants.PAY_STAT_00.equals(payBase.getPayStatCd())){
			throw new CustomException(ExceptionConstants.ERROR_PAY_COMPLETE_STATUS);
		}
		
		/*
		 * 결제 수단이 무통장 & 가상계좌 & 실시간계좌이체(모바일) 인 경우에만 가능
		 */
		if(!CommonConstants.PAY_MEANS_40.equals(payBase.getPayMeansCd()) && !CommonConstants.PAY_MEANS_30.equals(payBase.getPayMeansCd()) && !CommonConstants.PAY_MEANS_20.equals(payBase.getPayMeansCd())){
			throw new CustomException(ExceptionConstants.ERROR_PAY_COMPLETE_MEANS);
		}
		
		PayBasePO pbPO = new PayBasePO();
		pbPO.setPayNo(payNo);
		int payResult = this.payBaseDao.updatePayBaseComplete(pbPO);
		
		if(payResult == 1){
			
			/***********************************************
			 * 주문 완료 처리
			 ***********************************************/
			
			/* -----------------------------------------------
			 * 주문 결제 상태 체크
			 ----------------------------------------------- */
			boolean payComplete = this.checkPayStatus(orderBase.getOrdNo());
			
			/* -----------------------------------------------
			 *  주문 관련 상태 수정
			 *  - 주문 상세 상태 설정 > 주문완료
			 *  - 주문 기본 상태 설정 > 주문완료
			 ----------------------------------------------- */
			if(payComplete){
				
				// 주문 프로세스 결과 코드
				String orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_5000;	
				String orderPrcsRstMsg = null;
				String exceptionCd = null;
				
				try {
					/*
					 * 주문 상세 상태 처리
					 */
					OrderDetailPO odpo = new OrderDetailPO();
					odpo.setOrdNo(orderBase.getOrdNo());
					odpo.setOrdDtlStatCd(CommonConstants.ORD_DTL_STAT_120);
					int orderDetailResult = orderDetailDao.updateOrderDetail(odpo);
					
					if(orderDetailResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					/*
					 * 주문 상태 처리
					 */
					OrderBasePO obpo = new OrderBasePO();
					obpo.setOrdNo(orderBase.getOrdNo());
					obpo.setOrdStatCd(CommonConstants.ORD_STAT_20);
					int orderBaseResult = this.orderBaseDao.updateOrderBase(obpo);			

					if(orderBaseResult != 1){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					/***********************************************
					 * 주문 이메일/SMS 전송
					 *  - 결제완료에 대한 메일 발송
					 ***********************************************/
					this.orderSendService.sendOrderInfo(orderBase.getOrdNo());
					
				} catch (CustomException e){
					orderPrcsRstMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + e.getExCode());
					exceptionCd = e.getExCode(); 
				} catch (Exception e) {
					orderPrcsRstMsg = this.cacheService.getCodeName(CommonConstants.ORD_PRCS_RST, orderPrcsRstCd);
					exceptionCd = ExceptionConstants.ERROR_CODE_DEFAULT;
				} 
				
				if(exceptionCd != null){
					log.error("[주문 후 프로세스 오류] 주문번호 : "+ orderBase.getOrdNo());
					log.error("[주문 후 프로세스 오류] 처리결과코드 : "+ orderPrcsRstCd);
					log.error("[주문 후 프로세스 오류] 처리결과메세지 : "+ orderPrcsRstMsg);
					this.orderBaseService.updateOrderBaseProcessResult(orderBase.getOrdNo(), orderPrcsRstCd, orderPrcsRstMsg, null);

					throw new CustomException(exceptionCd);
				}
				
			}

		}else{
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
	}

	/*
	 * 결제 환불 접수
	 * @see biz.app.pay.service.PayBaseService#acceptPayBaseRefund(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public void acceptPayBaseRefund(String clmNo, String bankCd, String acctNo, String ooaNm, Long refundDlvrAmt) {

		List<PayBasePO> payBasePoList = new ArrayList<>();	// 환불데이터 생성 목록
		PayBasePO payBasePO = null;
				
		/*********************************
		 * 클레임 정보 조회
		 *********************************/
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);
		
		if(claimBase == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		/****************************
		 * 주문 정보 조회
		 *****************************/
		OrderBaseSO obso = new OrderBaseSO();
		obso.setOrdNo(claimBase.getOrdNo());
		OrderBaseVO orderBase = this.orderBaseDao.getOrderBase(obso);

		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		/*****************************************************
		 * 환불처리 : 클레임이 취소/반품인 경우에만 환불 처리
		 *****************************************************/
		if(CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd()) || CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())){

			//----------------------------------------
			// 주문의 결제 정보 조회
			//----------------------------------------
			PayBaseSO pbso = new PayBaseSO();
			pbso.setOrdNo(claimBase.getOrdNo());
			String[] payGbCds = {CommonConstants.PAY_GB_10, CommonConstants.PAY_GB_30};
			pbso.setPayGbCds(payGbCds);
			
			pbso.setCncYn(CommonConstants.COMM_YN_N);
			
			List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);
			
			
			Long refundPayAmt;	// 전체 환불 금액

			/*
			 * 주문 접수 시
			 *  - 주문 접수시에는 결제완료된 건에 대해서만 환불데이터 생성
			 */
			if(CommonConstants.ORD_STAT_10.equals(orderBase.getOrdStatCd())){
			
				/**********************************
				 * 환불 데이터 생성
				 **********************************/
				if(payBaseList != null && !payBaseList.isEmpty()){

					for(PayBaseVO payBase : payBaseList){
						
						// 적립금 정보에 대한 환급 데이터 생성
						if(CommonConstants.PAY_STAT_01.equals(payBase.getPayStatCd())){
							payBasePO = new PayBasePO();
							Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);
							payBasePO.setPayNo(payNo);
							payBasePO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
							payBasePO.setOrdNo(payBase.getOrdNo());
							payBasePO.setClmNo(clmNo);
							payBasePO.setPayGbCd(CommonConstants.PAY_GB_20);
							payBasePO.setPayMeansCd(payBase.getPayMeansCd());
							payBasePO.setPayStatCd(CommonConstants.PAY_STAT_00);
							payBasePO.setOrgPayNo(payBase.getPayNo());
							payBasePO.setCncYn(CommonConstants.COMM_YN_N);
							payBasePO.setStrId(payBase.getStrId());
							payBasePO.setBankCd(bankCd);
							payBasePO.setAcctNo(acctNo);
							payBasePO.setOoaNm(ooaNm);
							payBasePO.setPayAmt(payBase.getPayAmt());
							
							payBasePoList.add(payBasePO);
						}
					}	// for(payBaseList)
				}	// if(payBaseList)
				
			/*
			 * 주문 완료시	
			 */
			}else{
				
				/**********************************
				 * 환불 금액 계산
				 **********************************/
				
				//--------------------------------------
				// 상품 환불 금액 계산
				//--------------------------------------
				Long refundGoodsAmt = 0L;	// 상품환불금액

				/*
				 *  클레임 상세 목록 정보 조회
				 */
				ClaimDetailSO cdso = new ClaimDetailSO();
				cdso.setClmNo(clmNo);
				List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);
				
				if(claimDetailList == null || claimDetailList.isEmpty()){
					throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
				}
				
				/*
				 *  클레임 상세 단위 환불금액
				 */
				for(ClaimDetailVO claimDetail: claimDetailList){
					refundGoodsAmt += claimDetail.getPayAmt() * claimDetail.getClmQty();
					
					refundGoodsAmt += claimDetail.getRmnPayAmt();
				}

				//--------------------------------------
				// 환불 금액 합산
				//--------------------------------------
				refundPayAmt = refundGoodsAmt + refundDlvrAmt;
				
				/* MP 포인트 재계산 사용여부 체크 - N Start */
				//우주코인 추가할인부터 빼준다.
				CodeDetailSO codeSO = new CodeDetailSO();
				codeSO.setGrpCd(CommonConstants.PNT_TP);
				codeSO.setDtlCd(CommonConstants.PNT_TP_MP);
				CodeDetailVO mpCodeVO = codeService.getCodeDetail(codeSO);
				String mpReCalculateYn = StringUtil.isEmpty(mpCodeVO.getUsrDfn2Val()) ? "Y" : mpCodeVO.getUsrDfn2Val();
				Long mpRefundAddUsePnt = 0L;
				SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
				mpSO.setOrdNo(claimBase.getOrdNo());
				SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
				
				if("N".equals(mpReCalculateYn)) {
					if(refundPayAmt > 0 && mpVO != null && mpVO.getRmnAddUsePnt() > 0) {
						if(refundPayAmt > mpVO.getRmnAddUsePnt()) {
							refundPayAmt -= mpVO.getRmnAddUsePnt();
							mpRefundAddUsePnt = mpVO.getRmnAddUsePnt();
						}else {
							mpRefundAddUsePnt = refundPayAmt;
							refundPayAmt = 0L;
						}
					}
				}
				/* MP 포인트 재계산 사용여부 체크 - N End */
				
				
				log.debug(">>>>>>>>>>>>>>>환불금액=" + refundPayAmt);
				
				//--------------------------------------
				// 2021.05.10, ssmvf01, 취소시 환불 금액이 마이너스인 경우 payBase에 클레임, 입금으로 처리
				//--------------------------------------
				if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd()) && refundPayAmt < 0) {
					PayBasePO minusPo = new PayBasePO();
					minusPo.setPayNo(bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ));
					minusPo.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
					minusPo.setOrdNo(claimBase.getOrdNo());
					minusPo.setClmNo(claimBase.getClmNo());
					minusPo.setPayGbCd(CommonConstants.PAY_GB_30);
					minusPo.setPayMeansCd(CommonConstants.PAY_MEANS_30);	// payMeasnCd: 가상계좌
					minusPo.setPayStatCd(CommonConstants.PAY_STAT_00);
					minusPo.setPayAmt(refundPayAmt*-1);
					minusPo.setCncYn(CommonConstants.COMM_YN_N);
					
					payBaseDao.insertPayBase(minusPo);
				}
				
				/**********************************
				 * 환불 데이터 생성
				 **********************************/
				
				//----------------------------------------
				// 결제 정보로 부터 환불데이터 생성
				//----------------------------------------
				if(payBaseList != null && !payBaseList.isEmpty()){

					Long payAmt;
					
					for(PayBaseVO payBase : payBaseList){

						/*
						 * 취소 가능금액 계산
						 */
						payAmt = payBase.getPayAmt() - payBase.getRefundAmt();

						/* MP 포인트 재계산 사용여부 체크 - N Start */
						if(mpVO != null && CommonConstants.PAY_MEANS_81.equals(payBase.getPayMeansCd())) {
							payAmt = payAmt - (mpVO.getAddUsePnt() == null ? 0L : mpVO.getAddUsePnt());
						}
						
						/* MP 포인트 재계산 사용여부 체크 - N End */
						if(refundPayAmt > 0 && payAmt > 0
								&& (CommonConstants.PAY_STAT_01.equals(payBase.getPayStatCd()) || CommonConstants.PAY_GB_30.equals(payBase.getPayGbCd()))){  //PAY_GB_30 의 경우 입금 여부 상관 없음
							
							/*
							 * 결제 완료인 건에 대해서만 처리
							 */
							payBasePO = new PayBasePO();
							Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);
							payBasePO.setPayNo(payNo);
							payBasePO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
							payBasePO.setOrdNo(payBase.getOrdNo());
							payBasePO.setClmNo(clmNo);
							if(CommonConstants.PAY_GB_10.equals(payBase.getPayGbCd())) {
								payBasePO.setPayGbCd(CommonConstants.PAY_GB_20);
							}else{
								payBasePO.setPayGbCd(CommonConstants.PAY_GB_40);
							}
							payBasePO.setPayMeansCd(payBase.getPayMeansCd());
							payBasePO.setPayStatCd(CommonConstants.PAY_STAT_00);
							payBasePO.setOrgPayNo(payBase.getPayNo());
							payBasePO.setCncYn(CommonConstants.COMM_YN_N);
							payBasePO.setStrId(payBase.getStrId());
							payBasePO.setBankCd(bankCd);
							payBasePO.setAcctNo(acctNo);
							payBasePO.setOoaNm(ooaNm);
												
							if(refundPayAmt > payAmt){
								payBasePO.setPayAmt(payAmt);
								refundPayAmt -= payAmt;
							}else{
								payBasePO.setPayAmt(refundPayAmt);
								refundPayAmt -= refundPayAmt;
							}
							log.debug(">>>>>>>>>>>>>>>환불금액2=" + refundPayAmt);
							payBasePoList.add(payBasePO);
						}
					
					}	// for payBaseList
					
					if(refundPayAmt > 0){
						throw new CustomException(ExceptionConstants.ERROR_PAY_AMT_LESS);
					}
				}
				
				/* MP 포인트 재계산 사용여부 체크 - N Start */
				
				if(mpRefundAddUsePnt > 0) {
					boolean isMpRefund = false;
					for(PayBasePO payBase : payBasePoList){
						if(CommonConstants.PAY_MEANS_81.equals(payBase.getPayMeansCd())) {
							isMpRefund = true;
							payBase.setPayAmt(payBase.getPayAmt() + mpRefundAddUsePnt);
						}
					}
					
					if(!isMpRefund) {
						pbso = new PayBaseSO();
						pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
						pbso.setOrdNo(claimBase.getOrdNo());
						pbso.setCncYn(CommonConstants.COMM_YN_N);
						pbso.setPayMeansCd(CommonConstants.PAY_MEANS_81);
						
						PayBaseVO pbVO = this.payBaseDao.getPayBase(pbso);
						
						payBasePO = new PayBasePO();
						Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);
						payBasePO.setPayNo(payNo);
						payBasePO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
						payBasePO.setOrdNo(pbVO.getOrdNo());
						payBasePO.setClmNo(clmNo);
						if(CommonConstants.PAY_GB_10.equals(pbVO.getPayGbCd())) {
							payBasePO.setPayGbCd(CommonConstants.PAY_GB_20);
						}else{
							payBasePO.setPayGbCd(CommonConstants.PAY_GB_40);
						}
						payBasePO.setPayMeansCd(pbVO.getPayMeansCd());
						payBasePO.setPayStatCd(CommonConstants.PAY_STAT_00);
						payBasePO.setOrgPayNo(pbVO.getPayNo());
						payBasePO.setCncYn(CommonConstants.COMM_YN_N);
						payBasePO.setStrId(pbVO.getStrId());
						payBasePO.setBankCd(bankCd);
						payBasePO.setAcctNo(acctNo);
						payBasePO.setOoaNm(ooaNm);
						payBasePO.setPayAmt(mpRefundAddUsePnt);
						log.debug(">>>>>>>>>>>>>>>환불금액 MP=" + refundPayAmt);
						payBasePoList.add(payBasePO);
					}
				}
				/* MP 포인트 재계산 사용여부 체크 - N End */
			}	// 주문완료시 환불데이터 생성


			/**********************************
			 * 환불데이터 저장
			 **********************************/
			if(payBasePoList != null && !payBasePoList.isEmpty()){
				for(PayBasePO pbpo : payBasePoList){
					int result = this.payBaseDao.insertPayBase(pbpo);
					
					if(result != 1){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

		}
		
	}
	
	
	/*
	 * 결제 환불 예정 목록 조회
	 * @see biz.app.pay.service.PayBaseService#listPayBaseRefundExpect(java.lang.String, java.lang.Long)
	 */
	@Override
	public List<PayBasePO> listPayBaseRefundExpect(String ordNo, Long refundAmt) {
		List<PayBasePO> resultList = new ArrayList<>();
		PayBasePO result = null;
		
		//----------------------------------------
		// 주문의 결제 정보 조회
		//----------------------------------------
		PayBaseSO pbso = new PayBaseSO();
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
		pbso.setOrdNo(ordNo);
		pbso.setCncYn(CommonConstants.COMM_YN_N);
		
		List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);
		
		//----------------------------------------
		// 결제 정보로 부터 환불데이터 생성
		//----------------------------------------
		if(payBaseList != null && !payBaseList.isEmpty()){

			Long payAmt;
			
			for(PayBaseVO payBase : payBaseList){
				
				/*
				 * 결제 완료인 건에 대해서만 처리
				 */
				if(CommonConstants.PAY_STAT_01.equals(payBase.getPayStatCd())){
					result = new PayBasePO();
					result.setPayMeansCd(payBase.getPayMeansCd());
					
					/*
					 * 취소 금액
					 */
					payAmt = payBase.getPayAmt() - payBase.getRefundAmt();
				
					if(refundAmt > payAmt){
						result.setPayAmt(payAmt);
						refundAmt -= payAmt;
					}else{
						result.setPayAmt(refundAmt);
						refundAmt -= refundAmt;
					}
					resultList.add(result);
				}
			}	// for payBaseList
		}

		return resultList;
	}

	/* 
	 * 결제 환불 취소
	 * @see biz.app.pay.service.PayBaseService#cancelPayBaseRefund(java.lang.String)
	 */
	@Override
	public void cancelPayBaseRefund(String clmNo) {
		
		/**********************************
		 * 결제 환불 데이터 조회
		 **********************************/
		PayBaseSO pbso = new PayBaseSO();
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
		pbso.setClmNo(clmNo);
		List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);

		/**********************************
		 * 결제 환불 취소 처리
		 * - 현금 환급건이 존재하는 경우 취소 처리
		 ***********************************/
		if(payBaseList != null && !payBaseList.isEmpty()){
			for(PayBaseVO payBase : payBaseList){
				
				/*
				 * 결제 구분이 환불일 경우
				 */
				if(CommonConstants.PAY_GB_20.equals(payBase.getPayGbCd())){
					/*
					 * 결제정보 취소 처리 
					 */
					PayBasePO pbpo = new PayBasePO();
					pbpo.setPayNo(payBase.getPayNo());
					this.payBaseDao.updatePayBaseCancel(pbpo);

				/*
				 * 결제 구분이 결제일 경우
				 * - 추가 결제 금액이 존재할 수 있으므로 수단에 따른 취소 처리(신용카드 결제만 존재)
				 */
				}else if(CommonConstants.PAY_GB_10.equals(payBase.getPayGbCd())
						&& CommonConstants.PAY_MEANS_10.equals(payBase.getPayMeansCd())){
					PayBasePO pbpo = new PayBasePO();
					Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);
					pbpo.setPayNo(payNo);
					pbpo.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
					pbpo.setOrdNo(payBase.getOrdNo());
					pbpo.setClmNo(clmNo);
					pbpo.setPayGbCd(CommonConstants.PAY_GB_20);
					pbpo.setPayMeansCd(payBase.getPayMeansCd());
					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setOrgPayNo(payBase.getPayNo());
					pbpo.setPayAmt(payBase.getPayAmt());
					pbpo.setStrId(payBase.getStrId());

					/*
					 * 결제 취소 처리
					 */
//					INIPayCancel cancelDto = this.iniPayService.cancel(payBase.getStrId(), payBase.getDealNo(), INIPayConstants.CACNEL_REASON_CODE_1, "결제취소");
//
//					log.debug(">>>>>>>>>>>>>>>>>>>취소결과="+cancelDto.toString());
//					// 취소 성공
//					if(INIPayConstants.CANCEL_RETURN_SUCCESS_RESULT_CODE.equals(cancelDto.getResultCode())){
//						pbpo.setCfmRstCd(cancelDto.getResultCode());
//						pbpo.setCfmRstMsg(cancelDto.getResultMsg());
//						pbpo.setCfmDtm(DateUtil.getTimestamp(cancelDto.getCancelDate() + cancelDto.getCancelTime(), "yyyyMMddHHmmss"));
//						pbpo.setPayCpltDtm(DateUtil.getTimestamp(cancelDto.getCancelDate() + cancelDto.getCancelTime(), "yyyyMMddHHmmss"));
//						
//						/*
//						 * 결제 취소 정보 반영
//						 */
//						this.payBaseDao.insertPayBase(pbpo);
//					// 취소 실패
//					}else{
//						// 기 취소된 경우 Pass
//						if(cancelDto.getResultMsg().indexOf(INIPayConstants.CARD_MSG_CODE_ALREADY_CANCEL) > -1){
//							pbpo.setCfmRstCd(cancelDto.getResultCode());
//							pbpo.setCfmRstMsg(cancelDto.getResultMsg());
//							pbpo.setCfmDtm(DateUtil.getTimestamp());
//							pbpo.setPayCpltDtm(DateUtil.getTimestamp());
//							
//							/*
//							 * 결제 취소 정보 반영
//							 */
//							this.payBaseDao.insertPayBase(pbpo);
//						}else{
//							throw new CustomException(ExceptionConstants.ERROR_ORDER_PAY_APPROVE_FAIL);
//						}
//					}

				}
			}
			
		}
		
	}

	/* 
	 * 결제 환불 완료
	 * @see biz.app.pay.service.PayBaseService#completePayBaseRefund(java.lang.String)
	 */
	@Override
	public void completePayBaseRefund(String clmNo) {

		PayBaseSO pbso = null;
		PayCashRefundPO pcrpo = null;
		
		/****************************
		 * 클레임 정보 조회
		 *****************************/
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);
		
		if(claimBase == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		/****************************
		 * 주문 정보 조회
		 *****************************/
		OrderBaseSO obso = new OrderBaseSO();
		obso.setOrdNo(claimBase.getOrdNo());
		OrderBaseVO orderBase = this.orderBaseDao.getOrderBase(obso);

		if(orderBase == null){
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		/********************************
		 * 클레임 결제 정보 조회
		 *********************************/
		pbso = new PayBaseSO();
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
		pbso.setClmNo(clmNo);
		pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
		List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);

		
		/**********************************
		 * 결제(환불) 데이터 처리 
		 * -결제 수단별 처리 로직 포함
		 **********************************/
		boolean cashReceiptCancel = false;	//	현금영수증 환불
		Long	cashReceiptCancelAmt = 0L;	// 	현금영수증 취소 금액
		
		// 마이너스 환불로 인한 입금 금액 확인
		PayBaseSO pso = new PayBaseSO();
		pso.setOrdNo(claimBase.getOrdNo());
		String[] payGbCds = {CommonConstants.PAY_GB_30, CommonConstants.PAY_GB_40};
		pso.setPayGbCds(payGbCds);
		pso.setPayStatCd(CommonConstants.PAY_STAT_01);
		List<PayBaseVO> paidGb30List = this.payBaseDao.listPayBase(pso);
		Long padiGb30Amt = 0L;
		for(PayBaseVO pbvo : paidGb30List){
			if(CommonConstants.PAY_GB_30.equals(pbvo.getPayGbCd())) {	// 입금(마이너스 환불)
				padiGb30Amt += pbvo.getPayAmt();
			}else {														// 환불(마이너스 환불)
				padiGb30Amt -= pbvo.getPayAmt();
			}
		}
		
		if(payBaseList != null && !payBaseList.isEmpty()){
			for(PayBaseVO payBase : payBaseList){
				
				//0원 결제 제외하고 환불(마이너스 환불) 인경우 마이너스 환불로 인한 입금액 모자란 경우 제외
				if(!CommonConstants.PAY_MEANS_00.equals(payBase.getPayMeansCd()) 
						&& ( !CommonConstants.PAY_GB_40.equals(payBase.getPayGbCd()) || padiGb30Amt > 0 )
						&& payBase.getOrgPayNo()!=null) {
					PayBasePO pbpo = new PayBasePO();
					pbpo.setPayNo(payBase.getPayNo());	
					
					//---------------------------------------
					// 원 결제 정보 조회
					//---------------------------------------
					pbso = new PayBaseSO();
					pbso.setPayNo(payBase.getOrgPayNo());
					PayBaseVO orgPayBase = this.payBaseDao.getPayBase(pbso);
					
					CashReceiptSO cashReceiptSO = new CashReceiptSO();
					cashReceiptSO.setOrdNo(payBase.getOrdNo());
					
					if(CommonConstants.PAY_MEANS_80.equals(payBase.getPayMeansCd())) {
						//GS 포인트 환불
						if (payBase.getPayAmt() != null && payBase.getPayAmt().intValue() > 0) {
							
							Long calcelPnt = orgPayBase.getPayRmnAmt();
							if(calcelPnt > 0) {
								GsrMemberPointPO pntPO = new GsrMemberPointPO();
								pntPO.setPntRsnCd(CommonConstants.PNT_RSN_ORDER);
								pntPO.setMbrNo(claimBase.getMbrNo());
								pntPO.setRcptNo(payBase.getClmNo());
								//전체 취소
								pntPO.setPoint(Optional.ofNullable(calcelPnt).orElse(0L).toString());
								pntPO.setSaleDate(payBase.getSysRegDtm() == null ? null : DateUtil.getTimestampToString(payBase.getSysRegDtm()));
								pntPO.setSaleEndDt(payBase.getSysRegDtm() == null ? null : DateUtil.getTimestampToString(payBase.getSysRegDtm(), "HHmmss"));
								pntPO.setOrgApprNo(Optional.ofNullable(orgPayBase.getDealNo()).orElseGet(()->""));
								pntPO.setOrgApprDate(orgPayBase.getCfmDtm() == null ? null : DateUtil.getTimestampToString(orgPayBase.getCfmDtm(), "yyyyMMdd"));

								//포인트 환불 로직
								GsrMemberPointVO pntVO = gsrService.useCancelGsPoint(pntPO);
								if(StringUtil.isNotEmpty( Optional.ofNullable(pntVO.getApprNo()).orElseGet(()->""))){
									pbpo.setDealNo(pntVO.getApprNo());
									pbpo.setCfmNo(pntVO.getApprNo());
									pbpo.setCfmDtm(payBase.getSysRegDtm());
									pbpo.setCfmRstMsg(pntVO.getResultMessage());

									//포인트 환불
									this.payBaseDao.updatePayBaseRefundComplete(pbpo);

									// 포인트 전체 취소 이력 저장
									OrdSavePntSO pntRfndSO = new OrdSavePntSO();
									pntRfndSO.setOrdNo(claimBase.getOrdNo());
									pntRfndSO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_30);
									pntRfndSO.setDealGbCd(CommonConstants.DEAL_GB_10);
									pntRfndSO.setOrgGsPntHistNoIsNull(true);
									GsPntHistVO sphvo = ordSavePntDao.getSavePntHist(pntRfndSO);
									OrdSavePntPO pntRfndPO = new OrdSavePntPO();
									pntRfndPO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_20); // 취소
									pntRfndPO.setDealGbCd(CommonConstants.DEAL_GB_20);		  // 결제 취소
									pntRfndPO.setMbrNo(orderBase.getMbrNo());
									// 이전 포인트 사용 이력이 없으면 넣지 말것.
									if (sphvo != null) {
										pntRfndPO.setGspntNo(sphvo.getGspntNo());
										pntRfndPO.setOrgGsPntHistNo(sphvo.getGsPntHstNo());
										pntRfndPO.setPayAmt(sphvo.getPayAmt());
									}
									pntRfndPO.setPnt(calcelPnt.intValue());
									pntRfndPO.setDealNo(pntVO.getApprNo());
									pntRfndPO.setOrdNo(claimBase.getOrdNo());
									pntRfndPO.setClmNo(clmNo);
									pntRfndPO.setDealDtm(payBase.getSysRegDtm());
									pntRfndPO.setSysRegrNo(orderBase.getMbrNo());
									ordSavePntDao.insertGsPntHist(pntRfndPO);

									Long reUsePnt = calcelPnt - payBase.getPayAmt();
									//포인트 전체 취소가 아닌경우
									if(reUsePnt > 0) {
										GsrMemberPointPO gmppo = new GsrMemberPointPO();
										Date today = new Date();

										SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
										SimpleDateFormat time = new SimpleDateFormat("hhmmss");

										gmppo.setRcptNo(payBase.getClmNo());
										gmppo.setMbrNo(orderBase.getMbrNo());
										gmppo.setSaleAmt(Long.toString(payBase.getPayAmt()));
										gmppo.setPoint(Long.toString(reUsePnt));
										gmppo.setSaleDate(date.format(today));
										gmppo.setSaleEndDt(time.format(today));

										GsrMemberPointVO result = gsrService.useGsPoint(gmppo);
										if(StringUtil.isNotEmpty(Optional.ofNullable(result.getApprNo()).orElseGet(()->""))){
											pbpo.setDealNo(result.getApprNo());
											pbpo.setCfmNo(result.getApprNo());
											pbpo.setCfmDtm(payBase.getSysRegDtm());
											pbpo.setCfmRstMsg(result.getResultMessage());
											pbpo.setPayNo(orgPayBase.getPayNo());

											//기존 결제 포인트 업데이트
											this.payBaseDao.updatePayBaseComplete(pbpo);

											// 포인트 재결제 이력 저장
											OrdSavePntPO pntRusePO = new OrdSavePntPO();
											pntRusePO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_30); 	// 사용
											pntRusePO.setDealGbCd(CommonConstants.DEAL_GB_10);			// 결제
											pntRusePO.setMbrNo(orderBase.getMbrNo());
											pntRusePO.setGspntNo(sphvo.getGspntNo());
											pntRusePO.setOrgGsPntHistNo(sphvo.getGsPntHstNo());
											pntRusePO.setPayAmt(sphvo.getPayAmt());
											pntRusePO.setPnt(reUsePnt.intValue());
											pntRusePO.setDealNo(result.getApprNo());
											pntRusePO.setOrdNo(claimBase.getOrdNo());
											pntRusePO.setClmNo(clmNo);
											pntRusePO.setSysRegrNo(orderBase.getMbrNo());
											pntRusePO.setDealDtm(payBase.getSysRegDtm());
											ordSavePntDao.insertGsPntHist(pntRusePO);
										}else{
											pbpo.setDealNo(null);
											pbpo.setCfmNo(null);
											pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);
											pbpo.setCfmDtm(new Timestamp(today.getTime()));

											pbpo.setCfmRstMsg("환불 처리 후, 포인트 재사용 요청 실패");
											pbpo.setCfmRstCd(result.getResultCode());

											pbpo.setPayNo(payBase.getPayNo());

											//TO-DO::PAY_BASE 어떻게 update를 쳐야하나,,
										}
									}
								}else{
									pbpo.setDealNo(null);
									pbpo.setCfmNo(null);
									pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);
									pbpo.setCfmDtm(DateUtil.getTimestamp());

									pbpo.setCfmRstMsg("환불처리 전 전체 취소, 포인트 사용 취소 요청 실패");
									pbpo.setCfmRstCd(pntVO.getResultCode());

									pbpo.setPayNo(payBase.getPayNo());

									int payResult = this.payBaseDao.updatePayBaseComplete(pbpo);
								}
							}
						}
					}else if(CommonConstants.PAY_MEANS_81.equals(payBase.getPayMeansCd())) {
						//MP 포인트 환불은 claimService.excutePntProcess 추후 처리.
					}else{
						String midGb = "";
						
						CancelProcessReqVO reqVO = new CancelProcessReqVO();
						
						//간편결제 - MID_GB_SIMPLE
						if(CommonConstants.PAY_MEANS_70.equals(payBase.getPayMeansCd())
								|| CommonConstants.PAY_MEANS_71.equals(payBase.getPayMeansCd())
								|| CommonConstants.PAY_MEANS_72.equals(payBase.getPayMeansCd())
								) {
							midGb = NicePayConstants.MID_GB_SIMPLE;
						}else if(CommonConstants.PAY_MEANS_11.equals(payBase.getPayMeansCd())){
							//빌링 결제
							midGb = NicePayConstants.MID_GB_BILLING;
						}else {
							//신용카드, 실시간계좌이체, 가상계좌 - MID_GB_CERTIFY
							midGb = NicePayConstants.MID_GB_CERTIFY;
						}
						
						//원래 주문 거래번호
						reqVO.setTID(orgPayBase.getDealNo());
						reqVO.setMoid(payBase.getClmNo());
						reqVO.setCancelAmt(Optional.ofNullable(payBase.getPayAmt()).orElse(0L).toString());
						if(orgPayBase.getPayAmt().equals(payBase.getPayAmt())){
							reqVO.setPartialCancelCode(NicePayConstants.PART_CANCEL_CODE_0);
						}else {
							reqVO.setPartialCancelCode(NicePayConstants.PART_CANCEL_CODE_1);
						}
						
						//가상계좌 환불계좌
						if(CommonConstants.PAY_MEANS_30.equals(payBase.getPayMeansCd())) {
							reqVO.setRefundAcctNo(payBase.getAcctNo());
							reqVO.setRefundBankCd(payBase.getBankCd());
							reqVO.setRefundAcctNm(payBase.getOoaNm());
						}
						
						reqVO.setCancelMsg(NicePayConstants.CANCEL_MSG_REFUND);
						
						CancelProcessResVO resVO = nicePayCommonService.reqCancelProcess(reqVO, midGb, NicePayCodeMapping.getMappingToNiceCode(CommonConstants.PAY_MEANS, payBase.getPayMeansCd()), NicePayConstants.MDA_GB_01);
						
						if(NicePayConstants.CANCEL_PROCESS_SUCCESS_CODE.equals(resVO.getResultCode()) || NicePayConstants.VIRTUAL_CANCEL_PROCESS_SUCCESS_CODE.equals(resVO.getResultCode())) {
							pbpo.setStrId(orgPayBase.getStrId());
							pbpo.setCfmRstCd(resVO.getResultCode());
							pbpo.setCfmRstMsg(resVO.getResultMsg());
							pbpo.setCfmNo(resVO.getCancelNum());
							pbpo.setCfmDtm(DateUtil.getTimestamp(resVO.getCancelDate() + resVO.getCancelTime(), "yyyyMMddHHmmss"));
							pbpo.setLnkRspsRst(resVO.getResponseBody());
							
							this.payBaseDao.updatePayBaseRefundComplete(pbpo);
							
							//---------------------------------------
							// 현금영수증 처리 관련 설정
							//---------------------------------------
							if(CommonConstants.PAY_MEANS_20.equals(payBase.getPayMeansCd()) || CommonConstants.PAY_MEANS_30.equals(payBase.getPayMeansCd())){
								cashReceiptCancel = true;
								cashReceiptCancelAmt = payBase.getPayAmt();
							}
							

							// 마이너스 환불로 인한 입금 금액 계산
							padiGb30Amt -= payBase.getPayAmt();
						}else {
							//PG 환불 오류
							pbpo.setStrId(orgPayBase.getStrId());
							pbpo.setCfmRstCd(resVO.getResultCode());
							pbpo.setCfmRstMsg(resVO.getResultMsg());
							pbpo.setCfmNo(resVO.getCancelNum());
							//pbpo.setCfmDtm(DateUtil.getTimestamp(resVO.getCancelDate() + resVO.getCancelTime(), "yyyyMMddHHmmss"));
							pbpo.setLnkRspsRst(resVO.getResponseBody());
							
							this.payBaseDao.updatePayBaseRefundError(pbpo);
						}
					}   
				}
			}	//for payBaseList
		}	//if payBaseList
		
		/*************************************************************
		 * 주문접수 상태에서 주문취소가 된경우 현금영수증 취소 처리
		 * - 주문접수시에는 결제정보가 대기 상태이므로 결제대기에 대한 결제취소 정보가 존재하지 않으므로 현금영수증 재발급 로직을 실행하지 않음
		 * - 위와 같은 사유로 주문접수시의 취소에 대해서 현금영수증 재발금 처리가 가능하도록 처리
		 *************************************************************/
		
		/*
		 * 조건이 틀려 수정 (주문접수/주문완료 모두 취소 가능해야 함)
		if(CommonConstants.ORD_STAT_10.equals(orderBase.getOrdStatCd())){
			cashReceiptCancel = true;
		}*/
		
		/**********************************
		 * 현금영수증 재발급
		 **********************************/
		if(cashReceiptCancel){
			
			CashReceiptPO crpo = null;
			Long cashRctNo = null;
			
			//---------------------------------------
			// 기 발급된 현금 영수증 조회 
			//---------------------------------------
			CashReceiptSO crso = new CashReceiptSO();
			crso.setOrdNo(claimBase.getOrdNo());
			CashReceiptVO cashReceipt =  this.cashReceiptDao.getCashReceipt(crso);

			//---------------------------------------
			// 기 발금된 현금 영수증 취소
			//---------------------------------------
			if(cashReceipt != null){
				if(CommonConstants.CASH_RCT_STAT_10.equals(cashReceipt.getCashRctStatCd())){
					/********************************
					 * 기 발행상태가 접수일경우 취소
					 ********************************/
					crpo = new CashReceiptPO();
					crpo.setCrTpCd(CommonConstants.CR_TP_20);
					crpo.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_30);
					crpo.setCashRctNo(cashReceipt.getCashRctNo());
					int cashReceiptResult = this.cashReceiptDao.updateCashReceipt(crpo);
					
					if(cashReceiptResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				
				}else if(CommonConstants.CASH_RCT_STAT_20.equals(cashReceipt.getCashRctStatCd())){
					/***************************************
					 * 기 발행상태가 발행일 경우 발행 취소
					 ***************************************/
					
					//---------------------------------------
					// 수동신청+가상계좌 or 실시간 계좌이체 인 경우 수동 취소
					//---------------------------------------
					CancelProcessReqVO cancelVO = null;
					if("20".equals(cashReceipt.getIsuGbCd()) 
							&& (CommonConstants.PAY_MEANS_20.equals(payBaseList.get(0).getPayMeansCd()) || CommonConstants.PAY_MEANS_30.equals(payBaseList.get(0).getPayMeansCd()))) {
						cancelVO = nicePayCashReceiptService.setCancelCashReceipt(claimBase.getOrdNo());
					}
					//---------------------------------------
					// 현금영수증 데이터 생성 및 저장
					//---------------------------------------
					if(cancelVO != null) { //현금영수증 수동 API 취소한 경우
						cancelVO.setPayMeansCd(payBaseList.get(0).getPayMeansCd());
						CancelProcessResVO cancelRes = nicePayCommonService.reqCancelProcess(cancelVO, NicePayConstants.MID_GB_CERTIFY, cancelVO.getPayMeansCd(), NicePayConstants.MDA_GB_01);
						cashReceiptService.insertCancelCashReceipt(cancelRes, claimBase.getOrdNo(), clmNo);
					} else {
						crpo = new CashReceiptPO();
						cashRctNo = this.bizService.getSequence(CommonConstants.SEQUENCE_CASH_RCT_NO_SEQ);
						crpo.setCashRctNo(cashRctNo);
						crpo.setOrgCashRctNo(cashReceipt.getCashRctNo());
						crpo.setCrTpCd(CommonConstants.CR_TP_20);
						crpo.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_10);
						crpo.setUseGbCd(cashReceipt.getUseGbCd());
						crpo.setPayAmt(cashReceipt.getPayAmt());
						crpo.setSplAmt(cashReceipt.getSplAmt());
						crpo.setStaxAmt(cashReceipt.getStaxAmt());
						crpo.setSrvcAmt(cashReceipt.getSrvcAmt());
						crpo.setIsuGbCd(cashReceipt.getIsuGbCd());
						crpo.setIsuMeansCd(cashReceipt.getIsuMeansCd());
						crpo.setIsuMeansNo(cashReceipt.getIsuMeansNo());
						crpo.setLnkDealNo(cashReceipt.getLnkDealNo());
						crpo.setStrId(cashReceipt.getStrId());
	
						int cashReceiptResult = this.cashReceiptDao.insertCashReceipt(crpo);
	
						if(cashReceiptResult == 0){
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
	
						//---------------------------------------
						// 클레임 상세 목록 정보 조회
						//---------------------------------------
						ClaimDetailSO cdso = new ClaimDetailSO();
						cdso.setClmNo(clmNo);
						List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);
						
						if(claimDetailList == null || claimDetailList.isEmpty()){
							throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
						}
	
						//---------------------------------------
						// 현금영수증 상품매핑테이블 데이터 생성 및 저장
						//---------------------------------------
						CashReceiptGoodsMapPO crgmpo = null;
						
						for(ClaimDetailVO cdvo : claimDetailList){
							crgmpo = new CashReceiptGoodsMapPO();
							crgmpo.setCashRctNo(cashRctNo);
							crgmpo.setOrdClmNo(cdvo.getClmNo());
							crgmpo.setOrdClmDtlSeq(cdvo.getClmDtlSeq());
							crgmpo.setAplQty(cdvo.getClmQty());
							
							int cashReceiptGoodsMapResult = this.cashReceiptDao.insertCashReceiptGoodsMap(crgmpo);
	
							if(cashReceiptGoodsMapResult == 0){
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
	
						}
					}
				
				}

				//---------------------------------------------------------------------------------------------------------
				// 기 발급된 현금 영수증 금액에서 취소 금액을 제외한 나머지 금액이 존재할 경우 재발행
				//---------------------------------------------------------------------------------------------------------
				if(cashReceiptCancelAmt < cashReceipt.getPayAmt()){
					crpo = new CashReceiptPO();
					cashRctNo = this.bizService.getSequence(CommonConstants.SEQUENCE_CASH_RCT_NO_SEQ);
					crpo.setCashRctNo(cashRctNo);
					crpo.setCrTpCd(CommonConstants.CR_TP_10);
					crpo.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_10);
					crpo.setUseGbCd(cashReceipt.getUseGbCd());
					crpo.setStrId(cashReceipt.getStrId());
					
					// 금액 계산
					// 현재 과세상품만 존재하므로 결제금액(상품금액+배송비)에 대해 부가세 계산하여 처리
					Long payAmt = cashReceipt.getPayAmt() - cashReceiptCancelAmt;
					Long staxAmt = Math.round(payAmt.doubleValue() / 1.1 * 0.1);
					Long splAmt = payAmt - staxAmt;
					Long srvcAmt = 0L;

					crpo.setPayAmt(payAmt);
					crpo.setSplAmt(splAmt);
					crpo.setStaxAmt(staxAmt);
					crpo.setSrvcAmt(srvcAmt);
					crpo.setIsuGbCd(cashReceipt.getIsuGbCd());
					crpo.setIsuMeansCd(cashReceipt.getIsuMeansCd());
					crpo.setIsuMeansNo(cashReceipt.getIsuMeansNo());
					
					/*
					 * 주문 상세 목록 조회
					 */
					OrderDetailSO odso = new OrderDetailSO();
					odso.setOrdNo(claimBase.getOrdNo());
					List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);
					
					// 수동신청건 부분취소일 경우 전체 취소 후 부분 현금영수증 신청 
					if("20".equals(cashReceipt.getIsuGbCd()) 
							&& (CommonConstants.PAY_MEANS_20.equals(payBaseList.get(0).getPayMeansCd()) || CommonConstants.PAY_MEANS_30.equals(payBaseList.get(0).getPayMeansCd()))) {
						CashReceiptReqVO reqVO = new CashReceiptReqVO();
						
						CashReceiptSO cashReceiptSO = new CashReceiptSO();
						cashReceiptSO.setOrdNo(claimBase.getOrdNo());
						CashReceiptVO reqData = cashReceiptService.getCashReceipt(cashReceiptSO);
						
						reqVO.setMoid(claimBase.getOrdNo());
						reqVO.setReceiptAmt(payAmt.toString());
						reqVO.setGoodsName(orderDetailList.get(0).getGoodsNm());
						reqVO.setReceiptType("10".equals(reqData.getUseGbCd()) ? "1" : "2" );
						reqVO.setReceiptTypeNo(reqData.getIsuMeansNo());
						reqVO.setReceiptSupplyAmt(splAmt.toString());
						reqVO.setReceiptVAT(staxAmt.toString());
						
						CashReceiptResVO res =  nicePayCashReceiptService.reqCashReceipt(reqVO);
						
						crpo.setLnkDealNo(res.getTID());
						crpo.setLnkRstMsg(res.toString());
						crpo.setCfmRstCd(res.getResultCode());
						crpo.setCfmRstMsg(res.getResultMsg());
						try {
							SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
							SimpleDateFormat orgFormat = new SimpleDateFormat("yyMMddhhmmss");
							Date parsedDate = orgFormat.parse(res.getAuthDate());
							Date autoDate = dateFormat.parse(dateFormat.format(parsedDate));
							crpo.setLnkDtm(new java.sql.Timestamp(autoDate.getTime()));
						} catch (ParseException e) {
							throw new CustomException(ExceptionConstants.ERROR_DATA_PARSE_FAIL);
						}
					}

					// 현금영수증 저장
					int cashReceiptResult = this.cashReceiptDao.insertCashReceipt(crpo);

					if(cashReceiptResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					
					
					/*
					 * 현금영수증 상품매핑테이블 저장
					 */
					CashReceiptGoodsMapPO crgmpo = null;
					
					for(OrderDetailVO odvo : orderDetailList){
						if(odvo.getRmnOrdQty() - odvo.getRtnQty() > 0){
							crgmpo = new CashReceiptGoodsMapPO();
							crgmpo.setCashRctNo(cashRctNo);
							crgmpo.setOrdClmNo(odvo.getOrdNo());
							crgmpo.setOrdClmDtlSeq(odvo.getOrdDtlSeq());
							crgmpo.setAplQty(odvo.getRmnOrdQty() - odvo.getRtnQty());
							int cashReceiptGoodsMapResult = this.cashReceiptDao.insertCashReceiptGoodsMap(crgmpo);
	
							if(cashReceiptGoodsMapResult == 0){
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
						}
					}
				}
			}
			
		}	//현금영수증 재발급
		
		
		/*****************************
		 * 이메일 및 LMS전송
		 *****************************/
		this.paySendService.sendRefundComplete(clmNo);
		
	}

	@Override
	public PayBaseVO getPayBase(PayBaseSO so) {
		return payBaseDao.getPayBase(so);
	}
	
	@Override
	public void confirmDepositInfo(PayBasePO po) {
		int result = payBaseDao.confirmDepositInfo(po);
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void insertDepositInfo(PayBasePO po) {
		
		//입금 마감 일시 +1824
		String expDtm =  DateUtil.addDay("yyyyMMddHHmmss", 1824);
		
		// 결제 정보 등록
		Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);
		po.setPayNo(payNo);
		po.setPayMeansCd(CommonConstants.PAY_MEANS_30);
		po.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
		po.setPayGbCd(CommonConstants.PAY_GB_30);
		po.setPayStatCd(CommonConstants.PAY_STAT_00);		// 결제 상태는 기본 '입금대기', 수단별 결제완료 처리
		po.setCncYn(CommonConstants.COMM_YN_N);
		po.setDpstSchdAmt(po.getPayAmt());
		po.setDpstrNm(po.getOoaNm());
		po.setDpstSchdDt(expDtm);
		FixAccountReqVO fixReqVO = new FixAccountReqVO();
		fixReqVO.setMoid(po.getClmNo());
		fixReqVO.setAmt(String.valueOf(po.getPayAmt()));
		fixReqVO.setVbankBankCode(po.getBankCd());
		fixReqVO.setVbankNum(po.getAcctNo());
		fixReqVO.setVbankAccountName(po.getOoaNm());
		fixReqVO.setVbankExpDate(expDtm.substring(0, 8));
		fixReqVO.setVbankExpTime(expDtm.substring(8));
		fixReqVO.setReceiptType(NicePayConstants.RECEIPT_TYPE_1);
		fixReqVO.setReceiptTypeNo(po.getDepositMobile());
		
		 FixAccountResVO resVO = nicePayCommonService.reqRegistFixAccount(fixReqVO);
		
		if(NicePayConstants.FIX_ACCOUNT_SUCCESS_CODE.equals(resVO.getResultCode())) {
			po.setDealNo(resVO.getTID());
			po.setCfmNo(resVO.getTID());
			po.setCfmRstCd(resVO.getResultCode());
			po.setCfmRstMsg(resVO.getResultMsg());
			po.setCfmDtm(DateUtil.getTimestamp(resVO.getAuthDate(), "yyMMddHHmmss"));
			po.setLnkRspsRst(resVO.getResponseBody());
		}else {
			log.debug("실패 RES : {}", resVO.getResponseBody());
			throw new CustomException(ExceptionConstants.ERROR_PG_FAIL);
		}
		
		int payBaseResult = this.payBaseDao.insertPayBase(po);

		if (payBaseResult != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
	}
	
	@Override
	public List<PayBaseVO> pagePayBase(PayBaseSO so){
		return payBaseDao.pagePayBase(so);
	}

	@Override
	public PayBaseVO checkOrgPayBase(PayBaseSO so) {
		return payBaseDao.checkOrgPayBase(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: insertPayIfLog
	 * - 작성일		: 2021. 05. 17.
	 * - 작성자		: sorce
	 * - 설명			: PG Log insert
	 * </pre>
	 * @param vo
	 * @return
	 */
	public Integer insertPayIfLog( PayIfLogVO vo ) {
		return payBaseDao.insertPayIfLog(vo);
	}

	@Override
	public Integer insertPayBase(PayBasePO po) {
		return payBaseDao.insertPayBase(po);
	}
}
