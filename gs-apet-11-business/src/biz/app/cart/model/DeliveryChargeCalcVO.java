package biz.app.cart.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class DeliveryChargeCalcVO extends BaseSysVO{
	
	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;
	
	/** 배송비 조건 코드 */
	private String dlvrcCdtCd;
	
	/** 배송 금액 */
	private Long dlvrcDlvrAmt;
	
	/** 배송비 결제 방법 코드 */
	private String dlvrcPayMtdCd;
	
	/** 구매 수량 */
	private Integer buyQty;
	
	/** 무료배송 여부 */
	private String freeDlvrYn;
	
	/** 도서산간지역여부 */
	private String localPostYn;
	
	/** 배송비 기준 코드 */
	private String dlvrcStdCd;
	
	/** 배송비 구매 금액 기준 */
	private Long dlvrcBuyPrc;
	
	/** 배송비 조건 기준 코드 */
	private String dlvrcCdtStdCd;
	
	/** 최적 쿠폰 총 할인금액 */
	private Long selTotCpDcAmt;
	
	/** 구매 금액 */
	private Long buyAmt;
	
	/** 배송비 구매 수량 기준 */
	private Integer dlvrcBuyQty;
	
	/** 배송 추가 금액 */
	private Long dlvrcAddDlvrAmt;
	
	/** 묶음 배송 그룹 번호 */
	private Integer pkgDlvrNo;
	
	/** 묶음 배송비 */
	private Long pkgDlvrAmt;
	
	/** 묶음 원 배송비 */
	private Long pkgOrgDlvrAmt;
	
	/** 묶음 추가 배송비 */
	private Long pkgAddDlvrAmt;
	
	/** 묶음 배송 여부 */
	private String pkgDlvrYn;
	
	/** 묶음 배송 leaf 여부 */
	private String pkgLeafYn;
	
	/** 배송 기준 금액 */
	private Long dlvrStdAmt;

	/** 추가 배송 기준 금액 */
	private Long addDlvrStdAmt;	
	
	// 이하 claim 용 배송비 재계산용
	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 클레임 번호 */
	private String clmNo;
	
	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 배송비 번호 */
	private Long orgDlvrcNo;
	
	/** 쿠폰 번호 */
	private Long 	cpNo;
	
	/** 회원 쿠폰 번호 */
	private Long 	mbrCpNo;
	
	/** 쿠폰 할인 금액 */
	private Long 	cpDcAmt;	

	/** 잔여 주문 수량 */
	private Integer rmnOrdQty = 0;
	
	/** 배송비 정책 적용 여부 */
	private String plcAplYn;
	
	/** 판매자 귀책 사유 반품 수량 */
	private Integer compRtnQty = 0;
	
	/** 전체 반품 수량 */
	private Integer rtnQty = 0;

	/********************
	 * 배송비 fake 계산 용
	 ********************/
	private int reqClaimQty;

	private long reqClaimPayAmt;
	
	private long lastDlvrAmt;
	
	private boolean isClaimReq;
}
