package biz.app.claim.service;

import java.util.List;
import java.util.Properties;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.cart.service.CartService;
import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.dao.ClmDtlCstrtDao;
import biz.app.claim.model.ClaimAccept;
import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.delivery.dao.DeliveryChargeDao;
import biz.app.delivery.model.DeliveryChargePO;
import biz.app.delivery.service.DeliveryChargeService;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.dao.OrderDlvraDao;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDlvraPO;
import biz.app.order.service.OrderService;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PaymentException;
import biz.app.pay.service.PayBaseService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.cis.model.request.order.OrderCancelPO;
import biz.interfaces.cis.model.response.order.OrderCancelVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 
*/
@Slf4j
@Transactional
@Service("claimAcceptService")
public class ClaimAcceptServiceImpl implements ClaimAcceptService{

	@Autowired private ClaimService claimService;
	
	@Autowired private ClaimBaseDao claimBaseDao;
	@Autowired private ClaimDetailDao claimDetailDao;
	@Autowired private OrderDetailDao orderDetailDao;
	@Autowired private PayBaseService payBaseService;
	@Autowired private OrderDlvraDao orderDlvraDao;
	@Autowired private DeliveryChargeDao deliveryChargeDao;
	@Autowired private CacheService cacheService;
	@Autowired private ClaimSendService claimSendService;
	@Autowired private CisOrderService cisOrderService;
	@Autowired private ClmDtlCstrtDao clmDtlCstrtDao;
	@Autowired private Properties webConfig;
	@Autowired private OrderService orderService;
	@Autowired private BizService bizService;
	@Autowired private CartService cartService;
	
	@Autowired private DeliveryChargeService deliveryChargeService;
	
