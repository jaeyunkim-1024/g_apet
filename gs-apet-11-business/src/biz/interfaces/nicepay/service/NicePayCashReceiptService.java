package biz.interfaces.nicepay.service;

import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import framework.front.model.Session;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.service
 * - 파일명		: NicePayCashReceiptService.java
 * - 작성일		: 2021. 01. 13.
 * - 작성자		: JinHong
 * - 설명		: Nice Pay 현금영수증 서비스
 * </pre>
 */
public interface NicePayCashReceiptService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 01. 13.
	 * - 작성자		: JinHong
	 * - 설명		: 현금영수증 발급 요청
	 * </pre>
	 * @param vo
	 * @return
	 */
	public CashReceiptResVO reqCashReceipt(CashReceiptReqVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 04. 09.
	 * - 작성자		: pse
	 * - 설명		: 현금영수증 취소 요청
	 * </pre>
	 * @param vo
	 * @return
	 */
	public CancelProcessReqVO setCancelCashReceipt(String ordNo);
}