package biz.app.order.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailStatusHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 변경프로그램아이디 */
	private String chgPrgmId;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 주문 번호 */
	private String ordNo;

	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;

}