package biz.app.delivery.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.cart.model.DeliveryChargeCalcVO;
import biz.app.claim.model.ClaimBasePO;
import biz.app.delivery.model.DeliveryChargeDetailExcptProcessVO;
import biz.app.delivery.model.DeliveryChargeDetailVO;
import biz.app.delivery.model.DeliveryChargePO;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;
import biz.app.delivery.model.DeliveryPaymentVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderSO;
import framework.common.constants.CommonConstants;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.dao
* - 파일명		: DeliveryChargeDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 배송비 DAO
* </pre>
*/
@Repository
public class DeliveryChargeDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "deliveryCharge.";
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargeDao.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명			: 배송비 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertDeliveryCharge(DeliveryChargePO po){
		return insert(BASE_DAO_PACKAGE + "insertDeliveryCharge", po);
	}

	public int insertDeliveryChargeDetailExcptProcess(DeliveryChargeDetailExcptProcessVO vo){
		return insert(BASE_DAO_PACKAGE + "insertDeliveryChargeDetailExcptProcess", vo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargeDao.java
	* - 작성일		: 2017. 2. 28.
	* - 작성자		: snw
	* - 설명			: 배송비 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DeliveryChargeVO> listDeliveryCharge( DeliveryChargeSO so ) {
		return selectList( BASE_DAO_PACKAGE +  "listDeliveryCharge", so );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargeDao.java
	* - 작성일		: 2017. 6. 16.
	* - 작성자		: Administrator
	* - 설명			: 배송비 쿠폰이 사용된 목록 중 클레임에 의해 복원 해야할 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DeliveryChargeVO> listDeliveryChargeCancelCoupon( String clmNo ) {
		return selectList( BASE_DAO_PACKAGE +  "listDeliveryChargeCancelCoupon", clmNo );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargeDao.java
	* - 작성일		: 2021. 09. 02.
	* - 작성자		: lts
	* - 설명		: 배송비 쿠폰이 사용된 목록 중 주문취소일경우만 복원 해야할 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DeliveryChargeVO> deliveryCancelCouponWon(String clmNo) {
		return selectList( BASE_DAO_PACKAGE +  "deliveryCancelCouponWon", clmNo );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargeDao.java
	* - 작성일		: 2017. 3. 17.
	* - 작성자		: snw
	* - 설명			: 배송비 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public DeliveryChargeVO getDeliveryCharge( DeliveryChargeSO so ){
		return selectOne( BASE_DAO_PACKAGE +  "getDeliveryCharge", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargeDao.java
	* - 작성일		: 2017. 3. 20.
	* - 작성자		: snw
	* - 설명			: 배송비 취소 수정
	* </pre>
	* @param s
	* @return
	*/
	public int updateDeliveryChargeCancel(DeliveryChargeDetailVO s){
		return insert(BASE_DAO_PACKAGE + "updateDeliveryChargeCancel", s);
	}

	/**
	 * 클레임 후 주문 상품 목록 조회
	 * @param clmNo
	 * @return
	 */
	public List<DeliveryChargeCalcVO> listDeliveryChargeCalc(String ordNo) {
		return selectList( BASE_DAO_PACKAGE +  "listDeliveryChargeCalc", ordNo );
	}


	public List<DeliveryChargeDetailVO> listDeliveryChargeDetail (ClaimBasePO claimBasePO) {
		return selectList( BASE_DAO_PACKAGE +  "listDeliveryChargeDetail", claimBasePO );
	}

	/**
	 * 배송비 상세 insert (원주문 재계산)
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public int insertDeliveryChargeDetailOrder(DeliveryChargeDetailVO deliveryChargeDetailVO) {
		return insert(BASE_DAO_PACKAGE + "insertDeliveryChargeDetailOrder", deliveryChargeDetailVO);
	}
	
	/**
	 * 배송비 상세 insert (클레임 단독)
	 * @param list
	 * @return
	 * @throws Exception
	 */	
	public int insertDeliveryChargeDetailClaim(DeliveryChargeDetailVO deliveryChargeDetailVO) {
		return insert(BASE_DAO_PACKAGE + "insertDeliveryChargeDetailClaim", deliveryChargeDetailVO);
	}
	
	public int deleteDeliveryChargeDetail(String clmNo) {
		return insert(BASE_DAO_PACKAGE + "deleteDeliveryChargeDetail", clmNo);
	}


	public int insertDeliveryChargeFromDetail(DeliveryChargeDetailVO clmNo) {
		return insert(BASE_DAO_PACKAGE + "insertDeliveryChargeFromDetail", clmNo);
	}

	public void updateOrderDetailDlvrcNoFromDetail(DeliveryChargeDetailVO s) {
		insert(BASE_DAO_PACKAGE + "updateOrderDetailDlvrcNoFromDetail", s);
	}

	public DeliveryPaymentVO getFirstDeliveryCahrgeSum(String ordNo) {
		DeliveryPaymentVO deliveryPaymentVO = selectOne( BASE_DAO_PACKAGE +  "getFirstDeliveryCahrgeSum", ordNo );
		if(deliveryPaymentVO == null) {
			deliveryPaymentVO = selectOne( BASE_DAO_PACKAGE +  "getFirstDeliveryCahrgeSum2", ordNo );
		}

		return deliveryPaymentVO;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2021. 5. 25.
	* - 작성자		: ssmvf01
	* - 설명			: 스냅샷에서 프론트 결제 주문/클레임 배송비, 추가배송비 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public OrderPayVO getFrontPayRefundDlvrFromSnapshot(OrderSO orderSO) {
		return selectOne (BASE_DAO_PACKAGE + "getFrontPayRefundDlvrFromSnapshot", orderSO);
	}


	public void updateDeliveryChargeDetailDlvrcGbCd(DeliveryChargeDetailVO vo) {
		update(BASE_DAO_PACKAGE + "updateDeliveryChargeDetailDlvrcGbCd", vo);
	}


	public List<DeliveryChargeDetailVO> listDeliveryChargeDetailValid(ClaimBasePO claimBasePO) {
		
		return selectList( BASE_DAO_PACKAGE +  "listDeliveryChargeDetailValid", claimBasePO );
	}
	
	public List<DeliveryChargeDetailVO> getChangedDeliveryChargeDetailList(ClaimBasePO claimBasePO) {
		
		return selectList( BASE_DAO_PACKAGE +  "getChangedDeliveryChargeDetailList", claimBasePO );
	}
	
	public int selectBeforeExistsExceptionCnt(Long fstDlvrcNo) {
		
		return selectOne( BASE_DAO_PACKAGE +  "selectBeforeExistsExceptionCnt", fstDlvrcNo );
	}
	
	public int deleteDeliveryChargeDetailExcptProcess(Long fstDlvrcNo) {
		return insert(BASE_DAO_PACKAGE + "deleteDeliveryChargeDetailExcptProcess", fstDlvrcNo);
	}
	
	public DeliveryChargeDetailExcptProcessVO getDeliveryChargeDetailExceptProcess(Long fstDlvrcNo) {
		return selectOne(BASE_DAO_PACKAGE + "getDeliveryChargeDetailExceptProcess", fstDlvrcNo);
	}

	public void updateClaimDetailDlvrcNoFromDetail(DeliveryChargeDetailVO s, String dlvrcCostGbSend) {
		if(CommonConstants.DLVRC_COST_GB_SEND.equals(dlvrcCostGbSend)) {
			update(BASE_DAO_PACKAGE + "updateClaimDetailDlvrcNoFromDetail", s);	
		} else if(CommonConstants.DLVRC_COST_GB_RETURN.equals(dlvrcCostGbSend)) {
			update(BASE_DAO_PACKAGE + "updateClaimDetailRtnDlvrcNoFromDetail", s);
		}
	}

	public long selectMinorExceptionCase1(DeliveryChargeCalcVO deliveryChargeCalcVO) {
		return selectOne( BASE_DAO_PACKAGE +  "selectMinorExceptionCase1", deliveryChargeCalcVO );
	}
	
	
}
