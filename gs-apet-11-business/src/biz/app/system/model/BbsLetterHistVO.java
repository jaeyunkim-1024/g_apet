package biz.app.system.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 게시판 구분 코드 */
	private String HistGb; 
	

	
}
