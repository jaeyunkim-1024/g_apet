package biz.app.system.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterDispSO extends BaseSearchVO<BbsLetterDispSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 게시판 아이디 */
	private String bbsId;
	
	/** 글 번호 */
	private Long lettNo;

	/** 전시 우선 순위 */
	private Long dispPriorRank;
	

	 
}