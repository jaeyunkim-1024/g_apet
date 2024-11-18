package biz.interfaces.nicepay.model.request.data;

import biz.interfaces.nicepay.model.request.RequestCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CashReceiptReqVO extends RequestCommonVO{
	private static final long serialVersionUID = 1L;
	/** 필수 항목 start */
	
	/** 상점에서 부여한 주문번호(Unique하게 구성) */
	private String Moid;
	
	/** 현금영수증 요청 금액 */
	private String ReceiptAmt;
	
	/** 상품명 */
	private String GoodsName;
	
	/** 증빙구분(1: 소득공제, 2: 지출증빙) */
	private String ReceiptType;
	
	/** 
	 * 현금영수증 발급번호
	 * CashReceiptType=1 인 경우 휴대폰번호
	 * CashReceiptType=2 인 경우 사업자번호
	 */
	private String ReceiptTypeNo;
	
	/**
	 * 해당값 설정 시 각 값의 합이
	 * ReceiptAmt와 일치해야 함
	*/
	/** 별도 공급가액 설정 시 사용 */
	private String ReceiptSupplyAmt="0";
	
	/** 별도 부가세 설정 시 사용 */
	private String ReceiptVAT="0";
	
	/** 별도 봉사료 설정 시 사용 */
	private String ReceiptServiceAmt="0";
	
	/** 별도 면세금액 설정 시 사용 */
	private String ReceiptTaxFreeAmt="0";
	
	/** 필수 항목 end */
	
	/** 서브몰사업자번호, 가맹점 하위의 서브몰에 발행 시 설정 */
	private String ReceiptSubNum;
	
	/** 서브몰사업자상호 */
	private String ReceiptSubCoNm;
	
	/** 서브몰사업자대표자 */
	private String ReceiptSubBossNm;
	
	/** 서브몰사업자전화번호 */
	private String ReceiptSubTel;
	
	/** 구매자 이름 */
	private String BuyerName;
	
	/** 구매자 이메일주소 */
	private String BuyerEmail;
	
	/** 구매자 전화번호 */
	private String BuyerTel;
	
}
