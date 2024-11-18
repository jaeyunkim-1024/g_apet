package biz.app.order.model.interfaces.ob;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model.interfaces.ob
* - 파일명		: ObOrderResponsePO.java
* - 작성일		: 2017. 9. 20.
* - 작성자		: schoi
* - 설명			: Outbound API 이력 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ObOrderResponsePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API Response 이력 정보
	 ****************************/

	/* Outbound API 이력 일련번호 */
	private Integer obApiSeq;

	/* 11번가주문번호 */
	private Integer ordNo;

	/* 쇼핑몰주문번호 */
	private String shopOrdNo;

	/* 주문 처리 업무(10:Outbound 주문 발주 확인 처리,20:Outbound 주문 발송 처리 (배송중 처리),30:Outbound 주문 판매 불가 처리) */
	private String ordResCd;
	
	/* 11번가 시스템 코드 */
	private String openMallId;
	
	/* 11번가 시스템 코드 */
	private String open11stMall;
	
	/* 11번가 시스템 코드 */
	private String openDonePaymentInterface;
	
	/* 결과 코드 */
	private String resultCode;
	
	/* 결과 내용 */
	private String resultText;
	
	/* Outbound API 이력 구분(10:발주확인할내역(결재완료_목록조회),11:발주확인처리,12:발송처리(배송중_처리),13:판매불가처리) */
	private Integer obApiCd;

}
