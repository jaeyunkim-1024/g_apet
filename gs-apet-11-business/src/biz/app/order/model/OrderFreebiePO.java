package biz.app.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderFreebiePO.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 주문 사은품 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderFreebiePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사은품 번호 */
	private Long 	frbNo;

	/** 주문 클레임 구분 코드 */
	private String 	ordClmGbCd;

	/** 주문 번호 */
	private String 	ordNo;

	/** 주문 상세 순번 */
	private Integer 	ordDtlSeq;

	/** 클레임 번호 */
	private String 	clmNo;

	/** 클레임 상세 순번 */
	private Integer 	clmDtlSeq;

	/** 상품번호 */
	private String 	goodsId;

	/** 적용 수량 */
	private Integer aplQty;
}