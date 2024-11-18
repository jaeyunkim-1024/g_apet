package biz.app.search.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopWordVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 인기 검색어 순위 */
	private Integer iBricksRank;
	
	/** 검색어 명 */
	private String iBricksQuery;
	
	/** 검색 수 */
	private Integer iBricksCount;
	
	/** 이전 인기 검색어 순위 차 */
	private Integer iBricksDiff;
	
	/** 순위 변동 현황 (up,down,stay) */
	private String iBricksUpdown;
}