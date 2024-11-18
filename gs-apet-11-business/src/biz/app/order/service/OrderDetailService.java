package biz.app.order.service;

import java.util.List;

import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.order.service
* - 파일명		: OrderDetailService.java
* - 작성일		: 2017. 1. 9.
* - 작성자		: snw
* - 설명			: 주문 상세 서비스
* </pre>
*/
public interface OrderDetailService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 주문 상세 상태 수정
	* 					  - 구매확정 시 적립금지급
	* </pre>
	* @param ordNo
	* @param ordDtlSeq
	* @param ordDtlStatCd
	*/
	public void updateOrderDetailStatus(String ordNo, Integer ordDtlSeq, String ordDtlStatCd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 주문 상세 상태 수정 (주문상세의 모든 배송이 배송완료일자가 존재할때 배송완료로 UPDATE)
	* </pre>
	* @param ordNo
	* @param ordDtlSeq
	* @param ordDtlStatCd
	*/
	public void updateOrderDetailStatusDlvrCplt(String ordNo, Integer ordDtlSeq, String ordDtlStatCd);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 3. 20.
	* - 작성자		: snw
	* - 설명			: 주문상세 구매완료 처리
	* </pre>
	* @param ordNo
	* @param ordDtlSeq
	* @param ordDtlStatCd
	*/
	public void updateOrderDetailPurchase(String ordNo, Integer[] arrOrdDtlSeq);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 상세 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDetailVO> listOrderDetail( OrderDetailSO so );

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
	public OrderBaseVO listOrderDetail2ndE( OrderDetailSO so );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2020. 2. 10.
	* - 작성자		: valfac
	* - 설명			: 주문 상세 클레임 접수 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDetailVO> listOrderClaimDetail( OrderDetailSO so );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 5. 8.
	* - 작성자		: snw
	* - 설명			: 주문 단품 변경
	* </pre>
	* @param ordNo
	* @param ordDtlSeq
	* @param itemNo
	*/
	public void updateOrderDetailItem( String ordNo, Integer ordDtlSeq, Long itemNo );













	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 1. 9.
	* - 작성자		: snw
	* - 설명			: 주문 상세 단건 조회
	* </pre>
	* @param ordNo
	* @param ordDtlSeq
	* @return
	*/
	public OrderDetailVO getOrderDetail( String ordNo, Integer ordDtlSeq );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문상세 중 해당 단품의 다른 주문상세순번이 존재하는지 체크
	* </pre>
	* @param ordNo
	* @param itemNo
	* @return
	*/
	public boolean checkOrderItem(String ordNo, Long itemNo,Integer ordDtlSeq);




	 /**
	  *
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.order.service
	 * - 파일명      : OrderDetailService.java
	 * - 작성일      : 2017. 2. 28.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      : 오더디테일 수정
	 * </pre>
	  */
	public void updateOrderDetail(OrderDetailPO po);



	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDetailService.java
	* - 작성일		: 2017. 6. 20
	* - 작성자		: hjko
	* - 설명		: Interface order_detail status 변경
	* </pre>
	* @param orderDetailSO
	* @return
	 */
	void updateOrderDetailStatusInf(OrderDetailPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 상세 간략 정보
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listOrderDetailShort( OrderDetailSO so );
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 03.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 상세 구성 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrdDtlCstrtVO> listOrdDtlCstrt(OrderDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 09.
	 * - 작성자		: JinHong
	 * - 설명		: 자주 구매한 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listFrequentOrderGoods( OrderDetailSO so );
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: kek01
	 * - 설명		: 구매확정을 위한 배송완료된 주문상세 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listOrderDetailDlvrCpltForPurchaseConfirm( OrderDetailSO so );
	
	public Integer getOrderDetailCntByMbrNo(OrderDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 07. 30.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 포인트 가용화 처리
	 * </pre>
	 * @param ordNo
	 */
	public void excuteUsePsbSktmpPnt(String ordNo);
}
