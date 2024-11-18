package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: AplBnftPO.java
* - 작성일		: 2017. 1. 24.
* - 작성자		: snw
* - 설명			: 적용 혜택 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class AplBnftPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String	ordNo;

	/** 주문 상세 순번 */
	private Integer	ordDtlSeq;
	
	/** 적용 혜택 구분 코드 */
	private String 	aplBnftGbCd;
	
	/** 적용 혜택 유형 코드 */
	private String	aplBnftTpCd;
	
	/** 적용 번호 */
	private Long 	aplNo;

	/** 회원 쿠폰 번호 */
	private Long 	mbrCpNo;

	/** 적용 금액 */
	private Long		aplAmt;

	/** 잔여 적용 금액 */
	private Long		rmnAplAmt;
	
	/** 업체 부담 금액 */
	private Long 	compBdnAmt;

	/** 취소 여부 */
	private String	cncYn;
	
	/** 적용 혜택 번호 */
	private Integer	aplBenefitNo;
}