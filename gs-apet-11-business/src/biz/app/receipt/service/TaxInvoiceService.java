package biz.app.receipt.service;

import java.util.List;

import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderSO;
import biz.app.receipt.model.TaxInvoicePO;
import biz.app.receipt.model.TaxInvoiceVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.tax.service
 * - 파일명		: TaxService.java
 * - 작성일		: 2016. 4. 14.
 * - 작성자		: dyyoun
 * - 설명		: 계산서(현금영수증/세금계산서) 서비스
 * </pre>
 */
public interface TaxInvoiceService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 페이지 리스트
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<OrderListVO> pageTaxList( OrderSO orderSO );









	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxService.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 단건 추출(Sum)
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public TaxInvoiceVO getTaxInvoiceSum( OrderSO orderSO );

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param taxInvoicePO
	 * @return
	 */
	public void taxInvoiceAcceptExec( OrderSO orderSO, TaxInvoicePO taxInvoicePO );

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param taxInvoicePO
	 * @return
	 */
	public void taxInvoicePublishExec( OrderSO orderSO, TaxInvoicePO taxInvoicePO );



	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//
	

	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: TaxService.java
	* - 작성일	: 2016. 6. 29.
	* - 작성자	: jangjy
	* - 설명		: 세금계산서 신청
	* </pre>
	* @param orderSO
	* @param taxInvoicePO
	*/
	public void insertTaxInvoice(OrderSO orderSO, TaxInvoicePO taxInvoicePO);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderCommonService.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 리스트 조회
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<TaxInvoiceVO> listTaxInvoice( OrderSO orderSO );
}
