package biz.app.claim.model.interfaces.ob;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.claim.model.interfaces.ob
* - 파일명	: ObClaimResponsePO.java
* - 작성일	: 2017. 10. 11.
* - 작성자	: schoi
* - 설명		: Outbound API 이력 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ObClaimResponsePO extends BaseSysVO {

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

	/* 쇼핑몰클레임번호 */
	private String shopClmNo;
	
	/* 클레임 처리 업무(Outbound 클레임 처리 업무(10:Outbound 취소 승인 처리,11:Outbound 취소 거부 처리,20:Outbound 교환 승인 처리,21:Outbound 교환 거부 처리,30:Outbound 반품 승인 처리,31:Outbound 반품 거부 처리) */
	private String clmResCd;
	
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
	
	/* Outbound API 이력 구분 */
	private Integer obApiCd;

}
