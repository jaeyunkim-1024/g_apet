package biz.interfaces.nicepay.model.request.data;

import biz.interfaces.nicepay.model.request.RequestCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CancelProcessReqVO extends RequestCommonVO{
	private static final long serialVersionUID = 1L;
	
	/** 필수 항목 start */
	
	/** 상점에서 부여한 주문번호(Unique하게 구성) */
	private String Moid;
	
	/** 취소 금액 */
	private String CancelAmt;
	
	/**
	 * 해당값 설정 시 각 값의 합이
	 * CancelAmt와 일치해야 함
	*/
	/** 별도 공급가액 설정 시 사용 */
	private String SupplyAmt="0";
	
	/** 별도 부가세 설정 시 사용 */
	private String GoodsVat="0";
	
	/** 별도 봉사료 설정 시 사용 */
	private String ServiceAmt="0";
	
	/** 별도 면세금액 설정 시 사용 */
	private String TaxFreeAmt="0";
	
	/** 취소 사유 */
	private String CancelMsg;
	
	/** 부분취소 여부(전체취소 : 0 / 부분취소 : 1) */
	private String PartialCancelCode;
	
	/** 필수 항목 end */
	
	/** 장바구니 결제 유형 (장바구니 결제: 1 / 그 외:0 ) */
	private String CartType;
	
	/** 환불 관련 */
	/** 환불계좌번호 */
	private String RefundAcctNo;
	
	/** 환불계좌 은행코드 */
	private String RefundBankCd;
	
	/** 환불예금주명 */
	private String RefundAcctNm;
	
	/** 결제 수단 코드 */
	private String payMeansCd;
}
