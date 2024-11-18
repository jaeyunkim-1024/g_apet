package biz.app.pay.service;

import java.util.List;

import biz.app.pay.model.PayCashRefundPO;
import biz.app.pay.model.PayCashRefundSO;
import biz.app.pay.model.PayCashRefundVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.service
* - 파일명		: PayCashRefundService.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 결제 현금 환불 서비스 Interface
* </pre>
*/
public interface PayCashRefundService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayCashRefundService.java
	* - 작성일		: 2017. 3. 13.
	* - 작성자		: snw
	* - 설명			: 결제 현금 환불 완료 처리
	* </pre>
	* @param po
	*/
	public void compeltePayCashRefund(PayCashRefundPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayCashRefundService.java
	* - 작성일		: 2017. 3. 13.
	* - 작성자		: snw
	* - 설명			: 결제 현금 환불 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public PayCashRefundVO getPayCashRefund( PayCashRefundSO so );
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.pay.service
	* - 파일명      : PayCashRefundService.java
	* - 작성일      : 2017. 3. 16.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 주문 관리 > 클레임 관리 > 환불 목록
	* </pre>
	 */
	public List<PayCashRefundVO> pagePayCashRefund( PayCashRefundSO so );

}
