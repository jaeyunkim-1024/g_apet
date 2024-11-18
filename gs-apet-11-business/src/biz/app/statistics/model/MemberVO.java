package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 순위 */
	private String birth;

	/** 퍼센트 */
	private String rate;

	/** 남성 */
	private String man;

	/** 여성 */
	private Double woman;

	/** 총합 */
	private Long totCnt;
}