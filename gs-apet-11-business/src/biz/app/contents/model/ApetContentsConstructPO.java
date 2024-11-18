package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsConstructPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;
	
	/** 구성 순번 */
	private Long cstrtSeq;

	/** 구성 구분 코드 */
	private String cstrtGbCd;
	
	/** 제목 */
	private String ttl;
	
	/** 내용 */
	private String content;

}