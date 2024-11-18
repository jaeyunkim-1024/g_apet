package biz.app.pay.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PayCashRefundPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 현금 환불 번호 */
	private Long cashRfdNo;

	/** 결제 번호 */
	private Long payNo;

	/** 환불 유형 코드 */
	private String rfdTpCd;
	
	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/** 예정 금액 */
	private Long schdAmt;

	/** 환불 상태 코드 */
	private String rfdStatCd;

	/*********************************
	 * 완료 처리시 사용되는 파라미터
	 *********************************/

	/** 환불 금액 */
	private Long rfdAmt;

	/** 완료자 번호 */
	private Long cpltrNo;

	/** 메모 */
	private String memo;

}