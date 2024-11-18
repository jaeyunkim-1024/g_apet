package biz.app.receipt.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderDeliveryVO;
import biz.app.order.model.OrderSO;
import biz.app.receipt.model.TaxInvoicePO;
import biz.app.receipt.model.TaxInvoiceVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.receipt.dao
* - 파일명		: TaxInvoiceDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 세금계산서 DAO
* </pre>
*/
@Repository
public class TaxInvoiceDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "taxInvoice.";
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderCommonDao.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 등록
	 * </pre>
	 * @param cashReceiptPO
	 * @return
	 */
	public int insertTaxInvoice( TaxInvoicePO po ) {
		return insert( BASE_DAO_PACKAGE + "insertTaxInvoice", po );
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderCommonDao.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 변경
	 * </pre>
	 * @param taxInvoicePO
	 * @return
	 */
	public int updateTaxInvoice( TaxInvoicePO taxInvoicePO ) {
		return update( "orderCommon.updateTaxInvoice", taxInvoicePO );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderCommonDao.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 리스트 추출
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<TaxInvoiceVO> listTaxInvoice( OrderSO orderSO ) {
		return selectList( "orderCommon.listTaxInvoice", orderSO );
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxDao.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 리스트(페이지)
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<OrderDeliveryVO> pageTaxList( OrderSO orderSO ) {
		return selectListPage( BASE_DAO_PACKAGE + "pageTaxList", orderSO );
	}





	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxDao.java
	 * - 작성일		: 2016. 4. 22.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금 계산서 단건 Sum
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public TaxInvoiceVO getTaxInvoiceSum( OrderSO orderSO ) {
		return (TaxInvoiceVO) selectOne( BASE_DAO_PACKAGE + "getTaxInvoiceSum", orderSO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TaxDao.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 세금계산서 기 접수/승인 건 체크
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public int getTaxInvoiceExistsCheck( OrderSO orderSO ) {
		return (int) selectOne( BASE_DAO_PACKAGE + "getTaxInvoiceExistsCheck", orderSO );
	}





	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: TaxDao.java
	* - 작성일	: 2016. 6. 29.
	* - 작성자	: jangjy
	* - 설명		: 세금계산서 등록시 현금영수증 기 접수/승인 건 체크
	* </pre>
	* @param orderSO
	* @return
	*/
	public int getCashReceiptExistsCheckTaxInvoice( OrderSO orderSO ) {
		return (int) selectOne( BASE_DAO_PACKAGE + "getCashReceiptExistsCheckTaxInvoice", orderSO );
	}

	

}
