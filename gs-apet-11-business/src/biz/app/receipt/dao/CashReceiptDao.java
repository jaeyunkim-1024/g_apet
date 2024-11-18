package biz.app.receipt.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderSO;
import biz.app.receipt.model.CashReceiptGoodsMapPO;
import biz.app.receipt.model.CashReceiptGoodsMapSO;
import biz.app.receipt.model.CashReceiptGoodsMapVO;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.receipt.model.CashReceiptSO;
import biz.app.receipt.model.CashReceiptVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.receipt.dao
* - 파일명		: CashReceiptDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 현금영수증 DAO
* </pre>
*/
@Repository
public class CashReceiptDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "cashReceipt.";
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CashReceiptDao.java
	* - 작성일		: 2017. 3. 27.
	* - 작성자		: snw
	* - 설명			: 현금 영수증 등록
	* </pre>
	* @param cashReceiptPO
	* @return
	*/
	public int insertCashReceipt( CashReceiptPO cashReceiptPO ) {
		if (StringUtil.isNotBlank(cashReceiptPO.getIsuMeansNo())) {
			cashReceiptPO.setIsuMeansNo(cashReceiptPO.getIsuMeansNo().replaceAll("-", ""));
		}
		return insert( BASE_DAO_PACKAGE + "insertCashReceipt", cashReceiptPO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2017. 2. 27.
	 * - 작성자		: hongjun
	 * - 설명			: 현금영수증 상품 매핑 등록
	 * </pre>
	 * @param cashReceiptGoodsMapPO
	 * @return
	 */
	public int insertCashReceiptGoodsMap( CashReceiptGoodsMapPO cashReceiptGoodsMapPO ) {
		return insert( BASE_DAO_PACKAGE + "insertCashReceiptGoodsMap", cashReceiptGoodsMapPO );
	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2017. 2. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 현금영수증 페이지 리스트
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<CashReceiptVO> pageCashReceipList( OrderSO orderSO ) {
		return selectListPage( BASE_DAO_PACKAGE + "pageCashReceipList", orderSO );
	}
	


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2017. 2. 27.
	 * - 작성자		: hongjun
	 * - 설명		: 현금영수증 상품 매핑 리스트
	 * </pre>
	 * @param cashReceiptGoodsMapSO
	 * @return
	 */
	public List<CashReceiptGoodsMapVO> listCashReceiptGoodsMap( CashReceiptGoodsMapSO cashReceiptGoodsMapSO ) {
		return selectList( BASE_DAO_PACKAGE + "listCashReceiptGoodsMap", cashReceiptGoodsMapSO );
	}
	

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2016. 4. 18.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 변경
	 * </pre>
	 * @param cashReceiptPO
	 * @return
	 */
	public int updateCashReceipt( CashReceiptPO cashReceiptPO ) {
		return update( BASE_DAO_PACKAGE + "updateCashReceipt", cashReceiptPO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2016. 4. 19.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 리스트 추출
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<CashReceiptVO> listCashReceipt( OrderSO orderSO ) {
		return selectList( BASE_DAO_PACKAGE + "listCashReceipt", orderSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CashReceiptDao.java
	* - 작성일		: 2017. 3. 27.
	* - 작성자		: snw
	* - 설명			: 현금영수증 단건 조회
	* </pre>
	* @param cashReceiptSO
	* @return
	*/
	public CashReceiptVO getCashReceipt( CashReceiptSO cashReceiptSO ) {
		return (CashReceiptVO) selectOne( BASE_DAO_PACKAGE + "getCashReceipt", cashReceiptSO );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금 영수증 단건 Sum
	 * </pre>
	 * @param cashReceiptSO
	 * @return
	 */
	public CashReceiptVO getCashReceiptSum( CashReceiptSO cashReceiptSO ) {
		return (CashReceiptVO) selectOne( BASE_DAO_PACKAGE + "getCashReceiptSum", cashReceiptSO );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CashReceiptDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: dyyoun
	 * - 설명		: 현금영수증 기 접수/승인 건 체크
	 * </pre>
	 * @param cashReceiptSO
	 * @return
	 */
	public int getCashReceiptExistsCheck( CashReceiptSO cashReceiptSO ) {
		return (int) selectOne( BASE_DAO_PACKAGE + "getCashReceiptExistsCheck", cashReceiptSO );
	}
	
	public List<CashReceiptVO> listBatchCashReceipt() {
		return selectList(BASE_DAO_PACKAGE + "listBatchCashReceipt");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CashReceiptDao.java
	* - 작성일		: 2017. 7. 17.
	* - 작성자		: Administrator
	* - 설명			: 현금영수증 승인 요청 목록
	* </pre>
	* @return
	*/
	public List<CashReceiptVO> listBatchCashReceiptAppr() {
		return selectList(BASE_DAO_PACKAGE + "listBatchCashReceiptAppr");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CashReceiptDao.java
	* - 작성일		: 2017. 7. 17.
	* - 작성자		: Administrator
	* - 설명			: 현금영수증 승인 취소 목록
	* </pre>
	* @return
	*/
	public List<CashReceiptVO> listBatchCashReceiptCncl() {
		return selectList(BASE_DAO_PACKAGE + "listBatchCashReceiptCncl");
	}
	
}
