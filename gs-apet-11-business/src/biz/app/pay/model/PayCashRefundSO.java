package biz.app.pay.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayCashRefundSO.java
* - 작성일		: 2017. 3. 10.
* - 작성자		: snw
* - 설명			: 결제 현금 환불 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PayCashRefundSO extends BaseSearchVO<PayCashRefundSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 현금 환불 번호 */
	private Long cashRfdNo;

	/** 결제 번호 */
	private Long payNo;
	
	/** 시작 일시 : Start */
	private Timestamp dtmStart;

	/** 종료 일시 : End */
	private Timestamp dtmEnd;
	/** 환불 유형 코드 */
	private String rfdTpCd;
	/** 환불 유형 코드 */
	private String rfdStatCd;
	

}