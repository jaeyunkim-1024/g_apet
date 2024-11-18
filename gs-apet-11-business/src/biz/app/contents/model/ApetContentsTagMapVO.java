package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsTagMapVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;

	/** 태그 번호 */
	private String tagNo;
	
	/** 태그명 */
	private String tagNm;
	
	/** 이력 번호 */
	private Long histNo;

}