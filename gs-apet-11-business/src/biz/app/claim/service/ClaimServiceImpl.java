package biz.app.claim.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Properties;
import java.util.stream.Collectors;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.dao.ClaimDao;
import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.dao.ClmDtlCstrtDao;
import biz.app.claim.model.ClaimAccept;
import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimRefundPayVO;
import biz.app.claim.model.ClaimRefundVO;
import biz.app.claim.model.ClaimRefundVO.Means;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClaimRegist.ClaimSub;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClaimSummaryVO;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.counsel.dao.CounselDao;
import biz.app.counsel.model.CounselPO;
import biz.app.delivery.dao.DeliveryChargeDao;
import biz.app.delivery.dao.DeliveryChargePolicyDao;
import biz.app.delivery.model.DeliveryChargePO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;
import biz.app.delivery.service.DeliveryChargeService;
import biz.app.goods.service.GoodsStockService;
import biz.app.goods.service.ItemService;
import biz.app.member.dao.MemberCouponDao;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.service.MemberSavedMoneyService;
import biz.app.order.dao.AplBnftDao;
import biz.app.order.dao.OrdDtlCstrtDao;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.dao.OrderDlvraDao;
import biz.app.order.model.AplBnftPO;
import biz.app.order.model.AplBnftVO;
import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrdSavePntService;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderService;
import biz.app.pay.dao.PayBaseDao;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PayCashRefundPO;
import biz.app.pay.service.PayBaseService;
import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.service.CashReceiptService;
import biz.app.system.dao.LocalPostDao;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.LocalPostSO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.app.system.service.CodeService;
import biz.app.system.service.PntInfoService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.cis.model.request.order.OrderExptCreateSO;
import biz.interfaces.cis.model.response.order.OrderExptCreateVO;
import biz.interfaces.cis.service.CisOrderService;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.enums.NicePayCodeMapping;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.service.NicePayCashReceiptService;
import biz.interfaces.nicepay.service.NicePayCommonService;
import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00110ReqVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00110ResVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.claim.service
 * - 파일명		: ClaimServiceImpl.java
 * - 작성일		: 2017. 3. 6.
 * - 작성자		: snw
 * - 설명		: 클레임 서비스 Impl
 * </pre>
 */
@Slf4j
@Transactional
@Service("claimService")
public class ClaimServiceImpl implements ClaimService {

	@Autowired private ClaimBaseDao claimBaseDao;
	@Autowired private ClaimDetailDao claimDetailDao;
	@Autowired private ClaimDao claimDao;
	@Autowired private CounselDao counselDao;
	@Autowired private OrderDao orderDao;
	@Autowired private OrderBaseDao orderBaseDao;
	@Autowired private OrderDetailDao orderDetailDao;
	@Autowired private OrderDetailService orderDetailService;
	@Autowired private PayBaseDao payBaseDao;
	@Autowired private BizService bizService;
	@Autowired private ItemService itemService;
	@Autowired private PayBaseService payBaseService;
	@Autowired private OrderDlvraDao orderDlvraDao;
	@Autowired private DeliveryChargePolicyDao deliveryChargePolicyDao;
	@Autowired private DeliveryChargeDao deliveryChargeDao;
	@Autowired private CacheService cacheService;
	@Autowired private DeliveryChargeService deliveryChargeService;
	@Autowired private AplBnftDao aplBnftDao;
	@Autowired private MemberCouponDao memberCouponDao;
	@Autowired private MemberSavedMoneyService memberSavedMoneyService;
//	@Autowired private INIPayService iniPayService;
	@Autowired private LocalPostDao localPostDao;
	@Autowired private ClaimSendService claimSendService;
	@Autowired private CisOrderService cisOrderService;
	@Autowired private OrdDtlCstrtDao ordDtlCstrtDao;
	@Autowired private ClmDtlCstrtDao clmDtlCstrtDao;
	@Autowired private OrdSavePntService ordSavePntService;
	@Autowired private GoodsStockService goodsStockService;
	@Autowired private Properties webConfig;
	@Autowired private Properties bizConfig;
	@Autowired private NicePayCommonService nicePayCommonService;
	@Autowired private NicePayCashReceiptService nicePayCashReceiptService;
	@Autowired private CashReceiptService cashReceiptService;
	@Autowired private OrderService orderService;
	@Autowired private PntInfoService pntInfoService;
	@Autowired private SktmpService sktmpService;
	@Autowired private CodeService codeService;
	@Autowired private MessageSourceAccessor message;
	
	
	/*
	 * 주문 상세 단위의 클레임 접수 가능 상태 체크
	 *
	 */
	private boolean checkAcceptClaimPossibleStatus(String clmTpCd, String ordDtlStatCd) {
		boolean result = true;

		// 주문 취소일 경우
		if (CommonConstants.CLM_TP_10.equals(clmTpCd) && !CommonConstants.ORD_DTL_STAT_110.equals(ordDtlStatCd)
				&& !CommonConstants.ORD_DTL_STAT_120.equals(ordDtlStatCd)
				&& !CommonConstants.ORD_DTL_STAT_130.equals(ordDtlStatCd)
				&& !CommonConstants.ORD_DTL_STAT_140.equals(ordDtlStatCd)) {
			// 주문상세상태가 주문접수/주문완료/배송지시/상품준비중이 아닌 경우
			result = false;
		}

		// 반품/교환 일 경우
		if ((CommonConstants.CLM_TP_20.equals(clmTpCd) || CommonConstants.CLM_TP_30.equals(clmTpCd))
				&& !CommonConstants.ORD_DTL_STAT_160.equals(ordDtlStatCd)) {
			// 주문상세상태가 배송완료 아닌 경우
			// 구매확정 제외 - 2021.03.14 kjhvf01
			result = false;
		}

		return result;
	}

	
	/*
	 * 클레임 취소
	 * 
	 * @see biz.app.claim.service.ClaimService#cancelClaim(java.lang.String, java.lang.Long)
	 */
	@Override
	public void cancelClaim(String clmNo, Long cncrNo) {

		if (clmNo == null || "".equals(clmNo)) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}
		
		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 2. 클레임 상세 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);

		if (claimDetailList == null || claimDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 3. Validation
		//------------------------------------------------
		
		// 클레임 유형별 접수취소 가능 여부
		boolean cancelPsb = this.cancelClaimPossible(claimBase, claimDetailList);

		if (!cancelPsb) {
			if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())) {
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_ACCEPT_NO_CANCEL_TP_CANCEL);
			} else if (CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) {
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_ACCEPT_NO_CANCEL_TP_RETURN);
			} else if (CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd())) {
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_ACCEPT_NO_CANCEL_TP_EXCHANGE);
			}
		}

		
		//------------------------------------------------
		// 4. 배송비 취소 호출
		//------------------------------------------------
		Integer[] ordDtlSeq = new Integer[claimDetailList.size()];

		for (int i = 0; i < claimDetailList.size(); i++) {
			ordDtlSeq[i] = claimDetailList.get(i).getOrdDtlSeq();
		}
		ordDtlSeq =  Arrays.stream(ordDtlSeq).distinct().toArray(Integer[]::new);
		
		// 2021-06-04 이지연 주석 처리함. 배송비 로직 변경으로 클레임 철회 생기면 관련 작업 필요
