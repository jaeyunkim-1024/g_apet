package biz.app.counsel.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CsMainVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private Long inquiryCnt;

	private Long goodsCnt;

	private Long clmCnt;

	private Long fileCnt;
}