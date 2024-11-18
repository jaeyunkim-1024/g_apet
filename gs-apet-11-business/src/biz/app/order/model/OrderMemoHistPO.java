package biz.app.order.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderMemoHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 메모 순번 */
	private Long memoSeq;

	/** 메모 내용 */
	private String memoContent;

	/** 주문 번호 */
	private String ordNo;

	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;

}