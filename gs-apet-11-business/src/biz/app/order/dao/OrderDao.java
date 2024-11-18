package biz.app.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import biz.app.cart.model.CartGoodsSO;
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
import biz.app.order.model.OrderListExcelVO;
import biz.app.order.model.OrderListSO;
import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderMsgVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderReceiptVO;
import biz.app.order.model.OrderSO;
import biz.app.order.model.OrderStatusVO;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoPO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderDao.java
* - 작성일		: 2016. 3. 8.
* - 작성자		: dyyoun
* - 설명			:
* </pre>
*/
@Repository
public class OrderDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "order.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: snw
	* - 설명			: 원 주문 목록 페이징 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderListVO> pageOrderOrg( OrderListSO so ) {
		
		if(!StringUtil.isBlank(so.getOrdrTel())){
			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getOrdrMobile())){
			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
		}

		return selectListPage( BASE_DAO_PACKAGE + "pageOrderOrg", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2021. 3. 25.
	* - 작성자		: pse
	* - 설명			: 원 주문 엑셀 목록 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	@Transactional(value="slaveTransactionManager")
	public List<OrderListExcelVO> orderOrgExcel( OrderListSO so ) {
		
		if(!StringUtil.isBlank(so.getOrdrTel())){
			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getOrdrMobile())){
			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
		}

		return selectListPage( BASE_DAO_PACKAGE + "orderOrgExcel", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2021. 3. 25.
	* - 작성자		: pse
	* - 설명			: 원 주문 엑셀 목록 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	@Transactional(value="slaveTransactionManager")
	public List<OrderListExcelVO> orderAdjustExcel( OrderListSO so ) {
		
		if(!StringUtil.isBlank(so.getOrdrTel())){
			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getOrdrMobile())){
			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
		}

		return selectListPage( BASE_DAO_PACKAGE + "orderAdjustExcel", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: tigerfive
	* - 설명			: 원 주문 목록 페이징 조회 (API용)
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<biz.app.order.model.interfaces.OrderListVO> pageOrderOrgInterface( OrderListSO so ) {
		
		if(!StringUtil.isBlank(so.getOrdrTel())){
			so.setOrdrTel(so.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getOrdrMobile())){
			so.setOrdrMobile(so.getOrdrMobile().replaceAll("-", ""));
		}

		return selectListPage( BASE_DAO_PACKAGE + "pageOrderOrgInterface", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 결제 총괄 정보 조회
	* </pre>
	* @param ordNo
	* @return
	*/
	public OrderPayVO getOrderPayInfo(String ordNo){
		return selectOne (BASE_DAO_PACKAGE + "getOrderPayInfo", ordNo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2021. 4. 26.
	* - 작성자		: ssmvf01
	* - 설명			: 프론트 결제 정보 조회
	* </pre>
	* @param ordNo
	* @return
	*/
	public OrderPayVO getFrontPayInfo(String ordNo){
		return selectOne (BASE_DAO_PACKAGE + "getFrontPayInfo", ordNo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 4. 7.
	* - 작성자		: snw
	* - 설명			: 주문 데이터의 실 결제 예정 금액 조회
	* </pre>
	* @param ordNo
	* @return
	*/
	public Long	getOrderRealPayAmt(String ordNo){
		return selectOne (BASE_DAO_PACKAGE + "getOrderRealPayAmt", ordNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderDao.java
	 * - 작성일	: 2016. 3. 31.
	 * - 작성자	: jangjy
	 * - 설명		: Front 마이페이지 주문/배송조회 목록
	 * </pre>
	 * @param orderSo
	 * @return
	 */
	public List<OrderDeliveryVO> pageOrderDeliveryList( OrderSO orderSO ) {
		return this.selectListPage(BASE_DAO_PACKAGE + "pageOrderDeliveryList", orderSO );
	}

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
	public List<OrderBaseVO> pageOrderDeliveryList2ndE( OrderSO orderSO ) {
		return this.selectListPage(BASE_DAO_PACKAGE + "pageOrderDeliveryList2ndE", orderSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: OrderDao.java
	* - 작성일	: 2016. 4. 8.
	* - 작성자	: jangjy
	* - 설명		: 작성가능한 상품평 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDetailVO> pageBeforeGoodsCommentList (OrderSO so){
		return this.selectListPage(BASE_DAO_PACKAGE + "pageBeforeGoodsComment", so);
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: hjko
	* - 설명			: 나의 최근 주문 목록 + 연관상품
	* </pre>
	* @param os
	* @return
	 */
	public List<OrderDetailVO> listMyRecentOrderGoods(OrderSO os) {
		return selectList(BASE_DAO_PACKAGE + "listMyRecentOrderGoods", os);
	}
	
	//////////////////////////////









	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderDao.java
	 * - 작성일	: 2016. 5. 02.
	 * - 작성자	: jangjy
	 * - 설명		: 계산서/영수증 조회 및 신청 리스트 조회
	 * </pre>
	 * @param orderSo
	 * @return
	 */
	public List<OrderReceiptVO> pageOrderReceiptList( OrderSO so ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageOrderReceipt", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2016. 5. 20.
	* - 작성자		: phy
	* - 설명			: PC, 취소/교환/반품 신청 가능 주문 리스트 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderClaimVO> pageClaimRequestList( OrderSO orderSO ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageClaimRequestList", orderSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2016. 5. 30.
	* - 작성자		: phy
	* - 설명		: 나의 최근 주문현황
	* </pre>
	* @param orderSO
	* @return
	*/
	public OrderStatusVO listOrderCdCountList(OrderSO orderSO) {
		return selectOne(BASE_DAO_PACKAGE + "listOrderCdCountList", orderSO);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2016. 5. 31.
	* - 작성자		: yhkim
	* - 설명		: 주문 취소 리스트 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDeliveryVO> listCancelDetail( OrderSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listCancelDetail", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2021. 4. 22.
	* - 작성자		: pse
	* - 설명		: 주문 리스트 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDeliveryVO> listClaimDetail( OrderSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listClaimDetail", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2021. 3. 4.
	* - 작성자		: yhkim
	* - 설명		: 주문 구매확정 리스트 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDeliveryVO> listPurchaseDetail( OrderSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listPurchaseDetail", so );
	}



	
	///////////////////////////





	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 무통장/가상계좌 미입금된 목록 조회
	* </pre>
	* @return
	*/
	public List<BatchOrderVO> listPaymentAdviceEmail() {
		return selectList(BASE_DAO_PACKAGE + "listPaymentAdviceEmail");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 가상계좌 1시간 경과 후 미입금된 목록 조회
	* </pre>
	* @return
	*/
	public List<OrderMsgVO> listNdpstMsgSendKko() {
		return selectList(BASE_DAO_PACKAGE + "listNdpstMsgSendKko");
	}



	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2016. 6. 7.
	* - 작성자		: yhkim
	* - 설명		: 주문 교환 리스트 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDeliveryVO> listExchangeDetail( OrderSO  so ) {
		return selectList(BASE_DAO_PACKAGE + "listExchangeDetail", so );
	}








	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 2. 23.
	* - 작성자		: hjko
	* - 설명		: 해당 주문에 적용된 혜택 조회
	* </pre>
	* @param abso
	* @return
	 */
	public List<AplBnftVO> listOrderAplBnft(AplBnftSO abso) {
		return selectList(BASE_DAO_PACKAGE + "listOrderAplBnft", abso);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: hjko
	* - 설명		: 구매영수증
	* </pre>
	* @param orderSO
	* @return
	 */
	public List<OrderDetailVO> listPurchaseReceipt(OrderSO orderSO) {
		return selectList(BASE_DAO_PACKAGE + "listPurchaseReceipt", orderSO);
	}






	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderDao.java
	 * - 작성일	: 2016. 3. 31.
	 * - 작성자	: jangjy
	 * - 설명		: Front 1:1문의 주문정보 선택 (주문번호조회)
	 * </pre>
	 * @param orderSo
	 * @return
	 */
	public List<OrderDeliveryVO> pageOrderInfoList(OrderSO orderSO) {
		return this.selectListPage(BASE_DAO_PACKAGE + "pageOrderInfoList", orderSO);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: OrderDao.java
	 * - 작성일	: 2016. 3. 31.
	 * - 작성자	: jangjy
	 * - 설명		: Front 1:1문의 주문정보 선택 (주문번호해당상품조회)
	 * </pre>
	 * @param orderSo
	 * @return
	 */
	public List<OrderDeliveryVO> listOrderProdList(Map<String,Object> param) {
		return this.selectList(BASE_DAO_PACKAGE + "listOrderProdList", param);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2020. 3. 3.
	* - 작성자		: valfac
	* - 설명		: 주문 반품 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDeliveryVO> listReturnDetail( OrderSO  so ) {
		return selectList(BASE_DAO_PACKAGE + "listReturnDetail", so );
	}

	public int saveDefaultPayMethod(PrsnPaySaveInfoPO ppsipo){
		return insert(BASE_DAO_PACKAGE + "insertDefaultPayMethod", ppsipo);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getCashReceiptSaveInfo
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: sorce
	 * - 설명			: 
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public PrsnPaySaveInfoVO getCashReceiptSaveInfo(Long mbrNo) {
		return selectOne(BASE_DAO_PACKAGE + "getCashReceiptSaveInfo", mbrNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: saveCashReceiptSaveInfo
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: sorce
	 * - 설명			: 
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer saveCashReceiptSaveInfo(PrsnPaySaveInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCashReceiptSaveInfo", po);
	}
	
	public List<CardcInstmntInfoVO> getCardcInstmntInfo(CardcInstmntInfoSO so) {
		return selectList(BASE_DAO_PACKAGE + "getCardcInstmntInfo", so);
	}

	public int insertRegistBillCardTemp(PrsnCardBillingInfoPO pcbipo){
		return insert(BASE_DAO_PACKAGE + "insertRegistBillCardTemp", pcbipo);
	}

	public int updateRegistBillCard(PrsnCardBillingInfoPO pcbipo) {

		return update(BASE_DAO_PACKAGE + "updateRegistBillCard", pcbipo);
	}

	public String getBillingKey(String prsnCardBillNo){
		return selectOne(BASE_DAO_PACKAGE + "getBillingKey", prsnCardBillNo);
	}

	public PrsnCardBillingInfoVO getBillInfo(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getBillInfo", mbrNo);
	}

	public int updateInputFailCnt(PrsnCardBillingInfoPO failpo) {
		return update(BASE_DAO_PACKAGE + "updateInputFailCnt", failpo);
	}

	public int updateBillPassword(PrsnCardBillingInfoPO pcbipo) {

		return update(BASE_DAO_PACKAGE + "updateBillPassword", pcbipo);
	}

	public int resetInputFailCnt(PrsnCardBillingInfoPO failpo) {
		return update(BASE_DAO_PACKAGE + "updateInputFailCnt", failpo);
	}

	public int getBillInputFailCnt(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getBillInputFailCnt", mbrNo);
	}
	
	public List<OrderMsgVO> listOrderMsgInfo(OrderSO so) {
		return selectList(BASE_DAO_PACKAGE + "listOrderMsgInfo" , so);
	}

	public int deleteBillCardInfo(PrsnCardBillingInfoPO delpo) {

		return delete(BASE_DAO_PACKAGE + "deleteBillCardInfo", delpo);
	}
	
	public List<OrderAdbrixVO> listCartAdbrix(CartGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listCartAdbrix", so);
	}
	

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
	public OrderComplete getTempPayInfo(String ordNo) {
		return selectOne(BASE_DAO_PACKAGE + "getTempPayInfo", ordNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listOrderCompMobile
	 * - 작성일		: 2021. 05. 17.
	 * - 작성자		: sorce
	 * - 설명			: 주문 해당 업체 연락처 리스트 
	 * </pre>
	 * @param ordNo
	 * @return
	 */
	public List<OrderMsgVO> listOrderCompMobile(OrderSO so) {
		return selectList(BASE_DAO_PACKAGE + "listOrderCompMobile", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listOrderCompInfo
	 * - 작성일		: 2021. 05. 17.
	 * - 작성자		: hjh
	 * - 설명			: 위탁업체 주문 정보 조회
	 * </pre>
	 * @param ordNo
	 * @return
	 */
	public List<OrderMsgVO> listOrderCompInfo(OrderSO so) {
		return selectList(BASE_DAO_PACKAGE + "listOrderCompInfo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: updateDefaultPrsnCard
	 * - 작성일		: 2021. 05. 17.
	 * - 작성자		: sorce
	 * - 설명			: 간편 카드 기본 여부 업데이트 
	 * </pre>
	 * @param ordNo
	 * @return
	 */
	public int updateDefaultPrsnCard(PrsnPaySaveInfoPO ppsipo) {
		return update(BASE_DAO_PACKAGE + "updateDefaultPrsnCard", ppsipo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 07. 29.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 결제 정보 조회 - 포인트 환불
	 * </pre>
	 * @param so
	 * @return
	 */
	public OrderPayVO getOrderPayInfoForPnt(OrderSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getOrderPayInfoForPnt", so);
	}
}
