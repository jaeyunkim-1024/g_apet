package biz.app.story.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StoryLetterVO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 스토리 번호  */
	private Integer stryNo;
	
	/** 스토리 글 번호 */
	private Integer stryLettNo;
	
	/** 제목 */
	private String ttl;
	
	/** 조회수 */
	private Integer hits;
	
	/** 내용 */
	private String content;
	
	/** 대표이미지경로 */
	private String dlgtImgPath;
		
	/** 시스템 삭제 여부 */
	private String sysDelYn;
	
	/** 시스템 삭제자 번호 */
	private Integer	sysDelrNo;
	
	/** 시스템  삭제 일시 */
	private Timestamp	sysDelDtm;

	/** 시스템 삭제 사유 */
	private String sysDelRsn;
	
}