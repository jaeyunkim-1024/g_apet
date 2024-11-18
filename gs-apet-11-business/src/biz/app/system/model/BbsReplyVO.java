package biz.app.system.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsReplyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 댓글 번호 */
	private Long rplNo;

	/** 상위 답글 번호 */
	private String upRplNo;
	
	/** 내용 */
	private String content;

	/** 상위리플 */
	private Long parent;
	
	/** 레벨 */
	private Long lev;
	
	/**시스템 등록자 번호 */
	private Long	sysRegrNo;
	
	/**시스템 등록자 ID */
	private String	sysRegrId;

	/**시스템 등록 일시 */
	private Timestamp	sysRegDtm;

	/**시스템 수정자 번호 */
	private Long	sysUpdrNo;

	/**시스템 수정 일시 */
	private Timestamp sysUpdDtm;

	/** 시스템 삭제 여부 */
	private String sysDelYn;

	/** 시스템 삭제자 번호 */
	private Long sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** 시스템 삭제 사유 */
	private String sysDelRsn;

	/** 댓글 수 */
	private Long bbsReplyCnt;
	
}