package biz.app.system.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CodeGroupVO extends BaseSysVO {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/** 그룹 코드 */
	private String grpCd;

	/** 그룹 명 */
	private String grpNm;

	/** 사용자 정의1 명 */
	private String usrDfn1Nm;

	/** 사용자 정의2 명 */
	private String usrDfn2Nm;

	/** 사용자 정의3 명 */
	private String usrDfn3Nm;

	/** 사용자 정의4 명 */
	private String usrDfn4Nm;

	/** 사용자 정의5 명 */
	private String usrDfn5Nm;

	/** 시스템 삭제 여부 */
	private String sysDelYn;

	/** 시스템 삭제자 번호 */
	private Integer sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** 상세코드 리스트 */
	private List<CodeDetailVO> listCodeDetailVO;
}