//		this.deliveryChargeService.cancelDeliveryChargeRefund(clmNo, claimBase.getOrdNo(), ordDtlSeq);

		
		//------------------------------------------------
		// 5. 클레임 취소 수량 주문 상세에 반영
		//------------------------------------------------
		
		// 1) 취소
		if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())) {
			// 주문상세에 반영된 취소 수량 복원
			for (ClaimDetailVO cdvo : claimDetailList) {
				OrderDetailPO odpo = new OrderDetailPO();
				odpo.setOrdNo(cdvo.getOrdNo());
				odpo.setOrdDtlSeq(cdvo.getOrdDtlSeq());
				odpo.setCncQty(cdvo.getClmQty() * -1);
				this.orderDetailDao.updateOrderDetailClaimQty(odpo);
			}
		}

		// 2) 반품
		if (CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) {

			// 주문상세에 반영된 반품 수량 복원
			for (ClaimDetailVO cdvo : claimDetailList) {
				OrderDetailPO odpo = new OrderDetailPO();
				odpo.setOrdNo(cdvo.getOrdNo());
				odpo.setOrdDtlSeq(cdvo.getOrdDtlSeq());
				odpo.setRtnQty(cdvo.getClmQty() * -1);
				this.orderDetailDao.updateOrderDetailClaimQty(odpo);
			}
		}

		
		//------------------------------------------------
		// 6. 교환 배송정보에 차감된 웹재고 복구
		//------------------------------------------------
		if (CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd())) {
			// 접수 시 차감된 교환대상 단품의 웹재고 복구
			List<ClaimDetailVO> rtnClaimDetailList = new ArrayList<>();		// 교환회수 목록

			// 클레임 상세로 부터 교환회수 목록 추출
			for (ClaimDetailVO cdvo : claimDetailList) {
				Integer clmDtlStat = Integer.valueOf(cdvo.getClmDtlStatCd());

				// 교환회수건 조회
				if (clmDtlStat > 300 && clmDtlStat < 400) {
					rtnClaimDetailList.add(cdvo);
				}
			}

			// 20210812 CSR-1575 CIS를 통해 재고수량 업데이트 후 주문 시 웹 재고 차감만 하고 취소 시는 원복 로직을 제외
			// 추출된 교환 회수목록과 동일한 주문번호/주문상세순번 재고 복구
//			for (ClaimDetailVO rtncdvo : rtnClaimDetailList) {
//
//				for (ClaimDetailVO cdvo : claimDetailList) {
//					Integer clmDtlStat = Integer.valueOf(cdvo.getClmDtlStatCd());
//
//					// 교환회수와 동일한 교환배송건 중 복구
//					if (clmDtlStat > 400 && clmDtlStat < 500 && rtncdvo.getOrdNo().equals(cdvo.getOrdNo())
//							&& rtncdvo.getOrdDtlSeq().equals(cdvo.getOrdDtlSeq())) {
//						ClaimDetailSO cstrtSO = new ClaimDetailSO();
//						cstrtSO.setClmNo(cdvo.getClmNo());
//						cstrtSO.setClmDtlSeq(cdvo.getClmDtlSeq());
//						List<ClmDtlCstrtPO> cstrtList = clmDtlCstrtDao.listClmDtlCstrt(cstrtSO);
//						for(ClmDtlCstrtPO cstrt : cstrtList) {
//							goodsStockService.updateStockQty(cstrt.getCstrtGoodsId(), cdvo.getClmQty() * cstrt.getCstrtQty());
//						}
//					}
//				}
//			}

		}

		
		//------------------------------------------------
		// 7. 결제 환불 취소 호출
		//------------------------------------------------
		this.payBaseService.cancelPayBaseRefund(clmNo);

		
		//------------------------------------------------
		// 8. 클레임 기본 상태 '취소'로 변경
		//------------------------------------------------
		ClaimBasePO cbpo = new ClaimBasePO();
		cbpo.setClmNo(clmNo);
		cbpo.setCncrNo(cncrNo);
		cbpo.setClmStatCd(CommonConstants.CLM_STAT_40);

		int claimCancelResult = this.claimBaseDao.updateClaimBase(cbpo);

		if (claimCancelResult != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}
	
	/*
	 * 수정 시 변경 필요
	 * */
	@Override
	@Deprecated 
	public void claimReactPgCancel(String clmNo, Long cncrNo) {
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
		// pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
		List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);

		
		/**********************************
		 * 결제(환불) 데이터 처리 
		 * -결제 수단별 처리 로직 포함
		 **********************************/
		boolean cashReceiptCancel = false;	//	현금영수증 환불
		Long	cashReceiptCancelAmt = 0L;	// 	현금영수증 취소 금액
		
		if(payBaseList != null && !payBaseList.isEmpty()){
			for(PayBaseVO payBase : payBaseList){
				
				//0원 결제 제외
				if(!CommonConstants.PAY_MEANS_00.equals(payBase.getPayMeansCd())
						&&payBase.getOrgPayNo()!=null) {
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
					
					if(!CommonConstants.PAY_MEANS_80.equals(payBase.getPayMeansCd())) {
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
	}
	
	/*
	 * 클레임 취소 가능 여부 체크
	 * 
	 * @see biz.app.claim.service.ClaimService#cancelClaimPossible(biz.app.claim.model.ClaimBaseVO, java.util.List)
	 */
	@Override
	public boolean cancelClaimPossible(ClaimBaseVO claimBase, List<ClaimDetailVO> claimDetailList) {
		boolean result = true;

		if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())) {
			result = false;
		}

		// --------------------------------------------------------------------------------------------
		// 클레임 유형이 반품인 경우 반품접수와 반품 회수지시인 상태까지만 가능
		// - FO : 반품접수, BO : 반품접수,반품회수지시
		// --------------------------------------------------------------------------------------------
		else if (CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) {
			// 클레임 상태가 접수 또는 진행중인 경우에만 가능
			if (!CommonConstants.CLM_STAT_10.equals(claimBase.getClmStatCd())
					&& !CommonConstants.CLM_STAT_20.equals(claimBase.getClmStatCd())) {
				result = false;
			}

			// 클레임 상세상태가 반품전수 또는 반품회수지시 인 경우에만 가능
			for (ClaimDetailVO cdvo : claimDetailList) {

				if (CommonConstants.CLM_DTL_TP_20.equals(cdvo.getClmDtlTpCd())
						&& !CommonConstants.CLM_DTL_STAT_210.equals(cdvo.getClmDtlStatCd())
						&& !CommonConstants.CLM_DTL_STAT_220.equals(cdvo.getClmDtlStatCd())) {
					result = false;
				}
			}

		}

		// ---------------------------------------------------------------------------------------------
		// 클레임 유형이 교환인 경우 교환회수접수와 교환회수지시인 상태까지만 가능
		// - FO : 교환회수접수, BO : 교환회수접수, 교환회수지시
		// --------------------------------------------------------------------------------------------
		else if (CommonConstants.CLM_TP_30.equals(claimBase.getClmTpCd())) {
			// 클레임 상태가 접수 또는 진행중인 경우에만 가능
			if (!CommonConstants.CLM_STAT_10.equals(claimBase.getClmStatCd())
					&& !CommonConstants.CLM_STAT_20.equals(claimBase.getClmStatCd())) {
				result = false;
			}

			// 맞교환 여부에 따른 취소 가능 여부 판단
			// 맞교환 : 교환회수와 교환배송에 대한 상태 체크 필요, 
			//	- 교환회수인 경우 교환회수접소 또는교환회수지시, 교환배송인경우 교환배송접수, 교환배송지시인 경우에만 가능
			// 일반 : 클레임 상세 상태가 교환회수접수 또는 교환회수지시 상태인 경우에만 가능
			for (ClaimDetailVO cdvo : claimDetailList) {

				// 맞교환인 경우
				if (CommonConstants.COMM_YN_Y.equals(claimBase.getSwapYn())) {
					if (CommonConstants.CLM_DTL_TP_30.equals(cdvo.getClmDtlTpCd())
							&& !CommonConstants.CLM_DTL_STAT_310.equals(cdvo.getClmDtlStatCd())
							&& !CommonConstants.CLM_DTL_STAT_320.equals(cdvo.getClmDtlStatCd())) {
						result = false;
					}

					if (CommonConstants.CLM_DTL_TP_40.equals(cdvo.getClmDtlTpCd())
							&& !CommonConstants.CLM_DTL_STAT_410.equals(cdvo.getClmDtlStatCd())
							&& !CommonConstants.CLM_DTL_STAT_420.equals(cdvo.getClmDtlStatCd())) {
						result = false;
					}
					// 일반교환인 경우
				} else {
					if (CommonConstants.CLM_DTL_TP_30.equals(cdvo.getClmDtlTpCd())
							&& !CommonConstants.CLM_DTL_STAT_310.equals(cdvo.getClmDtlStatCd())
							&& !CommonConstants.CLM_DTL_STAT_320.equals(cdvo.getClmDtlStatCd())) {
						result = false;
					}
				}
			}
		}

		return result;
	}

	
	/*
	 * 주문 취소 완료
	 * 
	 * @see biz.app.claim.service.ClaimService#completeClaimCancel(java.lang.String, java.lang.Long)
	 */
	@Override
	public void completeClaimCancel(String clmNo, Long cpltrNo) {

		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		
		//------------------------------------------------
		// 2. Validation
		//------------------------------------------------
		
		// 클레임 유형이 주문취소가 아닌 경우
		if (!CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		

		//------------------------------------------------
		// 3. 클레임 상세 목록 정보 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);

		if (claimDetailList == null || claimDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		ClaimDetailPO cdpo = null;

		//------------------------------------------------
		// 4. 클레임 상세 상태 변경
		//------------------------------------------------
		for (ClaimDetailVO claimDetail : claimDetailList) {
			cdpo = new ClaimDetailPO();
			cdpo.setClmNo(claimDetail.getClmNo());
			cdpo.setClmDtlSeq(claimDetail.getClmDtlSeq());
			cdpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_120);
			this.claimDetailDao.updateClaimDetailStatus(cdpo);
		}

		//------------------------------------------------
		// 5. 클레임 완료 호출
		//------------------------------------------------
		this.completeClaim(clmNo, cpltrNo);
	}

	
	/**
	 * 클레임 접수 시, 환불 예정 금액 조회 시 호출
	 * 
	 * @param clmRegist
	 * @param accept true : 클레임 접수, false : 환불 예정 금액 조회 
	 * @return
	 */
	@Override
	public ClaimAccept getClaimBefore(ClaimRegist clmRegist, boolean accept) {
		ClaimAccept clmAccept = new ClaimAccept();
		
		log.debug("### ClaimRegist = " + clmRegist.toString());

		String clmNo = null;			// 클레임 번호
		String clmAcceptTpCd = CommonConstants.CLAIM_ACCEPT_TP_ALL;		// 클레임 접수 유형
		String clmBlameCd = null;		// 귀책 대상 코드
		
		
		//------------------------------------------------
		// 변수 선언부
		//------------------------------------------------
		
		// 클레임 기본
		ClaimBasePO claimBase = new ClaimBasePO();

		// 클레임 상세
		List<ClaimDetailVO> claimDetailList = new ArrayList<>();
		ClaimDetailVO claimDetail = null;
		//주문 상세 구성
		List<OrdDtlCstrtVO> ordDtlCstrtList = null;
		// 클레임 상세 구성
		List<ClmDtlCstrtPO> clmDtlCstrtList = new ArrayList<>();
		ClmDtlCstrtPO clmDtlCstrtPO = null;
		
		// 배송지 및 회수지 정보
		List<OrderDlvraPO> orderDlvraList = new ArrayList<>();
		OrderDlvraPO orderDlvraPO = null;
		Long ordDlvraNo = null;		// 배송지 번호
		OrderDlvraPO chgOrderDlvraPO = null; //교환배송지
		Long chgOrdDlvraNo = null;		// 교환배송지 번호
		
		String rtnPostNoNew = "";
		String rtnPostNoOld = "";
		
		// 반품/교환 배송비
		List<DeliveryChargePO> clmDlvrcList = new ArrayList<>();
			
		DeliveryChargePO deliveryChargePO = null;
		
		
		//------------------------------------------------
		// 클레임 접수 유형 체크
		//------------------------------------------------
		if (clmRegist.getClaimSubList() != null && !clmRegist.getClaimSubList().isEmpty()) {
			clmAcceptTpCd = CommonConstants.CLAIM_ACCEPT_TP_PART;
		}
		
		
		//------------------------------------------------
		// 파라미터 Validation 체크
		//------------------------------------------------
		
		// 주문 번호와 클레임 유형이 없는 경우
		if (clmRegist.getOrdNo() == null || "".equals(clmRegist.getOrdNo()) || clmRegist.getClmTpCd() == null || "".equals(clmRegist.getClmTpCd())) {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		// 클레임 사유는 반드시 필요 함(사유에 따른 배송비 재계산)
		if (clmRegist.getClmRsnCd() == null || "".equals(clmRegist.getClmRsnCd())) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NO_REASON);
		}

		
		//------------------------------------------------
		// 1. 주문 정보 조회
		//------------------------------------------------
		OrderBaseSO obso = new OrderBaseSO();
		obso.setOrdNo(clmRegist.getOrdNo());
		OrderBaseVO orderBase = this.orderBaseDao.getOrderBase(obso);
		
		// 조회 결과 Validation
		if (orderBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_BASE);
		}

		// 주문 기본 상태에 따른 Validation
		
		// 취소된 주문 일 경우
		if (CommonConstants.COMM_YN_Y.equals(orderBase.getOrdCancelYn())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CANCEL_COMPLETE);
		}
		
		// 주문 취소 시
		if (CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())) {
			// 주문 접수시에는 전체 취소만 가능
			if (CommonConstants.ORD_STAT_10.equals(orderBase.getOrdStatCd()) && CommonConstants.CLAIM_ACCEPT_TP_PART.equals(clmAcceptTpCd)) {
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_ALL_CANCEL_STAT_10);
			}
		}
		
		
		//------------------------------------------------
		// 2. 귀책대상 설정
		//------------------------------------------------
		CodeDetailVO clmRsnVO = this.cacheService.getCodeCache(CommonConstants.CLM_RSN, clmRegist.getClmRsnCd());

		if (clmRsnVO == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NO_REASON);
		}

		clmBlameCd = clmRsnVO.getUsrDfn2Val();

		
		//------------------------------------------------
		// 3-1. 신규배송지(회수지) 설정
		//------------------------------------------------
		if (clmRegist.getPostNoNew() != null && !"".equals(clmRegist.getPostNoNew())) {
			if (accept) {
				ordDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO);

				orderDlvraPO = new OrderDlvraPO();
				orderDlvraPO.setOrdDlvraNo(ordDlvraNo);
				orderDlvraPO.setClmNo(clmNo);
				orderDlvraPO.setAdrsNm(clmRegist.getAdrsNm());
				orderDlvraPO.setTel(clmRegist.getTel());
				orderDlvraPO.setMobile(clmRegist.getMobile());
				orderDlvraPO.setPostNoNew(clmRegist.getPostNoNew());
				orderDlvraPO.setPostNoOld(clmRegist.getPostNoOld());
				orderDlvraPO.setPrclAddr(clmRegist.getPrclAddr());
				
				// 지번 상세 주소가 존재하지 않은 경우 도로명상세주소로 설정
				if (clmRegist.getPrclDtlAddr() == null || "".equals(clmRegist.getPrclDtlAddr())) {
					orderDlvraPO.setPrclDtlAddr(clmRegist.getRoadDtlAddr());
				} else {
					orderDlvraPO.setPrclDtlAddr(clmRegist.getPrclDtlAddr());
				}
				orderDlvraPO.setRoadAddr(clmRegist.getRoadAddr());
				orderDlvraPO.setRoadDtlAddr(clmRegist.getRoadDtlAddr());
				orderDlvraPO.setDlvrMemo(clmRegist.getDlvrMemo());

				orderDlvraList.add(orderDlvraPO);
			}
			
			rtnPostNoNew = clmRegist.getPostNoNew();
			rtnPostNoOld = clmRegist.getPostNoOld();
		}
		
		//------------------------------------------------
		// 3-2. 신규배송지(교환배송지) 설정
		//------------------------------------------------
		if (clmRegist.getChgPostNoNew() != null && !"".equals(clmRegist.getChgPostNoNew())) {
			if (accept) {
				chgOrdDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO);

				chgOrderDlvraPO = new OrderDlvraPO();
				chgOrderDlvraPO.setOrdDlvraNo(chgOrdDlvraNo);
				chgOrderDlvraPO.setClmNo(clmNo);
				chgOrderDlvraPO.setAdrsNm(clmRegist.getChgAdrsNm());
				chgOrderDlvraPO.setTel(clmRegist.getChgTel());
				chgOrderDlvraPO.setMobile(clmRegist.getChgMobile());
				chgOrderDlvraPO.setPostNoNew(clmRegist.getChgPostNoNew());
				chgOrderDlvraPO.setPostNoOld(clmRegist.getChgPostNoOld());
				chgOrderDlvraPO.setPrclAddr(clmRegist.getChgPrclAddr());
				
				// 지번 상세 주소가 존재하지 않은 경우 도로명상세주소로 설정
				if (clmRegist.getChgPrclDtlAddr() == null || "".equals(clmRegist.getChgPrclDtlAddr())) {
					chgOrderDlvraPO.setPrclDtlAddr(clmRegist.getChgRoadDtlAddr());
				} else {
					chgOrderDlvraPO.setPrclDtlAddr(clmRegist.getChgPrclDtlAddr());
				}
				chgOrderDlvraPO.setRoadAddr(clmRegist.getChgRoadAddr());
				chgOrderDlvraPO.setRoadDtlAddr(clmRegist.getChgRoadDtlAddr());
				chgOrderDlvraPO.setDlvrMemo(clmRegist.getChgDlvrMemo());
				
				orderDlvraList.add(chgOrderDlvraPO);
			}
		}
		
		
		//------------------------------------------------
		// 4. 주문 상세 목록 조회
		//------------------------------------------------
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(clmRegist.getOrdNo());

		// 클레임 주문 상세 정보가 존재하는 경우
		if (clmRegist.getClaimSubList() != null && !clmRegist.getClaimSubList().isEmpty()) {
			Integer[] arrOrdDtlSeq = new Integer[clmRegist.getClaimSubList().size()];
			int idx = 0;
			for (ClaimSub claimSub : clmRegist.getClaimSubList()) {
				arrOrdDtlSeq[idx] = claimSub.getOrdDtlSeq();
				idx++;
			}
			odso.setArrOrdDtlSeq(arrOrdDtlSeq);
		}

		List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);

		// 조회 결과 Validation
		if (orderDetailList == null || orderDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		} 
		
		// 클레임 상품수와 조회된 상품수가 다른 경우
		if (clmRegist.getClaimSubList() != null && !clmRegist.getClaimSubList().isEmpty()
				&& orderDetailList.size() != clmRegist.getClaimSubList().size()) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
		}
		
		if (accept) {
			// 반품일 경우 진행중인 건이 존재하면 접수 불가
			for (OrderDetailVO orderDetailVO : orderDetailList) {
				if (CommonConstants.CLM_TP_20.equals(clmRegist.getClmTpCd()) && orderDetailVO.getRtnIngQty() > 0) {
					throw new CustomException(ExceptionConstants.ERROR_CALIM_ACCEPT_RETRUN_DUPLICATE);
				}
			}
		}
		
		
		//------------------------------------------------
		// 5. 클레임 기본 정보 생성
		//------------------------------------------------
		claimBase.setStId(orderBase.getStId());
		claimBase.setOrdNo(orderBase.getOrdNo());
		claimBase.setClmTpCd(clmRegist.getClmTpCd());
		
		if (accept) {
			clmNo = this.claimBaseDao.getClaimNo(orderBase.getOrdNo());
			claimBase.setClmNo(clmNo);
			claimBase.setMbrNo(orderBase.getMbrNo());
			claimBase.setClmStatCd(CommonConstants.CLM_STAT_10);
			claimBase.setOrdMdaCd(clmRegist.getOrdMdaCd());
			claimBase.setChnlId(orderBase.getChnlId());
			claimBase.setAcptrNo(clmRegist.getAcptrNo());
			
			// 맞교환 여부 설정
			
			
			if (CommonConstants.CLM_TP_30.equals(clmRegist.getClmTpCd())) {
				if (CommonConstants.PROJECT_GB_FRONT.equals(webConfig.getProperty("project.gb"))) {
					//FO 교환 신청 시 맞교환 Y, 자사 상품 클레임일경우  , 택배가 아닌경우 
					if(orderDetailList.stream().anyMatch(s -> CommonConstants.COMP_GB_10.equals(s.getCompGbCd())) && !CommonConstants.DLVR_PRCS_TP_10.equals(orderBase.getDlvrPrcsTpCd())) {
						claimBase.setSwapYn(CommonConstants.COMM_YN_Y);
					}else {
						claimBase.setSwapYn(CommonConstants.COMM_YN_N);
					}
				}else {
					// 교환
					if (clmRegist.getSwapYn() == null) {
						claimBase.setSwapYn(CommonConstants.COMM_YN_N);
					} else {
						claimBase.setSwapYn(clmRegist.getSwapYn());
					}
				}
				
				

			} else {
				claimBase.setSwapYn(CommonConstants.COMM_YN_N);
			}
			
			//배송 처리 유형 설정, 교환-맞교환여부-Y 일 경우 주문기본 배송정책
			if (CommonConstants.CLM_TP_30.equals(clmRegist.getClmTpCd())) {
				if(CommonConstants.COMM_YN_Y.equals(claimBase.getSwapYn())) {
					claimBase.setDlvrPrcsTpCd(orderBase.getDlvrPrcsTpCd());
				}else {
					claimBase.setDlvrPrcsTpCd(CommonConstants.DLVR_PRCS_TP_10);
				}
			}else if(CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())){
				//취소일 경우 원주문 배송처리유형
				claimBase.setDlvrPrcsTpCd(orderBase.getDlvrPrcsTpCd());
			}else {
				//반품 - 택배 고정
				claimBase.setDlvrPrcsTpCd(CommonConstants.DLVR_PRCS_TP_10);
			}
		}
		
		//5-1. 
		//자사 주문, 주문 취소 있는 경우
		if (accept) {
			OrderDetailSO ordDtlCstrtSO = null;
			OrderExptCreateSO exptSO = null;
			if(CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())) {
				List<OrderDetailVO> cisOrdSearchList = orderDetailList.stream()
						.filter(vo-> CommonConstants.COMP_GB_10.equals(vo.getCompGbCd()) && 
								(CommonConstants.ORD_DTL_STAT_130.equals(vo.getOrdDtlStatCd()) 
										|| CommonConstants.ORD_DTL_STAT_140.equals(vo.getOrdDtlStatCd()))).collect(Collectors.toList());	
				
				if(cisOrdSearchList.size() > 0) {
					boolean isCancelPsb = true;
					
					for(OrderDetailVO vo : orderDetailList) {
						try {
							ordDtlCstrtSO = new OrderDetailSO();
							ordDtlCstrtSO.setOrdNo(vo.getOrdNo());
							ordDtlCstrtSO.setOrdDtlSeq(vo.getOrdDtlSeq());
							//주문 상세 구성
							ordDtlCstrtList = ordDtlCstrtDao.listOrdDtlCstrt(ordDtlCstrtSO);
							
							for(OrdDtlCstrtVO ordCstrtVO :  ordDtlCstrtList) {
								exptSO = new OrderExptCreateSO();
								exptSO.setShopOrdrNo(ordCstrtVO.getOrdNo());
								exptSO.setShopSortNo(String.valueOf(ordCstrtVO.getOrdDtlSeq()).concat("_").concat(String.valueOf(ordCstrtVO.getOrdCstrtSeq())));
								try {
									OrderExptCreateVO exptVO =  cisOrderService.getExptCreate(exptSO);
									if(CommonConstants.CIS_API_SUCCESS_CD.equals(exptVO.getResCd()) && CommonConstants.COMM_YN_Y.equals(exptVO.getCreateYn())) {
										isCancelPsb = false;
									}
								} catch (Exception e) {
									throw new CustomException(ExceptionConstants.ERROR_CIS_GET_EXPT_CREATE_ERROR);
								}
							}
						}catch(Exception e) {
							throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR);
						}
					}
					
					if(!isCancelPsb) {
						throw new CustomException(ExceptionConstants.ERROR_ORDER_CANCEL_CIS_RETURN_ERROR);
					}
				}
			}
		}
		List<OrderDetailVO> newList = new ArrayList<>();
		
		Integer clmQty = null;			// 클레임 수량
		Integer orgClmQty = null;			// 원 클레임 수량
		Integer clmPsbQty = null;		// 클레임 가능 수량
		OrderDetailVO temp = null;
		OrderDetailSO detailSO = null;
		boolean claimAccept = true;		// 클레임 접수
		ClaimSub claimSub = null;		// 클레임 접수 Sub
		for(OrderDetailVO vo : orderDetailList) {
			claimAccept = true;
			claimSub = null;
			
			detailSO = new OrderDetailSO();
			detailSO.setOrdNo(vo.getOrdNo());
			detailSO.setOrdDtlSeq(vo.getOrdDtlSeq());
			
			//------------------------------------------------
			// 1) 클레임 접수 유형에 따른 클레임 수량 설정

			// 클레임 가능 수량 계산
			clmPsbQty = vo.getRmnOrdQty() - vo.getRtnQty() - vo.getClmExcIngQty();
			
			// 클레임 접수 유형에 따른 클레임 수량 설정
			if (CommonConstants.CLAIM_ACCEPT_TP_ALL.equals(clmAcceptTpCd)) {
				if (clmPsbQty > 0) {
					clmQty = clmPsbQty;
				} else {
					claimAccept = false;
				}
			} else {
				if (clmPsbQty == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CLAIM_CLAIM_QTY);
				} 
				
				for (ClaimSub cs : clmRegist.getClaimSubList()) {
					if (vo.getOrdDtlSeq().equals(cs.getOrdDtlSeq())) {
						claimSub = cs;
					}
				}

				// 수량취소 일 경우
				if (claimSub.getClmQty() != null) {
					if (clmPsbQty < claimSub.getClmQty()) {
						throw new CustomException(ExceptionConstants.ERROR_CLAIM_CLAIM_QTY);
					} 
					clmQty = claimSub.getClmQty();
					
				} else {
				}
			}
			
			orgClmQty = clmQty;
			
			//교환, 반품일 경우
			if(CommonConstants.CLM_TP_20.equals(clmRegist.getClmTpCd()) || CommonConstants.CLM_TP_30.equals(clmRegist.getClmTpCd())) {
				
				List<OrderDetailVO> tgList = orderDetailDao.listOrderDetailForClaimTarget(detailSO);
				
				for(OrderDetailVO tg : tgList) {
					
					temp = new OrderDetailVO();
					
					if(StringUtils.isEmpty(tg.getClmNo())) {
						//주문상세 - 남은 수량
						tg.setClmTgQty(tg.getClmTgQty() - tgList.stream().filter(t -> StringUtils.isNotEmpty(t.getClmNo())).mapToInt(OrderDetailVO::getClmTgQty).sum());
					}
					int tgQty = 0;
					BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0); 		
					
					try {
						BeanUtils.copyProperties(temp, vo);
					} catch (Exception e) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					if(clmQty > tg.getClmTgQty()) {
						tgQty = tg.getClmTgQty();
					}else {
						tgQty = clmQty;
					}
					
					if(tgQty <= 0) {
						continue;
					}
					
					temp.setOrgClmNo(StringUtils.isEmpty(tg.getClmNo()) ? null : tg.getClmNo());
					temp.setOrgClmDtlSeq(tg.getClmDtlSeq() == 0 ? null : tg.getClmDtlSeq());
					temp.setClmTgQty(tgQty);
					temp.setClaimAccept(claimAccept);
					
					//잔여 클레임 수량 업데이트
					if(accept && StringUtils.isNotEmpty(temp.getOrgClmNo())) {
						ClaimDetailPO clmDetailPO = new ClaimDetailPO();
						clmDetailPO.setClmNo(temp.getOrgClmNo());
						clmDetailPO.setClmDtlSeq(temp.getOrgClmDtlSeq());
						clmDetailPO.setReduceRmnClmQty(temp.getClmTgQty());
						
						claimDetailDao.updateClaimDetail(clmDetailPO);
					}
					
					//자사만 클레임 분리
					if(CommonConstants.COMP_GB_10.equals(vo.getCompGbCd())) {
						newList.add(temp);
					}
					
					clmQty -= tgQty;
				}
				
				if(!CommonConstants.COMP_GB_10.equals(vo.getCompGbCd())) {
					vo.setClmTgQty(orgClmQty);
					vo.setClaimAccept(claimAccept);
					newList.add(vo);
				}
			}else {
				vo.setClmTgQty(clmQty);
				vo.setClaimAccept(claimAccept);
				newList.add(vo);
			}
		}
		
		
		//------------------------------------------------
		// 6. 클레임 상세 정보 생성
		// - 클레임 수량 계산
		// - 배송/회수지 설정
		// - 반품/교환 배송비 계산
		//------------------------------------------------
		int clmDtlSeq = 1;				// 클레임 상세  순번
		int clmDtlRsnSeq = 1;			// 클레임 상세 사진 순번
		OrderDetailSO ordDtlCstrtSO = null;	//주문 상세 구성 조회 
		
		List<DeliveryChargePolicyVO> deliveryChargePolicyList = new ArrayList<>();	// 배송비 정책 목록
		long dlvrcSeq = 0;				// 배송비 순번:임시번호

		for (OrderDetailVO orderDetailVO : newList) {
			claimAccept = orderDetailVO.getClaimAccept();

			clmQty = orderDetailVO.getClmTgQty();
			
			if (claimAccept) {
				//------------------------------------------------
				// 2) 주문 상세 상태에 따른 Validation
				boolean checkResult = this.checkAcceptClaimPossibleStatus(clmRegist.getClmTpCd(), orderDetailVO.getOrdDtlStatCd());

				if (!checkResult) {
					//상품 상세 상태가 안맞는 경우 exception
					
					/*// 전체 클레임인 경우 클레임 처리가 가능한 데이터만 처리
					if (CommonConstants.CLAIM_ACCEPT_TP_ALL.equals(clmAcceptTpCd)) {
						claimAccept = false;
						// 부분 클레임 일 경우 Exception
					} else {
						throw new CustomException(ExceptionConstants.ERROR_CLAIM_ACCEPT_STATUS);
					}*/
					
					throw new CustomException(ExceptionConstants.ERROR_CLAIM_ACCEPT_STATUS);
				}
				
				//------------------------------------------------
				// 3) 클레임 상세 정보 생성
				// 공통 정보 설정
				claimDetail = new ClaimDetailVO();
				
				claimDetail.setClmNo(clmNo);
				claimDetail.setClmRsnCd(clmRegist.getClmRsnCd());
				claimDetail.setClmRsnContent(clmRegist.getClmRsnContent());
				claimDetail.setMbrNo(orderDetailVO.getMbrNo());
				claimDetail.setGoodsId(orderDetailVO.getGoodsId());
				claimDetail.setGoodsNm(orderDetailVO.getGoodsNm());
				claimDetail.setItemNo(orderDetailVO.getItemNo());
				claimDetail.setPakGoodsId(orderDetailVO.getPakGoodsId());
				claimDetail.setDealGoodsId(orderDetailVO.getDealGoodsId());
				claimDetail.setDispClsfNo(orderDetailVO.getDispClsfNo());
				claimDetail.setCompGoodsId(orderDetailVO.getCompGoodsId());
				claimDetail.setCompItemId(orderDetailVO.getCompItemId());
				claimDetail.setGoodsPrcNo(orderDetailVO.getGoodsPrcNo());
				claimDetail.setCms(orderDetailVO.getCms());
				claimDetail.setGoodsCmsnRt(orderDetailVO.getGoodsCmsnRt());
				claimDetail.setTaxGbCd(orderDetailVO.getTaxGbCd());
				claimDetail.setCompNo(orderDetailVO.getCompNo());
				claimDetail.setUpCompNo(orderDetailVO.getUpCompNo());
				claimDetail.setCompGbCd(orderDetailVO.getCompGbCd());
				claimDetail.setSaleAmt(orderDetailVO.getSaleAmt());
				claimDetail.setPayAmt(orderDetailVO.getPayAmt());
				claimDetail.setPrmtDcAmt(orderDetailVO.getPrmtDcAmt());
				claimDetail.setCpDcAmt(orderDetailVO.getCpDcAmt());
				claimDetail.setCartCpDcAmt(orderDetailVO.getCartCpDcAmt());
				claimDetail.setOrdNo(orderDetailVO.getOrdNo());
				claimDetail.setOrdDtlSeq(orderDetailVO.getOrdDtlSeq());
				claimDetail.setClmQty(clmQty);
				claimDetail.setRmnPayAmt(0L);
				claimDetail.setRmnQty(orderDetailVO.getRmnOrdQty() - orderDetailVO.getRtnQty() - clmQty);
				claimDetail.setClmDtlSeq(clmDtlSeq++);
				claimDetail.setOrgClmNo(orderDetailVO.getOrgClmNo());
				claimDetail.setOrgClmDtlSeq(orderDetailVO.getOrgClmDtlSeq());
				claimDetail.setRmnClmQty(clmQty);
				
				ordDtlCstrtSO = new OrderDetailSO();
				ordDtlCstrtSO.setOrdNo(orderDetailVO.getOrdNo());
				ordDtlCstrtSO.setOrdDtlSeq(orderDetailVO.getOrdDtlSeq());
				
				//주문 상세 구성
				ordDtlCstrtList = ordDtlCstrtDao.listOrdDtlCstrt(ordDtlCstrtSO);
				
				for(OrdDtlCstrtVO ordCstrtVO :  ordDtlCstrtList) {
					clmDtlCstrtPO = new ClmDtlCstrtPO();
					clmDtlCstrtPO.setClmNo(clmNo);
					clmDtlCstrtPO.setClmDtlSeq(claimDetail.getClmDtlSeq());
					clmDtlCstrtPO.setClmCstrtSeq(ordCstrtVO.getOrdCstrtSeq());
					clmDtlCstrtPO.setCstrtGoodsId(ordCstrtVO.getCstrtGoodsId());
					clmDtlCstrtPO.setSkuCd(ordCstrtVO.getSkuCd());
					clmDtlCstrtPO.setOrdDtlCstrtNo(ordCstrtVO.getOrdDtlCstrtNo());
					clmDtlCstrtPO.setCstrtGoodsGbCd(ordCstrtVO.getCstrtGoodsGbCd());
					clmDtlCstrtPO.setCstrtQty(ordCstrtVO.getCstrtQty());
					clmDtlCstrtPO.setOrgSaleAmt(ordCstrtVO.getOrgSaleAmt());
					clmDtlCstrtPO.setSaleAmt(ordCstrtVO.getSaleAmt());
					clmDtlCstrtPO.setOrdNo(ordCstrtVO.getOrdNo());
					clmDtlCstrtPO.setOrdDtlSeq(ordCstrtVO.getOrdDtlSeq());
					clmDtlCstrtPO.setOrdCstrtSeq(ordCstrtVO.getOrdCstrtSeq());
					clmDtlCstrtPO.setOrdDtlStatCd(orderDetailVO.getOrdDtlStatCd());
					clmDtlCstrtPO.setItemNo(ordCstrtVO.getItemNo());
					//주문 취소 param
					clmDtlCstrtPO.setClmQty(clmQty);
					clmDtlCstrtList.add(clmDtlCstrtPO);
				}
				
				// 클레임 유형별 설정
				// 주문취소
				if (CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())) {
					
					claimDetail.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_10);
					claimDetail.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_110);

					if (orderDetailVO.getRmnOrdQty() - clmQty == 0) {
						claimDetail.setRmnPayAmt(orderDetailVO.getRmnPayAmt());
					}

					claimDetailList.add(claimDetail);
				}
				// 반품
				else if (CommonConstants.CLM_TP_20.equals(clmRegist.getClmTpCd())) {
					//claimDetail.setItemNo(clmRegist.getOrgItemNo()); - 단품별 반품아님
					
					claimDetail.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_20);
					claimDetail.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_210);
					
					if (orderDetailVO.getRmnOrdQty() - orderDetailVO.getRtnQty() - clmQty == 0) {
						claimDetail.setRmnPayAmt(orderDetailVO.getRmnPayAmt());
					}
					
					// 배송비 정책에서 조회
					DeliveryChargePolicySO dcpso = new DeliveryChargePolicySO();
					dcpso.setDlvrcNo(orderDetailVO.getDlvrcNo());
					DeliveryChargePolicyVO deliveryChargePolicy = this.deliveryChargePolicyDao.getDeliveryChargePolicy(dcpso);
					
					if (accept) {
						// a) 회수지 정보 설정 (고객 주소지)
						if (ordDlvraNo != null) {
							claimDetail.setRtrnaNo(ordDlvraNo);
						} else {
							claimDetail.setRtrnaNo(orderDetailVO.getOrdDlvraNo());

							// 원 배송지 조회
							OrderDlvraSO odaso = new OrderDlvraSO();
							odaso.setOrdDlvraNo(orderDetailVO.getOrdDlvraNo());
							OrderDlvraVO orderDlvra = this.orderDlvraDao.getOrderDlvra(odaso);

							rtnPostNoNew = orderDlvra.getPostNoNew();
							rtnPostNoOld = orderDlvra.getPostNoOld();
						}
						
						// b) 배송지 정보 설정 (업체 주소지 - 예) 업체 물류창고 등)
						Long rtnDlvraNo = null;
						
						if (deliveryChargePolicy != null) {

							// 기 조회된 정책과 동일한 경우 중복제거를 위해 기존 회수지 번호 설정
							if (deliveryChargePolicyList != null && !deliveryChargePolicyList.isEmpty()) {
								for (DeliveryChargePolicyVO dcpvo : deliveryChargePolicyList) {
									if (dcpvo.getDlvrcPlcNo().equals(deliveryChargePolicy.getDlvrcPlcNo())) {
										rtnDlvraNo = dcpvo.getOrdDlvraNo();
									}
								}
							}

							// 중복된 정책이 존재하지 않은 경우
							if (rtnDlvraNo == null) {
								rtnDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO);

								orderDlvraPO = new OrderDlvraPO();
								orderDlvraPO.setOrdDlvraNo(rtnDlvraNo);
								orderDlvraPO.setClmNo(clmNo);
								orderDlvraPO.setAdrsNm(deliveryChargePolicy.getRtnExcMan());
								orderDlvraPO.setTel(deliveryChargePolicy.getRtnExcTel());
								orderDlvraPO.setMobile(deliveryChargePolicy.getRtnExcTel());
								orderDlvraPO.setPostNoNew(deliveryChargePolicy.getRtnaPostNoNew());
								orderDlvraPO.setPostNoOld(deliveryChargePolicy.getRtnaPostNoOld());
								orderDlvraPO.setPrclAddr(deliveryChargePolicy.getRtnaPrclAddr());
								orderDlvraPO.setPrclDtlAddr(deliveryChargePolicy.getRtnaPrclDtlAddr());
								orderDlvraPO.setRoadAddr(deliveryChargePolicy.getRtnaRoadAddr());
								orderDlvraPO.setRoadDtlAddr(deliveryChargePolicy.getRtnaRoadDtlAddr());

								// 주문배송지저장 목록 추가
								orderDlvraList.add(orderDlvraPO);

								// 배송비 정책 목록에 추가
								deliveryChargePolicy.setOrdDlvraNo(rtnDlvraNo);
								deliveryChargePolicyList.add(deliveryChargePolicy);

							}

							claimDetail.setDlvraNo(rtnDlvraNo);

						} else {
							// 배송비 정책이 존재하지 않을 경우
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
					else {
						claimDetail.setDlvraNo(orderDetailVO.getOrdDlvraNo());
						
						if ("".equals(rtnPostNoNew)) {
							// 원 배송지 조회
							OrderDlvraSO odaso = new OrderDlvraSO();
							odaso.setOrdDlvraNo(orderDetailVO.getOrdDlvraNo());
							OrderDlvraVO orderDlvra = this.orderDlvraDao.getOrderDlvra(odaso);

							rtnPostNoNew = orderDlvra.getPostNoNew();
							rtnPostNoOld = orderDlvra.getPostNoOld();
						}
					}
					
					// c) 반품 회수비 설정
					Long rtnDlvrcNo = null;

					// 기 동일한 배송비 정보가 존재하는 경우 생성된 정보 설정
					if (clmDlvrcList != null && !clmDlvrcList.isEmpty()) {
						for (DeliveryChargePO dcpo : clmDlvrcList) {
							if (orderDetailVO.getDlvrcNo().equals(dcpo.getOrdDlvrcNo())) {
								rtnDlvrcNo = dcpo.getDlvrcNo();
							}
						}
					}
					
					// 기 정보가 존재하지 않은 경우 신규 생성 하여 설정
					if (rtnDlvrcNo == null) {
						// 원 주문 배송비 조회
						DeliveryChargeSO dcso = new DeliveryChargeSO();
						dcso.setDlvrcNo(orderDetailVO.getDlvrcNo());
						DeliveryChargeVO orgDeliveryCharge = this.deliveryChargeDao.getDeliveryCharge(dcso);
						
						if (orgDeliveryCharge != null) {
							// DB에 저장하지 않더라도 임시 연산을 위해 delivery_charge_detail 에 insert하려면 PK 필요.
							rtnDlvrcNo = this.bizService.getSequence(CommonConstants.SEQUENCE_DLVRC_NO_SEQ);				
							
							deliveryChargePO = new DeliveryChargePO();
							deliveryChargePO.setDlvrcNo(rtnDlvrcNo);
							deliveryChargePO.setOrdDlvrcNo(orderDetailVO.getDlvrcNo());
							
							// 귀책에 따른 실 배송비 설정
							Long orgDlvrAmt;
							Long realDlvrAmt = 0L;
							Long addDlvrAmt = 0L;
							Long paidDlvrAmt =0L;
							
							// 원 배송비, 개당 부여 시
							if (CommonConstants.DLVRC_CDT_10.equals(orgDeliveryCharge.getDlvrcCdtCd())) {
								orgDlvrAmt = deliveryChargePolicy.getRtnDlvrc() * clmQty;
							} else {
								orgDlvrAmt = deliveryChargePolicy.getRtnDlvrc();
							}
							
							// 추가배송비 계산 여부
							LocalPostSO lpso = new LocalPostSO();
							lpso.setPostNoNew(rtnPostNoNew);
							lpso.setPostNoOld(rtnPostNoOld);
							String localPostYn = this.localPostDao.getLocalPostYn(lpso);
							
							// 업체 귀책이 아닌 경우, 실 배송비 추가 배송비 계산
							if (!CommonConstants.RSP_RSN_20.equals(clmBlameCd)) {
								if (CommonConstants.DLVRC_CDT_10.equals(orgDeliveryCharge.getDlvrcCdtCd())) {
									realDlvrAmt = deliveryChargePolicy.getRtnDlvrc() * clmQty;
									paidDlvrAmt = deliveryChargePolicy.getDlvrAmt() * clmQty;
									if (CommonConstants.COMM_YN_Y.equals(localPostYn)) {
										addDlvrAmt = deliveryChargePolicy.getAddDlvrAmt() * clmQty;
									}
								} else {
									realDlvrAmt = deliveryChargePolicy.getRtnDlvrc();
									paidDlvrAmt = deliveryChargePolicy.getDlvrAmt();
									if (CommonConstants.COMM_YN_Y.equals(localPostYn)) {
										addDlvrAmt = deliveryChargePolicy.getAddDlvrAmt();
									}
								}
							}
							
							deliveryChargePO.setOrgDlvrAmt(orgDlvrAmt + addDlvrAmt);
							deliveryChargePO.setRealDlvrAmt(realDlvrAmt + addDlvrAmt);
							deliveryChargePO.setAddDlvrAmt(addDlvrAmt);
							
							deliveryChargePO.setCostGbCd(CommonConstants.COST_GB_20);
							deliveryChargePO.setDlvrcCdtCd(orgDeliveryCharge.getDlvrcCdtCd());
							deliveryChargePO.setDlvrcCdtStdCd(orgDeliveryCharge.getDlvrcCdtStdCd());
							deliveryChargePO.setDlvrcPayMtdCd(orgDeliveryCharge.getDlvrcPayMtdCd());
							deliveryChargePO.setDlvrcPlcNo(orgDeliveryCharge.getDlvrcPlcNo());
							deliveryChargePO.setDlvrcStdCd(orgDeliveryCharge.getDlvrcStdCd());
							deliveryChargePO.setDlvrStdAmt(orgDeliveryCharge.getDlvrStdAmt());
							deliveryChargePO.setAddDlvrStdAmt(orgDeliveryCharge.getAddDlvrStdAmt());
							deliveryChargePO.setBuyPrc(orgDeliveryCharge.getBuyPrc());
							deliveryChargePO.setBuyQty(orgDeliveryCharge.getBuyQty());
							deliveryChargePO.setOrdDlvrcNo(orderDetailVO.getDlvrcNo());
							deliveryChargePO.setPrepayGbCd(CommonConstants.PREPAY_GB_10);		// 선착불코드는 주문시 결제방법코드가 선불만 존재하므로 고정 값
							deliveryChargePO.setClmDtlSeq(claimDetail.getClmDtlSeq());
							if (orgDeliveryCharge.getRealDlvrAmt() > 0 && (CommonConstants.DLVRC_CDT_10.equals(orgDeliveryCharge.getDlvrcCdtCd()) || (orderDetailVO.getRmnOrdQty() - orderDetailVO.getRtnQty() - clmQty == 0))) { // 클레임 대상 배송비(고객 귀책 반품이고 개별부과나 잔여수량이 0일경우에만 지불된 실배송비 표시)
								deliveryChargePO.setPaidDlvrAmt(paidDlvrAmt + addDlvrAmt);
							}else {
								deliveryChargePO.setPaidDlvrAmt(0l);
							}
							
							clmDlvrcList.add(deliveryChargePO);

							claimDetail.setRtnDlvrcNo(rtnDlvrcNo);
						} else {
							// 배송비가 존재하지 않을 경우
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}

					claimDetail.setRtnDlvrcNo(rtnDlvrcNo);

					claimDetailList.add(claimDetail);
				}
				// 교환
				else if (CommonConstants.CLM_TP_30.equals(clmRegist.getClmTpCd())) {
					//------------------------------
					// 교환 회수 등록
					//------------------------------ 
					//claimDetail.setItemNo(clmRegist.getOrgItemNo());
					
					claimDetail.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_30);
					claimDetail.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_310);
					
					// 배송비 정책 조회
					DeliveryChargePolicySO dcpso = new DeliveryChargePolicySO();
					dcpso.setDlvrcNo(orderDetailVO.getDlvrcNo());
					DeliveryChargePolicyVO deliveryChargePolicy = this.deliveryChargePolicyDao.getDeliveryChargePolicy(dcpso);
					
					if (accept) {
						//claimDetail.setItemNo(clmRegist.getOrgItemNo()); - 단품별 교환 아님.
						
						// a) 회수지 정보 설정 (고객 주소지)
						if (ordDlvraNo != null) {
							claimDetail.setRtrnaNo(ordDlvraNo);
						} else {
							claimDetail.setRtrnaNo(orderDetailVO.getOrdDlvraNo());

							// 원 배송지 조회
							OrderDlvraSO odaso = new OrderDlvraSO();
							odaso.setOrdDlvraNo(orderDetailVO.getOrdDlvraNo());
							OrderDlvraVO orderDlvra = this.orderDlvraDao.getOrderDlvra(odaso);

							rtnPostNoNew = orderDlvra.getPostNoNew();
							rtnPostNoOld = orderDlvra.getPostNoOld();
						}
						
						// b) 배송지 정보 설정(업체 주소지)
						if (deliveryChargePolicy != null) {
							Long rtnDlvraNo = null;

							// 기 조회된 정책과 동일한 경우 중복제거를 위해 기존 회수지 번호 설정
							if (deliveryChargePolicyList != null && !deliveryChargePolicyList.isEmpty()) {
								for (DeliveryChargePolicyVO dcpvo : deliveryChargePolicyList) {
									if (dcpvo.getDlvrcPlcNo().equals(deliveryChargePolicy.getDlvrcPlcNo())) {
										rtnDlvraNo = dcpvo.getOrdDlvraNo();
									}
								}
							}

							// 중복된 정책이 존재하지 않은 경우
							if (rtnDlvraNo == null) {
								rtnDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO);

								orderDlvraPO = new OrderDlvraPO();
								orderDlvraPO.setOrdDlvraNo(rtnDlvraNo);
								orderDlvraPO.setClmNo(clmNo);
								orderDlvraPO.setAdrsNm(deliveryChargePolicy.getRtnExcMan());
								orderDlvraPO.setTel(deliveryChargePolicy.getRtnExcTel());
								orderDlvraPO.setMobile(deliveryChargePolicy.getRtnExcTel());
								orderDlvraPO.setPostNoNew(deliveryChargePolicy.getRtnaPostNoNew());
								orderDlvraPO.setPostNoOld(deliveryChargePolicy.getRtnaPostNoOld());
								orderDlvraPO.setPrclAddr(deliveryChargePolicy.getRtnaPrclAddr());
								orderDlvraPO.setPrclDtlAddr(deliveryChargePolicy.getRtnaPrclDtlAddr());
								orderDlvraPO.setRoadAddr(deliveryChargePolicy.getRtnaRoadAddr());
								orderDlvraPO.setRoadDtlAddr(deliveryChargePolicy.getRtnaRoadDtlAddr());

								// 주문배송지저장 목록 추가
								orderDlvraList.add(orderDlvraPO);

								// 배송비 정책 목록에 추가
								deliveryChargePolicy.setOrdDlvraNo(rtnDlvraNo);
								deliveryChargePolicyList.add(deliveryChargePolicy);
							}

							claimDetail.setDlvraNo(rtnDlvraNo);

						} else {
							// 배송비 정책이 존재하지 않을 경우
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
					else {
						if ("".equals(rtnPostNoNew)) {
							// 원 배송지 조회
							OrderDlvraSO odaso = new OrderDlvraSO();
							odaso.setOrdDlvraNo(orderDetailVO.getOrdDlvraNo());
							OrderDlvraVO orderDlvra = this.orderDlvraDao.getOrderDlvra(odaso);

							rtnPostNoNew = orderDlvra.getPostNoNew();
							rtnPostNoOld = orderDlvra.getPostNoOld();
						}
					}
					
					
					// c) 교환비 계산
					Long rtnDlvrcNo = null;			// 교환회수비
					Long dlvrcNo = null;			// 교환배송비
					
					// 기 동일한 배송비 정보가 존재하는 경우 생성된 정보 설정
					if (clmDlvrcList != null && !clmDlvrcList.isEmpty()) {
						for (DeliveryChargePO dcpo : clmDlvrcList) {
							// 교환회수비 설정
							if (orderDetailVO.getDlvrcNo().equals(dcpo.getOrdDlvrcNo())
									&& CommonConstants.COST_GB_20.equals(dcpo.getCostGbCd())) {
								rtnDlvrcNo = dcpo.getDlvrcNo();
							}
							// 교환배송비 설정
							if (orderDetailVO.getDlvrcNo().equals(dcpo.getOrdDlvrcNo())
									&& CommonConstants.COST_GB_10.equals(dcpo.getCostGbCd())) {
								dlvrcNo = dcpo.getDlvrcNo();
							}
						}
					}
					
					// 기 정보가 존재하지 않은 경우 신규 생성 하여 설정
					if (rtnDlvrcNo == null) {
						DeliveryChargeSO dcso = new DeliveryChargeSO();
						dcso.setDlvrcNo(orderDetailVO.getDlvrcNo());
						DeliveryChargeVO orgDeliveryCharge = this.deliveryChargeDao.getDeliveryCharge(dcso);
						
						if (orgDeliveryCharge != null) {
							// 교환비를 배송비와 회수비로 분할
							Long excDlvrc = deliveryChargePolicy.getExcDlvrc() / 2;

							// 귀책에 따른 실 배송비 설정
							Long orgDlvrAmt;
							Long realDlvrAmt = 0L;
							Long addDlvrAmt = 0L;

							// 원 배송비
							if (CommonConstants.DLVRC_CDT_10.equals(orgDeliveryCharge.getDlvrcCdtCd())) {
								orgDlvrAmt = excDlvrc * clmQty;
							} else {
								orgDlvrAmt = excDlvrc;
							}
							
							// 추가배송비 계산 여부
							LocalPostSO lpso = new LocalPostSO();
							lpso.setPostNoNew(rtnPostNoNew);
							lpso.setPostNoOld(rtnPostNoOld);
							String localPostYn = this.localPostDao.getLocalPostYn(lpso);
							
							// 업체 귀책이 아닌 경우, 실 배송비 추가 배송비 계산
							if (!CommonConstants.RSP_RSN_20.equals(clmBlameCd)) {
								if (CommonConstants.DLVRC_CDT_10.equals(orgDeliveryCharge.getDlvrcCdtCd())) {
									realDlvrAmt = excDlvrc * clmQty;
									if (CommonConstants.COMM_YN_Y.equals(localPostYn)) {
										addDlvrAmt = deliveryChargePolicy.getAddDlvrAmt() * clmQty;
									}
								} else {
									realDlvrAmt = excDlvrc;
									if (CommonConstants.COMM_YN_Y.equals(localPostYn)) {
										addDlvrAmt = deliveryChargePolicy.getAddDlvrAmt();
									}
								}
							}
							
							// 교환회수비 정보 등록
							deliveryChargePO = new DeliveryChargePO();
							if (accept)
								rtnDlvrcNo = this.bizService.getSequence(CommonConstants.SEQUENCE_DLVRC_NO_SEQ);
							else
								rtnDlvrcNo = dlvrcSeq++;						
							
							deliveryChargePO.setDlvrcNo(rtnDlvrcNo);
							deliveryChargePO.setOrgDlvrAmt(orgDlvrAmt + addDlvrAmt);
							deliveryChargePO.setRealDlvrAmt(realDlvrAmt + addDlvrAmt);
							deliveryChargePO.setAddDlvrAmt(addDlvrAmt);
							
							deliveryChargePO.setCostGbCd(CommonConstants.COST_GB_20);
							deliveryChargePO.setOrdDlvrcNo(orderDetailVO.getDlvrcNo());
							
							deliveryChargePO.setDlvrcCdtCd(orgDeliveryCharge.getDlvrcCdtCd());
							deliveryChargePO.setDlvrcCdtStdCd(orgDeliveryCharge.getDlvrcCdtStdCd());
							deliveryChargePO.setDlvrcPayMtdCd(orgDeliveryCharge.getDlvrcPayMtdCd());
							deliveryChargePO.setDlvrcPlcNo(orgDeliveryCharge.getDlvrcPlcNo());
							deliveryChargePO.setDlvrcStdCd(orgDeliveryCharge.getDlvrcStdCd());
							deliveryChargePO.setDlvrStdAmt(orgDeliveryCharge.getDlvrStdAmt());
							deliveryChargePO.setAddDlvrStdAmt(orgDeliveryCharge.getAddDlvrStdAmt());
							deliveryChargePO.setBuyPrc(orgDeliveryCharge.getBuyPrc());
							deliveryChargePO.setBuyQty(orgDeliveryCharge.getBuyQty());
							deliveryChargePO.setPrepayGbCd(CommonConstants.PREPAY_GB_10);	// 선착불코드는 주문시 결제방법코드가 선불만 존재하므로 고정 값
							deliveryChargePO.setClmDtlSeq(claimDetail.getClmDtlSeq());
							
							clmDlvrcList.add(deliveryChargePO);
							
							
							// 교환배송비 정보 등록
							deliveryChargePO = new DeliveryChargePO();
							if (accept)
								dlvrcNo = this.bizService.getSequence(CommonConstants.SEQUENCE_DLVRC_NO_SEQ);
							else
								dlvrcNo = dlvrcSeq++;
							
							deliveryChargePO.setDlvrcNo(dlvrcNo);
							deliveryChargePO.setOrgDlvrAmt(orgDlvrAmt + addDlvrAmt);
							deliveryChargePO.setRealDlvrAmt(realDlvrAmt + addDlvrAmt);
							deliveryChargePO.setAddDlvrAmt(addDlvrAmt);
							
							deliveryChargePO.setCostGbCd(CommonConstants.COST_GB_10);
							deliveryChargePO.setOrdDlvrcNo(orderDetailVO.getDlvrcNo());

							deliveryChargePO.setDlvrcCdtCd(orgDeliveryCharge.getDlvrcCdtCd());
							deliveryChargePO.setDlvrcCdtStdCd(orgDeliveryCharge.getDlvrcCdtStdCd());
							deliveryChargePO.setDlvrcPayMtdCd(orgDeliveryCharge.getDlvrcPayMtdCd());
							deliveryChargePO.setDlvrcPlcNo(orgDeliveryCharge.getDlvrcPlcNo());
							deliveryChargePO.setDlvrcStdCd(orgDeliveryCharge.getDlvrcStdCd());
							deliveryChargePO.setDlvrStdAmt(orgDeliveryCharge.getDlvrStdAmt());
							deliveryChargePO.setAddDlvrStdAmt(orgDeliveryCharge.getAddDlvrStdAmt());
							deliveryChargePO.setBuyPrc(orgDeliveryCharge.getBuyPrc());
							deliveryChargePO.setBuyQty(orgDeliveryCharge.getBuyQty());
							deliveryChargePO.setPrepayGbCd(CommonConstants.PREPAY_GB_10);	// 선착불코드는 주문시 결제방법코드가 선불만 존재하므로 고정 값
							deliveryChargePO.setClmDtlSeq(claimDetail.getClmDtlSeq()+1);
							
							clmDlvrcList.add(deliveryChargePO);
						} else {
							// 배송비가 존재하지 않을 경우
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}

					// 교환회수비 정보 설정
					claimDetail.setRtnDlvrcNo(rtnDlvrcNo);

					claimDetailList.add(claimDetail);

					
					//------------------------------
					// 교환 배송 등록
					//------------------------------ 
					ClaimDetailVO exClaimDetail = null;
					
					exClaimDetail = new ClaimDetailVO();
				
					BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0); 							

					try {
						BeanUtils.copyProperties(exClaimDetail, claimDetail);
					} catch (Exception e) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					exClaimDetail.setClmDtlSeq(clmDtlSeq++);
					exClaimDetail.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_40);		
					exClaimDetail.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_410);		
					
					
					//클레임 상세 구성
					for(OrdDtlCstrtVO ordCstrtVO :  ordDtlCstrtList) {
						clmDtlCstrtPO = new ClmDtlCstrtPO();
						clmDtlCstrtPO.setClmNo(clmNo);
						clmDtlCstrtPO.setClmDtlSeq(exClaimDetail.getClmDtlSeq());
						clmDtlCstrtPO.setClmCstrtSeq(ordCstrtVO.getOrdCstrtSeq());
						clmDtlCstrtPO.setCstrtGoodsId(ordCstrtVO.getCstrtGoodsId());
						clmDtlCstrtPO.setSkuCd(ordCstrtVO.getSkuCd());
						clmDtlCstrtPO.setOrdDtlCstrtNo(ordCstrtVO.getOrdDtlCstrtNo());
						clmDtlCstrtPO.setCstrtGoodsGbCd(ordCstrtVO.getCstrtGoodsGbCd());
						clmDtlCstrtPO.setCstrtQty(ordCstrtVO.getCstrtQty());
						clmDtlCstrtPO.setOrgSaleAmt(ordCstrtVO.getOrgSaleAmt());
						clmDtlCstrtPO.setSaleAmt(ordCstrtVO.getSaleAmt());
						clmDtlCstrtPO.setOrdNo(ordCstrtVO.getOrdNo());
						clmDtlCstrtPO.setOrdDtlSeq(ordCstrtVO.getOrdDtlSeq());
						clmDtlCstrtPO.setOrdCstrtSeq(ordCstrtVO.getOrdCstrtSeq());
						clmDtlCstrtPO.setOrdDtlStatCd(orderDetailVO.getOrdDtlStatCd());
						
						//주문 취소 param
						clmDtlCstrtPO.setClmQty(clmQty);
						clmDtlCstrtList.add(clmDtlCstrtPO);
						
						//교환배송 재고 차감
						if (accept) {
							goodsStockService.updateStockQty(clmDtlCstrtPO.getCstrtGoodsId(), (clmDtlCstrtPO.getClmQty() * clmDtlCstrtPO.getCstrtQty())  * -1); 
						}
					}
					
					if (accept) {
						// a) 배송지 정보 설정
						if (chgOrdDlvraNo != null) {
							exClaimDetail.setDlvraNo(chgOrdDlvraNo);
						} else {
							exClaimDetail.setDlvraNo(orderDetailVO.getOrdDlvraNo());
						}
						
						exClaimDetail.setRtrnaNo(null);
					}
					
					// b) 교환 배송비 설정
					exClaimDetail.setDlvrcNo(dlvrcNo);
					exClaimDetail.setRtnDlvrcNo(null);

					claimDetailList.add(exClaimDetail);
				}
			} // claimAccept
		} // for orderDetailList

		if (claimDetailList == null || claimDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NO_GOODS);
		}
		
		clmAccept.setClmBlameCd(clmBlameCd);
		
		clmAccept.setClaimBase(claimBase);					// 클레임 기본
		clmAccept.setClaimDetailList(claimDetailList);		// 클레임 상세
		clmAccept.setClmDtlCstrtList(clmDtlCstrtList);		// 클레임 상세 구성
		clmAccept.setClmDlvrcList(clmDlvrcList);			// 반품/교환 배송비
		clmAccept.setOrderDlvraList(orderDlvraList);		// 배송지 및 회수지 정보
		
		return clmAccept;
	}
	
	
	/*
	 * 클레임 환불 예정금액 조회
	 * 
	 * @see biz.app.claim.service.ClaimService#getClaimRefundExcpect(biz.app.claim.model.ClaimRegist)
	 */
	@Override
	public ClaimRefundVO getClaimRefundExcpect(ClaimRegist clmRegist, String clmTpCd) {
		
		ClaimRefundVO result = new ClaimRefundVO();
		ClaimAccept clmAccept = getClaimBefore(clmRegist, false);
		
		ClaimBasePO claimBase = clmAccept.getClaimBase();
		List<ClaimDetailVO> claimDetailList = clmAccept.getClaimDetailList();
		List<DeliveryChargePO> clmDlvrcList = clmAccept.getClmDlvrcList();

		//------------------------------------------------
		// 1. 원 배송비 재계산
		//------------------------------------------------
		claimBase.setClmRsnCd(clmRegist.getClmRsnCd());
		claimBase.setClmTpCd(clmTpCd);
		deliveryChargeService.estimateDeliveryCharge(claimBase, clmDlvrcList, claimDetailList);
		
		//------------------------------------------------
		// 2. 환불금액 계산 (상품쿠폰할인금액,장바구니 쿠폰 할인금액, 반품/교환비)
		//------------------------------------------------

		// 1) 상품 환불 금액
		Long goodsAmt = 0L;
		Long cpDcAmt = 0L;
		Long cartCpDcAmt = 0L;
		if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd()) || CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) {
			for (ClaimDetailVO cdvo : claimDetailList) {
				goodsAmt += cdvo.getClmQty() * (cdvo.getSaleAmt() - cdvo.getPrmtDcAmt());
				cpDcAmt += cdvo.getClmQty() * cdvo.getCpDcAmt();
				cartCpDcAmt += cdvo.getClmQty() * cdvo.getCartCpDcAmt();
				//장바구니 쿠폰 할인금액 남은금액 처리.
				cartCpDcAmt += (cdvo.getRmnPayAmt() * -1L);

			}
		}
		
		result.setGoodsAmt(goodsAmt);
		result.setCpDcAmt(cpDcAmt);
		result.setCartCpDcAmt(cartCpDcAmt);
		
		ClaimBasePO refundAmtVO = deliveryChargeService.selectDeliveryCharge(claimBase);
		
		result.setClmDlvrcAmt(refundAmtVO.getClmDlvrcAmt());
		result.setClmDlvrcAmtCostGb10(refundAmtVO.getClaimDlvrcAmtCostGb10());
		result.setClmDlvrcAmtCostGb20(refundAmtVO.getClaimDlvrcAmtCostGb20());
		result.setOrgDlvrcAmt(refundAmtVO.getOrgDlvrcAmt());
		result.setRefundDlvrAmt(refundAmtVO.getRefundDlvrAmt());
		result.setAddOrgDlvrcAmt(0L);
		result.setAddReduceDlvrcAmt(0L);	

		Long realDlvrAmt = 0L;  // 클레임 대상 배송비(고객 귀책 반품이고 개별부과나 잔여수량이 0일경우에만 지불된 실배송비 표시)
		for (DeliveryChargePO dcpo : clmDlvrcList) {
			realDlvrAmt += dcpo.getPaidDlvrAmt();
		}
		result.setRealDlvrAmt(realDlvrAmt);
		
		//		Long totAmt = goodsAmt + result.getOrgDlvrcAmt() - (cpDcAmt + cartCpDcAmt) - result.getReduceDlvrcAmt() - refundAmtVO.getClmDlvrcAmt();
		Long totAmt = goodsAmt - (cpDcAmt + cartCpDcAmt) + refundAmtVO.getTotAmt();
		
		
		Long mpRefundAddUsePnt = 0L;
		/* MP 포인트 재계산 사용여부 체크 - N Start */
		//우주코인 추가할인부터 빼준다.
		CodeDetailSO codeSO = new CodeDetailSO();
		codeSO.setGrpCd(CommonConstants.PNT_TP);
		codeSO.setDtlCd(CommonConstants.PNT_TP_MP);
		CodeDetailVO mpCodeVO = codeService.getCodeDetail(codeSO);
		String mpReCalculateYn = StringUtil.isEmpty(mpCodeVO.getUsrDfn2Val()) ? "Y" : mpCodeVO.getUsrDfn2Val();
		result.setMpReCalculateYn(mpReCalculateYn);
		
		if("N".equals(mpReCalculateYn)) {
			SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
			mpSO.setOrdNo(claimBase.getOrdNo());
			SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
			
			if(totAmt > 0 && mpVO != null && mpVO.getRmnAddUsePnt() > 0) {
				if(totAmt > mpVO.getRmnAddUsePnt()) {
					totAmt -= mpVO.getRmnAddUsePnt();
					mpRefundAddUsePnt = mpVO.getRmnAddUsePnt();
				}else {
					mpRefundAddUsePnt = totAmt;
					totAmt = 0L;
				}
			}
		}
		/* MP 포인트 재계산 사용여부 체크 - N End */
		
		result.setTotAmt(totAmt);

		// 결제 정보
		List<PayBasePO> payBaseList = null;
		if ((CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd()) || CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) && totAmt > 0) {
			payBaseList = this.payBaseService.listPayBaseRefundExpect(claimBase.getOrdNo(), totAmt);
		}

		
		Long mpRefundAllPnt = 0L;
		// 5) 수단별 환불금액
		List<Means> refundMeansList = new ArrayList<>();
		Means mean = null;

		if (payBaseList != null && !payBaseList.isEmpty()) {
			for (PayBasePO pbpo : payBaseList) {
				mean = new Means();
				mean.setPayMeansCd(pbpo.getPayMeansCd());
				if (CommonConstants.PAY_MEANS_10.equals(pbpo.getPayMeansCd())) {
					mean.setMeansNm("신용카드");
				}else if(CommonConstants.PAY_MEANS_11.equals(pbpo.getPayMeansCd())) {
					mean.setMeansNm("간편카드");
				}else if(CommonConstants.PAY_MEANS_20.equals(pbpo.getPayMeansCd())
						|| CommonConstants.PAY_MEANS_30.equals(pbpo.getPayMeansCd())) {
					mean.setMeansNm("계좌이체");
				}else if(CommonConstants.PAY_MEANS_70.equals(pbpo.getPayMeansCd())) {
					mean.setMeansNm("네이버페이");
				}else if(CommonConstants.PAY_MEANS_71.equals(pbpo.getPayMeansCd())) {
					mean.setMeansNm("카카오페이");
				}else if(CommonConstants.PAY_MEANS_72.equals(pbpo.getPayMeansCd())) {
					mean.setMeansNm("페이코");
				}else if(CommonConstants.PAY_MEANS_81.equals(pbpo.getPayMeansCd())) {
					mpRefundAllPnt = pbpo.getPayAmt();
				}
					
				mean.setRefundAmt(pbpo.getPayAmt());
				refundMeansList.add(mean);
			}
		}
		

		if (refundMeansList != null && !refundMeansList.isEmpty()) {
			result.setMeansList(refundMeansList);
		}
		
		
		Long mpRefundUsePnt = 0L;
		
		//MP 포인트 환불건이 있는 경우
		if(CollectionUtils.isNotEmpty(payBaseList) && mpRefundAllPnt > 0) {
			
			SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
			mpSO.setOrdNo(claimBase.getOrdNo());
			SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
			
			Long usePnt = Optional.ofNullable(mpVO.getUsePnt()).orElse(0L);
			
			PayBaseSO pbso = new PayBaseSO();
			pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
			pbso.setOrdNo(claimBase.getOrdNo());
			pbso.setCncYn(CommonConstants.COMM_YN_N);
			pbso.setPayMeansCd(CommonConstants.PAY_MEANS_81);
			
			PayBaseVO pbVO = this.payBaseDao.getPayBase(pbso);
			
			//결제한 건이 부스트업 인지 확인
			if(mpVO != null && mpVO.getUseRate() != null && mpVO.getUseRate() > 0) {
				//잔여 결제금액
				Long payRmnAmt = pbVO.getPayRmnAmt();
				
				
				//예상금액은 결제기준으로 변경
				/*//부스트업 이었다가 아니게 된경우
				if(nowMpPntVO != null && !CommonConstants.PNT_PRMT_GB_20.equals(nowMpPntVO.getPntPrmtGbCd())) {
					Long mpAddUsePnt = payRmnAmt - mpVO.getUsePnt();
					
					Long refundAmt = mpRefundAllPnt;
					
					//추가 사용금액을 먼저 차감. 
					if(refundAmt > mpAddUsePnt) {
						refundAmt -= mpAddUsePnt;
						mpRefundUsePnt = refundAmt;
						mpRefundAddUsePnt = mpAddUsePnt;
					}else {
						mpRefundUsePnt = 0L;
						mpRefundAddUsePnt = refundAmt;
					}
				}else {
				}*/
				/* MP 포인트 재계산 사용여부 체크 - N Start */
				if("N".equals(mpReCalculateYn)) {
					mpRefundUsePnt = mpRefundAllPnt - mpRefundAddUsePnt;
				/* MP 포인트 재계산 사용여부 체크 - N End */
				}else {
					//환불 금액
					if(mpRefundAllPnt.equals(payRmnAmt)) {
						mpRefundUsePnt = usePnt;
						mpRefundAddUsePnt = mpRefundAllPnt - mpRefundUsePnt;
					}else {
						//재결제 금액
						Long reUseAllPnt = pbVO.getPayRmnAmt() - mpRefundAllPnt;
						
						Long reUsePnt = (long) Math.floor(reUseAllPnt.doubleValue() * (100 / (100 + mpVO.getUseRate())));
						
						mpRefundUsePnt = usePnt - reUsePnt;
						mpRefundAddUsePnt = mpRefundAllPnt - mpRefundUsePnt;
					}
				}
				
			}else {
				
				mpRefundUsePnt = mpRefundAllPnt;
				mpRefundAddUsePnt = 0L;
			}
		}
		
		result.setMpRefundUsePnt(mpRefundUsePnt);
		result.setMpRefundAddUsePnt(mpRefundAddUsePnt);
		
		log.debug("getClaimRefundExcpect returns " + result );
		return result;
	}


	/*
	 * 반품 거부 완료
	 * 
	 * @see biz.app.claim.service.ClaimService#completeClaimReturnRefuse(java.lang.String, java.lang.Integer[], java.lang.Integer[], java.lang.String, java.lang.Long)
	 */
	@Override
	public void completeClaimReturnRefuse(String clmNo, Integer[] arrClmDtlSeq, Integer[] arrRefuseQty, String clmDenyRsnContent, Long cpltrNo) {
		//arrClmDtlSeq -  사용안함 전체 반품 거부 완료
		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		
		//------------------------------------------------
		// 2. Validation
		//------------------------------------------------
		
		// 클레임 기본이 진행중인 경우에만 가능
		if (!CommonConstants.CLM_STAT_20.equals(claimBase.getClmStatCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_ING_POSSIBLE);
		}

		
		//------------------------------------------------
		// 3. 클레임 상세 목록 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);
		if (claimDetailList == null || claimDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		for (ClaimDetailVO claimDetail : claimDetailList) {
			
			// 클레임 상세 유형이 반품인 경우에만 가능
			if (!CommonConstants.CLM_DTL_TP_20.equals(claimDetail.getClmDtlTpCd())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_NO_TP);
			}

			// 클레임 상세 상태가 회수완료인 경우에만 가능
			if (!CommonConstants.CLM_DTL_STAT_240.equals(claimDetail.getClmDtlStatCd())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_WITHDRAW_COMPLETE);
			}

			//------------------------------------------------
			// 4. 클레임 상세 상태 변경
			//------------------------------------------------
			ClaimDetailPO cdpo = new ClaimDetailPO();
			cdpo.setClmNo(clmNo);
			cdpo.setClmDtlSeq(claimDetail.getClmDtlSeq());
			cdpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_250);
			cdpo.setClmDenyRsnContent(clmDenyRsnContent);
			this.claimDetailDao.updateClaimDetailStatus(cdpo);
		}


		//------------------------------------------------
		// 5. 클레임 완료 호출
		//------------------------------------------------
		this.completeClaim(clmNo, cpltrNo);

	}

	
	/*
	 * 반품 승인 완료
	 * 
	 * @see biz.app.claim.service.ClaimService#completeClaimReturnConfirm(java.lang.String, java.lang.Integer, java.lang.Long)
	 */
	@Override
	public void completeClaimReturnConfirm(String clmNo, Integer clmDtlSeq, Long cpltrNo) {
		//clmDtlSeq -  사용안함 전체 반품승인완료
		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 2. 클레임 상세 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);

		if (CollectionUtils.isEmpty(claimDetailList)) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 3. Validation
		//------------------------------------------------
		
		// 클레임 기본이 진행중인 경우에만 가능
		if (!CommonConstants.CLM_STAT_20.equals(claimBase.getClmStatCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_ING_POSSIBLE);
		}

		for(ClaimDetailVO claimDetail : claimDetailList) {
			// 클레임 상세 유형이 반품인 경우에만 가능
			if (!CommonConstants.CLM_DTL_TP_20.equals(claimDetail.getClmDtlTpCd())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_NO_TP);
			}
			
			// 클레임 상세 상태가 반품회수완료인 경우에만 가능
			if (!CommonConstants.CLM_DTL_STAT_240.equals(claimDetail.getClmDtlStatCd())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_WITHDRAW_COMPLETE);
			}
			
			//------------------------------------------------
			// 4. 클레임 상세 상태 변경
			//------------------------------------------------
			ClaimDetailPO cdpo = new ClaimDetailPO();
			cdpo.setClmNo(clmNo);
			cdpo.setClmDtlSeq(claimDetail.getClmDtlSeq());
			cdpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_260);		// 반품승인완료
			this.claimDetailDao.updateClaimDetailStatus(cdpo);
		}
		
		//------------------------------------------------
		// 5. 클레임 완료 호출
		//------------------------------------------------
		this.completeClaim(clmNo, cpltrNo);

	}

	
	/*
	 * 교환 거부 완료
	 * 
	 * @see
	 * biz.app.claim.service.ClaimService#completeClaimExchangeRefuse(java.lang.String, java.lang.Integer[], java.lang.Integer[], java.lang.String,java.lang.Long)
	 */
	@Override
	public void completeClaimExchangeRefuse(String clmNo, Integer[] arrClmDtlSeq, Integer[] arrRefuseQty, String clmDenyRsnContent, Long cpltrNo) {

		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		
		//------------------------------------------------
		// 2. Validation
		//------------------------------------------------
		
		// 클레임 기본이 진행중인 경우에만 가능
		if (!CommonConstants.CLM_STAT_20.equals(claimBase.getClmStatCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_ING_POSSIBLE);
		}

		
		//------------------------------------------------
		// 3. 클레임 상세 목록 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		cdso.setArrClmDtlSeq(arrClmDtlSeq);
		List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);

		if (claimDetailList == null || claimDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		for (ClaimDetailVO claimDetail : claimDetailList) {
			// 클레임 상세 유형이 교환회수인 경우에만 가능
			if (!CommonConstants.CLM_DTL_TP_30.equals(claimDetail.getClmDtlTpCd())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_NO_TP);
			}

			// 클레임 상세 상태가 회수완료인 경우에만 가능
			if (!CommonConstants.CLM_DTL_STAT_340.equals(claimDetail.getClmDtlStatCd())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_WITHDRAW_COMPLETE);
			}

			//------------------------------------------------
			// 4. 클레임 상세 상태 변경
			//------------------------------------------------
			ClaimDetailPO cdpo = new ClaimDetailPO();
			cdpo.setClmNo(clmNo);
			cdpo.setClmDtlSeq(claimDetail.getClmDtlSeq());
			cdpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_350);
			cdpo.setClmDenyRsnContent(clmDenyRsnContent);
			this.claimDetailDao.updateClaimDetailStatus(cdpo);
		}
		
		this.completeClaim(clmNo,cpltrNo);
	}

	
	/*
	 * 교환 승인 완료
	 * 
	 * @see
	 * biz.app.claim.service.ClaimService#completeClaimExchangeConfirm(java.lang.String, java.lang.Integer, java.lang.Long)
	 */
	@Override
	public void completeClaimExchangeConfirm(String clmNo, Integer clmDtlSeq, Long cpltrNo) {

		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		
		//------------------------------------------------
		// 2. 클레임 상세 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		cdso.setClmDtlSeq(clmDtlSeq);
		ClaimDetailVO claimDetail = this.claimDetailDao.getClaimDetail(cdso);

		if (claimDetail == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 3. Validation
		//------------------------------------------------
		
		// 클레임 기본이 진행중인 경우에만 가능
		if (!CommonConstants.CLM_STAT_20.equals(claimBase.getClmStatCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_ING_POSSIBLE);
		}
				
		// 클레임 상세 유형이 교환회수인 경우에만 가능
		if (!CommonConstants.CLM_DTL_TP_30.equals(claimDetail.getClmDtlTpCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_NO_TP);
		}

		// 클레임 상세 상태가 회수완료인 경우에만 가능
		if (!CommonConstants.CLM_DTL_STAT_340.equals(claimDetail.getClmDtlStatCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_WITHDRAW_COMPLETE);
		}

		
		//------------------------------------------------
		// 4. 클레임 상세 상태 변경
		//------------------------------------------------
		ClaimDetailPO cdpo = new ClaimDetailPO();
		cdpo.setClmNo(clmNo);
		cdpo.setClmDtlSeq(clmDtlSeq);
		cdpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_360);
		this.claimDetailDao.updateClaimDetailStatus(cdpo);
		
		this.completeClaim(clmNo,cpltrNo);
	}

	
	/*
	 * 클레임 완료 처리
	 * 
	 * @see biz.app.claim.service.ClaimService#completeClaim(java.lang.String, java.lang.Long)
	 */
	@Override
	public void completeClaim(String clmNo, Long cpltrNo) {

		boolean compleClaim = true;
		AplBnftPO abpo = null;
		MemberCouponPO mcpo = null;

		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);

		if (claimBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 2. 클레임 상세 목록 조회
		//------------------------------------------------
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(claimBase.getClmNo());
		List<ClaimDetailVO> claimDetailList = this.claimDetailDao.listClaimDetail(cdso);

		if (claimDetailList == null || claimDetailList.isEmpty()) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 3. 주문취소/반품일 경우 처리 로직
		//------------------------------------------------
		if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd()) || CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) {
			// 1) 클레임 취소 수량 단품 웹재고에 반영
			if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())) {
				for (ClaimDetailVO cdvo : claimDetailList) {
					if (CommonConstants.COMP_GB_20.equals(cdvo.getCompGbCd())
							|| CommonConstants.COMM_YN_Y.equals(cdvo.getRsvGoodsYn())) {
						// 20210817 CSR-1575 CIS를 통해 재고수량 업데이트 후 주문 시 웹 재고 차감만 하고 취소 시는 원복 로직을 제외 (자사인경우만)
						ClaimDetailSO cstrtSO = new ClaimDetailSO();
						cstrtSO.setClmNo(cdvo.getClmNo());
						cstrtSO.setClmDtlSeq(cdvo.getClmDtlSeq());
						List<ClmDtlCstrtPO> cstrtList = clmDtlCstrtDao.listClmDtlCstrt(cstrtSO);
						for(ClmDtlCstrtPO cstrt : cstrtList) {
							goodsStockService.updateStockQty(cstrt.getCstrtGoodsId(), cdvo.getClmQty() * cstrt.getCstrtQty());
						}
					}
				}
			}

			
			// 2) 적용 혜택 취소
			OrderDetailSO odso = new OrderDetailSO();
			odso.setOrdNo(claimBase.getOrdNo());
			List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);

			for (OrderDetailVO odvo : orderDetailList) {
				// 최종 잔여 주문 수량이 존재하지 않을 경우 적용 혜택 취소
				if (odvo.getRmnOrdQty() - odvo.getRtnQty() == 0) {
					abpo = new AplBnftPO();
					abpo.setOrdNo(odvo.getOrdNo());
					abpo.setOrdDtlSeq(odvo.getOrdDtlSeq());
					this.aplBnftDao.updateAplBnftCancel(abpo);
				}
			}

			
			// 3) 취소된 내역중 쿠폰에 대한 복원 처리
			// - 중복사용된 경우 전체가 취소되었을때만 취소 처리
			// - 쿠폰 복원 여부가 Y일 경우에만 복원
			List<AplBnftVO> aplBnftList = this.aplBnftDao.listAplBnftCancelCoupon(claimBase.getOrdNo());

			if (aplBnftList != null && !aplBnftList.isEmpty()) {
				for (AplBnftVO abvo : aplBnftList) {
					mcpo = new MemberCouponPO();
					mcpo.setMbrCpNo(abvo.getMbrCpNo());
					int result = this.memberCouponDao.updateMemberCouponUseCancel(mcpo);

					if (result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

				}
			}

			
			// 4) 배송비 쿠폰 복원
			// - 복원대상 배송비 쿠폰 조회 클레임에 의해 발송된 배송비가 존재하지 않고 취소된 배송비만 존재하는 경우 or 고객 귀책으로 반품된 케이스가 없는 경우
			// - 쿠폰 복원 여부가 Y일 경우에만 복원
			List<DeliveryChargeVO> deliveryChargeList = this.deliveryChargeDao.listDeliveryChargeCancelCoupon(claimBase.getClmNo());

			if (deliveryChargeList != null && !deliveryChargeList.isEmpty()) {
				for (DeliveryChargeVO dcvo : deliveryChargeList) {
					mcpo = new MemberCouponPO();
					mcpo.setMbrCpNo(dcvo.getMbrCpNo());
					int result = this.memberCouponDao.updateMemberCouponUseCancel(mcpo);

					if (result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

				}
			} else {
				// CSR-1590 쿠폰 원복
				if (CommonConstants.CLM_TP_10.equals(claimBase.getClmTpCd())) {
					List<DeliveryChargeVO> deliveryCancelList = this.deliveryChargeDao.deliveryCancelCouponWon(claimBase.getClmNo());
					if (deliveryCancelList != null && !deliveryCancelList.isEmpty()) {
						for (DeliveryChargeVO dcvo : deliveryCancelList) {
							MemberCouponPO mpo = new MemberCouponPO();
							mpo.setMbrCpNo(dcvo.getMbrCpNo());
							int result = this.memberCouponDao.updateMemberCouponUseCancel(mpo);
			
							if (result != 1) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
						}
					}
				}
			}
			
			// 5) 포인트 회수
			// 반품, 구매확정인 경우 포인트 회수
			for (OrderDetailVO odvo : orderDetailList) {
				for (ClaimDetailVO claimDetail : claimDetailList) {
					if (odvo.getOrdDtlSeq().equals(claimDetail.getOrdDtlSeq())) {
						//발급 예정 포인트 업데이트
						//본래 order_detail 잔여수량
						Integer orgQty = odvo.getRmnOrdQty() - odvo.getRtnQty() + claimDetail.getClmQty();
						Integer isuSchdPnt = odvo.getIsuSchdPnt();
						
						int minusPnt;
						if(orgQty == 0) {
							//수정 포인트 0 처리
							minusPnt = isuSchdPnt;
						}else {
							minusPnt = (int) Math.floor((claimDetail.getClmQty().doubleValue() / orgQty.doubleValue()) * isuSchdPnt.doubleValue());
						}
						int reIsuSchdPnt = isuSchdPnt - minusPnt;
						
						if(Integer.compare(isuSchdPnt, reIsuSchdPnt) != 0) {
							OrderDetailPO detailPO = new OrderDetailPO();
							detailPO.setOrdNo(odvo.getOrdNo());
							detailPO.setOrdDtlSeq(odvo.getOrdDtlSeq());
							detailPO.setIsuSchdPnt(reIsuSchdPnt);
							int result = orderDetailDao.updateOrderDetail(detailPO);
							
							if (result != 1) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
							//구매확정
							if (CommonConstants.ORD_DTL_STAT_170.equals(odvo.getOrdDtlStatCd())) {
								//적립 포인트 재 지급
								OrdSavePntPO pntPO = new OrdSavePntPO();
								pntPO.setMbrNo(claimDetail.getMbrNo());
								pntPO.setRcptNo(claimDetail.getClmNo().concat(claimDetail.getClmDtlSeq().toString()));
								pntPO.setPnt(reIsuSchdPnt);
								pntPO.setSaleAmt(odvo.getPayAmt() * (odvo.getRmnOrdQty() - odvo.getRtnQty()));
								pntPO.setSaleDtm(claimDetail.getSysRegDtm());
								pntPO.setOrdNo(claimDetail.getOrdNo());
								pntPO.setOrdDtlSeq(claimDetail.getOrdDtlSeq());
								pntPO.setClmNo(claimDetail.getClmNo());
								pntPO.setClmDtlSeq(claimDetail.getClmDtlSeq());
								
								//Table PO 변경
								/*
								OrdSavePntPO pntPO = new OrdSavePntPO();
								pntPO.setMbrNo(claimDetail.getMbrNo());
								pntPO.setRcptNo(claimDetail.getClmNo().concat(claimDetail.getClmDtlSeq().toString()));
								pntPO.setPnt(reIsuSchdPnt);
								pntPO.setPayAmt(odvo.getPayAmt() * (odvo.getRmnOrdQty() - odvo.getRtnQty()));
								pntPO.setDealDtm(claimDetail.getSysRegDtm());
								pntPO.setOrdNo(claimDetail.getOrdNo());
								pntPO.setOrdDtlSeq(claimDetail.getOrdDtlSeq());
								pntPO.setClmNo(claimDetail.getClmNo());
								pntPO.setClmDtlSeq(claimDetail.getClmDtlSeq());
								*/
								
								ordSavePntService.accumReOrdGsPoint(pntPO);
							}
						}
					}
				}
			}
		}

		
		//------------------------------------------------
		// 4. 클레임 완료 처리
		//------------------------------------------------

		// 클레임 상세 상태 체크
		String exRtnClmDtlStatCd = null;		// 교환 회수 상태코드

		
		for (ClaimDetailVO claimDetail : claimDetailList) {
			String swapYn = "N";
			if(CommonConstants.COMP_GB_10.equals(claimDetail.getCompGbCd())){
				swapYn = claimDetail.getSwapYn();
			}else {
				swapYn = "N";
			}
				
			
			// 주문 취소
			if (CommonConstants.CLM_DTL_TP_10.equals(claimDetail.getClmDtlTpCd())) {
				if (!CommonConstants.CLM_DTL_STAT_120.equals(claimDetail.getClmDtlStatCd())) {
					compleClaim = false;
				}
			}
			// 반품
			else if (CommonConstants.CLM_DTL_TP_20.equals(claimDetail.getClmDtlTpCd())) {
				if (!CommonConstants.CLM_DTL_STAT_250.equals(claimDetail.getClmDtlStatCd())
						&& !CommonConstants.CLM_DTL_STAT_260.equals(claimDetail.getClmDtlStatCd())) {
					compleClaim = false;
				}
			}
			// 교환회수
			else if (CommonConstants.CLM_DTL_TP_30.equals(claimDetail.getClmDtlTpCd())) {
				if (!CommonConstants.CLM_DTL_STAT_350.equals(claimDetail.getClmDtlStatCd())
						&& !CommonConstants.CLM_DTL_STAT_360.equals(claimDetail.getClmDtlStatCd())) {
					compleClaim = false;
				}
				exRtnClmDtlStatCd = claimDetail.getClmDtlStatCd();
			}
			// 교환배송
			else if (CommonConstants.CLM_DTL_TP_40.equals(claimDetail.getClmDtlTpCd()) && exRtnClmDtlStatCd != null
					//&& CommonConstants.CLM_DTL_STAT_360.equals(exRtnClmDtlStatCd)
					&& !(CommonConstants.COMM_YN_N.equals(swapYn) && CommonConstants.CLM_DTL_STAT_350.equals(exRtnClmDtlStatCd))
					&& !CommonConstants.CLM_DTL_STAT_450.equals(claimDetail.getClmDtlStatCd())) {
				//맞교환 아닐 경우, 회수거부완료일 경우 교환배송 상태 보지 않음.
				compleClaim = false;
			}
		}
		
		//반품 처리 코드
		String rtnPrcsCd = "";
		
		if(CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())){
			//반품 거부 완료
			if(claimDetailList.stream().allMatch(vo -> CommonConstants.CLM_DTL_STAT_250.equals(vo.getClmDtlStatCd()))) {
				rtnPrcsCd = CommonConstants.CLM_DTL_STAT_250;
			}else if(claimDetailList.stream().allMatch(vo -> CommonConstants.CLM_DTL_STAT_260.equals(vo.getClmDtlStatCd()))) {
				rtnPrcsCd = CommonConstants.CLM_DTL_STAT_260;
			}else {
				throw new CustomException(ExceptionConstants.ERROR_CLM_RETURN_COMPLETE_ERROR);
			}
		}
			

		// 클레임 기본 완료 처리
		if (compleClaim) {
			ClaimBasePO cbpo = new ClaimBasePO();
			cbpo.setClmNo(clmNo);
			cbpo.setCpltrNo(cpltrNo);
			cbpo.setClmStatCd(CommonConstants.CLM_STAT_30);

			int claimCancelResult = this.claimBaseDao.updateClaimBase(cbpo);

			if (claimCancelResult != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			//2021-05-10 전체 반품거부완료가 아닐경우
			if(!CommonConstants.CLM_DTL_STAT_250.equals(rtnPrcsCd)){
				//적립 대상금액 구하기 - 환불시 실패할수도있음.
				Long mainPayMeansAmt = 0L;
				
				PayBaseSO pbso = new PayBaseSO();
				pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
				pbso.setClmNo(clmNo);
				pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
				List<PayBaseVO> refundPayList = this.payBaseDao.listPayBase(pbso);
				
				//------------------------------------------------
				// 2. 결제 주문정보 조회
				//------------------------------------------------
				pbso = new PayBaseSO();
				pbso.setOrdNo(claimBase.getOrdNo());
				pbso.setPayGbCd(CommonConstants.PAY_GB_10);
				pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
				pbso.setCncYn(CommonConstants.COMM_YN_N);
				pbso.setPayStatCd(CommonConstants.PAY_STAT_01);
				
				List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);
				
				for(PayBaseVO vo : payBaseList) {
					if(!CommonConstants.PAY_MEANS_80.equals(vo.getPayMeansCd()) && !CommonConstants.PAY_MEANS_81.equals(vo.getPayMeansCd())) {
						mainPayMeansAmt += vo.getPayRmnAmt();
					}
				}
				
				//주결제 환불금 빼줌.
				for(PayBaseVO vo : refundPayList) {
					if(!CommonConstants.PAY_MEANS_80.equals(vo.getPayMeansCd()) && !CommonConstants.PAY_MEANS_81.equals(vo.getPayMeansCd())) {
						mainPayMeansAmt -= vo.getPayRmnAmt();
					}
				}
				
				
				
				// 결제 환불 처리
				this.payBaseService.completePayBaseRefund(clmNo);
				
				//GS포인트 재계산 및 SKT 포인트 환불 처리
				this.excutePntProcess(claimBase, mainPayMeansAmt);
			}
			
			// 반품 완료시 알림톡 전송 (반품승인이 하나라도 있을 경우, 반품승인건만 전송)
			if(claimDetailList.stream().anyMatch(vo -> CommonConstants.CLM_DTL_STAT_260.equals(vo.getClmDtlStatCd()))) {
				orderService.sendMessage(claimBase.getOrdNo(), clmNo, "K_M_ord_0011", null);
			}
		}
	}

	
	/**
	 * CS 관리 - CS 접수 팝업에서 접수처리(회원/비회원)
	 * 
	 * @see biz.app.claim.service.ClaimService#claimCsAcceptNonOrderExec(biz.app.order.model.OrderSO, biz.app.counsel.model.CounselPO)
	 */
	@Override
	public void claimCsAcceptNonOrderExec(OrderSO orderSO, CounselPO counselPO) {

		//------------------------------------------------
		// 1. CS 정보 세팅
		//------------------------------------------------
		
		// 문의자 회원 번호
		counselPO.setEqrrMbrNo(orderSO.getMbrNo());

		// 상담 상태 코드 : 접수
		counselPO.setCusStatCd(AdminConstants.CUS_STAT_10);

		// 상담 경로 코드 : WEB
		counselPO.setCusPathCd(AdminConstants.CUS_PATH_10);

		// 상담 접수자 번호
		counselPO.setCusAcptrNo(AdminSessionUtil.getSession().getUsrNo());

		
		//------------------------------------------------
		// 2. CS 등록
		//------------------------------------------------
		int result = counselDao.insertCounsel(counselPO);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	/**
	 * CS 관리 - CS 접수 팝업에서 완료처리(회원/비회원)
	 * 
	 * @see biz.app.claim.service.ClaimService#counselComplete(biz.app.order.model.OrderSO, biz.app.counsel.model.CounselPO)
	 */
	@Deprecated
	@Override
	public void counselComplete(OrderSO orderSO, CounselPO counselPO) {

		// CS 접수
		claimCsAcceptNonOrderExec(orderSO, counselPO);
		
		counselPO.setEqrrMbrNo(orderSO.getMbrNo());					// 회원 번호
		counselPO.setCusStatCd(AdminConstants.CUS_STAT_20);			// 상담 상태 코드 : 접수
		counselPO.setCusPathCd(AdminConstants.CUS_PATH_10);			// 상담 경로 코드 : 콜센터
		
		counselPO.setCusAcptrNo(AdminSessionUtil.getSession().getUsrNo());	// 상담 접수자 번호
		counselPO.setCusCpltrNo(AdminSessionUtil.getSession().getUsrNo());	// 상담처리자 번호

		
		// CS 완료 처리
		int result = counselDao.updateCounselComplete(counselPO);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	/*
	 * 반품 목록 페이징 조회
	 * 
	 * @see biz.app.claim.service.ClaimService#pageClaim(biz.app.claim.model.ClaimSO)
	 */
	@Override
	public List<ClaimListVO> pageClaim(ClaimSO claimSO) {
		return claimDao.pageClaim(claimSO);
	}

	/*
	 * 반품 목록 페이징 조회 (API용)
	 * 
	 * @see
	 * biz.app.claim.service.ClaimService#pageClaimInterface(biz.app.claim.model.interfaces.ClaimSO)
	 */
	@Override
	public List<biz.app.claim.model.interfaces.ClaimListVO> pageClaimInterface(biz.app.claim.model.interfaces.ClaimSO claimSO) {
		return claimDao.pageClaimInterface(claimSO);
	}

	/*
	 * 반품/교환 회수 완료
	 * 
	 * @see
	 * biz.app.claim.service.ClaimService#claimProductRecoveryFinalExec(java.lang.String, java.lang.Integer)
	 */
	@Override
	public void claimProductRecoveryFinalExec(String clmNo, Integer clmDtlSeq) {

		String clmDtlStatCd = null;

		//------------------------------------------------
		// 1. 클레임 상세 조회
		//------------------------------------------------
		ClaimDetailSO so = new ClaimDetailSO();
		so.setClmNo(clmNo);
		so.setClmDtlSeq(clmDtlSeq);
		ClaimDetailVO claimDetail = this.claimDetailDao.getClaimDetail(so);
		
		if (claimDetail == null) {
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		
		//------------------------------------------------
		// 2. Validation
		//------------------------------------------------
		
		// 반품회수 또는 교환회수가 아닌경우
		if (!CommonConstants.CLM_DTL_TP_20.equals(claimDetail.getClmDtlTpCd())
				&& !CommonConstants.CLM_DTL_TP_30.equals(claimDetail.getClmDtlTpCd())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_NO_TP);
		}

		// 반품인 경우 회수지시 또는 회수중 상태에서만 가능
		if (CommonConstants.CLM_DTL_TP_20.equals(claimDetail.getClmDtlTpCd())) {
			if (!CommonConstants.CLM_DTL_STAT_220.equals(claimDetail.getClmDtlStatCd())
					&& !CommonConstants.CLM_DTL_STAT_230.equals(claimDetail.getClmDtlStatCd())) {
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_WITHDRAW_IMPOSSIBLE);
			}
			clmDtlStatCd = AdminConstants.CLM_DTL_STAT_240;
		}

		// 반품인 경우 반품 회수중 상태가 아니라면 오류
		if (CommonConstants.CLM_DTL_TP_30.equals(claimDetail.getClmDtlTpCd())) {
			if (!CommonConstants.CLM_DTL_STAT_320.equals(claimDetail.getClmDtlStatCd())
					&& !CommonConstants.CLM_DTL_STAT_330.equals(claimDetail.getClmDtlStatCd())) {
				throw new CustomException(ExceptionConstants.ERROR_CLAIM_WITHDRAW_IMPOSSIBLE);
			}
			clmDtlStatCd = AdminConstants.CLM_DTL_STAT_340;
		}

		
		//------------------------------------------------
		// 3. 반품/교환 구분에 따른 상태 설정
		//------------------------------------------------
		ClaimDetailPO updateClaimDetailPO = new ClaimDetailPO();
		updateClaimDetailPO.setClmDtlStatCd(clmDtlStatCd);
		updateClaimDetailPO.setClmNo(clmNo);
		updateClaimDetailPO.setClmDtlSeq(clmDtlSeq);
		this.claimDetailDao.updateClaimDetailStatus(updateClaimDetailPO);
	}

	/*
	 * 클레임 목록 조회
	 * 
	 * @see
	 * biz.app.claim.service.ClaimService#pageClaimCancelRefundList(biz.app.claim.model.ClaimSO)
	 */
	@Override
	public List<ClaimBaseVO> pageClaimCancelRefundList(ClaimSO so) {
		return claimDao.pageClaimCancelRefundList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: pageClaimCancelRefundList2ndE
	 * - 작성일		: 2021. 04. 17.
	 * - 작성자		: sorce
	 * - 설명			: 클레임 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderBaseVO> pageClaimCancelRefundList2ndE(ClaimSO so) {
		return claimDao.pageClaimCancelRefundList2ndE(so);
	}
	
	/*
	 * 클레임(환불)
	 * 
	 * @see biz.app.claim.service.ClaimService#getClaimRefund(biz.app.claim.model.ClaimSO)
	 */
	@Override
	public ClaimBaseVO getClaimRefund(ClaimSO claimSO) {
		return claimDao.getClaimRefund(claimSO);
	}

	/*
	 * 클레임(환불 가격)
	 * 
	 * @see biz.app.claim.service.ClaimService#getClaimRefundPay(biz.app.claim.model.ClaimSO)
	 */
	@Override
	public ClaimRefundPayVO getClaimRefundPay(ClaimSO claimSO) {
		return claimDao.getClaimRefundPay(claimSO);
	}

	/*
	 * 취소/교환/반품 현황
	 * 
	 * @see
	 * biz.app.claim.service.ClaimService#claimSummary(biz.app.claim.model.ClaimSO)
	 */
	@Override
	public ClaimSummaryVO claimSummary(ClaimSO claimSO) {
		return claimDao.listClaimCdCountList(claimSO);
	}
	
	/*
	 * 취소/교환/반품 엑셀 데이터 조회 
	 * 
	 * @see biz.app.claim.service.ClaimService#getClaimExcelList(biz.app.claim.model.ClaimSO)
	 */
	@Override
	public List<ClaimListVO> getClaimExcelList(ClaimSO claimSO) {
		return claimDao.getClaimExcelList(claimSO);
	}


	@Override
	public void saveAllImgClaimDetail(ClaimDetailPO po, List<String> imgPaths) {
		if (po == null || imgPaths == null || imgPaths.size() == 0) {
			return;
		}
		
		for (int i=0; i<imgPaths.size(); i++) {
			po.setImgPath(imgPaths.get(i));
			po.setClmDtlRsnSeq(i+1);
			
			claimDetailDao.saveImgClaimDetailFromClmNo(po);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.claim.service
	 * - 작성일		: 2021. 07. 30.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 처리-GS포인트, 우주코인
	 * </pre>
	 * @param claimBase
	 */
	public void excutePntProcess(ClaimBaseVO claimBase, Long mainPayMeansAmt) {
		
		/********************************
		 * 1. 환불건 있는지, 배송비 조회
		 *******************************/
		OrderSO ordSO = new OrderSO();
		ordSO.setOrdNo(claimBase.getOrdNo());
		ordSO.setClmNo(claimBase.getClmNo());
		OrderPayVO checkInfo = orderDao.getOrderPayInfoForPnt(ordSO);
		//order기준 배송비
		Long dlvrAmt = checkInfo.getDlvrAmt();
		Long accumTgAmt = 0L;
		
		/********************************
		 * 2. 적립 대상 금액 구하기 - mainPayMeansAmt
		 *******************************/
		
		OrderDetailVO orderDetail = null;
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(claimBase.getOrdNo());
		List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);
		
		Long totalGoodsPayAmtAfterCartDc = 0L;
		Long orderFixIsuSchdPnt = 0L;
		for (int i = 0; i < orderDetailList.size(); i++) {
			orderDetail = orderDetailList.get(i);
			
			if(CommonConstants.ORD_DTL_STAT_170.equals(orderDetail.getOrdDtlStatCd())) {
				orderFixIsuSchdPnt += orderDetail.getIsuSchdPnt();
			}else {
				totalGoodsPayAmtAfterCartDc += orderDetail.getPayAmt() * (orderDetail.getRmnOrdQty() - orderDetail.getRtnQty());
			}
		}
		
		/********************************
		 * 3. order_detail 적립 예정 GS 포인트 수정
		 *******************************/
		PntInfoSO pntSO = new PntInfoSO();
		pntSO.setPntTpCd(CommonConstants.PNT_TP_GS);
		PntInfoVO gsPntVO = pntInfoService.getPntInfo(pntSO);
		
		List<OrderDetailPO> updatePOList = new ArrayList<>();
		OrderDetailPO updatePO = null;
		accumTgAmt = mainPayMeansAmt - dlvrAmt;
		
		if(gsPntVO != null) {
			double gsPntRate = gsPntVO.getSaveRate() == null ? 0d : gsPntVO.getSaveRate()  * 0.01;
			
			/*
			 * 적립 대상금액
			 * GS 포인트의 경우 각각 구매확정이기 때문에 클레임 완료 시 구매확정한 상품의 적립예정 포인트는 이미 지급했으므로 적립대상금액에서 역계산해서 빼준다.
			 * 예) 3포인트가 구매확정으로 지급한 경우 3 / 0.001 = 3000 을   기준금액에서 빼줌.   
			*/
			Long gsAccumTgAmt = accumTgAmt - (new Double(orderFixIsuSchdPnt.doubleValue() / gsPntRate)).longValue();
			
			if(gsAccumTgAmt < 0) {
				gsAccumTgAmt = 0L;
			}
			
			for (int i = 0; i < orderDetailList.size(); i++) {
				orderDetail = orderDetailList.get(i);
				
				if(!CommonConstants.ORD_DTL_STAT_170.equals(orderDetail.getOrdDtlStatCd())) {
					updatePO = new OrderDetailPO();
					Long orderDetailPayAmt = orderDetail.getPayAmt() * (orderDetail.getRmnOrdQty() - orderDetail.getRtnQty());
					//준회원 일 경우 적립포인트 0
					if(gsAccumTgAmt.equals(0L) || totalGoodsPayAmtAfterCartDc.equals(0L)) {
						updatePO.setIsuSchdPnt(0);
					}else {
						// 기준금액 * (주문디테일지불금액 / 전체 주문금액) * 지급비율
						int savePoint = (int) Math.ceil(gsAccumTgAmt.doubleValue()* (orderDetailPayAmt.doubleValue() / totalGoodsPayAmtAfterCartDc.doubleValue()) * gsPntRate);
						updatePO.setIsuSchdPnt(savePoint);
					}
					
					updatePO.setOrdNo(orderDetail.getOrdNo());
					updatePO.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
					
					updatePOList.add(updatePO);
				}
			}
		}
		
		//주문상세 적립예정 GS 포인트 업데이트
		for(OrderDetailPO detailPO : updatePOList) {
			orderDetailDao.updateOrderDetail(detailPO);
		}
		
		/********************************
		 * 4. SKT MP 포인트 재요청
		 *******************************/
		PayBaseSO pbso = new PayBaseSO();
		pbso.setClmNo(claimBase.getClmNo());
		pbso.setPayMeansCd(CommonConstants.PAY_MEANS_81);
		pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
		
		PayBaseVO mpClmPayBase =  payBaseDao.getPayBase(pbso);
		PayBasePO pbpo = new PayBasePO();
		if(mpClmPayBase != null) {
			pbpo.setPayNo(mpClmPayBase.getPayNo());
		}
		
		
		SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
		mpSO.setOrdNo(claimBase.getOrdNo());
		mpSO.setClmNo(claimBase.getClmNo());
		List<SktmpLnkHistVO> clmMpList = sktmpService.listSktmpLnkHist(mpSO);
		
		OrderBasePO ordBasePO = new OrderBasePO();
		ordBasePO.setOrdNo(claimBase.getOrdNo());
		
		SktmpLnkHistVO cancelMpVO = null;
		SktmpLnkHistVO reReqMpVO = null;
		
		
		for(SktmpLnkHistVO vo : clmMpList) {
			if(CommonConstants.MP_REAL_LNK_GB_10.equals(vo.getMpRealLnkGbCd())) {
				reReqMpVO = vo;
			}else if(CommonConstants.MP_REAL_LNK_GB_20.equals(vo.getMpRealLnkGbCd())) {
				cancelMpVO = vo;
			}
		}
		
		if(cancelMpVO != null) {
			cancelMpVO.setCardNo(bizService.twoWayDecrypt(cancelMpVO.getCardNo()));
			cancelMpVO.setPinNo(bizService.twoWayDecrypt(cancelMpVO.getPinNo()));
			
			SktmpLnkHistSO orgSO = new SktmpLnkHistSO();
			orgSO.setMpLnkHistNo(cancelMpVO.getOrgMpLnkHistNo());
			SktmpLnkHistVO orgVO = sktmpService.getSktmpLnkHist(orgSO);
			cancelMpVO.setCncCfmNo(orgVO.getCfmNo());
			cancelMpVO.setCiCtfVal(checkInfo.getCiCtfVal());
			String cancelErrorCd = null;
			if(!SktmpConstants.RES_SUCCESS_CODE.equals(orgVO.getResCd())) {
				cancelErrorCd = ExceptionConstants.ERROR_SKTMP_RE_REQ_PRE_ERROR;
			}
			
			sktmpService.cancelMpApprove(cancelMpVO, cancelErrorCd);
			
			pbpo.setDealNo(cancelMpVO.getDealNo());
			pbpo.setCfmNo(cancelMpVO.getCfmNo());
			pbpo.setCfmDtm(DateUtil.getTimestamp());
			pbpo.setCfmRstCd(cancelMpVO.getResCd());
			if(cancelMpVO.getResCd() != null ) {
				if(SktmpConstants.RES_SUCCESS_CODE.equals(cancelMpVO.getResCd())) {
					pbpo.setCfmRstMsg("정상");
				}else {
					pbpo.setCfmRstMsg(message.getMessage("business.exception.SKTMP" + cancelMpVO.getResCd()));
				}
			}
			
			ordBasePO.setMpLnkHistNo(cancelMpVO.getMpLnkHistNo());
			
		}
		
		String errorCd = null;
		if(reReqMpVO != null) {
			
			reReqMpVO.setCardNo(bizService.twoWayDecrypt(reReqMpVO.getCardNo()));
			reReqMpVO.setPinNo(bizService.twoWayDecrypt(reReqMpVO.getPinNo()));
			
			pntSO = new PntInfoSO();
			pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
			PntInfoVO nowMpPntVO = pntInfoService.getPntInfo(pntSO);
			
			//기존 요청이 결제 요청인 경우
			SktmpLnkHistSO payMpSO = new SktmpLnkHistSO();
			payMpSO.setPayOrdNo(claimBase.getOrdNo());
			SktmpLnkHistVO orgPayMpVO = sktmpService.getSktmpLnkHist(payMpSO);
			
			String nowDateStr = DateUtil.getNowDate();
			String reqDateStr = DateUtil.getTimestampToString(orgPayMpVO.getReqDtm());
			
			//오늘 재요청을 할 경우 상품코드로 보냄 else -> 대체 상품코드 , 최초 적립포인트가 있는경우
			if(orgPayMpVO.getSaveSchdPnt() != null && orgPayMpVO.getSaveSchdPnt() > 0 &&  nowDateStr.equals(reqDateStr)) {
				reReqMpVO.setIfGoodsCd(nowMpPntVO.getIfGoodsCd());
			}else {
				reReqMpVO.setIfGoodsCd(nowMpPntVO.getAltIfGoodsCd());
			}
			reReqMpVO.setPntNo(nowMpPntVO.getPntNo());
			ISR3K00110ReqVO saveReq = new ISR3K00110ReqVO();
			saveReq.setEBC_NUM1(reReqMpVO.getCardNo());
			saveReq.setGOODS_CD(reReqMpVO.getIfGoodsCd());
			ISR3K00110ResVO saveRes = sktmpService.getMpSaveRmnCount(saveReq);
			if(reReqMpVO.getSaveSchdPnt() != null && reReqMpVO.getSaveSchdPnt() > 0 && Integer.valueOf(saveRes.getACCUM_CNT()) == 0) {
				errorCd = ExceptionConstants.ERROR_SKTMP_RE_REQ_DAY_ACCUM;
			}
			
			if(!SktmpConstants.RES_SUCCESS_CODE.equals(cancelMpVO.getResCd())) {
				errorCd = ExceptionConstants.ERROR_SKTMP_RE_REQ_PRE_ERROR;
			}
			
			reReqMpVO.setCiCtfVal(checkInfo.getCiCtfVal());
			sktmpService.reqMpApprove(reReqMpVO, CommonConstants.ORD_CLM_GB_20, errorCd);
			
			pbpo.setDealNo(reReqMpVO.getDealNo());
			pbpo.setCfmNo(reReqMpVO.getCfmNo());
			pbpo.setCfmDtm(DateUtil.getTimestamp());
			pbpo.setCfmRstCd(reReqMpVO.getResCd());
			if(reReqMpVO.getResCd() != null ) {
				if(SktmpConstants.RES_SUCCESS_CODE.equals(reReqMpVO.getResCd())) {
					pbpo.setCfmRstMsg("정상");
				}else {
					pbpo.setCfmRstMsg(message.getMessage("business.exception.SKTMP" + reReqMpVO.getResCd()));
				}
			}
			
			
			ordBasePO.setMpLnkHistNo(reReqMpVO.getMpLnkHistNo());
		}
		
		if(cancelMpVO != null || reReqMpVO != null) {
			this.orderBaseDao.updateOrderBase(ordBasePO);
			
			//포인트 환불
			if(pbpo.getPayNo() != null) {
				this.payBaseDao.updatePayBaseRefundComplete(pbpo);
			}
		}
		
		/********************************
		 * 5. SKT MP 포인트 가용화 처리
		 *******************************/
		orderDetailService.excuteUsePsbSktmpPnt(claimBase.getOrdNo());
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 메서드명	: pageClaimIntegrateList
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: LTS
	 * - 설명		: 클레임 통합 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ClaimListVO> pageClaimIntegrateList(ClaimSO claimSo) {
		return claimDao.pageClaimIntegrateList(claimSo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 메서드명	: getClaimIntegrateExcelList
	 * - 작성일		: 2021. 08. 10.
	 * - 작성자		: LTS
	 * - 설명		: 클레임 통합 목록 조회 엑셀다운로드
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<ClaimListVO> getClaimIntegrateExcelList(ClaimSO claimSO) {
		return claimDao.getClaimIntegrateExcelList(claimSO);
	}
	
	@Override
	public void calMpPnt(String clmNo) {
		PayBaseSO pbso = null;
		//------------------------------------------------
		// 1. 클레임 기본 조회
		//------------------------------------------------
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO claimBase = this.claimBaseDao.getClaimBase(cbso);
		
		OrderSO ordSO = new OrderSO();
		ordSO.setOrdNo(claimBase.getOrdNo());
		ordSO.setClmNo(claimBase.getClmNo());
		OrderPayVO checkInfo = orderDao.getOrderPayInfoForPnt(ordSO);
		/*배송비 로그 확인용*/
		/*DeliveryChargeSO dlvrSO = new DeliveryChargeSO();
		dlvrSO.setOrdNo(claimBase.getOrdNo());
		List<DeliveryChargeVO> dlvrcList = deliveryChargeDao.listDeliveryCharge(dlvrSO);
		ClaimBasePO clmPO = new ClaimBasePO();
		clmPO.setOrdNo(claimBase.getOrdNo());
		List<DeliveryChargeDetailVO> dlvrcDetailList = deliveryChargeDao.listDeliveryChargeDetail(clmPO);*/
		
		
		//------------------------------------------------
		// 2. 클레임 결제정보 조회
		//------------------------------------------------
		pbso = new PayBaseSO();
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
		pbso.setClmNo(clmNo);
		pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
		List<PayBaseVO> refundPayList = this.payBaseDao.listPayBase(pbso);
		
		//------------------------------------------------
		// 2. 결제 주문정보 조회
		//------------------------------------------------
		pbso = new PayBaseSO();
		pbso.setOrdNo(claimBase.getOrdNo());
		pbso.setPayGbCd(CommonConstants.PAY_GB_10);
		pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
		pbso.setCncYn(CommonConstants.COMM_YN_N);
		pbso.setPayStatCd(CommonConstants.PAY_STAT_01);
		
		List<PayBaseVO> payBaseList = this.payBaseDao.listPayBase(pbso);
		PayBaseVO mpClmPayBase = null; 
		PayBaseVO mpOrdPayBase = null; 
		//주결제 결제금액
		Long mainPayMeansAmt = 0L;
		Long accumTgAmt = 0L;
		Long reUsePnt = 0L;
		
		for(PayBaseVO vo : payBaseList) {
			if(!CommonConstants.PAY_MEANS_80.equals(vo.getPayMeansCd()) && !CommonConstants.PAY_MEANS_81.equals(vo.getPayMeansCd())) {
				mainPayMeansAmt += vo.getPayRmnAmt();
			}else if(CommonConstants.PAY_MEANS_81.equals(vo.getPayMeansCd())) {
				mpOrdPayBase = vo;
			}
		}
		
		//주결제 환불금 빼줌.
		for(PayBaseVO vo : refundPayList) {
			if(!CommonConstants.PAY_MEANS_80.equals(vo.getPayMeansCd()) && !CommonConstants.PAY_MEANS_81.equals(vo.getPayMeansCd())) {
				mainPayMeansAmt -= vo.getPayRmnAmt();
			}else if(CommonConstants.PAY_MEANS_81.equals(vo.getPayMeansCd())) {
				mpClmPayBase = vo;
			}
		}
		accumTgAmt = mainPayMeansAmt - checkInfo.getDlvrAmt();
		
		if(accumTgAmt < 0) {
			accumTgAmt = 0L;
		}
		
		/********************************
		 * 4. SKT MP 포인트 재요청
		 *******************************/
		
		SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
		mpSO.setOrdNo(claimBase.getOrdNo());
		SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
		
		Long mpPayRmnAmt = mpOrdPayBase == null ? 0L : mpOrdPayBase.getPayRmnAmt();
		Long mpClmPayAmt = mpClmPayBase == null ? 0L : mpClmPayBase.getPayAmt();
		if(mpVO != null && CommonConstants.MP_REAL_LNK_GB_10.equals(mpVO.getMpRealLnkGbCd())) {
			Long usePnt = Optional.ofNullable(mpVO.getUsePnt()).orElse(0L);
			//제외 - 적립 대상금액 달라졌을 경우 and 적립이 된 경우 재요청, 재사용 포인트가 있는 경우 (부분취소인경우)
			if(mpClmPayBase != null || (Long.compare((mpVO.getDealAmt() - usePnt), accumTgAmt) != 0 &&  (mpVO.getSaveSchdPnt() != null && mpVO.getSaveSchdPnt() != 0L) ) ) {
				reUsePnt = mpPayRmnAmt - mpClmPayAmt;
				
				OrderBasePO ordBasePO = new OrderBasePO();
				ordBasePO.setOrdNo(claimBase.getOrdNo());
				
				//취소 요청
				SktmpLnkHistVO cncVO = new SktmpLnkHistVO();
				cncVO.setMpLnkHistNo(this.bizService.getSequence(CommonConstants.SEQUENCE_SKTMP_LNK_HIST_SEQ));
				cncVO.setPntNo(mpVO.getPntNo());
				cncVO.setOrdNo(mpVO.getOrdNo());
				cncVO.setClmNo(claimBase.getClmNo());
				cncVO.setOrgMpLnkHistNo(mpVO.getMpLnkHistNo());
				if(CommonConstants.MP_LNK_GB_10.equals(mpVO.getMpLnkGbCd())) {
					cncVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_20);
				}else {
					cncVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_40);
				}
				cncVO.setMpRealLnkGbCd(CommonConstants.MP_REAL_LNK_GB_20);
				cncVO.setCardNo(mpVO.getCardNo());
				cncVO.setPinNo(mpVO.getPinNo());
				cncVO.setIfGoodsCd(mpVO.getIfGoodsCd());
				cncVO.setDealAmt(mpVO.getDealAmt());
				cncVO.setUsePnt(usePnt);
				cncVO.setAddUsePnt(mpVO.getAddUsePnt());
				cncVO.setSaveSchdPnt(mpVO.getSaveSchdPnt());
				cncVO.setAddSaveSchdPnt(mpVO.getAddSaveSchdPnt());
				cncVO.setCiCtfVal(checkInfo.getCiCtfVal());
				
				//클레임 접수시 오류내지않음.
				/*if(!SktmpConstants.RES_SUCCESS_CODE.equals(mpVO.getResCd())) {
					throw new CustomException(ExceptionConstants.ERROR_SKTMP_REQ_PRE_ERROR);
				}*/
				
				sktmpService.insertSktmpLnkHist(cncVO);
				
				
				//전체 취소일경우 적립대상금액 없음.
				if("N".equals(checkInfo.getOrdRmnYn())) {
					accumTgAmt = 0L;
				}
				
				//MP 포인트 결제가 없고 적립대상금액만 있을 경우, 재사용포인트가 있을경우(클레임 포인트 있을경우)
				if((Long.compare((mpVO.getDealAmt() - usePnt), accumTgAmt) != 0 ) || reUsePnt > 0 ) {
					SktmpLnkHistVO reMpVO = new SktmpLnkHistVO();
					
					//기존에 요청한 포인트 번호로 조회.
					PntInfoSO pntSO = new PntInfoSO();
					pntSO.setPntNo(mpVO.getPntNo());
					PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
					
					reMpVO.setMpLnkHistNo(this.bizService.getSequence(CommonConstants.SEQUENCE_SKTMP_LNK_HIST_SEQ));
					reMpVO.setPntNo(mpPntVO.getPntNo());
					reMpVO.setOrdNo(mpVO.getOrdNo());
					reMpVO.setClmNo(claimBase.getClmNo());
					//취소 MP 이력번호
					reMpVO.setOrgMpLnkHistNo(cncVO.getMpLnkHistNo());
					reMpVO.setMpRealLnkGbCd(CommonConstants.MP_REAL_LNK_GB_10);
					reMpVO.setCardNo(mpVO.getCardNo());
					reMpVO.setPinNo(mpVO.getPinNo());
					reMpVO.setCiCtfVal(checkInfo.getCiCtfVal());
					
					Long reRealUsePnt = 0L;
					Long addUsePnt = 0L;
					
					if(mpClmPayAmt == 0) {
						//환불건 없는 경우
						if(reUsePnt > 0) {
							reRealUsePnt = usePnt;
							addUsePnt = mpVO.getAddUsePnt();
						}else {
							//MP 남은 결제 금액 없음. or 전체 취소
							reRealUsePnt = 0L;
							addUsePnt = 0L;
						}
					}else{
						//환불건 있는 경우
						if(reUsePnt > 0) {
							if(CommonConstants.PNT_PRMT_GB_20.equals(mpVO.getPntPrmtGbCd()) && mpVO.getUseRate() != null && mpVO.getUseRate() > 0) {
								/* MP 포인트 재계산 사용여부 체크 - N Start */
								CodeDetailSO codeSO = new CodeDetailSO();
								codeSO.setGrpCd(CommonConstants.PNT_TP);
								codeSO.setDtlCd(CommonConstants.PNT_TP_MP);
								CodeDetailVO mpCodeVO = codeService.getCodeDetail(codeSO);
								String mpReCalculateYn = StringUtil.isEmpty(mpCodeVO.getUsrDfn2Val()) ? "Y" : mpCodeVO.getUsrDfn2Val();
								if("N".equals(mpReCalculateYn)) {
									if(mpClmPayAmt > 0 && mpVO != null && mpVO.getRmnAddUsePnt() > 0) {
										if(mpClmPayAmt > mpVO.getRmnAddUsePnt()) {
											reRealUsePnt = mpVO.getUsePnt() - (mpClmPayAmt - mpVO.getRmnAddUsePnt());
											addUsePnt = 0L;
										}else {
											addUsePnt = mpVO.getRmnAddUsePnt() - mpClmPayAmt;
											reRealUsePnt = mpVO.getUsePnt();
										}
									}else {
										reRealUsePnt = reUsePnt;
										addUsePnt = 0L;
									}
								/* MP 포인트 재계산 사용여부 체크 - N End */
								}else {
									//사용프로모션 - 재계산 필요
									reRealUsePnt = (long) Math.floor(reUsePnt.doubleValue() * (100 / (100 + mpVO.getUseRate())));
									addUsePnt = (long)Math.floor(reRealUsePnt * (mpVO.getUseRate() / 100));
								}
								
							}else {
								reRealUsePnt = reUsePnt;
								addUsePnt = 0L;
							}
						}else {
							//재사용 포인트 없음. MP 전체 취소 
							reRealUsePnt = 0L;
							addUsePnt = 0L;
						}
					}
					
					reMpVO.setUsePnt(reRealUsePnt);
					reMpVO.setAddUsePnt(addUsePnt);
					if(reMpVO.getUsePnt() != null && reMpVO.getUsePnt().intValue() > 0) {
						reMpVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_10);
					}else {
						reMpVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_30);
					}
					
					//적립 포인트 재계산
					Long saveSchdPnt = 0L;
					Long addSaveSchdPnt = 0L;
					
					//기존 요청
					SktmpLnkHistSO payMpSO = new SktmpLnkHistSO();
					payMpSO.setPayOrdNo(claimBase.getOrdNo());
					SktmpLnkHistVO orgPayMpVO = sktmpService.getSktmpLnkHist(payMpSO);
					if(orgPayMpVO.getSaveSchdPnt() == null || orgPayMpVO.getSaveSchdPnt() == 0) {
						//APETQA-7069 최초 주문이 적립이 안됐을 경우 부분취소 시 적립시키지 않음.- 적립대상금액, 적립 포인트 0 처리 
						accumTgAmt = 0L;
						saveSchdPnt = 0L;
						addSaveSchdPnt = 0L;
					}else {
						if(accumTgAmt > 0) {
							//적립 예정 포인트 계산
							Double saveRate = mpPntVO.getSaveRate() == null ? 0D : mpPntVO.getSaveRate() * 0.01;
							Double addSaveRate = mpPntVO.getAddSaveRate() == null ? 0D : mpPntVO.getAddSaveRate() * 0.01;
							
							Long allSavePnt = (long)Math.floor(accumTgAmt.doubleValue() * (saveRate + addSaveRate));
							
							if(!allSavePnt.equals(0L)) {
								Long maxSavePnt = mpPntVO.getMaxSavePnt() == null ? 0L : mpPntVO.getMaxSavePnt();
								
								if(!maxSavePnt.equals(0L)) {
									if(allSavePnt > maxSavePnt) {
										allSavePnt = maxSavePnt;
									}
								}
								
								if(!addSaveRate.equals(0D)) {
									saveSchdPnt = (long)Math.floor(allSavePnt * (saveRate / (saveRate + addSaveRate)));
									addSaveSchdPnt = allSavePnt - saveSchdPnt;
								}else {
									saveSchdPnt = allSavePnt;
									addSaveSchdPnt = 0L;
								}
							}
							
							//전체 취소또는 반품되어 남은 수량이 없을 경우
							if("N".equals(checkInfo.getOrdRmnYn())) {
								saveSchdPnt = 0L;
								addSaveSchdPnt = 0L;
							}
						}
						
					}
					
					
					reMpVO.setDealAmt(accumTgAmt + reRealUsePnt);
					reMpVO.setSaveSchdPnt(saveSchdPnt);
					reMpVO.setAddSaveSchdPnt(addSaveSchdPnt);
					
					
					if(saveSchdPnt > 0 || reRealUsePnt > 0) {
						sktmpService.insertSktmpLnkHist(reMpVO);
					}
				}
			}
		}
	}
}