	/**
	 * 취소, 반품, 교환 접수
	 * @param clmRegist
	 * @return
	 */
	@Override
	public String acceptClaim(ClaimRegist clmRegist) {
		String clmNo = null;			// 클레임 번호
		String exceptionCd = null;		// 예외 처리 코드
		
		//------------------------------------------------
		// 변수 선언부
		//------------------------------------------------
		
		// 추가 결제
		PayBasePO payBase = null;
		
		try {
			ClaimAccept clmAccept = claimService.getClaimBefore(clmRegist, true); // 신규 클레임 번호 채번 + 이전 주문 조회
			
			ClaimBasePO claimBasePO = clmAccept.getClaimBase();
			List<ClaimDetailVO> claimDetailList = clmAccept.getClaimDetailList();
			List<ClmDtlCstrtPO> clmDtlCstrtList = clmAccept.getClmDtlCstrtList();
			List<DeliveryChargePO> clmDlvrcList = clmAccept.getClmDlvrcList();
			List<OrderDlvraPO> orderDlvraList = clmAccept.getOrderDlvraList();
			
			clmNo = claimBasePO.getClmNo();
			
			//------------------------------------------------
			// 0. 배송비 환불 재계산 재계산 (클레임 데이터 생성 전 기준.)
			//------------------------------------------------			
			claimBasePO.setClmRsnCd(clmRegist.getClmRsnCd());
			deliveryChargeService.estimateDeliveryCharge(claimBasePO, clmDlvrcList, claimDetailList);

			//------------------------------------------------
			// 1. 클레임 수량 주문 상세에 반영
			//------------------------------------------------
			 
			OrderDetailPO odpo = null;
			
			// 주문 취소
			if (CommonConstants.CLM_TP_10.equals(claimBasePO.getClmTpCd())) {
				// 클레임 수량을 주문의 취소 수량에 반영
				for (ClaimDetailVO cdpo : claimDetailList) {
					odpo = new OrderDetailPO();
					odpo.setOrdNo(cdpo.getOrdNo());
					odpo.setOrdDtlSeq(cdpo.getOrdDtlSeq());
					odpo.setCncQty(cdpo.getClmQty());
					this.orderDetailDao.updateOrderDetailClaimQty(odpo);
				}
			}

			// 반품
			if (CommonConstants.CLM_TP_20.equals(claimBasePO.getClmTpCd())) {
				// 클레임 수량을 주문의 반품수량에 반영
				for (ClaimDetailVO cdpo : claimDetailList) {
					odpo = new OrderDetailPO();
					odpo.setOrdNo(cdpo.getOrdNo());
					odpo.setOrdDtlSeq(cdpo.getOrdDtlSeq());
					odpo.setRtnQty(cdpo.getClmQty());
					this.orderDetailDao.updateOrderDetailClaimQty(odpo);
				}
			}

			
			//------------------------------------------------
			// 2. 추가 결제 정보 생성 (고정 가상계좌 - 과오납 등록 처리)
			//------------------------------------------------
			if (StringUtils.isNotEmpty(clmRegist.getDepositBankCd())) {
				payBase = new PayBasePO();
				payBase.setMngrRegYn("N");
				payBase.setOrdNo(claimBasePO.getOrdNo());
				payBase.setClmNo(claimBasePO.getClmNo());
				payBase.setBankCd(clmRegist.getDepositBankCd());
				payBase.setAcctNo(clmRegist.getDepositAcctNo());
				payBase.setOoaNm(clmRegist.getDepositOoaNm());
				payBase.setPayAmt(clmRegist.getDepositAmt());
				payBase.setDepositMobile(clmRegist.getDepositMobile());
				
				payBaseService.insertDepositInfo(payBase);
			}
			
			//------------------------------------------------
			// 4. 배송/회수지 정보 저장
			//------------------------------------------------
			if (orderDlvraList != null && !orderDlvraList.isEmpty()) {
				for (OrderDlvraPO odlvrapo : orderDlvraList) {
					int orderDlvraResult = this.orderDlvraDao.insertOrderDlvra(odlvrapo);

					if (orderDlvraResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

			
			//------------------------------------------------
			// 5. 클레임 정보 저장
			//------------------------------------------------
			
			// 1) 클레임 기본 저장
			int claimResult = this.claimBaseDao.insertClaimBase(claimBasePO);
			if (claimResult != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			// 2) 클레임 상세 저장
			log.debug("### 클레임 상세 저장 정보 = " + claimDetailList.toString());
			for (ClaimDetailVO cdvo : claimDetailList) {
				ClaimDetailPO cdpo = new ClaimDetailPO();
				BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0);
				BeanUtils.copyProperties(cdpo, cdvo);
				
				int claimDtlResult = this.claimDetailDao.insertClaimDetail(cdpo);
				if (claimDtlResult != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				// 2-1) 클레임 이미지 있을 경우 저장 && 클레임상세 교환배송일때는 제외 (CLM_DTL_TP_40)
				if(clmRegist.getImgPaths() != null && clmRegist.getImgPaths().size() != 0 && !CommonConstants.CLM_DTL_TP_40.equals(cdvo.getClmDtlTpCd()) ) {
					int clmDtlRsnSeq = 1;				// 클레임 상세 사진 순번
					for(String imgPath : clmRegist.getImgPaths()) {
						/**
						 * 이미지 경로 처리 필요
						 * */
						cdpo.setClmDtlRsnSeq(clmDtlRsnSeq++);
						cdpo.setImgPath(imgPath);
						cdpo.setDelYn(CommonConstants.COMM_YN_N);
						
						FtpImgUtil ftpImgUtil = new FtpImgUtil();
						String filePath = ftpImgUtil.uploadFilePath(cdpo.getImgPath(), AdminConstants.CLAIM_IMAGE_PATH + FileUtil.SEPARATOR + cdpo.getClmNo());
						ftpImgUtil.upload(cdpo.getImgPath(), filePath);
						if(StringUtil.isNotEmpty(filePath)){
							cdpo.setImgPath(filePath);
						}
						
						int imgResult = this.claimDetailDao.insertImgClaimDetail(cdpo);
						/*if(imgResult == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}*/
					}
				}
			}
			
			// 2-2) 클레임 상세 구성 저장
			for(ClmDtlCstrtPO cstrtPO : clmDtlCstrtList) {
				int claimDtlResult = clmDtlCstrtDao.insertClmDtlCstrt(cstrtPO);
				if (claimDtlResult != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			
			//------------------------------------------------
			// 7. 배송비 데이터 생성 및 결제 환불 데이터 생성
			//------------------------------------------------
			if(StringUtils.isEmpty(claimBasePO.getClmNo())) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			deliveryChargeService.insertDeliveryCharge(claimBasePO);
			ClaimBasePO refundAmtVO = deliveryChargeService.selectDeliveryCharge(claimBasePO);
			
			this.payBaseService.acceptPayBaseRefund(clmNo, clmRegist.getBankCd(), clmRegist.getAcctNo(), clmRegist.getOoaNm(), refundAmtVO.getTotAmt());
			
			
			//------------------------------------------------
			// 7.5 MP 포인트 계산
			//------------------------------------------------
			claimService.calMpPnt(clmNo);
			
			//------------------------------------------------
			// 8. 주문 취소일 경우 CIS 취소 요청
			//------------------------------------------------
			
			OrderCancelPO param = null;
			for(ClmDtlCstrtPO clmDtlCstrt : clmDtlCstrtList) {
				
				//배송지시나 상품준비중일 경우
				if(CommonConstants.ORD_DTL_STAT_130.equals(clmDtlCstrt.getOrdDtlStatCd()) || CommonConstants.ORD_DTL_STAT_140.equals(clmDtlCstrt.getOrdDtlStatCd())){
					param = new OrderCancelPO();
					param.setShopOrdrNo(clmDtlCstrt.getOrdNo());
					String shopSortNo = String.valueOf(clmDtlCstrt.getOrdDtlSeq()).concat("_").concat(String.valueOf(clmDtlCstrt.getOrdCstrtSeq()));
					
					param.setShopSortNo(shopSortNo);
					param.setEa(clmDtlCstrt.getClmQty() * clmDtlCstrt.getCstrtQty());
					
					OrderCancelVO cancelVO = cisOrderService.cancelOrder(param);
					
					if(!CommonConstants.CIS_API_SUCCESS_CD.equals(cancelVO.getResCd())) {
						//Exception 처리하지 않음. -  단건 처리이므로.
						log.error("CIS 주문취소 요청 오류: {}", "return code ->"+cancelVO.getResCd() +"||"+cancelVO.getResMsg());
						//throw new CustomException(ExceptionConstants.ERROR_CIS_ORDER_CANCEL);
					}
				}
			}
			
			//------------------------------------------------
			// 9. 주문취소일 경우 완료 처리
			//------------------------------------------------
			if (CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())) {
				claimService.completeClaimCancel(clmNo, clmRegist.getAcptrNo());
			} else {
				// Sms or Email 발송 : 반품 or 교환
				claimSendService.sendClaimAccept(clmNo);
			}
			
			//------------------------------------------------
			// 10.BO 일경우  티켓 사건 추가 API
			//------------------------------------------------
			if(CommonConstants.PROJECT_GB_ADMIN.equals(webConfig.getProperty("project.gb"))) {
				claimSendService.sendAddTicketIncident(clmRegist);
			}
			
			//------------------------------------------------
			// 11.알림톡 전송
			//------------------------------------------------
			if (CommonConstants.CLM_TP_10.equals(clmRegist.getClmTpCd())) {
				// 주문 취소
				orderService.sendMessage(clmRegist.getOrdNo(), clmNo, "K_M_ord_0008", null);
			}else if (CommonConstants.CLM_TP_20.equals(clmRegist.getClmTpCd()) && CommonConstants.PROJECT_GB_FRONT.equals(webConfig.getProperty("project.gb"))) {
				// 주문 반품
				orderService.sendMessage(clmRegist.getOrdNo(), clmNo, "K_M_ord_0009", null);
			}else if (CommonConstants.CLM_TP_30.equals(clmRegist.getClmTpCd()) && CommonConstants.PROJECT_GB_FRONT.equals(webConfig.getProperty("project.gb"))) {
				// 주문 교환
				orderService.sendMessage(clmRegist.getOrdNo(), clmNo, "K_M_ord_0010", null);
			}
			
		} catch (CustomException e) {
			exceptionCd = e.getExCode();
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch (PaymentException ep) {
			exceptionCd = ep.getExCode();
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ep);
		} catch (Exception e) {
			exceptionCd = ExceptionConstants.ERROR_CODE_DEFAULT;
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}

		if (exceptionCd != null) {

//			if ((inipayAppDto != null
//					&& INIPayConstants.APPROVE_RETURN_SUCCESS_RESULT_CODE.equals(inipayAppDto.getResultCode()))
//					|| (inipayMobileAppDto != null && INIPayConstants.APPROVE_MOBILE_RETURN_SUCCESS_RESULT_CODE.equals(inipayMobileAppDto.getResultCode()))) {
//
//				INIPayCancel cancelResult = this.iniPayService.cancel(inipayAppDto.getMid(), inipayAppDto.getTid(), INIPayConstants.CACNEL_REASON_CODE_2, "클레임 접수 완료 오류");
//
//				if (!INIPayConstants.CANCEL_RETURN_SUCCESS_RESULT_CODE.equals(cancelResult.getResultCode())) {
//					log.error("**************************************************");
//					log.error("[클레임 추가 결제 취소 오류 : PG CANCEL ERROR]");
//					log.error("[클레임 추가 결제 취소 결과 DATA : " + cancelResult.toString());
//					log.error("**************************************************");
//				}
//			}
			
			throw new CustomException(exceptionCd);
		}
		
		return clmNo;
	}
}
