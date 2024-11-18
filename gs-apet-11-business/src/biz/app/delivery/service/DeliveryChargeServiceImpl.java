package biz.app.delivery.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.cart.model.DeliveryChargeCalcVO;
import biz.app.cart.service.CartService;
import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.delivery.dao.DeliveryChargeDao;
import biz.app.delivery.dao.DeliveryChargePolicyDao;
import biz.app.delivery.model.DeliveryChargeDetailVO;
import biz.app.delivery.model.DeliveryChargePO;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;
import biz.app.delivery.model.DeliveryPaymentVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.delivery.service
 * - 파일명		: DeliveryChargeServiceImpl.java
 * - 작성일		: 2017. 3. 27.
 * - 작성자		: snw
 * - 설명		: 배송비 서비스 Impl
 * </pre>
 */
@Slf4j
@Transactional
@Service("deliveryChargeService")
public class DeliveryChargeServiceImpl implements DeliveryChargeService {

	@Autowired
	private DeliveryChargeDao deliveryChargeDao;
	@Autowired
	private ClaimBaseDao claimBaseDao;
	@Autowired
	private BizService bizService;
	@Autowired
	private CartService cartService;
	@Autowired
	private CacheService cacheService;
	@Autowired
	private DeliveryChargePolicyDao deliveryChargePolicyDao;

	/*
	 * 배송비 목록 조회
	 * 
	 * @see
	 * biz.app.delivery.service.DeliveryChargeService#listDeliveryCharge(biz.app.
	 * delivery.model.DeliveryChargeSO)
	 */
	@Override
	public List<DeliveryChargeVO> listDeliveryCharge(DeliveryChargeSO so) {
		List<DeliveryChargeVO> list = this.deliveryChargeDao.listDeliveryCharge(so);
		if (so.getSearchType().equals("ALL")) { // BO 주문의 배송비리스트 조회시 원배송비 번호 포함하여 조회
			List<DeliveryChargeVO> addList = list;
			boolean isExistOrg = true;
			while (isExistOrg) {
				Set<Long> dlvrcNos = new HashSet<Long>();
				Set<Long> orgDlvrcNos = new HashSet<Long>();
				Iterator<DeliveryChargeVO> itr = addList.iterator();
				while (itr.hasNext()) {
					DeliveryChargeVO thisVo = itr.next();
					dlvrcNos.add(thisVo.getDlvrcNo());
					if (thisVo.getOrgDlvrcNo() != null) {
						orgDlvrcNos.add(thisVo.getOrgDlvrcNo());
					}
				}
				orgDlvrcNos.removeAll(dlvrcNos);
				if (orgDlvrcNos.size() > 0) {
					DeliveryChargeSO orgDlvrcNosSo = new DeliveryChargeSO();
					orgDlvrcNosSo.setArrDlvrcNo(orgDlvrcNos.toArray());
					addList = this.deliveryChargeDao.listDeliveryCharge(orgDlvrcNosSo);
					list.addAll(addList);
				} else {
					isExistOrg = false;
					// 정렬
					Collections.sort(list, new Comparator<DeliveryChargeVO>() {
						@Override
						public int compare(DeliveryChargeVO s1, DeliveryChargeVO s2) {
							if (s1.getDlvrcNo() < s2.getDlvrcNo()) {
								return -1;
							} else if (s1.getDlvrcNo() > s2.getDlvrcNo()) {
								return 1;
							}
							return 0;
						}
					});
				}
			}
		}
		return list;
	}

