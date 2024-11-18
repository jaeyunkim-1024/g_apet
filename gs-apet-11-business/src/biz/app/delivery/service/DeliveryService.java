package biz.app.delivery.service;

import java.util.List;

import biz.app.delivery.model.DeliveryHistPO;
import biz.app.delivery.model.DeliveryHistSO;
import biz.app.delivery.model.DeliveryHistVO;
import biz.app.delivery.model.DeliveryListVO;
import biz.app.delivery.model.DeliverySO;
import biz.app.delivery.model.DeliveryVO;
import biz.app.order.model.OrderSO;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsSO;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsVO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryPO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryResultPO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.delivery.service
 * - 파일명		: DeliveryService.java
 * - 작성일		: 2016. 4. 22.
 * - 작성자		: dyyoun
 * - 설명		: 배송 서비스
 * </pre>
 */
public interface DeliveryService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 배송번호 단위로 송장번호 등록 후 배송정보 업데이트
	* </pre>
	* @param so
	* @return
	*/
	public void processDeliveryInvNo(Long dlvrNo,String hdcCd, String invNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 배송 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public DeliveryVO getDelivery( Long dlvrNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 4. 13.
	* - 작성자		: Administrator
	* - 설명			: 배송 목록 조회 (페이징)
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<DeliveryListVO> pageDeliveryList( OrderSO orderSO );


	/**
 	 *
 	* <pre>
 	* - 프로젝트명   : 11.business
 	* - 패키지명   : biz.app.delivery.service
 	* - 파일명      : DeliveryService.java
 	* - 작성일      : 2017. 3. 10.
 	* - 작성자      : valuefactory 권성중
 	* - 설명        : 주문크레임 송장 단일등록
 	* </pre>
 	 */
	public void ordClmInvoiceOneCreateExec(Long dlvrNo,String hdcCd, String invNo);




	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DeliveryService.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: dyyoun
	 * - 설명		: 배송완료 처리
	 * </pre>
	 * @param orderSO
	 * @param deliveryPO
	 */
	public void deliveryFinalExec(Long[] arrDlvrNo,Long		mbrNo  );


	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.order.service
	* - 파일명      : OrderDetailService.java
	* - 작성일      : 2017. 3. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 배송분리
	* </pre>
	 */
	public void deliveryDivision(String[] arrOrdNo, Integer[] arrOrdDtlSeq);


	//-------------------------------------------------------------------------------------------------------------------------//
	//- 프론트
	//-------------------------------------------------------------------------------------------------------------------------//
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.service
	* - 파일명      : DeliveryService.java
	* - 작성일      : 2017. 5. 16.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  송장 단순 수정
	* </pre>
	 */
	public void deliveryInvoiceUpdateExec(Long dlvrNo,String hdcCd, String invNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 연동 가능 여부 체크
	* </pre>
	* @param dlvrNo
	* @return
	 */
	public boolean checkGoodsFlowDelivery(Long dlvrNo);

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 정보 조회
	* </pre>
	* @param dlvrNo
	* @return
	 */
	public biz.interfaces.goodsflow.model.request.data.DeliveryVO getGoodsFlowDelivery(Long dlvrNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 상품 정보 조회
	* </pre>
	* @param dlvrNo
	* @param transUniqueCode
	* @return
	 */
	public List<DeliveryGoodsVO> getGoodsFlowDeliveryGoods(DeliveryGoodsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 저장
	* </pre>
	* @param po
	* @return
	 */
	public int insertGoodsFlowDelivery(GoodsFlowDeliveryPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 결과 저장
	* </pre>
	* @param po
	* @return
	 */
	public int insertGoodsFlowDeliveryResult(GoodsFlowDeliveryResultPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: WilLee
	* - 설명			:
	* </pre>
	* @param itemUniqueCode
	* @return
	 */
	public Long getDeliveryNoByItemUniqueCode(String itemUniqueCode);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		:
	* - 설명		: 굿스플로 배송 조회 링크를 위한 고유번호 조회 (FO,MO 사용)
	* </pre>
	* @param so
	* @return
	 */
	public DeliveryVO getGoodsFlowCode(OrderSO orderSO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2019. 7. 1.
	* - 작성자		: siete
	* - 설명		: 굿스플로 배송 연동 등록 대상 조회
	* </pre>
	* @param dlvrNo
	* @return
	 */	
	public List<DeliveryVO> getGoodsFlowRequestTraceList(DeliverySO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2021. 9. 2.
	* - 작성자		: siete
	* - 설명		: 위탁업체 배송 안내 알림톡 발송
	* </pre>
	* @param so
	* @return
	 */	
	public List<DeliveryVO> listDeliveryConsignComp(DeliveryVO so);
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DeliveryService.java
	* - 작성일	: 2021. 9. 8.
	* - 작성자 	: valfac
	* - 설명 		: 배송 히스토리 등록
	* </pre>
	*
	* @param arrDlvrNo
	* @return
	*/
	public int insertDeliveryHist(DeliveryHistPO po);
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DeliveryService.java
	* - 작성일	: 2021. 9. 8.
	* - 작성자 	: valfac
	* - 설명 		: 배송 히스토리 목록
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<DeliveryHistVO> pageDeliveryHist(DeliveryHistSO so);
	
	
}
