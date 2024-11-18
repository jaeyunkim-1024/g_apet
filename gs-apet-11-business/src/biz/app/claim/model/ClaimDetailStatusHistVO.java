package biz.app.claim.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimDetailStatusHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 변경프로그램아이디 */
	private String chgPrgmId;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 클레임 상태 코드 */
	private String clmStatCd;

	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;

}