	/**
	 * 배송비 계산. 반품의 경우 기 배송 완료되므로 배송비 허들이 깨지는 경우 잔여 주문 수량에 대해 배송비 추가하는 취소와는 달리 기 배송
	 * 완료 수량에 대해 배송비를 추징해야 함. (판매자 귀책은 수량에서 제외) 실제 배송비는 cartService 로직을 사용하되, 무료 조건에
	 * 걸리지 않도록 fake 처리하여 계산.
	 * 
	 * @param remainValidOrderDetailList
	 * @param claimBasePO
	 * @param isCustClmBlameCd
	 */
	private void setDeliveryChargeCalc(List<DeliveryChargeCalcVO> remainValidOrderDetailList, ClaimBasePO claimBasePO,
			boolean isCustClmBlameCd) {

		cartService.setDeliveryChargeCalc(remainValidOrderDetailList,
				remainValidOrderDetailList.get(0).getLocalPostYn(), claimBasePO.getClmTpCd());

		// 반품만 추가 확인
		if (!CommonConstants.CLM_TP_20.equals(claimBasePO.getClmTpCd()))
			return;

		boolean isNeedFakeReCalc = false;
		for (DeliveryChargeCalcVO s : remainValidOrderDetailList) {
			if (!s.isClaimReq())
				continue;

			if (CommonConstants.COMM_YN_N.equals(s.getPkgDlvrYn())
					|| CommonConstants.COMM_YN_Y.equals(s.getPkgLeafYn())) {
				boolean isBrokenHurdle = "N".equals(s.getPlcAplYn()) && !isCustClmBlameCd; // 이미 깨진 경우 배송비 환불을 위해 계산.
				boolean isBreakingHurdle = (s.getLastDlvrAmt() < s.getPkgDlvrAmt()) && isCustClmBlameCd; // 이번에 깨지고 있음.
																											// 소비자 귀책만
																											// 계산. 깨짐
																											// 마킹하고 전체
																											// 배송비 추징.
				boolean isOnlyReturn = (s.getRmnOrdQty() - s.getCompRtnQty() - s.getReqClaimQty() == 0); // 판매자 귀책 제외 최초
																											// 전체 반품 건.
																											// 확인 차원에서
																											// 계산.

				// [[예외처리 - 배송비 보정 - 개당 부여 배송비 전체 소비자 귀책 반품 배송비를 예상 배송비에 더함. (판매자 귀책 반품 시 이전 소비자
				// 귀책 반품건의 원 배송비 환불 방지)
				long keepChargeAmt = deliveryChargeDao.selectMinorExceptionCase1(s);
				s.setPkgDlvrAmt(s.getPkgDlvrAmt() + keepChargeAmt);
				// ]]
				boolean isKeepHurdleLastReturn = (keepChargeAmt == 0)
						&& (s.getRmnOrdQty() - s.getRtnQty() - s.getReqClaimQty() == 0) && "Y".equals(s.getPlcAplYn()); // 허들
																														// 깨지지
																														// 않고
																														// 발생한
																														// 마지막
																														// 반품
																														// 건.

				if (isBrokenHurdle || isBreakingHurdle || isOnlyReturn || isKeepHurdleLastReturn) {
					int deliveryQty = s.getRmnOrdQty() - s.getCompRtnQty(); // 판매자 귀책을 제외한 배송된 상품 수
					if (!isCustClmBlameCd)
						deliveryQty -= s.getReqClaimQty(); // 이번도 판매자 귀책이면 또 제외.

					s.setBuyQty(deliveryQty);
					s.setBuyAmt(deliveryQty * s.getReqClaimPayAmt());
					s.setDlvrcBuyPrc(Long.MAX_VALUE);
					s.setDlvrcBuyQty(Integer.MAX_VALUE); // 무료 여부는 무료로 오고. 허들만 재계산.
					s.setPlcAplYn("N");

					isNeedFakeReCalc = true;
				} else {
					s.setPlcAplYn("Y");
				}

			}
		}

		if (isNeedFakeReCalc) {
			cartService.setDeliveryChargeCalc(remainValidOrderDetailList,
					remainValidOrderDetailList.get(0).getLocalPostYn(), claimBasePO.getClmTpCd());
		}
	}

