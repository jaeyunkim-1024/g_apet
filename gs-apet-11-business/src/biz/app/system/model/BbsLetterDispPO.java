package biz.app.system.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterDispPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 게시판 아이디 */
	private String bbsId;
	
	/** 글 번호 */
	private Long lettNo;

	/** 전시 우선 순위 */
	private Long dispPriorRank;
	 
	/** 전시 코너 아이템 그리드 */
	private List<BbsLetterDispPO> bbsLetterDispPOList; 

}