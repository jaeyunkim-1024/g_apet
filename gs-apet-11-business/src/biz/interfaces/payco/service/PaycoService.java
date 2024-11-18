package biz.interfaces.payco.service;

import biz.interfaces.payco.model.PaycoApproveDTO;
import biz.interfaces.payco.model.PaycoApproveResult;
import biz.interfaces.payco.model.PaycoCancelDTO;
import biz.interfaces.payco.model.PaycoCancelResult;
import biz.interfaces.payco.model.PaycoReserveDTO;
import biz.interfaces.payco.model.PaycoReserveResult;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.easypay.service
* - 파일명		: PaycoService.java
* - 작성일		: 2016. 5. 31.
* - 작성자		: snw
* - 설명		: Payco 서비스 interface
* </pre>
*/
public interface PaycoService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PaycoService.java
	* - 작성일		: 2016. 6. 1.
	* - 작성자		: snw
	* - 설명		: 주문 예약
	* </pre>
	* @param dto
	* @return
	*/
	PaycoReserveResult reserve(PaycoReserveDTO dto);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PaycoService.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: snw
	* - 설명		: 결제 승인
	* </pre>
	* @param dto
	*/
	PaycoApproveResult approve(PaycoApproveDTO dto);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PaycoService.java
	* - 작성일		: 2016. 6. 13.
	* - 작성자		: snw
	* - 설명		: 결제 취소
	* </pre>
	* @param dto
	* @return
	*/
	PaycoCancelResult cancel(PaycoCancelDTO dto);
	
	
}