	/**
	 * 배송비 계산 후 임시 테이블에 저장 클레임 데이터 생성 전 기준.
	 * 
	 */
	@Override
	public void estimateDeliveryCharge(ClaimBasePO claimBasePO, List<DeliveryChargePO> claimDeliveryChargeList,
			List<ClaimDetailVO> reqClaimDetailList) {

		CodeDetailVO clmRsnVO = this.cacheService.getCodeCache(CommonConstants.CLM_RSN, claimBasePO.getClmRsnCd());
		String clmBlameCd = clmRsnVO.getUsrDfn2Val();
		boolean isCustClmBlameCd = CommonConstants.RSP_RSN_10.equals(clmBlameCd); // 고객 귀책여부

		if (StringUtils.isEmpty(claimBasePO.getClmNo())) {
			claimBasePO.setClmNo(claimBaseDao.getClaimNo(claimBasePO.getOrdNo()));
		}
		deliveryChargeDao.deleteDeliveryChargeDetail(claimBasePO.getClmNo()); // 이전 임시 데이터 있을 수 있음. 지운다.

		////////////////// 1.
		if (CommonConstants.CLM_TP_10.equals(claimBasePO.getClmTpCd())
				|| CommonConstants.CLM_TP_20.equals(claimBasePO.getClmTpCd())) {
			// 1. 취소/반품만 시작 [[
			// --------------------------------------------------------------------------

			// Calim이 발생되는 경우에 잔여 주문 상품 목록
			List<Long> dlvrcPlcNoList = new ArrayList<>();
			List<DeliveryChargeCalcVO> remainValidOrderDetailList = deliveryChargeDao
					.listDeliveryChargeCalc(claimBasePO.getOrdNo());
			for (DeliveryChargeCalcVO remainValidOrderDetail : remainValidOrderDetailList) {
				for (ClaimDetailVO reqClaimDetail : reqClaimDetailList) {
					if (remainValidOrderDetail.getOrdDtlSeq().equals(reqClaimDetail.getOrdDtlSeq())) {
						remainValidOrderDetail
								.setBuyQty(remainValidOrderDetail.getBuyQty() - reqClaimDetail.getClmQty());
						remainValidOrderDetail.setBuyAmt(remainValidOrderDetail.getBuyAmt()
								- reqClaimDetail.getClmQty() * reqClaimDetail.getPayAmt()); // 쿠폰까지 적용된 최종 할인 금액
						remainValidOrderDetail.setClmDtlSeq(reqClaimDetail.getClmDtlSeq());

						// 허들 fake 계산용
						remainValidOrderDetail.setReqClaimQty(remainValidOrderDetail.getReqClaimQty() + reqClaimDetail.getClmQty());
						remainValidOrderDetail.setReqClaimPayAmt(remainValidOrderDetail.getReqClaimPayAmt() + reqClaimDetail.getPayAmt());
						remainValidOrderDetail.setClaimReq(true);
						dlvrcPlcNoList.add(remainValidOrderDetail.getDlvrcPlcNo());

					}
				}
			}
			for (DeliveryChargeCalcVO remainValidOrderDetail : remainValidOrderDetailList) {
				if (dlvrcPlcNoList.indexOf(remainValidOrderDetail.getDlvrcPlcNo()) > -1) {
					remainValidOrderDetail.setClaimReq(true); // 합배송의 경우 함께 계산
				}
			}

			// 유효 상품으로 배송비 재계산
			// 배송비 재계산 할때, (회수비 말고 배송비)
			// 배송비는 배송된, 또는 될 상품에 대한 금액을 구해야 하고. 무료 여부는 실제 주문 수량임.
			// 주문 수량 <> 배송 수량 인 경우 : 반품.
			this.setDeliveryChargeCalc(remainValidOrderDetailList, claimBasePO, isCustClmBlameCd);
			// 원주문 배송비 쿠폰 적용
			DeliveryChargeSO dcso = new DeliveryChargeSO();
			dcso.setOrdNo(claimBasePO.getOrdNo());
			dcso.setMbrCpUseYn("Y");
			List<DeliveryChargeVO> orderDeliveryChargeUseCouponList = this.deliveryChargeDao.listDeliveryCharge(dcso);
			if (orderDeliveryChargeUseCouponList != null) {
				for (DeliveryChargeVO orderDC : orderDeliveryChargeUseCouponList) {
					for (DeliveryChargeCalcVO remainValidOrderDetail : remainValidOrderDetailList) {
						if (remainValidOrderDetail.getPkgDlvrNo().intValue() == orderDC.getDlvrcNo().intValue()) {
							remainValidOrderDetail.setCpNo(orderDC.getCpNo());
							remainValidOrderDetail.setMbrCpNo(orderDC.getMbrCpNo());
							remainValidOrderDetail.setCpDcAmt(orderDC.getCpDcAmt());
							remainValidOrderDetail
									.setPkgDlvrAmt(remainValidOrderDetail.getPkgDlvrAmt() - orderDC.getCpDcAmt());
						}
					}
				}
			}

			// 재계산된 배송비 전체를 Delivery Charge 데이터만 DLIVERY_CHARGE_DETAIL에 insert.
			for (DeliveryChargeCalcVO s : remainValidOrderDetailList) {
				if (!s.isClaimReq())
					continue;
				if (CommonConstants.COMM_YN_N.equals(s.getPkgDlvrYn())
						|| CommonConstants.COMM_YN_Y.equals(s.getPkgLeafYn())) {
					DeliveryChargeDetailVO t = new DeliveryChargeDetailVO();
					t.setDlvrcNo(bizService.getSequence(CommonConstants.SEQUENCE_DLVRC_NO_SEQ));
					t.setOrdNo(claimBasePO.getOrdNo());
					t.setClmNo(claimBasePO.getClmNo());
					t.setClmDtlSeq(s.getClmDtlSeq());
					t.setOrgDlvrcNo(s.getOrgDlvrcNo());
					t.setCostGbCd(CommonConstants.DLVRC_COST_GB_SEND);
					t.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
					t.setOrgDlvrAmt(s.getPkgOrgDlvrAmt());
					t.setRealDlvrAmt(s.getPkgDlvrAmt());
					t.setAddDlvrAmt(s.getPkgAddDlvrAmt());
					t.setClmRsnCd(claimBasePO.getClmRsnCd());
					t.setPlcAplYn(s.getPlcAplYn());
					t.setPlcAplYn(s.getPlcAplYn());

					deliveryChargeDao.insertDeliveryChargeDetailOrder(t);
				}
			}

			// 취소/반품만 끝
			// --------------------------------------------------------------------------]]
		}

		////////////////// 2.
		for (DeliveryChargePO s : claimDeliveryChargeList) {
			// 2. 회수비, 재배송비
			DeliveryChargeDetailVO t = new DeliveryChargeDetailVO();
			t.setDlvrcNo(s.getDlvrcNo()); // 초도 주문에 대한 delivery_charge가 아니면 미리 Key 생성되어 전달 받음.
			t.setOrdNo(claimBasePO.getOrdNo());
			t.setClmNo(claimBasePO.getClmNo());
			t.setClmDtlSeq(s.getClmDtlSeq());
			t.setDlvrcPlcNo(s.getDlvrcPlcNo());
			t.setOrgDlvrcNo(s.getOrdDlvrcNo());
			t.setCostGbCd(s.getCostGbCd());
			t.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
			t.setOrgDlvrAmt(s.getOrgDlvrAmt());
			t.setRealDlvrAmt(s.getRealDlvrAmt());
			t.setRealDlvrAddAmt(s.getRealDlvrAmt());
			t.setAddDlvrAmt(s.getAddDlvrAmt());
			t.setClmRsnCd(claimBasePO.getClmRsnCd());
			t.setPlcAplYn("Y");
			t.setDftDlvrcYn("Y");

			deliveryChargeDao.insertDeliveryChargeDetailClaim(t);
		}

		////////////////// 3. 귀책에 따른 적용 여부 처리
		List<DeliveryChargeDetailVO> list = deliveryChargeDao.listDeliveryChargeDetail(claimBasePO);
		for (DeliveryChargeDetailVO v : list) {
			log.debug("최종 반영 대상 --------------------------------- [" + v.getOrdClmGbCd() + "," + v.getCostGbCd() + "] "
					+ v.toString());

			if (CommonConstants.DLVRC_COST_GB_SEND.equals(v.getCostGbCd())) {
				// 1. 주문 배송비 변경에 대해
				// ----------------------------------------------------------------
				if (v.getRealDlvrAddAmt() > 0 && isCustClmBlameCd) { // 소비자 귀책으로 허들깨져 배송비 추가 되는 경우 = 고객이 돈을 더 내야 하는 경우
					v.setDlvrcGbCd("20");

				} else if (v.getRealDlvrAddAmt() < 0) { // 배송비 환불되는 경우
					if ("10".equals(claimBasePO.getClmTpCd()) || !isCustClmBlameCd) {
						// 1.2. 취소나 업체 과실의 반품만 배송비 환불
						v.setDlvrcGbCd("10");

					}
				}

			} else if (CommonConstants.DLVRC_COST_GB_RETURN.equals(v.getCostGbCd())) {
				// 회수비 부과 ----------------------------------------------------------------
				if (isCustClmBlameCd) {
					v.setDlvrcGbCd("20");

				}
			} else {
				throw new CustomException("not DLVRC_COST_GB_SEND nor DLVRC_COST_GB_RETURN" + v.toString());
			}
		}

		////////////////// 4.
		for (DeliveryChargeDetailVO v : list) {
			deliveryChargeDao.updateDeliveryChargeDetailDlvrcGbCd(v); // DB 저장
		}

	}

