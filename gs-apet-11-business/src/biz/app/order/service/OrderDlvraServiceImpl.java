package biz.app.order.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.delivery.dao.DeliveryDao;
import biz.app.delivery.model.DeliveryPO;
import biz.app.order.dao.OrdDtlCstrtDao;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.dao.OrderDlvrAreaDao;
import biz.app.order.dao.OrderDlvraDao;
import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvrAreaPO;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.common.service.BizService;
import biz.interfaces.cis.model.request.order.OrderExptCreateSO;
import biz.interfaces.cis.model.request.order.OrderUpdateItemPO;
import biz.interfaces.cis.model.request.order.OrderUpdatePO;
import biz.interfaces.cis.model.response.order.OrderExptCreateVO;
import biz.interfaces.cis.model.response.order.OrderUpdateVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderDlvraServiceImpl.java
* - 작성일		: 2017. 1. 26.
* - 작성자		: snw
* - 설명			: 주문 배송지 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("orderDlvraService")
public class OrderDlvraServiceImpl implements OrderDlvraService {

	@Autowired
	private OrderDlvraDao orderDlvraDao;
	
	@Autowired private Properties webConfig;
	
	@Autowired	private OrderDetailDao orderDetailDao;
	
	@Autowired	private DeliveryDao deliveryDao;

	@Autowired	private OrderBaseDao orderBaseDao;
	
	@Autowired	private OrderDlvrAreaDao orderDlvrAreaDao;
	
	@Autowired private BizService bizService;
	
	@Autowired private CisOrderService cisOrderService;
	@Autowired private OrdDtlCstrtDao ordDtlCstrtDao;
	
	
	/*
	 * 주문 배송 목록 조회
	 * @see biz.app.order.service.OrderDlvraService#listOrderDlvra(biz.app.order.model.OrderDlvraSO)
	 */
	@Override
	public List<OrderDlvraVO> listOrderDlvra(OrderDlvraSO so) {
		return this.orderDlvraDao.listOrderDlvra(so);
	}
	
	/*
	 * 배송조회 
	 * @see biz.app.order.service.OrderDlvraService#getOrderDlvra(biz.app.order.model.OrderDlvraSO)
	 */
	@Override
	public OrderDlvraVO getOrderDlvra(OrderDlvraSO so) {
		return this.orderDlvraDao.getOrderDlvra(so);
	}
	
