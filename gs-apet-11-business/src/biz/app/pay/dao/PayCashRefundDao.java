package biz.app.pay.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.pay.model.PayCashRefundPO;
import biz.app.pay.model.PayCashRefundSO;
import biz.app.pay.model.PayCashRefundVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.dao
* - 파일명		: PayCashRefundDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 결제 현금 환불 DAO
* </pre>
*/
@Repository
public class PayCashRefundDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "payCashRefund.";
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayCashRefundDao.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 결제 현금 환불 등록
	* </pre>
	* @param payCashRefundPO
	* @return
	*/
	public int insertPayCashRefund( PayCashRefundPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertPayCashRefund", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayCashRefundDao.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 현금 환불 상태 변경
	* </pre>
	* @param payCashRefundPO
	* @return
	*/
	public int updatePayCashRefundStatus( PayCashRefundPO po ) {
		return update( BASE_DAO_PACKAGE + "updatePayCashRefundStatus", po );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayCashRefundDao.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 결제 현금 환불 단건 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public PayCashRefundVO getPayCashRefund( PayCashRefundSO so ) {
		return selectOne( BASE_DAO_PACKAGE + "getPayCashRefund", so );
	}	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.pay.dao
	* - 파일명      : PayCashRefundDao.java
	* - 작성일      : 2017. 3. 16.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  홈 > 주문 관리 > 클레임 관리 > 환불 목록
	* </pre>
	 */
		public List<PayCashRefundVO> pagePayCashRefund( PayCashRefundSO so ) {
			return selectListPage( "payCashRefund.pagePayCashRefund", so );
		}
}
