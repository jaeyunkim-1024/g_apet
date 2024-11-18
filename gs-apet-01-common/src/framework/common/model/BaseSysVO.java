package framework.common.model;

import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
public class BaseSysVO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 시스템 등록자 번호 */
	private Long		sysRegrNo;

	/** 시스템 등록자 명 */
	private String		sysRegrNm;

	/** 시스템 등록 일시 */
	private Timestamp	sysRegDtm;

	/** 시스템 수정자 번호 */
	private Long		sysUpdrNo;

	/** 시스템 수정자 명 */
	private String		sysUpdrNm;

	/** 시스템 수정 일시 */
	private Timestamp	sysUpdDtm;

	private String execSql = "";

	private Long cnctHistNo = 0L;

	private Long inqrHistNo = 0L;

}