	/**
	 * 본테이블 저장
	 */
	@Override
	public void insertDeliveryCharge(ClaimBasePO claimBasePO) {

		List<DeliveryChargeDetailVO> changedDeliveryChargeDetailList = deliveryChargeDao.getChangedDeliveryChargeDetailList(claimBasePO);

		for (DeliveryChargeDetailVO s : changedDeliveryChargeDetailList) {
			// 변경된 내용만 저장
			// 남은수량 - 반품수량이 있는경우
			if (s.getRealDlvrAddAmt() == 0 && "N".equals(s.getDftDlvrcYn())) {
				continue;
			}

			deliveryChargeDao.insertDeliveryChargeFromDetail(s);

			if (CommonConstants.ORD_CLM_GB_20.equals(s.getOrdClmGbCd())) {
				if (CommonConstants.DLVRC_COST_GB_SEND.equals(s.getCostGbCd())) {

					if ("N".equals(s.getDftDlvrcYn())) { // 배송비 재계산 경우
						deliveryChargeDao.updateOrderDetailDlvrcNoFromDetail(s);
						s.setCncClmNo(s.getClmNo());
						deliveryChargeDao.updateDeliveryChargeCancel(s);
					}

					deliveryChargeDao.updateClaimDetailDlvrcNoFromDetail(s, CommonConstants.DLVRC_COST_GB_SEND);
				} else if (CommonConstants.DLVRC_COST_GB_RETURN.equals(s.getCostGbCd())) {
					deliveryChargeDao.updateClaimDetailDlvrcNoFromDetail(s, CommonConstants.DLVRC_COST_GB_RETURN);
				}
			}
		}
	}

