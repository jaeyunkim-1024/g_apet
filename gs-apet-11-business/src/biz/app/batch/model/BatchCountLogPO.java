package biz.app.batch.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BatchCountLogPO extends BatchLogPO {

	private static final long serialVersionUID = 1L;
	
	/** 실행 대상 건수 */
	private Long execTgCnt;
	
	/** 실행 성공 건수 */
	private Long execSuccCnt;

	/** 실행 실패 건수 */
	private Long execFailCnt;
	
}