	/*
	 * 배송지 수정 
	 * @see biz.app.order.service.OrderDlvraService#updateDeliveryAddress(biz.app.order.model.OrderDlvraPO)
	 */
	@Override
	public String updateDeliveryAddress(OrderDlvraPO po) {
		
		boolean isCheckUpdate = true;
		boolean isCisCheck = false;
		boolean isAdmin = CommonConstants.PROJECT_GB_ADMIN.equals(this.webConfig.getProperty("project.gb"));
		boolean isDawnAndOneDayDlvr = false;
		boolean isPackUpdate = false;
		
		if(isAdmin) {
			OrderDetailSO so = new OrderDetailSO();
			OrderDetailSO ordDtlCstrtSO = null;
			OrderExptCreateSO exptSO = null;
			//주문 상세 구성
			List<OrdDtlCstrtVO> ordDtlCstrtList = null;
			
			so.setOrdNo(po.getOrdNo());
			//취소 주문 제외
			List<OrderDetailVO> ordDtlList = orderDetailDao.listOrderDetailShort(so).stream().filter(s -> s.getRmnOrdQty()> 0).collect(Collectors.toList());
			
			//BO에서 수정, 자사 업체 상품, 배송지시, 상품준비중일경우
			//새벽/당일 배송인지 체크
			boolean isLocalComp = ordDtlList.stream().anyMatch(vo -> CommonConstants.COMP_GB_10.equals(vo.getCompGbCd())); 
			String dlvrPrcsTpCd = ordDtlList.get(0).getDlvrPrcsTpCd();
			isDawnAndOneDayDlvr =  CommonConstants.DLVR_PRCS_TP_20.equals(dlvrPrcsTpCd) || CommonConstants.DLVR_PRCS_TP_21.equals(dlvrPrcsTpCd);
			isCisCheck = isLocalComp 
					&& ordDtlList.stream().anyMatch(vo -> CommonConstants.ORD_DTL_STAT_130.equals(vo.getOrdDtlStatCd()) || CommonConstants.ORD_DTL_STAT_140.equals(vo.getOrdDtlStatCd()));
			isPackUpdate = ordDtlList.stream().allMatch(vo -> 
							CommonConstants.ORD_DTL_STAT_110.equals(vo.getOrdDtlStatCd()) 
							|| CommonConstants.ORD_DTL_STAT_120.equals(vo.getOrdDtlStatCd()) 
							|| CommonConstants.ORD_DTL_STAT_130.equals(vo.getOrdDtlStatCd()) 
							|| CommonConstants.ORD_DTL_STAT_140.equals(vo.getOrdDtlStatCd())
						  );
			for(OrderDetailVO vo : ordDtlList) {
				//주문접수, 주문완료, 배송지시, 상품준비중 상태일 경우 변경
				if(!CommonConstants.ORD_DTL_STAT_110.equals(vo.getOrdDtlStatCd())
						&& !CommonConstants.ORD_DTL_STAT_120.equals(vo.getOrdDtlStatCd())		
						&& !CommonConstants.ORD_DTL_STAT_130.equals(vo.getOrdDtlStatCd())
						&& !CommonConstants.ORD_DTL_STAT_140.equals(vo.getOrdDtlStatCd()) ) {
					return ExceptionConstants.ERROR_ORDER_DLVRA_CHANGE_STAT;
				}
				
				if(isCisCheck) {
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
								isCheckUpdate = false;
							}
						} catch (Exception e) {
							return ExceptionConstants.ERROR_CIS_GET_EXPT_CREATE_ERROR;
						}
					}
				}
			}
			
			//CIS 배송지 변경 인터페이스 결과 -  불가
			if(!isCheckUpdate) {
				return ExceptionConstants.ERROR_ORDER_DLVRA_CHANGE_CIS_RETURN;
			}
			
			
			if(isCisCheck) {
				//배송지 변경 할 경우 택배로 고정배송
				OrderUpdatePO cisUpdatePO = new OrderUpdatePO();
				cisUpdatePO.setShopOrdrNo(po.getOrdNo()); 		//주문번호
				cisUpdatePO.setRecvNm(po.getAdrsNm()); 			//수령자 이름
				cisUpdatePO.setRecvTelNo(po.getTel()); 			//수령자 전화번호
				cisUpdatePO.setRecvCelNo(po.getMobile());		//수령자 휴대전화
				cisUpdatePO.setRecvZipcode(po.getPostNoNew());	//수령자 우편번호
				cisUpdatePO.setRecvAddr(po.getRoadAddr());		//수령자 주소
				cisUpdatePO.setRecvAddrDtl(po.getRoadDtlAddr());//수령자 주소 상세
				cisUpdatePO.setGateNo(null);					//공동현관 출입번호
				
				List<OrderUpdateItemPO> itemList = new ArrayList<>();
				OrderUpdateVO cisUpdateVO = null;
				for(OrderDetailVO vo : ordDtlList) {
					if (CommonConstants.ORD_DTL_STAT_130.equals(vo.getOrdDtlStatCd()) || CommonConstants.ORD_DTL_STAT_140.equals(vo.getOrdDtlStatCd())) {
						ordDtlCstrtSO = new OrderDetailSO();
						ordDtlCstrtSO.setOrdNo(vo.getOrdNo());
						ordDtlCstrtSO.setOrdDtlSeq(vo.getOrdDtlSeq());
						//주문 상세 구성
						ordDtlCstrtList = ordDtlCstrtDao.listOrdDtlCstrt(ordDtlCstrtSO);
						
						for(OrdDtlCstrtVO ordCstrtVO :  ordDtlCstrtList) {
							OrderUpdateItemPO temp = new OrderUpdateItemPO();
							String shopSortNo = String.valueOf(ordCstrtVO.getOrdDtlSeq()).concat("_").concat(String.valueOf(ordCstrtVO.getOrdCstrtSeq()));
							temp.setShopOrdrNo(po.getOrdNo());
							temp.setShopSortNo(shopSortNo);
							temp.setDlvtTpCd("10"); //택배
							
							itemList.add(temp);
						}
					}
				}
				
				// 2021.04.19, 서성민, item 대상이 없으면 CIS 주소 변경 안함
				if (itemList.size() > 0) {
					cisUpdatePO.setItemList(itemList);
					try {
						//CIS 배송지 변경
						cisUpdateVO = cisOrderService.updateOrder(cisUpdatePO);
					}catch (Exception e) {
						return ExceptionConstants.ERROR_CIS_DLVRA_UPDATE_ERROR;
					}
					
					if(cisUpdateVO != null && !CommonConstants.CIS_API_SUCCESS_CD.equals(cisUpdateVO.getResCd())) {
						return ExceptionConstants.ERROR_CIS_DLVRA_UPDATE_ERROR;
					}
				}
			
			}
			
		}
		
		/***************************
		 * 주문 배송지 신규 등록
		 ***************************/
		Long ordDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO);
		po.setOrdDlvraNo(ordDlvraNo);
		
		int result = this.orderDlvraDao.insertOrderDlvra(po);
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		/************************************
		 * 주문 상세에 신규 배송지 번호 수정
		 ************************************/
		// 오더 디테일 수정 
		OrderDetailPO orderDetailPO = new OrderDetailPO();
		orderDetailPO.setOrdNo(po.getOrdNo());
		orderDetailPO.setOrdDlvraNo(ordDlvraNo);
		result = orderDetailDao.updateOrderDetail(orderDetailPO);

		if(result == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		//주문접수, 주문완료, 배송지시, 배송준비중일 경우 변경
		if(isPackUpdate) {
			//새벽배송, 당일배송인 경우만
			if(isDawnAndOneDayDlvr) {
				//권역쪽 del_yn = 'Y' 업데이트
				OrderDlvrAreaPO areaPO = new OrderDlvrAreaPO();
				areaPO.setOrdNo(po.getOrdNo());
				result = orderDlvrAreaDao.deleteOrderDlvrAreaMap(areaPO);
				
				if(result != 1){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				//주문 기본 -  택배로 변경
				OrderBasePO basePO = new OrderBasePO();
				basePO.setOrdNo(po.getOrdNo());
				basePO.setDlvrPrcsTpCd(CommonConstants.DLVR_PRCS_TP_10);
				result = orderBaseDao.updateOrderBase(basePO);
				if(result != 1){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
			}
		}
		
		//변경되면 택배 고정
		//배송테이블 -  택배로 변경
		DeliveryPO dlvrPO = new DeliveryPO();
		dlvrPO.setOrdNo(po.getOrdNo());
		if(isDawnAndOneDayDlvr) {
			dlvrPO.setDlvrPrcsTpCd(CommonConstants.DLVR_PRCS_TP_10);
		}
		dlvrPO.setOrdDlvraNo(ordDlvraNo);
		result = deliveryDao.updateDeliveryOrder(dlvrPO);
		
		return "SUCCESS";
	}
}

