package biz.app.delivery.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryChargeDetailVO extends DeliveryChargeVO {

	/** 주문 번호 */
	private String 	ordNo;
	
	/** 클레임 번호 */
	private String	clmNo;
	
	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;
	
	/** 원 배송 금액 */
	private Long 	orgDlvrAmt;
	
	/** 실 배송 금액 */
	private Long 	realDlvrAddAmt;

	/** 추가 배송 금액 */
	private Long		addDlvrAddAmt; 
	
	/** 주문 클레임 구분 코드 */
	private String 	ordClmGbCd;

	/** 클레임 사유 코드 */
	private String clmRsnCd;
	
	/** 클레임 유형 코드 */
	private String clmTpCd;
	
	/** 클레임 유형 코드 */
	
	// - 10 orderDlvrcAmt
	// - 20 claimDlvrcAmt
	private String dlvrcGbCd;
	
	private Long 	fstDlvrcNo;
	
	/** 배송비 정책 적용 여부 */
	private String plcAplYn;
	
	/** 기본 반품/회수비 여부 -- 추징/환불 무관하게 배송비 테이블에 데이터 생성. */
	private String dftDlvrcYn = "N";
	
}