package biz.app.receipt.service;

import java.util.List;

import biz.app.order.model.OrderSO;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.model.CashReceiptVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.receipt.service
* - 파일명		: CashReceiptService.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 현금영수증 서비스
* </pre>
*/
public interface CashReceiptService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2017. 2. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 현금영수증 페이지 리스트
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<CashReceiptVO> pageCashReceipList( OrderSO orderSO );


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 단건 추출(Sum)
	 * </pre>
	 * @param cashReceiptSO
	 * @return
	 */
	public CashReceiptVO getCashReceiptSum( CashReceiptSO cashReceiptSO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param cashReceiptPO
	 * @return
	 */
	public void cashReceiptAcceptExec( OrderSO orderSO, CashReceiptPO cashReceiptPO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 발행
	 * </pre>
	 * @param orderSO
	 * @param cashReceiptPO
	 */
	public void cashReceiptPublishExec( OrderSO orderSO, CashReceiptPO cashReceiptPO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 재발행
	 * </pre>
	 * @param cashReceiptSO
	 * @param cashReceiptPO
	 */
	public void cashReceiptRePublishExec( CashReceiptSO cashReceiptSO, CashReceiptPO cashReceiptPO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: valueFactory
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<CashReceiptVO> listBatchCashReceipt();
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 4. 19.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 리스트 조회
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<CashReceiptVO> listCashReceipt( OrderSO orderSO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2016. 4. 19.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 단건 조회
	 * </pre>
	 * @param cashReceiptSO
	 * @return
	 */
	public CashReceiptVO getCashReceipt( CashReceiptSO cashReceiptSO );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: TaxService.java
	* - 작성일	: 2016. 6. 21.
	* - 작성자	: jangjy
	* - 설명		: 현금영수증 수동 발행
	* </pre>
	* @param orderSO
	* @param cashReceiptPO
	*/
	public void insertCashReceipt(OrderSO orderSO, CashReceiptPO cashReceiptPO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2017. 3. 30.
	 * - 작성자		: WilLee
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<CashReceiptVO> listBatchCashReceiptAppr();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2017. 3. 30.
	 * - 작성자		: WilLee
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<CashReceiptVO> listBatchCashReceiptCncl();
	
	public int updateCashReceipt(CashReceiptPO cashReceiptPO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CashReceiptService.java
	* - 작성일		: 2017. 7. 17.
	* - 작성자		: Administrator
	* - 설명			: 현금영수증 상품명 조회
	* </pre>
	* @param cashRctNo
	* @return
	*/
	public String getCashReceiptGoodsNm(Long cashRctNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2021. 4. 9.
	 * - 작성자		: pse
	 * - 설명		: 현금영수증 발행 데이터 db insert
	 * </pre>
	 * @param cashReceiptPO
	 */
	public void cashReceiptInsert( CashReceiptPO cashReceiptPO );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptService.java
	 * - 작성일		: 2021. 4. 9.
	 * - 작성자		: pse
	 * - 설명		: 현금영수증 취소 DB Insert 
	 * </pre>
	 * @param CancelProcessResVO
	 */
	public CashReceiptPO insertCancelCashReceipt(CancelProcessResVO res, String ordNo, String clmNo);
}
