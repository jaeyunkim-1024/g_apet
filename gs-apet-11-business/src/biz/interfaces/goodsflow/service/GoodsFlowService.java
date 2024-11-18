package biz.interfaces.goodsflow.service;

import java.util.List;

import org.springframework.web.client.RestClientException;

import biz.interfaces.goodsflow.model.TraceResult;
import biz.interfaces.goodsflow.model.response.data.InvoiceVO;

public interface GoodsFlowService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: WilLee
	* - 설명			: 운송장번호 검증 수신 응답
	* 
	* </pre>
	* @param form
	* @return
	 */
	public List<InvoiceVO> checkInvoiceNo(List<biz.interfaces.goodsflow.model.request.data.InvoiceVO> invoices);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 6. 12.
	* - 작성자		: WilLee
	* - 설명			: 배송 추적 요청
	* </pre>
	* @param dlvrNo
	* @return
	 */
	public boolean sendTraceRequest(Long dlvrNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: WilLee
	* - 설명			: 배송 결과 수신 및 응답 처리
	* </pre>
	* @return
	 */
	public TraceResult receiveTraceResult();
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 6. 20.
	* - 작성자		: WilLee
	* - 설명			: 배송 결과 수신 및 응답 처리 (배치에서 사용)
	* </pre>
	* @return
	 */
	public TraceResult receiveTraceResultV3();
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2019. 6. 28.
	* - 작성자		: siete
	* - 설명		: 배송 추적 등록 요청 ( 배치 호출 용 )
	 * </pre>
	 */
	public TraceResult requestTraceV3() throws RestClientException;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFlowService.java
	 * - 작성일		: 2021. 4. 29.
	 * - 작성자		: ssmvf01
	 * - 설명		: 뉴 배송 추적 등록 요청 ( 배치 호출 용 )
	 * </pre>
	 */
	public TraceResult requestTraceV3New() throws RestClientException;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsFlowService.java
	* - 작성일	: 2021. 9. 15.
	* - 작성자 	: valfac
	* - 설명 		: 뉴 배송 추적 등록 요청 단건
	* </pre>
	*
	* @param dlvrNo
	* @return
	* @throws RestClientException
	*/
	public int requestTraceV3NewForOnce(Long dlvrNo) throws RestClientException;
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 6. 12.
	* - 작성자		: WilLee
	* - 설명		: 배송 추적 요청 :: 배치(메소드:requestTraceV3())에서 사용하므로 되도록 직접호출 사용 금지 
	* </pre>
	* @param dlvrNo
	* @return
	 */
	public boolean sendTraceRequestV3(Long dlvrNo);
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 6. 12.
	* - 작성자		: WilLee
	* - 설명		: 배송 추적 요청 :: 배치(메소드:requestTraceV3())에서 사용하므로 되도록 직접호출 사용 금지 
	* </pre>
	* @param 
	* @return
	 */
	public boolean sendTraceRequestV3New(biz.interfaces.goodsflow.model.request.data.DeliveryVO goodsFlowTrace);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsFlowService.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: WilLee
	* - 설명			: 운송장번호 검증 수신 응답
	* 
	* </pre>
	* @param form
	* @return
	 */
	public List<InvoiceVO> checkInvoiceNoV3(List<biz.interfaces.goodsflow.model.request.data.InvoiceVO> invoices);
}
