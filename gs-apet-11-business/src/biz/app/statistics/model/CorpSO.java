package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CorpSO extends BaseSearchVO<CorpSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 접수 시작 일시 */
	private Timestamp ordAcptDtmStart;

	/** 주문 접수 종료 일시 */
	private Timestamp ordAcptDtmEnd;

	/** 결제일 / 주문일 시작일자 */
	private Timestamp ordStartDate;

	/** 결제일 / 주문일 종료일자 */
	private Timestamp ordEndDate;

	/** 주문 완료 시작 일시 */
	private Timestamp ordCpltDtmStart;

	/** 주문 완료 종료 일시 */
	private Timestamp ordCpltDtmEnd;
}