	/**
	 * 견적 조회
	 */
	@Override
	public ClaimBasePO selectDeliveryCharge(ClaimBasePO claimBasePO) {

		List<DeliveryChargeDetailVO> appliedDeliveryChargeDetailList = deliveryChargeDao
				.listDeliveryChargeDetailValid(claimBasePO);

		Long claimDlvrcAmt = 0L; // 추가 배송비
		Long claimDlvrcAmtCostGb10 = 0l;
		Long claimDlvrcAmtCostGb20 = 0l;
		Long refundDlvrAmt = 0L;
		Long totAmt = 0L;
		

		String ordNo = "";

		for (DeliveryChargeDetailVO s : appliedDeliveryChargeDetailList) {
			if (StringUtils.isNotBlank(s.getOrdNo()))
				ordNo = s.getOrdNo();

			if (s.getDlvrcGbCd().equals("20")) {
				// 추징
				claimDlvrcAmt += s.getRealDlvrAddAmt();
				if (s.getCostGbCd().equals("10")) {
					claimDlvrcAmtCostGb10 += s.getRealDlvrAddAmt();
				} else if (s.getCostGbCd().equals("20")) {
					claimDlvrcAmtCostGb20 += s.getRealDlvrAddAmt();
				}
			} else if (s.getDlvrcGbCd().equals("10")) {
				// 환불
				refundDlvrAmt -= s.getRealDlvrAddAmt();
			}
		}

		totAmt = refundDlvrAmt - claimDlvrcAmt;

		ClaimBasePO retClaimBasePO = new ClaimBasePO();
		retClaimBasePO.setClmDlvrcAmt(claimDlvrcAmt);
		retClaimBasePO.setClaimDlvrcAmtCostGb10(claimDlvrcAmtCostGb10);
		retClaimBasePO.setClaimDlvrcAmtCostGb20(claimDlvrcAmtCostGb20);
		retClaimBasePO.setRefundDlvrAmt(refundDlvrAmt);
		retClaimBasePO.setTotAmt(totAmt);

		if (StringUtils.isEmpty(ordNo)) {
			ordNo = claimBasePO.getOrdNo();
		}
		if (StringUtils.isEmpty(ordNo)) {
			ClaimBaseSO so = new ClaimBaseSO();
			so.setClmNo(claimBasePO.getClmNo());
			ordNo = claimBaseDao.getClaimBase(so).getOrdNo();
		}
		DeliveryPaymentVO firstDeliveryCahrgeSum = deliveryChargeDao.getFirstDeliveryCahrgeSum(ordNo);
		retClaimBasePO.setOrgDlvrcAmt(firstDeliveryCahrgeSum.getFirstDlvrcAmt());

		log.debug("selectDeliveryCharge return : " + retClaimBasePO.toString());

		return retClaimBasePO;
	}

}
