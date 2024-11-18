package biz.interfaces.nicepay.model.response.data;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class CancelProcessResVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;
	
	/** ResultCode : 결제 결과 코드 (성공 : 취소 - 2001 , 환불 - 2211)*/
	
	/** 에러 코드 */
	private String ErrorCD;
	
	/** 에러 메시지 
	 * 예) 해당거래 취소실패(기취소성공) : 전화 문의(1661-0808)
	 */
	private String ErrorMsg;
	
	/** 취소 금액 */
	private String CancelAmt;
	
	/** 상점 ID */
	private String MID;
	
	/** 주문번호 */
	private String Moid;
	
	/** 결제수단 코드
	 * (신용카드: CARD, 계좌이체: BANK, 가상계좌: VBANK, 핸드폰 :CELLPHONE)
	*/
	private String PayMethod;
	
	/** 거래번호, 거래를 구분하는 transaction ID */
	private String TID;
	
	/** 취소일자, YYYYMMDD */
	private String CancelDate;
	
	/** 취소시간, HHmmss */
	private String CancelTime;
	
	/** 취소번호 */
	private String CancelNum;
	
	/** 취소 후 잔액*/
	private String RemainAmt;
}
