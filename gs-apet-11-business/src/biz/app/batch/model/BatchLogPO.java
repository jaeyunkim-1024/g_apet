package biz.app.batch.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper = false)
public class BatchLogPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String batchId;

	private Timestamp batchStrtDtm;

	private Timestamp batchEndDtm;

	private String batchRstCd;

	private String batchRstMsg;

	private int result;

}