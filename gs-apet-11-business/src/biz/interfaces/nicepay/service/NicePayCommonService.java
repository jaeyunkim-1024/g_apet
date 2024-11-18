package biz.interfaces.nicepay.service;

import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CheckBankAccountReqVO;
import biz.interfaces.nicepay.model.request.data.FixAccountReqVO;
import biz.interfaces.nicepay.model.request.data.VirtualAccountReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CheckBankAccountResVO;
import biz.interfaces.nicepay.model.response.data.FixAccountResVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountResVO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.service
 * - 파일명		: NicePayCommonService.java
 * - 작성일		: 2021. 02. 22.
 * - 작성자		: JinHong
 * - 설명		: Nice pay 공통 서비스
 * </pre>
 */
public interface NicePayCommonService {
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: JinHong
	 * - 설명		: 승인 취소 
	 * </pre>
	 * @param vo
	 * @return
	 */
	public CancelProcessResVO reqCancelProcess(CancelProcessReqVO vo, String midGb, String payMeans, String mdaGb);
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: JinHong
	 * - 설명		: 예금주 성명 조회
	 * </pre>
	 * @param vo
	 * @return
	 */
	public CheckBankAccountResVO reqCheckBankAccount(CheckBankAccountReqVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: JinHong
	 * - 설명		: 가상계좌 발급 요청
	 * </pre>
	 * @param vo
	 * @return
	 */
	public VirtualAccountResVO reqGetVirtualAccount(VirtualAccountReqVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.service
	 * - 작성일		: 2021. 03. 30.
	 * - 작성자		: JinHong
	 * - 설명		: 고정형 가상계좌  과오납 요청 
	 * </pre>
	 * @param vo
	 * @return
	 */
	public FixAccountResVO reqRegistFixAccount(FixAccountReqVO vo);
}