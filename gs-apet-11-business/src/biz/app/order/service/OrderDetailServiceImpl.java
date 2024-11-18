package biz.app.order.service;

import java.util.List;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.ItemDao;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.service.GoodsStockService;
import biz.app.goods.service.ItemService;
import biz.app.member.service.MemberSavedMoneyService;
import biz.app.order.dao.OrdDtlCstrtDao;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.dao.OrderDetailStatusHistDao;
import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.interfaces.sktmp.client.SktmpApiClient;
import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00109ReqVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00109ResVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.common.connect.UrlConnect;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderDetailServiceImpl.java
* - 작성일		: 2017. 1. 9.
* - 작성자		: snw
* - 설명			: 주문 상세 서비스 Impl
* </pre>
*/
@Slf4j
@Service("orderDetailService")
@Transactional
public class OrderDetailServiceImpl implements OrderDetailService {

	
	@Autowired	private OrderService orderService;
	@Autowired	private OrderBaseDao orderBaseDao;

	@Autowired	private OrderDetailDao orderDetailDao;

	@Autowired private MemberSavedMoneyService memberSavedMoneyService;

	@Autowired private ItemDao itemDao;

	@Autowired private ItemService itemService;

	@Autowired
	private OrderDetailStatusHistDao orderDetailStatusHistDao;
	
	@Autowired	private OrdDtlCstrtDao ordDtlCstrtDao;
	
	@Autowired	private OrdSavePntService ordSavePntService;
	@Autowired	private GoodsStockService goodsStockService;
	@Autowired	private SktmpService sktmpService;
	
	@Autowired 
	private Properties bizConfig;

