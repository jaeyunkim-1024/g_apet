package biz.app.order.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: AplBnftSO.java
* - 작성일		: 2017. 1. 24.
* - 작성자		: snw
* - 설명			: 적용 혜택 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class AplBnftSO extends BaseSearchVO<AplBnftSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String	ordNo;

	/** 적용 혜택 구분 코드 */
	private String 	aplBnftGbCd;
	
	/** 취소 여부 */
	private String	cncYn;

}