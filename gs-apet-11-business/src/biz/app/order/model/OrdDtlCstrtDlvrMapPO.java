package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrdDtlCstrtDlvrMapPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 상세 구성 번호 */
	private Long ordDtlCstrtNo;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/** CIS 출고 수량 */
	private Long cisOoQty;

	/** 대표 여부 */
	private String DlgtYn;
	
	
	/** 주문 번호 */
	private String ordNo;
	/** 주문 상세 번호 */
	private Long ordDtlSeq;
	/** 주문 구성 순번 */
	private Long ordCstrtSeq;
	/** 업체 구분 코드 */
	private String compGbCd;
	/** 업체 번호 */
	private String compNo;
	/** 배송비 번호 */
	private Long dlvrcNo;
	/** 신규 배송 번호 */
	private Long newDlvrNo;
	
}