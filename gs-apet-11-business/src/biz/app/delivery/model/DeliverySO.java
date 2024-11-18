package biz.app.delivery.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.model
* - 파일명		: DeliverySO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 배송 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverySO extends BaseSearchVO<DeliverySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 배송 번호 */
	private Long dlvrNo;

	/**  주문 상세 순번  */
	private Integer ordDtlSeq;

	/**  클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	
	/** 송장등록할 때만 사용하려고 추가했음. */
	private Boolean onlyOne;

	/** 업체 구분 코드*/
	private String compGbCd;
}