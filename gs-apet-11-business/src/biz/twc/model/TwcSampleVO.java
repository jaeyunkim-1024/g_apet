package biz.twc.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class TwcSampleVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String name;
	private String helpKeywordId;
}