package biz.app.system.model.interfaces;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CodeDetailVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 상세 코드 */
	private String dtlCd;

	/** 상세 명 */
	private String dtlNm;

	/** 상세 약어 명 */
	private String dtlShtNm;

	/** 정렬 순서 */
	private Long sortSeq;

	/** 사용 여부 */
	private String useYn;

	/** 사용자 정의1 값 */
	private String usrDfn1Val;

	/** 사용자 정의2 값 */
	private String usrDfn2Val;

	/** 사용자 정의3 값 */
	private String usrDfn3Val;

	/** 그룹 코드 */
	private String grpCd;

	/** 그룹명 */
	private String grpNm;
	
	/** 사용자 정의4 값 */
	private String usrDfn4Val;

	/** 사용자 정의5 값 */
	private String usrDfn5Val;

	/** 시스템 삭제 여부 */
	private String sysDelYn;

	/** 시스템 삭제자 번호 */
	private Integer sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** API 코드그룹명 */
	private String apiGrpCd;
}