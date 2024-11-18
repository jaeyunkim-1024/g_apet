package biz.app.story.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StoryLetterReplyPO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 스토리 글 번호 */
	private Integer stryLettNo;
	
	/** 답글순번 */
	private Integer rplSeq;
	
	/** 내용 */
	private String content;
	
	/** 시스템 삭제 여부 */
	private String sysDelYn;
	
	/** 시스템 삭제자 번호 */
	private Integer	sysDelrNo;
	
	/** 시스템  삭제 일시 */
	private Timestamp	sysDelDtm;

	/** 시스템 삭제 사유 */
	private String sysDelRsn;
	
}