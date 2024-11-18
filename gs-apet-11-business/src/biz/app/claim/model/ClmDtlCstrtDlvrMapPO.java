package biz.app.claim.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClmDtlCstrtDlvrMapPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 상세 구성 번호 */
	private Long clmDtlCstrtNo;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/** CIS 출고 수량 */
	private Long cisOoQty;
	
	/** 대표 여부 */
	private String DlgtYn;
	
	
	/** 클레임 번호 */
	private String clmNo;
	/** 클레임 상세 순번 */
	private int    clmDtlSeq;
	/** 업체 구분 코드 */
	private String compGbCd;
	/** 업체 번호 */
	private String compNo;
	/** 배송비 번호 */
	private Long dlvrcNo;
	/** 신규 배송 번호 */
	private Long newDlvrNo;
	
}