package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrdDtlCstrtDlvrMapSO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 상세 구성 번호 */
	private Long ordDtlCstrtNo;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 클레임 배송 여부 */
	private String clmDlvrYn;
}