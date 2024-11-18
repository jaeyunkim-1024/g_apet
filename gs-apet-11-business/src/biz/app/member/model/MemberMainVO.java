package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberMainVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private Long useCnt;

	private Long humanCnt;

	private Long withdrawCnt;

	private Long newCnt;

}