package biz.app.order.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailDlvrHopeDtHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 변경프로그램아이디 */
	private String chgPrgmId;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 배송 희망 일자 */
	private String dlvrHopeDt;

	/** 주문 번호 */
	private String ordNo;

	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;

}