package biz.app.search.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SearchWordLogVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/* 로그 번호 */
	private String logNo;
	
	/* 회원 번호 */
	private Long mbrNo;
	
	/* 검색어 */
	private String srchWord;
	
	/* 삭제여부 */
	private String delYn;
	
	/* 세션 ID */
	private String ssnId;

}