	/*
	 * 주문 상세 상태 수정
	 * @see biz.app.order.service.OrderDetailService#updateOrderDetailStatus(java.lang.String, java.lang.Integer, java.lang.String)
	 */
	@Override
	public void updateOrderDetailStatus(String ordNo, Integer ordDtlSeq, String ordDtlStatCd) {

		// 주문 상태 수정
		OrderDetailPO odpo = new OrderDetailPO();
		odpo.setOrdNo(ordNo);
		odpo.setOrdDtlSeq(ordDtlSeq);
		odpo.setOrdDtlStatCd(ordDtlStatCd);

		int result = this.orderDetailDao.updateOrderDetail(odpo);

		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}else{
			
			
			/*
			 * 주문 상세 상태가 '구매확정'인 경우 지급
			 */
			if(CommonConstants.ORD_DTL_STAT_170.equals(ordDtlStatCd)){
				/**
				 * 1. 추천인 쿠폰 지급
				 * 2. 최초~세번째 구매 감사 쿠폰 지급
				 * 3. GS 포인트 지급
				 * 4. SKT MP 포인트 가용화
				 */
				/********************************
				 * 1. 추천인 쿠폰 지급 - 2021.04.13, by kek01
				 *******************************/
				log.debug("##### BO 구매확정 - <START> 추천인 쿠폰 지급");
				this.orderService.giveRecommandThanksCoupon(ordNo);
				log.debug("##### BO 구매확정 - <END>   추천인 쿠폰 지급");
				
				/********************************
				 * 2. 최초~세번째 구매 감사 쿠폰 지급 - 2021.05.03, by kek01
				 *******************************/
				log.debug("##### BO 구매확정 - <START> 최초~세번째 구매 감사 쿠폰 지급");
				this.orderService.giveFirstOrderThanksCoupon(ordNo);
				log.debug("##### BO 구매확정 - <END>   최초~세번째 구매 감사 쿠폰 지급");

				OrderBaseSO obso = new OrderBaseSO();
				obso.setOrdNo(ordNo);
				OrderBaseVO orderBase = this.orderBaseDao.getOrderBase(obso);
				if(orderBase != null){
					if(!CommonConstants.NO_MEMBER_NO.equals(orderBase.getMbrNo())){
						/********************************
						 * 3. GS 포인트 지급
						 *******************************/
						
						OrderDetailSO odso = new OrderDetailSO();
						odso.setOrdNo(ordNo);
						odso.setOrdDtlSeq(ordDtlSeq);
						OrderDetailVO orderDetail = this.orderDetailDao.getOrderDetail(odso);

						if(orderDetail != null){
							 
							// 취소된 주문인지 체크
							if(orderDetail.getRmnOrdQty() == 0){
								throw new CustomException(ExceptionConstants.ERROR_ORDER_CANCEL_COMPLETE);
							}

							// 클레임이 진행중인 건인지 체크
							if(CommonConstants.COMM_YN_Y.equals(orderDetail.getClmIngYn())){
								throw new CustomException(ExceptionConstants.ERROR_ORDER_CLAIM_ING);
							}
							
							if(orderDetail.getIsuSchdPnt().longValue() > 0) {
								OrdSavePntPO pntPO = new OrdSavePntPO();
								pntPO.setMbrNo(orderDetail.getMbrNo());
								pntPO.setRcptNo(orderDetail.getOrdNo().concat(orderDetail.getOrdDtlSeq().toString()));
								pntPO.setPnt(orderDetail.getIsuSchdPnt());
								pntPO.setSaleAmt(orderDetail.getPayAmt() * (orderDetail.getRmnOrdQty() - orderDetail.getRtnQty()));
								pntPO.setSaleDtm(orderDetail.getSysRegDtm());
								pntPO.setOrdNo(orderDetail.getOrdNo());
								pntPO.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
								
								ordSavePntService.accumOrdGsPoint(pntPO);
							}
							
						}else{
							throw new CustomException( ExceptionConstants.ERROR_ORDER_NO_GOODS);
						}
						
						/********************************
						 * 4. SKT MP 포인트 가용화
						 *******************************/
						this.excuteUsePsbSktmpPnt(ordNo);
					}
				}else{
					throw new CustomException( ExceptionConstants.ERROR_ORDER_NO_BASE);
				}

			}
			/*
			 * [ OUTBOUND API LOGIC ]
			 * added by tigerfive, 2017-09-29, 상품준비중으로 주문이 변경될 때 아웃바운드 API를 호출한다.
			 */
			else if(CommonConstants.ORD_DTL_STAT_140.equals(ordDtlStatCd)) {
				OrderBaseSO obso = new OrderBaseSO();
				obso.setOrdNo(ordNo);
				OrderBaseVO orderBase = this.orderBaseDao.getOrderBase(obso);
				
				if(orderBase != null
						&& CommonConstants.OPENMARKET_11ST_CHANNEL_ID.equals(orderBase.getChnlId())) {
					// 아웃바운드 주문인 경우
					// 아웃바운드의 종류가 많아질 경우 여기에 추가하라.
					OrderDetailSO odso = new OrderDetailSO();
					odso.setOrdNo(ordNo);
					odso.setOrdDtlSeq(ordDtlSeq);
					OrderDetailVO orderDetail = this.orderDetailDao.getOrderDetail(odso);
					
					if(orderDetail != null && !StringUtils.isEmpty(orderDetail.getOutsideOrdDtlNo())) {
						String apiUrl = bizConfig.getProperty("interface.ob.base.uri") + "/api/11st/order/ready";
						UrlConnect urlConnect = new UrlConnect(apiUrl, "GET", "utf-8");
						
						try {
							String params = String.format("ordNo=%s&shopOrdNo=%s&ordPrdSeq=%d&addPrdYn=N&addPrdNo=null&dlvNo=%d", 
									orderDetail.getOutsideOrdDtlNo(), 
									ordNo, 
									ordDtlSeq, 
									orderDetail.getDlvrNo());
							
							String response = urlConnect.connect(params);
							log.debug("response : " + response);
						} catch (Exception e) {
							log.debug(e.getLocalizedMessage());
						}
					}
				}
			}
		}

	}

	/*
	 * 주문 상세 상태 수정 (배송완료)
	 * @see biz.app.order.service.OrderDetailService#updateOrderDetailStatus(java.lang.String, java.lang.Integer, java.lang.String)
	 */
	@Override
	public void updateOrderDetailStatusDlvrCplt(String ordNo, Integer ordDtlSeq, String ordDtlStatCd) {

		// 주문 상태 수정
		OrderDetailPO odpo = new OrderDetailPO();
		odpo.setOrdNo(ordNo);
		odpo.setOrdDtlSeq(ordDtlSeq);
		odpo.setOrdDtlStatCd(ordDtlStatCd);
		odpo.setOrdDtlAllDlvrCpltYn("Y");

		this.orderDetailDao.updateOrderDetail(odpo);
	}
	
	/*
	 * 주문상세 구매완료 처리
	 * @see biz.app.order.service.OrderDetailService#updateOrderDetailPurchase(java.lang.String, java.lang.Integer[])
	 */
	@Override
	public void updateOrderDetailPurchase(String ordNo, Integer[] arrOrdDtlSeq) {

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length >0){
			for(int i=0; i < arrOrdDtlSeq.length; i++){
				this.updateOrderDetailStatus(ordNo, arrOrdDtlSeq[i], CommonConstants.ORD_DTL_STAT_170);
			}
		}
	}

	/*
	 * 주문 상세 목록 조회
	 * @see biz.app.order.service.OrderDetailService#listOrderDetail(biz.app.order.model.OrderDetailSO)
	 */
	@Override
	public List<OrderDetailVO> listOrderDetail(OrderDetailSO so) {
		return this.orderDetailDao.listOrderDetail(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listOrderDetail2ndE
	 * - 작성일		: 2021. 04. 17.
	 * - 작성자		: sorce
	 * - 설명			: 주문 상세 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderBaseVO listOrderDetail2ndE( OrderDetailSO so ) {
		return this.orderDetailDao.listOrderDetail2ndE(so);
	}
	
	/*
	 * 주문 상세 클레임 접수 정보 조회
	 * @see biz.app.order.service.OrderDetailService#listOrderDetail(biz.app.order.model.OrderDetailSO)
	 */
	@Override
	public List<OrderDetailVO> listOrderClaimDetail(OrderDetailSO so) {
		return this.orderDetailDao.listOrderClaimDetail(so);
	}

	/*
	 * 주문 단품 변경
	 * @see biz.app.order.service.OrderDetailService#updateOrderDetailItem(java.lang.String, java.lang.Integer, java.lang.Long)
	 */
	@Override
	@Deprecated
	public void updateOrderDetailItem(String ordNo, Integer ordDtlSeq, Long itemNo) {

		/**************************************
		 * 주문 상세 정보 조회
		 **************************************/
		OrderDetailSO orderDetailSO = new OrderDetailSO();
		orderDetailSO.setOrdNo(ordNo);
		orderDetailSO.setOrdDtlSeq(ordDtlSeq);

		OrderDetailVO orderDetailVO = orderDetailDao.getOrderDetail( orderDetailSO );

		if ( orderDetailVO == null ) {
			throw new CustomException( ExceptionConstants.ERROR_ORDER_NO_BASE );
		}

		/*
		 * 주문상세상태가 주문접수/주문완료/배송지시/상품준비중 일 경우에만 단품변경이 가능 합니다.
		 */
		String ordDtlStatCd = orderDetailVO.getOrdDtlStatCd();
		if( !CommonConstants.ORD_DTL_STAT_110.equals(ordDtlStatCd)
				&& !CommonConstants.ORD_DTL_STAT_120.equals(ordDtlStatCd)
				&& !CommonConstants.ORD_DTL_STAT_130.equals(ordDtlStatCd)
				&& !CommonConstants.ORD_DTL_STAT_140.equals(ordDtlStatCd)){
			throw new CustomException( ExceptionConstants.ERROR_ORDER_NO_CHANGE_ITEM_STATUS );
		}


		ItemSO iso = null;
		/**************************************
		 * 원 단품 정보 조회
		 **************************************/
		iso = new ItemSO();
		iso.setItemNo(orderDetailVO.getItemNo());
		ItemVO orgItem = this.itemDao.getItem( iso );
		if ( orgItem == null ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		/**************************************
		 * 변경 단품 정보 조회
		 **************************************/
		iso = new ItemSO();
		iso.setItemNo(itemNo);
		ItemVO newItem = this.itemDao.getItem( iso );
		if ( newItem == null ) {
			throw new CustomException( ExceptionConstants.ERROR_GOODS_NO_OPTION );
		}

		/*
		 * 변경할 단품의 상품아이디와 원 주문의 상품 아이디가 다른 경우
		 */
		if(!orgItem.getGoodsId().equals(newItem.getGoodsId())){
			throw new CustomException( ExceptionConstants.ERROR_GOODS_NO_OPTION );
		}

		/*
		 * 원 주문의 단품번호와 신규 단품의 단품번호가 같을 경우
		 */
		if(orgItem.getItemNo().equals(newItem.getItemNo())){
			throw new CustomException( ExceptionConstants.ERROR_ORDER_NO_CHANGE_ITEM );
		}

		/*
		 * 단품의 추가 금액이 다른 경우 변경 불가
		 */
		if(!orgItem.getAddSaleAmt().equals(newItem.getAddSaleAmt())){
			throw new CustomException( ExceptionConstants.ERROR_ITEM_ADD_SALE_AMT_EXISTS );
		}

		/********************************
		 * 단품 변경 및 단품의 재고 수량
		 ********************************/
		/*
		 * 기존 단품의 웹 재고수량 증가
		 */
		// 20210812 CSR-1575 CIS를 통해 재고수량 업데이트 후 주문 시 웹 재고 차감만 하고 취소 시는 원복 로직을 제외
//		goodsStockService.updateStockQty(orgItem.getGoodsId(), orderDetailVO.getOrdQty());

		/*
		 * 신규 단품의 웹 재고수량 차감
		 */
		goodsStockService.updateStockQty(newItem.getGoodsId(), orderDetailVO.getOrdQty() *-1);

		/*
		 * 주문 상세 수정
		 */
		OrderDetailPO odpo = new OrderDetailPO();
		odpo.setOrdNo( orderDetailVO.getOrdNo() );
		odpo.setOrdDtlSeq( orderDetailVO.getOrdDtlSeq() );
		odpo.setItemNo( newItem.getItemNo() );
		odpo.setItemNm( newItem.getItemNm() );

		int result = this.orderDetailDao.updateOrderDetail( odpo );

		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

	}

	/*
	 * 주문 상세 단건 조회
	 * @see biz.app.order.service.OrderDetailService#getOrderDetail(java.lang.String, java.lang.Integer)
	 */
	@Override
	@Transactional(readOnly=true)
	public OrderDetailVO getOrderDetail(String ordNo, Integer ordDtlSeq) {
		OrderDetailSO so = new OrderDetailSO();
		so.setOrdNo(ordNo);
		so.setOrdDtlSeq(ordDtlSeq);
		return this.orderDetailDao.getOrderDetail(so);
	}

	/*
	 * 주문상세 중 해당 단품의 다른 주문상세순번이 존재하는지 체크
	 * @see biz.app.order.service.OrderDetailService#duplicateOrderItem(java.lang.String, java.lang.Long, java.lang.Integer)
	 */
	@Override
	public boolean checkOrderItem(String ordNo, Long itemNo, Integer ordDtlSeq) {
		boolean result = false;

		OrderDetailSO so = new OrderDetailSO();
		so.setOrdNo(ordNo);
		so.setItemNo(itemNo);
		OrderDetailVO orderDetail = this.orderDetailDao.getOrderDetail(so);

		// 동일한 단품을 포함하고 있는 주문상세가 존재하고 주문순번이 다를경우
		if(orderDetail != null && !orderDetail.getOrdDtlSeq().equals(ordDtlSeq)){
			result = true;
		}

		return result;
	}

 /**
  *
 * <pre>
 * - 프로젝트명  : 11.business
 * - 패키지명  	: biz.app.order.service
 * - 파일명      	: OrderDetailServiceImpl.java
 * - 작성일      	: 2017. 2. 28.
 * - 작성자      	: valuefactory 권성중
 * - 설명      	: 주문 상세 수정
 * </pre>
  */
	@Override
	public void updateOrderDetail(OrderDetailPO po) {
		int result = orderDetailDao.updateOrderDetail(po);

		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

	}


	 /**
	  *
	 * <pre>
	 * - 프로젝트명  : 11.business
	 * - 패키지명  	: biz.app.order.service
	 * - 파일명      	: OrderDetailServiceImpl.java
	 * - 작성일      	: 2017. 6. 20.
	 * - 작성자      	: valuefactory hjko
	 * - 설명      	: Interface 주문 상세 상태 수정
	 * </pre>
	  */
	@Override
	public void updateOrderDetailStatusInf(OrderDetailPO odpo){

		// 주문 상태 수정
		int result = this.orderDetailDao.updateOrderDetail(odpo);

		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}

	@Override
	public List<OrderDetailVO> listOrderDetailShort(OrderDetailSO so) {
		return orderDetailDao.listOrderDetailShort(so);
	}

	@Override
	public List<OrdDtlCstrtVO> listOrdDtlCstrt(OrderDetailSO so) {
		return ordDtlCstrtDao.listOrdDtlCstrt(so);
	}

	@Override
	public List<OrderDetailVO> listFrequentOrderGoods(OrderDetailSO so) {
		return orderDetailDao.listFrequentOrderGoods(so);
	}

	@Override
	public List<OrderDetailVO> listOrderDetailDlvrCpltForPurchaseConfirm( OrderDetailSO so ) {
		return orderDetailDao.listOrderDetailDlvrCpltForPurchaseConfirm(so);
	}
	@Override
	public Integer getOrderDetailCntByMbrNo(OrderDetailSO so) {
		return orderDetailDao.getOrderDetailCntByMbrNo(so);
	}
	
	@Override
	public void excuteUsePsbSktmpPnt(String ordNo) {
		SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
		mpSO.setOrdNo(ordNo);
		SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
		
		OrderDetailSO listSO = new OrderDetailSO();
		listSO.setOrdNo(ordNo);
		List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(listSO);
		boolean isUsePsb = true;
		
		for(OrderDetailVO detail : orderDetailList) {
			if(!CommonConstants.ORD_DTL_STAT_170.equals(detail.getOrdDtlStatCd())){
				if(detail.getRmnOrdQty() - detail.getRtnQty() != 0) {
					isUsePsb = false;
				}
				
				if(CommonConstants.COMM_YN_Y.equals(detail.getClmIngYn())) {
					isUsePsb = false;
				}
				
			}
			
		}
		
		//전체 구매확정 or 남은수량 없고, 클레임 진행중이 아닐경우  AND 적립예정 MP 포인트 구매확정 시 가용화 처리
		if(isUsePsb && mpVO != null) {
			
			//적립 포인트가 있는 경우
			if(mpVO != null && mpVO.getSavePnt() != null && mpVO.getSavePnt() != 0L) {
				//이미 가용화 처리 한 경우 제외.
				if(!SktmpConstants.API_HUB_SUCCESS_CODE.equals(mpVO.getUsePsbResCd())) {
					ISR3K00109ReqVO usePsbReqVO = new ISR3K00109ReqVO();
					usePsbReqVO.setACK_NUM(mpVO.getCfmNo());
					usePsbReqVO.setEBC_NUM(mpVO.getCardNo());
					usePsbReqVO.setCO_CD(SktmpConstants.PRTNR_CODE);
					//형식 예시가 없어 yyyyMMdd 로 세팅
					usePsbReqVO.setACK_DATE(DateUtil.getTimestampToString(mpVO.getResDtm()));
					
					SktmpApiClient client = new SktmpApiClient();
					ISR3K00109ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00109, usePsbReqVO, ISR3K00109ResVO.class);
					
					SktmpLnkHistVO res = new SktmpLnkHistVO();
					res.setMpLnkHistNo(mpVO.getMpLnkHistNo());
					if("S".equals(vo.getRESULT())) {
						res.setUsePsbResCd(vo.getCODE());
						res.setUsePsbResMsg(vo.getMESSAGE());
					}else {
						res.setUsePsbResCd(vo.getRESULT_CODE());
						res.setUsePsbResMsg(vo.getRESULT_MESSAGE());
					}
					
					sktmpService.updateSktmpLnkHist(res);
				}
			}
		}
	}
}

