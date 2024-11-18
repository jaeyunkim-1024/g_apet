package biz.app.order.service;

import java.util.List;
import java.util.Map;

import biz.app.cart.model.CartGoodsSO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.order.model.AplBnftSO;
import biz.app.order.model.AplBnftVO;
import biz.app.order.model.BatchOrderVO;
import biz.app.order.model.CardcInstmntInfoSO;
import biz.app.order.model.CardcInstmntInfoVO;
import biz.app.order.model.OrderAdbrixVO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderClaimVO;
import biz.app.order.model.OrderComplete;
import biz.app.order.model.OrderDeliveryVO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderListExcelVO;
import biz.app.order.model.OrderListSO;
import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderMsgVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderReceiptVO;
import biz.app.order.model.OrderRegist;
import biz.app.order.model.OrderSO;
import biz.app.order.model.OrderStatusVO;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnPaySaveInfoPO;
import biz.app.pay.model.PrsnPaySaveInfoVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.service
 * - 파일명		: OrderService.java
 * - 작성일		: 2017. 1. 17.
 * - 작성자		: snw
 * - 설명		: 주문 서비스
 * </pre>
 */
public interface OrderService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderCommonService.java
	 * - 작성일		: 2017. 1. 17.
	 * - 작성자		: snw
	 * - 설명		: 주문 등록 - 비활성화 상태로 등록
	 * </pre>
	 * 
	 * @param ordRegist
	 */
	public String insertOrder(OrderRegist ordRegist, OrderComplete ordComplete);

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getTempPayInfo
	 * - 작성일		: 2021. 04. 27.
	 * - 작성자		: sorce
	 * - 설명			: 주문임시 저장 정보
	 * </pre>
	 * @param ordNo
	 * @return
	 */
	public OrderComplete getTempPayInfo(String ordNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderCommonService.java
	 * - 작성일		: 2017. 1. 26.
	 * - 작성자		: snw
	 * - 설명		: 주문 완료 - 주문접수 & 결제완료
	 * </pre>
	 * 
	 * @param ordComplete
	 */
	public void insertOrderComplete(OrderComplete ordComplete);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderService.java
	 * - 작성일		: 2021. 3. 24.
	 * - 작성자		: kek01
	 * - 설명		: 최초~세번째 구매 감사 쿠폰 지급처리 (구매확정시 쿠폰 지급처리)
	 * </pre>
	 * 
	 * @param orderNo
	 */
	public void giveFirstOrderThanksCoupon(String orderNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderService.java
	 * - 작성일		: 2021. 4. 12.
	 * - 작성자		: kek01
	 * - 설명		: 추천인 쿠폰 지급처리(피추천인이 최초 구매확정 처리시 1회만 쿠폰 지급처리)
	 * </pre>
	 * 
	 * @param orderNo
	 */
	public void giveRecommandThanksCoupon(String orderNo);	
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: snw
	* - 설명			: 원주문 목록 페이징 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderListVO> pageOrderOrg(OrderListSO so);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: tigerfive
	* - 설명			: 원주문 목록 페이징 조회 (API용)
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<biz.app.order.model.interfaces.OrderListVO> pageOrderOrgInterface(OrderListSO so);
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2021. 3. 25.
	* - 작성자		: pse
	* - 설명			: 원주문 엑셀 목록 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderListExcelVO> orderOrgExcel(OrderListSO so);
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2021. 5. 17.
	* - 작성자		: pse
	* - 설명			: 정산내역 엑셀 목록 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderListExcelVO> orderAdjustExcel(OrderListSO so);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 주문 결제 정보
	* 					 클레임 완료건을 반영한 정보
	 * </pre>
	 * 
	 * @param ordNo
	 * @return
	 */
	public OrderPayVO getOrderPayInfo(String ordNo);
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2021. 4. 26.
	* - 작성자		: ssmvf01
	* - 설명			: 프론트 결제 정보 조회
	 * </pre>
	 * 
	 * @param ordNo
	 * @return
	 */
	public OrderPayVO getFrontPayInfo(String ordNo);
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2021. 5. 25.
	* - 작성자		: ssmvf01
	* - 설명			: 스냅샷에서 프론트 결제 주문/클레임 배송비, 추가배송비 조회
	 * </pre>
	 * 
	 * @param ordNo
	 * @return
	 */
	public OrderPayVO getFrontPayRefundDlvrFromSnapshot(OrderSO orderSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderService.java
	 * - 작성일	: 2016. 3. 31.
	 * - 작성자	: jangjy
	 * - 설명		: Front 마이룸 주문/배송조회 리스트
	 * </pre>
	 * 
	 * @param orderSo
	 * @return
	 */
	public List<OrderDeliveryVO> pageOrderDeliveryList(OrderSO orderSO);


	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: pageOrderDeliveryList
	 * - 작성일		: 2021. 04. 15.
	 * - 작성자		: sorce
	 * - 설명			: 임시메서드 기존 리스트 에러 안나도록
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<OrderBaseVO> pageOrderDeliveryList2ndE( OrderSO orderSO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderService.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: valueFactory
	 * - 설명			: 무통장/가상계좌 미입금된 목록 조회
	 * </pre>
	 */
	public List<BatchOrderVO> listPaymentAdviceEmail();
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderService.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: valueFactory
	 * - 설명			: 가상계좌 1시간 경과 후 미입금된 목록 조회
	 * </pre>
	 */
	public List<OrderMsgVO> listNdpstMsgSendKko();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderService.java
	 * - 작성일	: 2016. 5. 02.
	 * - 작성자	: jangjy
	 * - 설명		: 계산서/영수증 조회 및 신청 리스트 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<OrderReceiptVO> pageOrderReceiptList(OrderSO so);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2016. 5. 20.
	* - 작성자		: phy
	* - 설명		: 취소/교환/반품 신청 가능 주문 리스트 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderClaimVO> pageClaimRequestList(OrderSO orderSO);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2016. 5. 30.
	* - 작성자		: phy
	* - 설명		: 나의 최근 주문현황
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public OrderStatusVO listOrderCdCountList(OrderSO orderSO);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2016. 5. 31.
	* - 작성자		: yhkim
	* - 설명			: 주문 취소 리스트 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderDeliveryVO> listCancelDetail(OrderSO so);
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2021. 4. 21.
	* - 작성자		: pse
	* - 설명			: 주문 리스트 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderDeliveryVO> listClaimDetail(OrderSO so);
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2021. 3. 4.
	* - 작성자		: yhkim
	* - 설명			: 주문 구매확정 리스트 조회
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderDeliveryVO> listPurchaseDetail(OrderSO so);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: ClaimService.java
	* - 작성일	: 2016.6. 7.
	* - 작성자	: yhkim
	* - 설명		: 주문 교환 리스트 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<OrderDeliveryVO> listExchangeDetail(OrderSO so);

	/**
	 *
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: hjko
	* - 설명			: 나의 최근 주문 목록
	 * </pre>
	 * 
	 * @param os
	 * @return
	 */
	public List<OrderDetailVO> listMyRecentOrderGoods(OrderSO os);

//////////////////////////////////////////////

	/**
	 *
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2017. 2. 23.
	* - 작성자		: hjko
	* - 설명		: 주문에 해당하는 적용 혜택 목록 조회
	 * </pre>
	 * 
	 * @param abso
	 * @return
	 */
	public List<AplBnftVO> listOrderAplBnft(AplBnftSO abso);

	/**
	 *
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderService.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: hjko
	* - 설명		:  front 구매영수증 팝업
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<OrderDetailVO> listPurchaseReceipt(OrderSO orderSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderService.java
	 * - 작성일	: 2016. 3. 31.
	 * - 작성자	: jangjy
	 * - 설명		: Front 1:1문의 주문정보 선택
	 * </pre>
	 * 
	 * @param orderSo
	 * @return
	 */
	public List<OrderDeliveryVO> pageOrderInfoList(OrderSO orderSO);

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: OrderDao.java
	* - 작성일	: 2017. 7. 04.
	* - 작성자	: hjko
	* - 설명		: batch. 미입금된 주문 목록 조회
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public List<OrderDetailVO> listUnpaidOrder();
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: ClaimService.java
	* - 작성일	: 2020.3. 3.
	* - 작성자	: valfac
	* - 설명		: 주문 반품 리스트 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<OrderDeliveryVO> listReturnDetail(OrderSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderService.java
	 * - 작성일	: 2021.03.14
	 * - 작성자	: valfac
	 * - 설명	: 기본결제수단저장
	 * </pre>
	 *
	 * @param ppsipo
	 * @return
	 */
	public void saveDefaultPayMethod(PrsnPaySaveInfoPO ppsipo);

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getCashReceiptSaveInfo
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: sorce
	 * - 설명			: 현금영수증 신청저장정보 select
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public PrsnPaySaveInfoVO getCashReceiptSaveInfo(Long mbrNo);
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: saveCashReceiptSaveInfo
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: sorce
	 * - 설명			: 현금영수증 신청저장정보  저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer saveCashReceiptSaveInfo(PrsnPaySaveInfoPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getCardcInstmntInfo
	 * - 작성일		: 2021. 05. 03.
	 * - 작성자		: sorce
	 * - 설명			: 무이자 정보 조회 (수정)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CardcInstmntInfoVO> getCardcInstmntInfo(CardcInstmntInfoSO so);


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderService.java
	 * - 작성일	: 2021.03.14
	 * - 작성자	: valfac
	 * - 설명	: 임시 빌링정보 저장
	 * </pre>
	 *
	 * @param pcbipo
	 * @return
	 */
	public String insertRegistBillCardTemp(PrsnCardBillingInfoPO pcbipo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderService.java
	 * - 작성일	: 2021.03.14
	 * - 작성자	: valfac
	 * - 설명	: 빌링정보 update
	 * </pre>
	 *
	 * @param pcbipo
	 * @return
	 */
	public void updateRegistBillCard(PrsnCardBillingInfoPO pcbipo);

	public String getBillingKey(String prsnCardBillNo);

	public Map<String, Object> checkBillPassword(PrsnCardBillingInfoPO pcbipo);

	public void updateBillPassword(PrsnCardBillingInfoPO pcbipo);

	public void resetInputFailCnt(PrsnCardBillingInfoPO pcbipo);

	public int getBillInputFailCnt(Long mbrNo);

	public void deleteBillCardInfo(PrsnCardBillingInfoPO delpo);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: OrderService.java
	* - 작성일	: 2021. 4. 26.
	* - 작성자 	: valfac
	* - 설명 		:
	* </pre>
	*
	* @param ordNo
	* @param clmNo
	* @param tmplCd
	* @param ordDtlSeq
	*/
	public void sendMessage(String ordNo, String clmNo, String tmplCd, Integer ordDtlSeq);
	public void sendMessage(String ordNo, String clmNo, String tmplCd, Integer ordDtlSeq, Integer[] arrOrdDtlSeq);
	public void sendMessage(String ordNo, String clmNo, String tmplCd, Integer ordDtlSeq, Integer[] arrOrdDtlSeq, String invNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 04. 25.
	 * - 작성자		: hjh
	 * - 설명		: 업체 주문 알림 발송 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderMsgVO> listOrderCompInfo(OrderSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 04. 25.
	 * - 작성자		: JinHong
	 * - 설명		: adbrix 관련 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderAdbrixVO> listCartAdbrix(CartGoodsSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 05. 28.
	 * - 작성자		: JinHong
	 * - 설명		: List<OrderDetailVO>개인정보마스킹 처리
	 * </pre>
	 * @param so
	 * @return
	 */	
	public OrderBaseVO getMaskingOrderBaseVO(OrderBaseVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 05. 28.
	 * - 작성자		: JinHong
	 * - 설명		: List<OrderDetailVO>개인정보마스킹 처리
	 * </pre>
	 * @param so
	 * @return
	 */	
	public OrderDlvraVO getMaskingOrderDlvraVO(OrderDlvraVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 06. 14.
	 * - 작성자		: KKB
	 * - 설명		: 웹재고 조회 리스트(재고관리 Y)
	 * </pre>
	 * @param so
	 * @return
	 */	
	public List<GoodsBaseVO> listWebStkQty(GoodsBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: OrderService.java
	* - 작성일	: 2021. 8. 10.
	* - 작성자 	: valfac
	* - 설명 		: 배송지시시 중복으로 등록된 배송 매핑 삭제 
	* </pre>
	*
	* @param ordNo
	* @param ordDtlSeq
	* @return
	*/
	public int deleteOrdDtlCstrtDlvrMap(String ordNo, Long ordDtlSeq);
}
