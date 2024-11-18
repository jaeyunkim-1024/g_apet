package biz.app.story.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StoryBasePO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 스토리 번호  */
	private Integer	stryNo;
	
	/**스토리 명 */
	private String	stryNm;
	
	/**전시 여부 */
	private String	dispYn;
	
	/**사이트 아이디 */
	private String	stId;
	
	/**정렬 순서 */
	private Integer	sortSeq;	
	
}