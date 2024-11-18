package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsSO extends BaseSearchVO<BbsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 명 */
	private String bbsNm;
	
	/** 게시판 유형 */
	private String bbsTpCd;

	/** 사이트 ID */
	private Integer stId;

}