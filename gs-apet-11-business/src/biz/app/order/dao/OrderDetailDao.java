package biz.app.order.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailStatusHistPO;
import biz.app.order.model.OrderDetailVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: OrderDetailDao.java
* - 작성일		: 2017. 1. 9.
* - 작성자		: snw
* - 설명			: 주문 상세 DAO
* </pre>
*/
@Repository
public class OrderDetailDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderDetail.";

	@Autowired private OrderDetailStatusHistDao orderDetailStatusHistDao;

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2017. 1. 13.
	* - 작성자		: snw
	* - 설명			: 주문 상세 등록
	* </pre>
	* @param orderDetailPO
	* @return
	*/
	public int insertOrderDetail( OrderDetailPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertOrderDetail", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 상세 목록 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDetailVO> listOrderDetail( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listOrderDetail", so );
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
		return selectOne( BASE_DAO_PACKAGE + "listOrderDetail2ndE", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2020. 2. 10.
	* - 작성자		: snw
	* - 설명			: 주문 상세 클레임 접수 정보 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDetailVO> listOrderClaimDetail( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listOrderClaimDetail", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 주문 상세 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateOrderDetail( OrderDetailPO po ) {

		
		int rtn = update( BASE_DAO_PACKAGE + "updateOrderDetail", po );
		
		/*
		 * 주문 상세 상태 코드가 변경되는 경우 이력 저장
		 */
		if (rtn > 0 
				&& po.getOrdDtlStatCd() != null && !"".equals(po.getOrdDtlStatCd())){
			OrderDetailStatusHistPO odshpo = new OrderDetailStatusHistPO();
			odshpo.setOrdNo(po.getOrdNo());
			// interface regrno 등록시 널로 들어가서 추가. 2017/06/20 hjko
			odshpo.setSysRegrNo(po.getSysRegrNo());

			if(po.getOrdDtlSeq() != null){
				odshpo.setOrdDtlSeq(po.getOrdDtlSeq());
			}
			orderDetailStatusHistDao.insertOrderDetailStatusHist(odshpo);
		}
		

		return rtn;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2017. 3. 3.
	* - 작성자		: snw
	* - 설명			: 주문 상세 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public OrderDetailVO getOrderDetail( OrderDetailSO so ) {
		return (OrderDetailVO) selectOne( BASE_DAO_PACKAGE + "getOrderDetail", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2017. 3. 9.
	* - 작성자		: snw
	* - 설명			: 주문상세 클레임 수량 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateOrderDetailClaimQty(OrderDetailPO po){
		return update(BASE_DAO_PACKAGE + "updateOrderDetailClaimQty", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 주문 상세 수 조회 (대기 또는 완료)
	* </pre>
	* @param so
	* @return
	*/
	public Integer getOrderDetailLiveCnt(OrderDetailSO so) {
		return (Integer) selectOne(BASE_DAO_PACKAGE + "getOrderDetailLiveCnt", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderDetailDao.java
	 * - 작성일		: 2021. 3. 23.
	 * - 작성자		: kek01
	 * - 설명		: 주문 상세 수 조회 (주문완료건)
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer getOrderDetailCntByMbrNo(OrderDetailSO so) {
		return (Integer) selectOne(BASE_DAO_PACKAGE + "getOrderDetailCntByMbrNo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderDetailDao.java
	 * - 작성일		: 2021. 5. 03.
	 * - 작성자		: kek01
	 * - 설명		: 주문 구매확정 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer getOrderPurchaseConfirmCntByMbrNo(OrderDetailSO so) {
		return (Integer) selectOne(BASE_DAO_PACKAGE + "getOrderPurchaseConfirmCntByMbrNo", so);
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: OrderDao.java
	* - 작성일	: 2016. 4. 12.
	* - 작성자	: jangjy
	* - 설명		: 상품평 등록으로 인한 주문상세 업데이트 (상품 평가 등록 여부)
	* </pre>
	* @param po
	* @return
	*/
	public int updateOrderDetailComment(OrderDetailPO po){
		return update(BASE_DAO_PACKAGE + "updateOrderDetailComment", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: OrderDao.java
	* - 작성일	: 2017. 7. 04.
	* - 작성자	: hjko
	* - 설명		: batch . 미입금된 주문 목록 조회
	* </pre>
	* @param po
	* @return
	*/
	public List<OrderDetailVO> listUnpaidOrder(){
		return selectList(BASE_DAO_PACKAGE + "listUnpaidOrder");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 상세 간략 정보 
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listOrderDetailShort( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listOrderDetailShort", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 03. 09.
	 * - 작성자		: JinHong
	 * - 설명		: 자주 구매한 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listFrequentOrderGoods( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listFrequentOrderGoods", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2021. 03. 18.
	* - 작성자		: kek01
	* - 설명			: 구매확정을 위한 배송완료된 주문상세 목록 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<OrderDetailVO> listOrderDetailDlvrCpltForPurchaseConfirm( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listOrderDetailDlvrCpltForPurchaseConfirm", so );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: OrderDetailDao.java
	* - 작성일		: 2021. 3. 25.
	* - 작성자		: pcm
	* - 설명		: 펫로그 후기 작성 후 주문 상세 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateOrderDetailPlg(OrderDetailPO po) {
		return update(BASE_DAO_PACKAGE + "updateOrderDetailPlg", po);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 04. 08.
	 * - 작성자		: JinHong
	 * - 설명		: 
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listValidGoodsStock( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listValidGoodsStock", so );
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.dao
	 * - 작성일		: 2021. 05. 27.
	 * - 작성자		: JinHong
	 * - 설명		: 클레임 대상 수량 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listOrderDetailForClaimTarget( OrderDetailSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listOrderDetailForClaimTarget", so );
	}
}
