package biz.app.delivery.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryChargePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 배송비정책번호 */
	private Long dlvrcPlcNo;

	/** 배송비 기준 코드 */
	private String dlvrcStdCd;

	/** 배송비 결제 방법 코드 */
	private String dlvrcPayMtdCd;

	/** 배송비 조건 코드 */
	private String dlvrcCdtCd;

	/** 배송비 조건 기준 코드 */
	private String dlvrcCdtStdCd;

	/** 배송 기준 금액 */
	private Long dlvrStdAmt;

	/** 추가 배송 기준 금액 */
	private Long addDlvrStdAmt;
	
	/** 구매 수량 */
	private Integer buyQty;

	/** 구매 가격 */
	private Long buyPrc;

	/** 원 배송 금액 */
	private Long orgDlvrAmt;

	/** 실 배송 금액 */
	private Long realDlvrAmt;

	/** 추가 배송 금액 */
	private Long addDlvrAmt;

	/** 원 배송비 번호 */
	private Long orgDlvrcNo;
	
	/** 비용 구분 코드 */
	private String costGbCd;

	/** 선착불 구분 코드 */
	private String prepayGbCd;
	
	/** 쿠폰 번호 */
	private Long cpNo;
	
	/** 회원 쿠폰 번호 */
	private Long mbrCpNo;
	
	/** 쿠폰 할인 금액 */
	private Long cpDcAmt;

	/** 취소 여부 */
	private String cncYn;

	/** 취소 클레임 번호 */
	private String cncClmNo;

	/**********************
	 * 비교 참조 정보
	 *********************/
	
	/** 묶음 배송 그룹 번호 */
	private Integer pkgDlvrNo;
	
	/** 주문 배송비 번호 */
	private Long 	ordDlvrcNo;
	
	/** 추가 환불 배송 금액 */
	private Long addReduceDlvrcAmt;
	
	/** 추가 원 배송 금액 */
	private Long addOrgDlvrcAmt;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;
	
	/** 기존 지불된 배송비 */
	private Long paidDlvrAmt;
}